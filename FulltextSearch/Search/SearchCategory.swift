//
//  SearchCategory.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 10.10.2022.
//

import Foundation

enum SearchCategory: Int {

	case none, justPlayers, justCompetitions

	static var all: [SearchCategory] {
		[.none, .justCompetitions, .justPlayers]
	}

	var title: String {
		switch self {
		case .none:
			return "Vše"
		case .justPlayers:
			return "Hráči"
		case .justCompetitions:
			return "Soutěže"
		}
	}

	var searchQueryIDs: [Int] {
		switch self {
		case .none:
			return [1, 2, 3, 4]
		case .justPlayers:
			return [3, 4]
		case .justCompetitions:
			return [1]
		}
	}
/*
 type-ids
 1 | soutěže
 2 | týmy
 3 | hráči jednotlivci (napr. tenisti)
 4 | hráči v týmech (napr. fotbalisti)
 */
}

extension SearchCategory: Identifiable {
	var id: Int {
		self.rawValue
	}
}
