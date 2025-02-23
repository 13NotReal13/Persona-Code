//
//  NextButtonView.swift
//  Persona Code
//
//  Created by Иван Семикин on 23/02/2025.
//

//import SwiftUI
//
//struct NavigationButtonView: View {
//    @ObservedObject var enterDataViewModel: EnterDataViewModel
//    
//    var body: some View {
//        NavigationLink(
//            destination: PreloadMatrixDataView(
//                matrix: ShortMatrixData(
//                name: enterDataViewModel.name,
//                dateOfBirthday: enterDataViewModel.dateBirthday,
//                dateCreationMatrix: .now)
//            ),
//            isActive: $enterDataViewModel.canNavigate
//        ) {
//            Button {
//                enterDataViewModel.validateName()
//                enterDataViewModel.validateDate()
//                
//                if enterDataViewModel.isNameValid && enterDataViewModel.isDateValid {
//                    enterDataViewModel.canNavigate = true
//                }
//            } label: {
//                Text("Далее")
//                    .frame(width: UIScreen.main.bounds.width * 0.2)
//                    .customText(fontSize: 16, textColor: .white)
//                    .customButtonStyle(shape: .capsule)
//                    .padding(.top, 16)
//            }
//        }
//    }
//}
//
//#Preview {
//    NavigationButtonView(enterDataViewModel: EnterDataViewModel())
//}
