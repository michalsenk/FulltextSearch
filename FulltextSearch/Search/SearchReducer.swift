//
//  SearchReducer.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 08.10.2022.
//

import Combine
import ComposableArchitecture
import Foundation

let searchReducer = Reducer<
	SearchState,
	SearchAction,
	SystemEnvironment<SearchEnvironment>
> { state, action, environment in
	switch action {
	case .searchStringChanged(let searchString):
		guard !searchString.isEmpty else {
			state.results = []
			return .cancel(id: state.searchString)
		}
		state.searchString = searchString
		return .none

	case .searchButtonTapped:
		state.isLoading = true
		return environment.searchRequest(state.searchString, state.searchCategory, environment.decoder())
			.receive(on: environment.mainQueue())
			.delay(for: 2, scheduler: environment.mainQueue())
			.catchToEffect()
			.map(SearchAction.searchDataReturned)
			.cancellable(id: state.searchString)

	case .searchCategoryChanged(let index):

		guard let category = SearchCategory(rawValue: index) else {
			fatalError("Search category not made")
		}

		state.searchCategory = category
		if !state.searchString.isValidSearchString() {
			return .none
		}

		// TODO: cancel previous EFFECT before running new one
		state.isLoading = true
		// TODO: remove duplicit
		return environment.searchRequest(state.searchString, state.searchCategory, environment.decoder())
			.debounce(id: state.searchString, for: .seconds(1), scheduler: environment.mainQueue())
			.receive(on: environment.mainQueue())
			.catchToEffect()
			.map(SearchAction.searchDataReturned)

	case .searchDataReturned( let result):
		state.isLoading = false
		switch result {
		case .success(let data):
			print("searchDataReturned")
			state.results = data
			return .none

		case .failure(let error):
			return .none
		}
	}
}
.signpost()
