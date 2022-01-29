//
//  ContentView.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject
    private var viewModel = AVPlayerViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.pipStatus.description)
                .bold()
                .frame(maxWidth: .infinity)
                .foregroundColor(viewModel.pipStatus.color)
            
            AVVideoPlayerView(viewModel: viewModel)
            
            Button("Pip") {
                viewModel.startPip = true
            }
        }
        .onAppear {
            viewModel.play(MediaModel(title: "BigBuckBunny", url: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"))
        }
        .onDisappear(perform: viewModel.pause)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}