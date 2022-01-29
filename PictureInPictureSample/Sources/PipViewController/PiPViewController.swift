//
//  PiPViewController.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//
import AVKit
import UIKit

final class PiPViewController: UIViewController {
    
    var pipScreen: PiPScreen!
    var pipController: AVPictureInPictureController!
    
    override func loadView() {
        super.loadView()
        pipScreen = PiPScreen()
        view = pipScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pipScreen.delegate = self
        pipScreen.movieLink = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    }
    
    //Using because of Constraints inside PipScreen
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pipScreen.stop()
    }
    
    func setupPictureInPicture() {
        // Ensure PiP is supported by current device.
        if AVPictureInPictureController.isPictureInPictureSupported() {
            // Create a new controller, passing the reference to the AVPlayerLayer.
            pipController = AVPictureInPictureController(playerLayer: pipScreen.playerLayer)
            pipController.delegate = self
        } else {
            pipScreen.pipButtonHidden(true)
        }
    }
}

extension PiPViewController: PiPScreenDelegate {
    func didSetupAVPlayer() {
        setupPictureInPicture()
    }
    
    func didActionPipButton() {
        pipController.startPictureInPicture()
    }
}


extension PiPViewController: AVPictureInPictureControllerDelegate {
    func pictureInPictureControllerWillStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        
    }

    func pictureInPictureControllerDidStartPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        
    }
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, failedToStartPictureInPictureWithError error: Error) {
        
    }

    func pictureInPictureControllerWillStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        
    }
    
    func pictureInPictureControllerDidStopPictureInPicture(_ pictureInPictureController: AVPictureInPictureController) {
        
    }

    
    func pictureInPictureController(_ pictureInPictureController: AVPictureInPictureController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        
        completionHandler(true)
    }
}

