//
//  ImageLineView.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 11.10.2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct LineImageView: View {
	let imageName: String?
	let squareSize: CGFloat
	var body: some View {
		Group {
			if let name = imageName, let url = URL(string: "https://www.livesport.cz/res/image/data/\(name)") {
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
	var body: some View {
		VStack {
			LineImageView(imageName: "2yzKvwhU-WOPcYF7D.png", squareSize: 100)
			LineImageView(imageName: "2yzKvwhU-WOPcYF7D.pngX", squareSize: 100)
			LineImageView(imageName: nil, squareSize: 100)
			Spacer()
		}
	}
}

struct ImageLineView_Previews: PreviewProvider {
    static var previews: some View {
		LineImageViewMock()
    }
}
