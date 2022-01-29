//
//  PiPViewControllerRepresentable.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import Foundation
import SwiftUI

struct PiPViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = PiPViewController
    
    func makeUIViewController(context: Context) -> PiPViewController {
        PiPViewController()
    }
    
    func updateUIViewController(_ uiViewController: PiPViewController, context: Context) {}
}
