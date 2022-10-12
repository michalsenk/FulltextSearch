//
//  FulltextSearchTests.swift
//  FulltextSearchTests
//
//  Created by Michal Šenk on 29.09.2022.
//

import ComposableArchitecture
import Network
import SDWebImageSwiftUI
import XCTest

@testable import FulltextSearch

final class FulltextSearchTests: XCTestCase {

	let testScheduler = DispatchQueue.test
	let searchResultMock = SearchModel.mockArray

// case searchStringChanged(String)
// case searchButtonTapped
// case searchCategoryChanged(Int)
// case searchDataReturned(Result<[SearchModel], APIError>)
// case alertCancelTapped
// case alertRetryTapped

    func testDataReceivedSearch() {

		let store = TestStore(
			initialState: SearchState(),
			reducer: searchReducer,
			environment: SystemEnvironment(
				environment: SearchEnvironment.dev,
				mainQueue: { self.testScheduler.eraseToAnyScheduler() },
				decoder: { JSONDecoder() },
				pathMonitor: { NWPathMonitor() }
			)
		)

		store.send(.searchDataReturned(.success(searchResultMock))) { [weak self] state in
			guard let self = self else { return }
			state.results = self.searchResultMock.toSections()
		}
    }
}
