//
//  TestData.swift
//  NetworkRequestTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import Foundation

func jsonData() -> Data {
	"""
	{
		"results": [
			{
				"artistName": "Artist",
				"trackName": "Track",
				"averageUserRating": 2.5,
				"genres": [
					"Foo",
					"Bar"
				]
			}
		]
	}
	""".data(using: .utf8)!
}
