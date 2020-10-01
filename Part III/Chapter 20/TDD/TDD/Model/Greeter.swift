//
//  Greeter.swift
//  TDD
//
//  Created by Chad Rutherford on 9/30/20.
//

import Foundation

struct Greeter {
	
	private let name: String
	private let greetingTimes: [(from: Int, greeting: String)] = [
		(0, "Good evening"),
		(5, "Good morning"),
		(12, "Good afternoon"),
		(17, "Good evening"),
		(24, "SENTINEL"),
	]
	init(name: String) {
		self.name = name
	}
	
	func greet(time: Date) -> String {
		let hello = greeting(for: time)
		if name.isEmpty {
			return "\(hello)."
		}
		return "\(hello), \(name)."
	}
	
	func greeting(for time: Date) -> String {
		let theHour = hour(for: time)
		for (index, greetingTime) in greetingTimes.enumerated() {
			if greetingTime.from <= theHour && theHour < greetingTimes[index + 1].from {
				return greetingTime.greeting
			}
		}
		return ""
	}
	
	private func hour(for time: Date) -> Int {
		let components = Calendar.current.dateComponents([.hour], from: time)
		return components.hour ?? 0
	}
}
