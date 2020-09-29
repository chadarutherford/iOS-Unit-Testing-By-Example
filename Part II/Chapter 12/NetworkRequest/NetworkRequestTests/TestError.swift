//
//  TestError.swift
//  NetworkRequestTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import Foundation

struct TestError: LocalizedError {
	let message: String
	var errorDescription: String? { message }
}
