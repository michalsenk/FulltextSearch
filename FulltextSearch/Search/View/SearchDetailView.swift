//
//  SearchDetailView.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 11.10.2022.
//

import SwiftUI

struct SeasrchDetailView: View {
	var model: SearchModel
	var body: some View {
		VStack {
			HStack {
				LineImageView(url: model.imageUrl, squareSize: 100)
				Text(model.name)
				Spacer()
			}
			Spacer()
		}
		.padding()
	}
}

struct SeasrchDetailViewMock: View {
	let model = SearchModel(
		name: "Djokovic Novak",
		sport: "Tenis",
		country: "Serbia",
		imageUrl: URL(string: "https://www.livesport.cz/res/image/data/tSfwGCdM-0rY6MEPI.png")
	)

	var body: some View {
		SeasrchDetailView(model: model)
	}
}

struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
		SeasrchDetailViewMock()
    }
}
