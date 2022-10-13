//
//  SearchAPIErrorResponse.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 11.10.2022.
//

import Foundation

struct SearchAPIErrorResponse: Decodable, Error {
	let code: Int
	let message: String
	let name: String
	let stack: String
	let errors: [[String: String]]
}
