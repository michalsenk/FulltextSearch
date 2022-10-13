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
	var connectivityEffect: () -> Effect<NWPath.Status, Never>

	private static func decoder() -> JSONDecoder {
		let decoder = JSONDecoder()
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		return decoder
	}

	private static func connectivityPublisher() -> Effect<NWPath.Status, Never> {
		let publisher = NWPathMonitor.NetworkStatusPublisher(
			monitor: NWPathMonitor(),
			queue: .main
		)
		return Effect(publisher)
	}

	static func live(environment: Environment) -> Self {
		Self(
			environment: environment,
			mainQueue: { .main },
			decoder: decoder,
			connectivityEffect: connectivityPublisher
		)
	}

	#if DEBUG
		static func dev(environment: Environment, mainQueue: AnySchedulerOf<DispatchQueue>) -> Self {
			Self(
				environment: environment,
				mainQueue: { mainQueue },
				decoder: decoder,
				connectivityEffect: connectivityPublisher
			)
	}
	#endif

	subscript<Dependency>(
		dynamicMember keyPath: WritableKeyPath<Environment, Dependency>
	) -> Dependency {
		get { self.environment[keyPath: keyPath] }
		set { self.environment[keyPath: keyPath] = newValue }
	}
}
