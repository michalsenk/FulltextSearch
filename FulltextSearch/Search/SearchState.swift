//
//  SearchState.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 08.10.2022.
//

import ComposableArchitecture
import Foundation
import Network

struct SearchState: Equatable {

	var searchString: String = ""
	var results: [SearchModelSection] = []
	var isLoading = false
	var searchCategory: SearchCategory = .none
	var alert: AlertState<SearchAction>?
	var networkStatus: NWPath.Status = .satisfied
}
