//
//  SearchModel.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Foundation

private struct RawModel: Decodable {

	struct ImageO: Decodable {
		var path: String
		var variantTypeId: Int
	}

	struct Sport: Decodable {
		var name: String
	}

	var name: String
	var images: [ImageO]
	var sport: Sport
}

struct SearchModel: Decodable, Equatable {
	let name, sport: String
	let imageName: String?
}

extension SearchModel: Identifiable {
	var id: String { name }
}

extension SearchModel {
	init(from decoder: Decoder) throws {
		let rawModel = try RawModel(from: decoder)
		name = rawModel.name
		sport = rawModel.sport.name
		imageName = rawModel.images
			.filter { $0.variantTypeId == 15 } // 15 == 100x100 pic
			.map { $0.path }
			.first
	}
}
