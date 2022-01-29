//
//  PictureInPictureSampleApp.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import SwiftUI

@main
struct PictureInPictureSampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                List {                    
                    NavigationLink("PiP w/ UIViewController") {
                        PiPViewControllerRepresentable()
                    }
                    
                    NavigationLink(destination: {
                        ContentView()
                    }, label: {
                        (Text("PiP SwiftUI ") + Text("UIViewControllerRepresentable").font(.caption))
                    })
                }
                .navigationBarTitle("Picture in Picture Samples 🎬")
            }
        }
    }
}
