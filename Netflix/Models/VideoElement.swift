//
//  File.swift
//  Netflix
//
//  Created by Aidos on 31.01.2023.
//

import Foundation

struct YouTubeSearchResponce: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
