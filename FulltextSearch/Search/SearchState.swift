//
//  SearchState.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 08.10.2022.
//

import Foundation

struct SearchState: Equatable {

	var searchString: String = ""
	var results: [SearchModel] = []
	var isLoading = false
	var searchCategory: SearchCategory = .none
}

enum SearchCategory: Int {

	case none, justPlayers, justCompetitions

	static var all: [SearchCategory] {
		[.none, .justCompetitions, .justPlayers]
	}

	var title: String {
		switch self {
		case .none: return "Vše"
		case .justPlayers: return "Hráči"
		case .justCompetitions: return "Soutěže"
		}
	}

	var searchQueryIDs: [Int] {
		switch self {
		case .none: return [1,2,3,4]
		case .justPlayers: return [1]
		case .justCompetitions: return [2,3,4]
		}
	}
}

extension SearchCategory: Identifiable {
	var id: Int {
		self.rawValue
	}
}
