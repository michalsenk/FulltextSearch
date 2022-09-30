//
//  RootFeature.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import ComposableArchitecture

struct RootState {
	var searchState = SearchState()
}

enum RootAction {
	case searchAction(SearchAction)
}

struct RootEnvironment {}

let rootReducer = Reducer<
	RootState,
	RootAction,
	SystemEnvironment<RootEnvironment>
>.combine(
	
	searchReducer.pullback(
		state: \.searchState,
		action: /RootAction.searchAction,
		environment: { _ in SystemEnvironment.dev(environment: SearchEnvironment(searchRequest: mockSearchEffect)) }
	)
)
