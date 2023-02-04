//
//  Tv.swift
//  Netflix
//
//  Created by Aidos on 29.01.2023.
//

import Foundation


struct TrendingTvResponce: Codable {
    let results: [Tv]
}

struct Tv: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
