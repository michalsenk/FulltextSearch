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

func mockSearchEffect(decoder: JSONDecoder) ->  Effect<[SearchModel], APIError> {

	let mock = [
		SearchModel(name: "Ronaldo", sportName: "Football"),
		SearchModel(name: "Kincl", sportName: "MMA"),
		SearchModel(name: "Škvor", sportName: "Thaibox"),
		SearchModel(name: "Kohout", sportName: "Thaibox")
	]
	return Effect(value: mock)
}
