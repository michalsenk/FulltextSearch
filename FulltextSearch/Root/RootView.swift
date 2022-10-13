//
//  RootView.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {

	let store: Store<RootState, RootAction>
    var body: some View {
		WithViewStore(self.store.stateless) { _ in
			NavigationView {
				SearchView(
					store: store.scope(
					state: \.searchState,
					action: RootAction.searchAction
				)
				)
			}
		}
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
		RootView(
			store: Store(
				initialState: RootState(),
				reducer: rootReducer,
				environment: SystemEnvironment.live(environment: RootEnvironment())
			)
		)
    }
}
