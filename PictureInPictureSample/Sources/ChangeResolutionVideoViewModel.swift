//
//  ChangeResolutionVideoViewModel.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import AVKit
import Combine

final class ChangeResolutionVideoViewModel: ObservableObject {
    
    @Published
    var mediaModel: MediaModel?
    
    @Published
    var currentResolution: Resolution = .p360
    
    
    private var lowerResolution: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var player = AVPlayer()
    private var timeObserverToken: Any?
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        binding()
    }
    deinit {
        removeObservables()
    }
    
    private func binding() {
        
        lowerResolution
            .dropFirst()
            .filter { $0 == true }
            .sink { [weak self] _ in
                self?.changeResolution()
            }
            .store(in: &cancellables)
        
        $currentResolution
            .map { $0.streamURL }
            .sink(receiveValue: replaceItem(_:))
            .store(in: &cancellables)
    }
    
    private func removeObservables() {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
        }
    }
    
    private func replaceItem(_ url: URL) {
        
        let currentTime: CMTime
        
        if let currentItem = player.currentItem {
            currentTime = currentItem.currentTime()
        } else {
            currentTime = .zero
        }
        
        player.replaceCurrentItem(with: .init(url: url))
        player.seek(to: currentTime)
        
        obeservableTimePlayer()
    }
    
    private func changeResolution() {
        guard let newResolution = currentResolution.lowerIfPossible else { return }
        currentResolution = newResolution
    }
    
    private func obeservableTimePlayer() {
        
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
        }
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: .init(value: 1, timescale: 600), queue: .main) { [weak self] time in
            guard let self = self,
            let currentItem = self.player.currentItem else { return }
            
            guard !currentItem.isPlaybackBufferFull else {
                self.lowerResolution.value = false
                return
            }
            
            if currentItem.status == .readyToPlay{
                self.lowerResolution.value = !currentItem.isPlaybackLikelyToKeepUp && !currentItem.isPlaybackBufferEmpty
            }
        }
    }
}
