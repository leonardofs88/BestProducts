//
//  SearchView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI

struct SearchView: View {

    @State private(set) var searchTerm: String = ""
    @State private(set) var caseInsensitive: Bool = true {
        didSet {
            filterState()
        }
    }

    @State private(set) var diacriticInsesitive: Bool = true {
        didSet {
            filterState()
        }
    }

    @State private(set) var filter: FilterOption = .all

    private(set) var termTags: [TermTag]
    private(set) var searchAction: (String, FilterOption) -> Void
    private(set) var deleteTag: (UUID) -> Void
    private(set) var clearTags: () -> Void

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
                                    deleteTag(tag.id)
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
                SwitchButton(
                    isPressed: caseInsensitive,
                    buttonType: .image(.textFormatSize)
                ) { isPressed in
                    caseInsensitive = isPressed
                }

                SwitchButton(
                    isPressed: diacriticInsesitive,
                    buttonType: .text("àéö")
                ) { isPressed in
                    diacriticInsesitive = isPressed
                }

                if !termTags.isEmpty {
                    SystemButtom(buttonType: .text("Clear filter")) {
                        withAnimation {
                            clearTags()
                        }
                    }
                }
            }
            .padding(.top, 5)
        }
        .padding()
        .onChange(of: searchTerm) { _, newTerm in
            guard newTerm != " " else {
                searchTerm = ""
                return
            }

            if newTerm.last == " " {
                searchTerm = ""
            }

            searchAction(newTerm, filter)
        }
    }

    func filterState() {
        if caseInsensitive && diacriticInsesitive {
            filter = .all
        } else if diacriticInsesitive {
            filter = .diacriticInsensitive
        } else if caseInsensitive {
            filter = .caseInsensitive
        } else {
            filter = .none
        }
        searchAction(searchTerm, filter)
    }
}

#Preview {
    SearchView(
        termTags: []
    ) { searchTerm, filter in
        print("search term: \(searchTerm) with filter: \(filter)")
    } deleteTag: { print("delete tag ID: \($0)") }
    clearTags: { print("Tags cleared") }
}

enum FilterOption {
    case caseInsensitive
    case diacriticInsensitive
    case all
    case none
}
