//
//  SearchAction.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 08.10.2022.
//

import Foundation
import Network

enum SearchAction: Equatable {
	case searchStringChanged(String)
	case searchButtonTapped
	case searchCategoryChanged(Int)
	case doSearch
	case searchDataReturned(Result<[SearchModel], APIError>)
	case alertCancelTapped
	case alertRetryTapped
	case didFinishLaunching
	case networkChange(Result<NWPath.Status, Never>)
}
