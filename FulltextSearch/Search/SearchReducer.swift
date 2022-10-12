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
		state.searchString = searchString
		guard !searchString.isEmpty else {
			state.results = []
			return .cancel(id: state.searchString)
		}
		return .none

	case .searchButtonTapped:
		state.isLoading = true
		return search(state.searchString, state.searchCategory, environment)

	case .searchCategoryChanged(let index):
		guard let category = SearchCategory(rawValue: index) else {
			fatalError("Search category not made")
		}

		state.searchCategory = category
		if !state.searchString.isValidSearchString() {
			return .none
		}

		state.isLoading = true
		return search(state.searchString, state.searchCategory, environment)

	case .searchDataReturned( let result):
		state.isLoading = false
		switch result {
		case .success(let models):
			state.results = models.toSections()
			return .none

		case .failure(let error):
			state.alert = AlertState(
				title: TextState(error.localizedAlertTitle),
				message: TextState(error.localizedDescription),
				primaryButton: .default( TextState(error.localizedRetryActionTitle), send: .alertRetryTapped),
				secondaryButton: .cancel(send: .alertCancelTapped)
			)
			return .none
		}

	case .alertCancelTapped:
		state.alert = nil
		return .none

	case .alertRetryTapped:
		state.alert = nil
		state.isLoading = true
		return search(state.searchString, state.searchCategory, environment)
	}
}
.signpost()

private func search (
	_ searchString: String,
	_ category: SearchCategory,
	_ environment: SystemEnvironment<SearchEnvironment>
	) -> Effect<SearchAction, Never> {

		let cancelID = searchString
		return environment.searchRequest(searchString, category, environment.decoder())
			.debounce(id: cancelID, for: .seconds(1), scheduler: environment.mainQueue())
			.receive(on: environment.mainQueue())
			.catchToEffect()
			.map(SearchAction.searchDataReturned)
			.cancellable(id: cancelID)
}
