//
//  SearchFeature.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Combine
import ComposableArchitecture
import Foundation

struct SearchState: Equatable {
	var searchString: String = ""
	var results: [SearchModel] = []
	var isLoading = false
	var searchCriteria: Int = 0
}

enum SearchAction: Equatable {
	case searchStringChanged(String)
	case searchButtonTapped
	case searchCriteriaChanged(Int)
	case searchDataReturned(Result<[SearchModel], APIError>)
}

struct SearchEnvironment {
	var searchRequest: (String, Int, JSONDecoder) -> Effect<[SearchModel], APIError>
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

	case .searchButtonTapped:
		state.isLoading = true
		return environment.searchRequest(state.searchString, state.searchCriteria, environment.decoder())
			.receive(on: environment.mainQueue())
			.delay(for: 2, scheduler: environment.mainQueue())
			.catchToEffect()
			.map(SearchAction.searchDataReturned)

	case .searchCriteriaChanged(let index):
		state.searchCriteria = index
		if !state.searchString.isValidSearchString() {
			return .none
		}
		// TODO: cancel previous EFFECT before running new one
		state.isLoading = true
		// TODO: remove duplicit
		return environment.searchRequest(state.searchString, state.searchCriteria, environment.decoder())
			.receive(on: environment.mainQueue())
			.delay(for: 2, scheduler: environment.mainQueue())
			.catchToEffect()
			.map(SearchAction.searchDataReturned)

	case .searchDataReturned( let result):
		state.isLoading = false
		switch result {
		case .success(let data):
			state.results = data
			return .none

		case .failure(let error):
			return .none
		}
	}
}
