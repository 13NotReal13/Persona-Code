//
//  PDFManager.swift
//  Persona Code
//
//  Created by Иван Семикин on 24/02/2025.
//

import UIKit
import PDFKit
import SwiftUI

final class PDFManager {
    let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
    let leftPadding: CGFloat = 50
    let topPadding: CGFloat = 50
    let rightPadding: CGFloat = 50
    let bottomPadding: CGFloat = 50
    
    var currentY: CGFloat = 0.0
    var stars: [(CGPoint, CGFloat)] = [] // (позиция, прозрачность)
    
    func createPDF(personaCodeData: PersonaCodeModel) -> Data? {
        generateStars(in: pageRect.size)
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pageRect, nil)
        
        beginNewPage()
        
        // Шрифты с белым цветом текста
        let personalDataFont = UIFont.boldSystemFont(ofSize: 24)
        let titleFont = UIFont.boldSystemFont(ofSize: 18)
        let subtitleFont = UIFont.boldSystemFont(ofSize: 16)
        let shortDescriptionFont = UIFont.italicSystemFont(ofSize: 14)
        let mainDescriptionFont = UIFont.systemFont(ofSize: 14)
        let headerFont = UIFont.boldSystemFont(ofSize: 28)
        
        let textColor = UIColor.white
        
        let headerAttrs: [NSAttributedString.Key: Any] = [.font: headerFont, .foregroundColor: textColor]
        let personalDataAttrs: [NSAttributedString.Key: Any] = [.font: personalDataFont, .foregroundColor: textColor]
        let titleAttrs: [NSAttributedString.Key: Any] = [.font: titleFont, .foregroundColor: textColor]
        let subtitleAttrs: [NSAttributedString.Key: Any] = [.font: subtitleFont, .foregroundColor: textColor]
        let shortDescriptionAttrs: [NSAttributedString.Key: Any] = [.font: shortDescriptionFont, .foregroundColor: textColor]
        let mainDescriptionAttrs: [NSAttributedString.Key: Any] = [.font: mainDescriptionFont, .foregroundColor: textColor]
        
        // Заголовок всего документа
        let headerText = "Код Личности"
        drawCenteredText(headerText, attributes: headerAttrs)
        
        currentY += 40
        
        // Персональные данные
        let personalInfoText = "\(personaCodeData.name) - \(personaCodeData.dateOfBirthday.formattedDate())"
        drawAttributedTextLineByLine(NSAttributedString(string: personalInfoText, attributes: personalDataAttrs))
        
        currentY += 30
        
        // Проходим по всем энергиям
        for energy in personaCodeData.allEnergies {
            // Заголовок энергии
            drawAttributedTextLineByLine(NSAttributedString(string: energy.title, attributes: titleAttrs))
            
            for subcat in energy.subcategories {
                currentY += 20
                drawAttributedTextLineByLine(NSAttributedString(string: subcat.title, attributes: subtitleAttrs))
                currentY += 5
                drawAttributedTextLineByLine(NSAttributedString(string: subcat.shortDescription, attributes: shortDescriptionAttrs))
                currentY += 5
                drawAttributedTextLineByLine(NSAttributedString(string: subcat.mainDescription, attributes: mainDescriptionAttrs))
            }
            
            currentY += 40
        }
        
        UIGraphicsEndPDFContext()
        return pdfData as Data
    }
    
    func savePDF(personaCodeData: PersonaCodeModel) -> URL? {
        guard let pdfData = createPDF(personaCodeData: personaCodeData) else { return nil }
        
        let fileName = "\(personaCodeData.name) - \(personaCodeData.dateOfBirthday.formattedDate()).pdf"
        
        if let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let pdfURL = documentsURL.appendingPathComponent(fileName)
            do {
                try pdfData.write(to: pdfURL)
                return pdfURL
            } catch {
                print("Ошибка при сохранении PDF: \(error)")
            }
        }
        return nil
    }
    
    private func beginNewPage() {
        UIGraphicsBeginPDFPage()
        currentY = topPadding
        
        // Рисуем однотонный фон
        if let context = UIGraphicsGetCurrentContext() {
            let backgroundColor = UIColor(Color.ringColor2)
            context.setFillColor(backgroundColor.cgColor)
            context.fill(pageRect)
            
            // Рисуем звёзды
            for (position, brightness) in stars {
                let starColor = UIColor.white.withAlphaComponent(brightness)
                context.setFillColor(starColor.cgColor)
                context.fillEllipse(in: CGRect(x: position.x, y: position.y, width: 2, height: 2))
            }
        }
    }
    
    /// Рисуем текст по центру
    private func drawCenteredText(_ text: String, attributes: [NSAttributedString.Key: Any]) {
        let attrString = NSAttributedString(string: text, attributes: attributes)
        let textSize = attrString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                               options: [.usesLineFragmentOrigin, .usesFontLeading],
                                               context: nil)
        
        if currentY + textSize.height > pageRect.height - bottomPadding {
            beginNewPage()
        }
        
        let x = (pageRect.width - textSize.width) / 2
        attrString.draw(in: CGRect(x: x, y: currentY, width: textSize.width, height: textSize.height))
        currentY += textSize.height
    }
    
    /// Рисуем атрибутированный текст построчно (без дублирования) используя lineFragmentRect
    private func drawAttributedTextLineByLine(_ attrString: NSAttributedString) {
        let maxWidth = pageRect.width - leftPadding - rightPadding
        
        // Создаём NSTextStorage и NSLayoutManager
        let textStorage = NSTextStorage(attributedString: attrString)
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize(width: maxWidth, height: .greatestFiniteMagnitude))
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        var glyphIndex = 0
        while glyphIndex < layoutManager.numberOfGlyphs {
            var lineRange = NSRange()
            let lineRect = layoutManager.lineFragmentRect(forGlyphAt: glyphIndex, effectiveRange: &lineRange, withoutAdditionalLayout: true)
            
            // Проверяем, поместится ли строка на текущей странице
            if currentY + lineRect.height > pageRect.height - bottomPadding {
                // Если не помещается, начинаем новую страницу
                beginNewPage()
            }
            
            // Отрисовываем строку
            // lineRect.origin.y - это координата строки в контексте текста (сверху 0),
            // нам нужно сдвинуть её так, чтобы она появилась на currentY
            let offset = CGPoint(x: leftPadding, y: currentY - lineRect.origin.y)
            
            layoutManager.drawBackground(forGlyphRange: lineRange, at: offset)
            layoutManager.drawGlyphs(forGlyphRange: lineRange, at: offset)
            
            currentY += lineRect.height
            glyphIndex = NSMaxRange(lineRange)
        }
    }
    
    private func generateStars(in size: CGSize) {
        let screenWidth = size.width
        let screenHeight = size.height
        
        stars = (0..<100).map { _ in
            (
                CGPoint(
                    x: CGFloat.random(in: 0...screenWidth),
                    y: CGFloat.random(in: 0...screenHeight)
                ),
                CGFloat.random(in: 0.5...1.0) // яркость
            )
        }
    }
}
