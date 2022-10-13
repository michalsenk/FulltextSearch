//
//  APIError.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 29.09.2022.
//

import Foundation

enum APIError: LocalizedError {

	case responseError
	case decodingError
	case serviceUnavailable
	case requestValuesMissing
	case requestValuesInvalid

	var localizedDescription: String {
		switch self {

		case .responseError:
			return "Chyba při vyhledávání, zkontrolujte, vaše připojení. To k Internetu."
		case .decodingError:
			return "Omlouváme se, vyhledávání sice něco našlo, ale netuší, co to je."
		case .serviceUnavailable:
			return "Vyhledávání na serveru Livesport momentálně není dostupné."
		case .requestValuesMissing:
			return "Server Livesportu říká, že mu od nás ještě neco chybí."
		case .requestValuesInvalid:
			return "Server Livesportu říká, že to, co mu posíláme, není žádná hitparáda."
		}
	}

	var localizedRetryActionTitle: String {
		switch self {

		case .responseError,
			.decodingError,
			.serviceUnavailable,
			.requestValuesMissing,
			.requestValuesInvalid:
			return "Opakovat"
		}
	}

	var localizedAlertTitle: String {
		switch self {

		case .responseError,
			.decodingError,
			.serviceUnavailable,
			.requestValuesMissing,
			.requestValuesInvalid:
			return "Chyba"
		}
	}
}

extension APIError: Identifiable {
	var id: String {
		localizedDescription
	}
}
