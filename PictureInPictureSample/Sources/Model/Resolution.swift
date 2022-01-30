//
//  Resolution.swift
//  PictureInPictureSample
//
//  Created by marcos.felipe.souza on 29/01/22.
//

import Foundation

enum Resolution: Int, CaseIterable, Identifiable {
    var id: String {
        self.description
    }
    
    case p360 = 0
    case p540
    case p720
    case p1080
    
    var description: String {
        switch self {
        case .p360: return "360p"
        case .p540: return "540p"
        case .p720: return "720p"
        case .p1080: return "1080p"
        }
    }
    
    var streamURL: URL {
        switch self {
        case .p360:
            return URL(string: "https://d142uv38695ylm.cloudfront.net/videos/promo/allesneu.land-promo-trailer-360p.m3u8")!
        case .p540: return URL(string: "https://d142uv38695ylm.cloudfront.net/videos/promo/allesneu.land-promo-trailer-540p.m3u8")!
        case .p720: return URL(string: "https://d142uv38695ylm.cloudfront.net/videos/promo/allesneu.land-promo-trailer-720p.m3u8")!
        case .p1080: return URL(string: "https://d142uv38695ylm.cloudfront.net/videos/promo/allesneu.land-promo-trailer-1080p.m3u8")!
        }
    }
    
    var lowerIfPossible: Resolution? {
        guard rawValue > 0 else { return self }
        
        return Resolution(rawValue: rawValue - 1)
    }
}
