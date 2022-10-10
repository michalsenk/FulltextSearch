//
//  SearchEffects.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import ComposableArchitecture
import Foundation

func searchEffect(
	searchQuery: String,
	searchCategory: SearchCategory,
	decoder: JSONDecoder
) -> Effect<[SearchModel], APIError> {

	let escapedQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? searchQuery
	let categoriesString = searchCategory.searchQueryIDs.map { "\($0)" }.joined(separator: ",")
	let URLString = "https://s.livesport.services/api/v2/"
	+ "search?type-ids=\(categoriesString)"
	+ "&project-type-id=1"
	+ "&project-id=602"
	+ "&lang-id=1"
	+ "&q=\(escapedQuery)"
	+ "&sport-ids=1,2,3,4,5,6,7,8,9"
	guard let URL = URL(string: URLString) else {
		fatalError("Search URL not made")
	}

	return URLSession.shared.dataTaskPublisher(for: URL)
		.mapError { error in
			APIError.responseError
		}
		.map { data, _ in
			print(data.prettyPrintedJSONString)
			return data
		}
		.decode(type: [SearchModel].self, decoder: decoder)
		.mapError { error in
			APIError.decodingError
		}
		.eraseToEffect()
}

extension Data {
	var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
		guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
			  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
			  let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

		return prettyPrintedString
	}
}
