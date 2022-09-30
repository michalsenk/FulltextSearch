//
//  SearchModel.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Foundation

struct SearchModel: Decodable, Equatable {
	enum CodingKeys: String, CodingKey {
		case name, sportName, category
	}

	let name: String
	let sportName: String
	let category: Int
}

extension SearchModel: Identifiable {
	var id: String { name }
}
