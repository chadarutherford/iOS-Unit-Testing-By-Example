//
//  TestHelpers.swift
//  TDDTests
//
//  Created by Chad Rutherford on 9/30/20.
//

import Foundation

func date(hour: Int, minute: Int) -> Date {
	let components = DateComponents(calendar: Calendar.current, hour: hour, minute: minute)
	return components.date!
}
