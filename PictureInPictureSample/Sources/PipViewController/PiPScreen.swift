//
//  PiPScreen.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import UIKit
import AVKit

protocol PiPScreenDelegate: NSObjectProtocol {
    func didSetupAVPlayer()
    func didActionPipButton()
}


final class PiPScreen: UIView {
    
    // MARK: - Create UI
    lazy var playerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pipButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        let startImage = AVPictureInPictureController.pictureInPictureButtonStartImage
        button.setImage(startImage, for: .normal)
        button.setTitle("Pip", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(didTapPipButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties AVPlayer
    private var player: AVPlayer?
    
    
    // MARK: - Publics Properties
    var movieLink: String = "" {
        didSet {
            guard let url = URL(string: movieLink),
            let player = player else { return }
            player.replaceCurrentItem(with: .init(url: url))
        }
    }
    var playerLayer: AVPlayerLayer!
    weak var delegate: PiPScreenDelegate?
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        initialize()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize() {
        setupView()
        setupAnchors()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAVPlayer()
    }
    
    // MARK: - Setups
    private func setupView() {
        addSubview(playerView)
        addSubview(pipButton)
    }
    
    private func setupAnchors() {
        NSLayoutConstraint.activate([
            //playerView
            playerView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            playerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            playerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playerView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 5.0/4.0),
            
            //pipButton
            pipButton.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 0),
            pipButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            pipButton.widthAnchor.constraint(equalToConstant: 100),
            pipButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    private func setupAVPlayer(){
        guard let url = URL(string: movieLink) else {
            return
        }
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = playerView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerView.layer.addSublayer(playerLayer)
        play()
        delegate?.didSetupAVPlayer()
    }
    
    // MARK: - Event UI
    @objc
    func didTapPipButton() {
        delegate?.didActionPipButton()
    }
    
    func play() {
        player?.play()
    }
    
    func stop() {
        player?.pause()
    }
    
    func pipButtonHidden(_ isHidden: Bool) {
        pipButton.isHidden = isHidden
    }
    
}
