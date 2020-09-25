//
//  TestHelpers.swift
//  TextFieldTests
//
//  Created by Chad Rutherford on 9/25/20.
//

import UIKit

extension UITextContentType: CustomStringConvertible {
	public var description: String { rawValue }
}

extension UITextAutocorrectionType: CustomStringConvertible {
	public var description: String {
		switch self {
		case .default:
			return "default"
		case .no:
			return "no"
		case .yes:
			return "yes"
		@unknown default:
			fatalError("Unknown UITextAutocorrectionType")
		}
	}
}

extension UIReturnKeyType: CustomStringConvertible {
	public var description: String {
		switch self {
		case .join:
			return "join"
		case .next:
			return "next"
		case .continue:
			return "continue"
		case .default:
			return "default"
		case .done:
			return "done"
		case .emergencyCall:
			return "emergencyCall"
		case .go:
			return "go"
		case .google:
			return "google"
		case .route:
			return "route"
		case .search:
			return "search"
		case .send:
			return "send"
		case .yahoo:
			return "yahoo"
		@unknown default:
			fatalError("Unkown UIReturnKeyType")
		}
	}
}

func executeRunLoop() {
	RunLoop.current.run(until: Date())
}


func shouldChangeCharacters(in textField: UITextField,
							range: NSRange = NSRange(),
							replacement: String) -> Bool? {
	textField.delegate?.textField?(
		textField,
		shouldChangeCharactersIn: range,
		replacementString: replacement
	)
}

func putInViewHeirarchy(_ vc: UIViewController) {
	let window = UIWindow()
	window.addSubview(vc.view)
}

@discardableResult
func shouldReturn(in textField: UITextField) -> Bool? {
	textField.delegate?.textFieldShouldReturn?(textField)
}
