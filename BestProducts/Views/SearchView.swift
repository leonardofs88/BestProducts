//
//  SearchView.swift
//  BestProducts
//
//  Created by Leonardo Soares on 15/10/2025.
//

import SwiftUI
import Factory

struct SearchView: View {

    @Injected(\.filterManager) private var filterManager

    @State private(set) var searchTerm: String = ""
    @State private(set) var caseInsensitive: Bool = true {
        didSet {
            filterAction()
        }
    }

    @State private(set) var diacriticInsesitive: Bool = true {
        didSet {
            filterAction()
        }
    }

    private(set) var termTags: [TermTag]
    private(set) var searchAction: (String) -> Void
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

            searchAction(newTerm)
        }
    }

    func filterAction() {
        Task {
            await filterManager.setOption(
                caseInsensitive: caseInsensitive,
                diacriticInsesitive: diacriticInsesitive
            )
            searchAction(searchTerm)
        }
    }
}

#Preview {
    SearchView(
        termTags: []
    ) { searchTerm in
        print("search term: \(searchTerm)")
    } deleteTag: { print("delete tag ID: \($0)") }
    clearTags: { print("Tags cleared") }
}
