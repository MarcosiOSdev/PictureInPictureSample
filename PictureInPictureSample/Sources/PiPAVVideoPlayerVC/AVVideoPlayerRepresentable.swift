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
    
    let avPlayerVC = AVPlayerViewController()
    var changeStatus: ((PipStatus) -> Void)?
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {        
        avPlayerVC.player = viewModel.player
        avPlayerVC.canStartPictureInPictureAutomaticallyFromInline = viewModel.startPictureInPictureAutomaticallyFromInline
        return avPlayerVC
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(avPlayerVC: avPlayerVC, changeStatus: changeStatus)
    }
}

extension AVVideoPlayerRepresentable {
    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        let avPlayerVC: AVPlayerViewController
        
        var changeStatus: ((PipStatus) -> Void)?
        
        init(
            avPlayerVC: AVPlayerViewController,
            changeStatus: ((PipStatus) -> Void)? = nil
        ) {
            self.avPlayerVC = avPlayerVC
            self.changeStatus = changeStatus
            super.init()
            self.avPlayerVC.delegate = self
        }
        
        func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            self.changeStatus?(.willStart)
        }
        
        func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
            self.changeStatus?(.didStart)
        }
        
        func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            self.changeStatus?(.willStop)
        }
        
        
        func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
            self.changeStatus?(.didStop)
        }
    }
}
