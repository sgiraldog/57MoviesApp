//
//  Movie.swift
//  MovieApp
//
//  Created by Sebastián Giraldo Gómez on 6/05/21.
//

import Foundation

struct Movies: Decodable {
    let results: [MovieData]
}

struct MovieData: Decodable {
    let title: String
    let voteAverage: Float
    let voteCount: Float
    let overview: String
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case overview
        case posterPath = "poster_path"
    }
}
