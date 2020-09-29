//
//  Search.swift
//  NetworkRequest
//
//  Created by Chad Rutherford on 9/25/20.
//

import Foundation

struct Search: Codable {
	let results: [SearchResult]
}

struct SearchResult: Codable, Equatable {
	let artistName: String
	let trackName: String
	let averageUserRating: Float
	let genres: [String]
}
