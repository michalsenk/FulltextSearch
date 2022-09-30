//
//  SearchEffects.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Foundation
import ComposableArchitecture

func searchEffect(decoder: JSONDecoder) -> Effect<[SearchModel], APIError> {
	
	//TODO: url as param, URL escape before sending
	
	return URLSession.shared.dataTaskPublisher(for: URL(string: "")!)
		.mapError { _ in APIError.responseError }
		.map { data, _ in data }
		.decode(type: [SearchModel].self, decoder: decoder)
		.mapError { _ in APIError.decodingError }
		.eraseToEffect()
}

func mockSearchEffect(searchQuery: String, searchCategory: Int, decoder: JSONDecoder) ->  Effect<[SearchModel], APIError> {
	
	var mock: [SearchModel] = []
	
	mock.append(SearchModel(name: "Glory", sportName: "Thaibox", category: 2))
	mock.append(SearchModel(name: "Oktagon", sportName: "MMA", category: 2))
	mock.append(SearchModel(name: "RFA", sportName: "MMA", category: 2))
	mock.append(SearchModel(name: "UFC", sportName: "MMA", category: 2))
	mock.append(SearchModel(name: "Škvor", sportName: "Thaibox", category: 1))
	mock.append(SearchModel(name: "Kohout", sportName: "Thaibox", category: 1))
	mock.append(SearchModel(name: "Ronaldo", sportName: "Fotbal", category: 1))
	mock.append(SearchModel(name: "Kincl", sportName: "MMA", category: 1))
	
	// strstr
	mock = mock.filter({
		$0.name.lowercased().localizedStandardContains(searchQuery.lowercased()) ||
		$0.sportName.lowercased().localizedStandardContains(searchQuery.lowercased()) })
	// category
	mock = mock.filter({
		searchCategory == 0 || searchCategory == $0.category
	})
	
	return Effect(value: mock)
}
