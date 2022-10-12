//
//  LineImageView.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 11.10.2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct LineImageView: View {

	let url: URL?
	let squareSize: CGFloat
	var body: some View {
		Group {
			if let url = url {
				WebImage(url: url)
					.placeholder(Image(systemName: "photo.fill"))
					.resizable()
					.frame(width: squareSize, height: squareSize)
					.aspectRatio(contentMode: .fill)
			}
			else {
				Image(systemName: "photo.fill")
					.frame(width: squareSize, height: squareSize)
					.foregroundColor(.gray)
					.overlay(
						RoundedRectangle(cornerRadius: squareSize)
							.stroke(Color(UIColor.lightGray), lineWidth: 1)
					)
			}
		}
	}
}

struct LineImageViewMock: View {

	let validURL = URL(string: "https://www.livesport.cz/res/image/data/2yzKvwhU-WOPcYF7D.png")
	let invalidURL = URL(string: "https://www.livesport.cz/res/image/data/2yzKvwhU-WOPcYF7D.png_XXX")

	var body: some View {
		VStack {
			LineImageView(url: validURL, squareSize: 100)
			LineImageView(url: invalidURL, squareSize: 100)
			LineImageView(url: nil, squareSize: 100)
			Spacer()
		}
	}
}

struct LineImageView_Previews: PreviewProvider {
    static var previews: some View {
		LineImageViewMock()
    }
}
