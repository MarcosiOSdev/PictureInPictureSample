//
//  AVPlayerViewModel.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import AVKit
import Combine

final class AVPlayerViewModel: ObservableObject {
    @Published var pipStatus: PipStatus = .undefined
    @Published var media: MediaModel?
    @Published var startPip: Bool = false
    
    var startPictureInPictureAutomaticallyFromInline = true
    
    let player = AVPlayer()
    private var cancellable: AnyCancellable?
    
    init() {
        setAudioSessionCategory(to: .playback)
        cancellable = $media
            .compactMap({ $0 })
            .compactMap({ URL(string: $0.url) })
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.player.replaceCurrentItem(with: AVPlayerItem(url: $0))
            })
    }
    
    func play(_ media: MediaModel) {
        self.media = media
        play()
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func setAudioSessionCategory(to value: AVAudioSession.Category) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(value)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
}


