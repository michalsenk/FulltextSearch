//
//  SearchState.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 08.10.2022.
//

import ComposableArchitecture
import Foundation

struct SearchState: Equatable {

	var searchString: String = "Dj"
	var results: [SearchModelSection] = []
	var isLoading = false
	var searchCategory: SearchCategory = .none
	var alert: AlertState<SearchAction>?
}
