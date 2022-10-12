//
//  ClearButton.swift
//  FulltextSearch
//
//  Created by Michal Šenk on 11.10.2022.
//

import SwiftUI

struct ClearButton: ViewModifier {
	@Binding var text: String

	func body(content: Content) -> some View {
		ZStack(alignment: .trailing) {
			content
			if !text.isEmpty {
				Button(
					action: {
						self.text = ""
					}, label: {
					Image(systemName: "delete.left")
						.foregroundColor(Color(UIColor.opaqueSeparator))
					}
				)
				.padding(.trailing, 8)
			}
		}
	}
}

struct ClearExample: View {
	@State var text = "Mock"

	var body: some View {
		VStack {
			TextField(
				"Co hledat ?",
				text: $text
			)
			.textFieldStyle(.roundedBorder)
			.disableAutocorrection(true)
			.autocapitalization(.none)
			.modifier(ClearButton(text: $text))
			.padding()
			Spacer()
		}
	}
}

struct ClearButton_Previews: PreviewProvider {

	static var previews: some View {
		ClearExample()
	}
}
