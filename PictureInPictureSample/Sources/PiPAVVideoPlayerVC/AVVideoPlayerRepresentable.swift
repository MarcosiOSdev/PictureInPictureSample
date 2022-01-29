//
//  AVVideoPlayer.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import Combine
import SwiftUI
import AVKit

typealias AVVideoPlayerView = AVVideoPlayerRepresentable
struct AVVideoPlayerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AVPlayerViewController
    
    @ObservedObject var viewModel: AVPlayerViewModel
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let avPlayerVC = AVPlayerViewController()
        avPlayerVC.player = viewModel.player
        avPlayerVC.canStartPictureInPictureAutomaticallyFromInline = viewModel.startPictureInPictureAutomaticallyFromInline
        avPlayerVC.delegate = makeCoordinator()                
        return avPlayerVC
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

extension AVVideoPlayerRepresentable {
    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        let parent: AVVideoPlayerRepresentable
        
        init(_ parent: AVVideoPlayerRepresentable) {
            self.parent = parent
            
        }
        
        func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.viewModel.pipStatus = .willStart
        }
        
        func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.viewModel.pipStatus = .didStart
        }
        
        func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.viewModel.pipStatus = .willStop
        }
        
        
        func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            parent.viewModel.pipStatus = .didStop
        }
    }
}
