//
//  StringExt.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 30.09.2022.
//

import Foundation

extension String {
	func isValidSearchString() -> Bool {
		return !self.isEmpty
	}
}
