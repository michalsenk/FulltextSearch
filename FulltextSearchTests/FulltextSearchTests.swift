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

	let testEnvironment = SystemEnvironment.dev(
		environment: SearchEnvironment.dev,
		mainQueue: DispatchQueue.test.eraseToAnyScheduler()
	)

	func mockAlert(forError error: APIError) -> AlertState<SearchAction> {
		AlertState(
			title: TextState(error.localizedAlertTitle),
			message: TextState(error.localizedDescription),
			primaryButton: .default( TextState(error.localizedRetryActionTitle), send: .alertRetryTapped),
			secondaryButton: .cancel(send: .alertCancelTapped)
		)
	}

	func testSearchStringChange() {

		var state = SearchState(
			searchString: "",
			results: searchResultMock.toSections()
		)

		_ = searchReducer(&state, .searchStringChanged("test"), testEnvironment)
		XCTAssertEqual(
			state,
			SearchState(
				searchString: "test",
				results: searchResultMock.toSections()
			)
		)

		_ = searchReducer(&state, .searchStringChanged(""), testEnvironment)
		XCTAssertEqual(
			state,
			SearchState(
				searchString: "",
				results: []
			)
		)
	}

	func testCategoryChanged() {

		guard
			let category1 = SearchCategory(rawValue: 1),
			let category2 = SearchCategory(rawValue: 2)
		else {
			fatalError("Test category not made")
		}

		var state = SearchState(
			isLoading: false,
			searchCategory: category1
		)

		_ = searchReducer(&state, .searchCategoryChanged(category2.rawValue), testEnvironment)
		XCTAssertEqual(
			state,
			SearchState(
				isLoading: true,
				searchCategory: category2
			)
		)
	}

    func testDataReceivedSearchHappy() {

		let store = TestStore(
			initialState: SearchState(),
			reducer: searchReducer,
			environment: testEnvironment
		)

		store.send(.searchDataReturned(.success(searchResultMock))) { [weak self] state in
			guard let self = self else { return }
			state.results = self.searchResultMock.toSections()
		}
    }

	func testDataReceivedSearchUnhappy() {
		let store = TestStore(
			initialState: SearchState(),
			reducer: searchReducer,
			environment: testEnvironment
		)

		let decodeError = APIError.decodingError

		store.send(.searchDataReturned(.failure(decodeError))) { [weak self] state in
			guard let self = self else { return }
			state.alert = self.mockAlert(forError: decodeError)
		}
	}

	func testAlertCancelTapped() {

		let decodeError = APIError.decodingError

		let store = TestStore(
			initialState: SearchState(alert: self.mockAlert(forError: decodeError)),
			reducer: searchReducer,
			environment: testEnvironment
		)

		store.send(.alertCancelTapped) {
			$0.alert = nil
		}
	}

	func testAlertRetryTapped() {

	}

//	func testSearchButtonTappedFlow() async {
//		
//		let store = TestStore(
//			initialState: SearchState(searchString: "Dj"),
//			reducer: searchReducer,
//			environment: testEnvironment
//		)
//
//		_ = await store.send(.doSearch)
//
//		await testScheduler.advance(by: 2)
//
//		await store.receive(.searchDataReturned(.success(searchResultMock))) {
//			$0.results = SearchModel.mockArray.toSections()
//			$0.isLoading = false
//		}
//
//	}

}
