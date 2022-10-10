//
//  SearchAction.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 08.10.2022.
//

import Foundation

enum SearchAction: Equatable {
	case searchStringChanged(String)
	case searchButtonTapped
	case searchCategoryChanged(Int)
	case searchDataReturned(Result<[SearchModel], APIError>)
}

