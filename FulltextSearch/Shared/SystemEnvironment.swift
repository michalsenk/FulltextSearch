//
//  SystemEnvironment.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import ComposableArchitecture
import Foundation
import Network

@dynamicMemberLookup
struct SystemEnvironment<Environment> {
	var environment: Environment

	var mainQueue: () -> AnySchedulerOf<DispatchQueue>
	var decoder: () -> JSONDecoder
	
	let n = NWPathMonitor()

	private static func decoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}

	static func live(environment: Environment) -> Self {
		Self(environment: environment, mainQueue: { .main }, decoder: decoder)
	}

	static func dev(environment: Environment) -> Self {
		Self(environment: environment, mainQueue: { .main }, decoder: decoder)
	}

	subscript<Dependency>(
		dynamicMember keyPath: WritableKeyPath<Environment, Dependency>
	) -> Dependency {
		get { self.environment[keyPath: keyPath] }
		set { self.environment[keyPath: keyPath] = newValue }
	}
}
