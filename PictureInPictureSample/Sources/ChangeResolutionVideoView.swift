//
//  ChangeResolutionVideoView.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import SwiftUI
import AVKit

struct ChangeResolutionVideoView: View {
    
    @ObservedObject
    private var viewModel = ChangeResolutionVideoViewModel()

    @State private var showResolutions = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            
            if showResolutions {
                
                VStack(alignment: .center, spacing: 24) {
                    ForEach(Resolution.allCases) { resolution in
                        Button(resolution.description) {
                            viewModel.currentResolution = resolution
                            withAnimation {
                                showResolutions.toggle()
                            }
                        }
                    }
                    
                    Button {
                        showResolutions.toggle()
                    } label: {
                        Image(systemName: "xmark.circle")
                            .imageScale(.large)
                    }

                }
                
            } else {
                Text("Current Resolution = \(viewModel.currentResolution.description)")
                Button("Change resolution") {
                    withAnimation {
                        showResolutions.toggle()
                    }
                }
                
                VideoPlayer(player: viewModel.player)
            }
        }
        
    }
}
