//
//  SearchView.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Combine
import ComposableArchitecture
import SDWebImageSwiftUI
import SwiftUI

struct SearchView: View {
	let store: Store<SearchState, SearchAction>
    var body: some View {
		WithViewStore(self.store) { viewStore in
			NavigationView {
				VStack {
					Spacer()
					HStack {
						TextField(
							"Co hledat ?",
							text: viewStore.binding(
								get: \.searchString,
								send: SearchAction.searchStringChanged
							)
						)
						.textFieldStyle(.roundedBorder)
						.disableAutocorrection(true)
						.autocapitalization(.none)
						.modifier(ClearButton(text: viewStore.binding(
							get: \.searchString,
							send: SearchAction.searchStringChanged
						)))

						Button("Hledat") {
							viewStore.send(.searchButtonTapped)
						}
						.disabled(viewStore.isLoading)
					}
					HStack {
						Picker(
							selection: viewStore.binding(
								get: \.searchCategory.rawValue,
								send: SearchAction.searchCategoryChanged
						),
						label: Text(""),
						content: {
							ForEach( SearchCategory.all ) { category in
								Text(category.title).tag(category.rawValue)
							}
						}
						)
						.pickerStyle(SegmentedPickerStyle())
					}
					ScrollView {
						VStack {
							Group {
								if viewStore.isLoading {
									Text("Načítám ...")
								}
								else {
									ForEach(viewStore.results) { section in
										Section(header: SectionHeaderView(name: section.name)) {
											ForEach(section.models) { model in
												NavigationLink(
													destination: SeasrchDetailView(model: model)) {
													SearchResultModelView(model: model)
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			.padding()
			.navigationTitle("Vyhledávání")
			.alert(
				self.store.scope(state: \.alert),
				dismiss: .alertCancelTapped
			)
		}
    }
}

struct SectionHeaderView: View {
	let name: String
	var body: some View {
		HStack {
			Text(name)
				.font(.headline)
			Spacer()
		}
		.padding()
	}
}

struct SearchResultModelView: View {
	let model: SearchModel
	var body: some View {
		HStack {
			LineImageView(url: model.imageUrl, squareSize: 50)
			VStack(alignment: .leading) {
				Text(model.name)
					.bold()
				Text(model.country)
			}
			Spacer()
		}
		.padding()
		.frame(height: 50)
	}
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
		let store = Store(
			initialState: SearchState(),
			reducer: searchReducer,
			environment: SystemEnvironment.live(
				environment: SearchEnvironment(
					searchRequest: searchEffect
				)
			)
		)
        SearchView(store: store)
    }
}
