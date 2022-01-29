//
//  PipStatus.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import SwiftUI
import Foundation

enum PipStatus: CaseIterable {
    case willStart
    case didStart
    case willStop
    case didStop
    case undefined
    
    var description: String {
        switch self {
        case .didStart : return "Did Start"
        case .willStart : return "Will Start"
        case .willStop : return "Will Sop"
        case .didStop : return "Did Sop"
        case .undefined: return "Nothing"
        }
    }
    
    var color: Color {
        switch self {
        case .didStart : return .blue
        case .willStart : return .blue
        case .willStop : return .red
        case .didStop : return .red
        case .undefined: return .purple
        }
    }
}
