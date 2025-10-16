//
//  SearchView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

struct SearchView: View {
    @State private(set) var searchTerm: String = ""
    @State private(set) var termTags: [TermTag] = []

    private(set) var searchAction: (String) -> Void

    var body: some View {
        VStack(alignment: .leading) {

            VStack(alignment: .leading) {
                TextField("Search", text: $searchTerm)
                    .padding(.top, 5)
                Divider()
                    .background(.productBackgroundShadow)

                DynamicHStack {
                    ForEach(termTags) { tag in
                        HStack {
                            Text(tag.term)
                            Button {
                                withAnimation {
                                    termTags.removeAll(where: { $0.term == tag.term })
                                }
                            } label: {
                                Image(systemName: "x.circle.fill")
                            }
                        }
                        .padding(3)
                        .foregroundStyle(.white)
                        .background(Color.black)
                    }
                }
            }

            HStack {
                SwitchButton(buttonType: .image(.textFormatSize)) { isPressed in
                    print("filter by font size? ", isPressed)
                }

                SwitchButton(buttonType: .text("àéö")) { isPressed in
                    print("filter by font accentuation? ", isPressed)
                }

                if !termTags.isEmpty {
                    SystemButtom(buttonType: .text("Clear filter")) {
                        print("filter cleared")
                    }
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .onChange(of: searchTerm) { oldTerm, newTerm in
            guard newTerm != " ", !newTerm.isEmpty else {
                searchTerm = ""
                return
            }

            if newTerm.contains(" ") && newTerm.first != " " {
                withAnimation {
                    termTags.append(TermTag(term: oldTerm))
                }

                searchTerm = ""
                searchAction(newTerm)
            }
        }
    }
}

#Preview {
    SearchView { searchTerm in
        print("search term: \(searchTerm)")
    }
}

struct TermTag: Identifiable {
    var id: UUID = UUID()
    var term: String
}
