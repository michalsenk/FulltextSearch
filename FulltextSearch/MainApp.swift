//
//  FulltextSearchApp.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import ComposableArchitecture
import SwiftUI

@main
struct MainApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(
				store: Store(
					initialState: RootState(),
					reducer: rootReducer,
					environment: SystemEnvironment.live(environment: RootEnvironment())
				)
			)
        }
    }
}
