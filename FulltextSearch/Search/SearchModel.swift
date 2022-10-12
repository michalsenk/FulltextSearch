//
//  SearchModel.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Foundation

private struct RawModel: Decodable {

	struct ImageO: Decodable {
		var path: String?
		var variantTypeId: Int
	}

	struct Country: Decodable {
		var name: String
	}

	struct Sport: Decodable {
		var name: String
	}

	var name: String
	var images: [ImageO]
	var defaultCountry: Country
	var sport: Sport
}

struct SearchModel: Decodable, Equatable {
	let name, sport, country: String
	let imageUrl: URL?
}

extension SearchModel: Identifiable {
	var id: String { name }
}

extension SearchModel {
	init(from decoder: Decoder) throws {
		let rawModel = try RawModel(from: decoder)
		name = rawModel.name
		sport = rawModel.sport.name
		country = rawModel.defaultCountry.name
		let imageName = rawModel.images
			.filter { $0.variantTypeId == 15 } // 15 == 100x100
			.compactMap { $0.path }
			.first

		if let imageName = imageName {
			self.imageUrl = URL(string: "https://www.livesport.cz/res/image/data/\(imageName)")
		}
		else {
			self.imageUrl = nil
		}
	}
}

struct SearchModelSection: Equatable, Identifiable {
	let name: String
	let models: [SearchModel]
	let id: String

	init(name: String, models: [SearchModel]) {
		self.name = name
		self.models = models
		self.id = "\(name)\(models.map { $0.name } .joined())"
	}
}

extension SearchModel {
	static var mockArray: [SearchModel] {
		[
			"https://www.livesport.cz/res/image/data/2yzKvwhU-WOPcYF7D.png",
			"https://www.livesport.cz/res/image/data/OCsZNke5-679ShjBm.png",
			"https://www.livesport.cz/res/image/data/tGlwrdDa-bcMlgUsc.png",
			"https://www.livesport.cz/res/image/data/8nHYSHAr-QD5YRW2q.png"
		].compactMap {
			SearchModel(
				name: "TestName",
				sport: "TestSport",
				country: "TestCountry",
				imageUrl: URL(string: $0)
			)
		}
	}
}

extension Array<SearchModel> {
	func toSections() -> [SearchModelSection] {
		let dict = Dictionary(grouping: self) { $0.sport }
		let sections = dict.map {
			SearchModelSection(name: $0.key, models: $0.value)
		}
		return sections
	}
}
