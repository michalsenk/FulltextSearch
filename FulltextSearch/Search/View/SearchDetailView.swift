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



struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailView()
    }
}
