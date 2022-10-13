//
//  RootReducer.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 08.10.2022.
//

import ComposableArchitecture

let rootReducer = Reducer<
	RootState,
	RootAction,
	SystemEnvironment<RootEnvironment>
>.combine(
	// swiftlint:disable:next trailing_closure
	searchReducer.pullback(
		state: \.searchState,
		action: /RootAction.searchAction,
		environment: { _ in
			SystemEnvironment.live(environment: SearchEnvironment(searchRequest: searchEffect))
		}
	)
)
