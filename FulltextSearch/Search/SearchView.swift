//
//  SearchView.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct SearchView: View {
	let store: Store<SearchState, SearchAction>
    var body: some View {
		WithViewStore(self.store) { viewStore in
			TextField(
				"Hledat ...",
				text: viewStore.binding(
					get: \.searchString,
					send: SearchAction.searchStringChanged)
			)
		}
		
        
    }
}

struct SeasrchDetailView: View {
	var body: some View {
		Text("Detail")
	}
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
		
		let store = Store(initialState: SearchState(), reducer: searchReducer, environment: SystemEnvironment.dev(environment: SearchEnvironment(searchRequest: mockSearchEffect)))
		
        SearchView(store: store)
    }
}
