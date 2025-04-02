//
//  AudioManager.swift
//  Persona Code
//
//  Created by Иван Семикин on 02/04/2025.
//

import AVFoundation

final class AudioManager {
    static let shared = AudioManager()
    
    var isMusicEnabled: Bool {
        get {
            if UserDefaults.standard.object(forKey: musicKey) == nil {
                UserDefaults.standard.set(true, forKey: musicKey)
            }
            return UserDefaults.standard.bool(forKey: musicKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: musicKey)
            newValue ? playMusic() : stopMusic()
        }
    }
    
    private var audioplayer: AVAudioPlayer?
    private let musicKey = "isMusicEnabled"
    
    private init() {
        if isMusicEnabled {
            playMusic()
        }
    }
    
    private func playMusic() {
        guard let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") else { return }
        
        do {
            audioplayer = try? AVAudioPlayer(contentsOf: url)
            audioplayer?.numberOfLoops = -1
            audioplayer?.volume = 0.3
            audioplayer?.prepareToPlay()
            audioplayer?.play()
        }
    }
    
    private func stopMusic() {
        audioplayer?.stop()
    }
}
