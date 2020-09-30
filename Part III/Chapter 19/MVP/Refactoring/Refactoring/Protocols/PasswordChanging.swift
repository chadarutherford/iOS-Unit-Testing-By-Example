//
//  PasswordChanging.swift
//  Refactoring
//
//  Created by Chad Rutherford on 9/29/20.
//

import Foundation

protocol PasswordChanging {
	func change(securityToken: String, oldPassword: String, newPassword: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
}
