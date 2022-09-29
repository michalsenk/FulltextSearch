//
//  SearchFeature.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Foundation
import ComposableArchitecture
import Combine

struct SearchState: Equatable {
	var searchString: String = ""
	var results: [SearchModel] = []
}

enum SearchAction: Equatable {
	case searchStringChanged(String)
}

struct SearchEnvironment {
	var searchRequest: (JSONDecoder) -> Effect<[SearchModel], APIError>
}

let searchReducer = Reducer<
	SearchState,
	SearchAction,
	SystemEnvironment<SearchEnvironment>
> { state, action, environment in
	
	switch action {
	case .searchStringChanged(let searchString):
		state.searchString = searchString
		return .none
		
	}
	

}

