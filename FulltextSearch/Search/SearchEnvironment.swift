//
//  SearchEnvironment.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 08.10.2022.
//

import Combine
import ComposableArchitecture
import Foundation

struct SearchEnvironment {
	var searchRequest: (String, SearchCategory, JSONDecoder) -> Effect<[SearchModel], APIError>
}

#if DEBUG
extension SearchEnvironment {
	static var dev = SearchEnvironment(searchRequest: { String, SearchCategory, JSONDecoder in
		return Effect(value: SearchModel.mockArray)
	})
}
#endif
