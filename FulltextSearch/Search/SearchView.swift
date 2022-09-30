//
//  SearchView.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Combine
import ComposableArchitecture
import SwiftUI

struct SearchView: View {
	let store: Store<SearchState, SearchAction>
    var body: some View {
		WithViewStore(self.store) { viewStore in
			VStack {
				HStack {
					TextField(
						"Hráč nebo soutěž ...",
						text: viewStore.binding(
							get: \.searchString,
							send: SearchAction.searchStringChanged
						)
					)
					.textFieldStyle(.roundedBorder)
					Button("Hledat") {
						viewStore.send(.searchButtonTapped)
					}
					.disabled(viewStore.isLoading)
				}
				HStack {
					Picker(selection: viewStore.binding(
						get: \.searchCriteria,
						send: SearchAction.searchCriteriaChanged
					),
					label: Text(""),
					content: {
						Text("Vše").tag(0)
						Text("Hráči").tag(1)
						Text("Soutěže").tag(2)
					}
					)
					.pickerStyle(SegmentedPickerStyle())
					.disabled(viewStore.isLoading)
				}
				ScrollView {
					VStack {
						Group {
							if viewStore.isLoading {
								Text("Načítám ...")
							}
							else {
								ForEach(viewStore.results) { item in
									NavigationLink(
										destination: SeasrchDetailView(model: item)) {
										SearchResultItemView(item: item)
									}
								}
							}
						}
					}
				}
			}
		}.padding()
    }
}

struct SearchResultItemView: View {
	let item: SearchModel
	var body: some View {
		Text(item.sportName).bold()
		Text(item.name)
		Spacer()
	}
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
		let store = Store(
			initialState: SearchState(),
			reducer: searchReducer,
			environment: SystemEnvironment.dev(
				environment: SearchEnvironment(
					searchRequest: mockSearchEffect
				)
			)
		)
        SearchView(store: store)
    }
}

struct SeasrchDetailView: View {
	var model: SearchModel
	var body: some View {
		VStack {
			Text(model.sportName).bold()
			Text(model.name)
		}
	}
}
