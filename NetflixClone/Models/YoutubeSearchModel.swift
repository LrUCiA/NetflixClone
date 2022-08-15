//
//  YoutubeSearchModel.swift
//  NetflixClone
//
//  Created by LrUCiA.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdElement
}

struct IdElement: Codable {
    let kind: String
    let videoId: String
}
