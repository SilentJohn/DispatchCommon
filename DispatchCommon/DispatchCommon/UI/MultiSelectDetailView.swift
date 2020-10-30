//
//  MultiSelectDetailView.swift
//  DispatchCommon
//
//  Created by Jiang, John X. -ND on 10/26/20.
//

import SwiftUI

struct MultiSelectDetailView<Selectable>: View where Selectable: Identifiable & Hashable & CustomStringConvertible  {
    let options: [Selectable]
    
    @Binding var selected: Set<Selectable>
    
    var body: some View {
        List {
            ForEach(options) { selectable in
                Button(action: {
                    toggleSelection(selectable)
                }) {
                    HStack {
                        Text(selectable.description)
                            .foregroundColor(.black)
                        Spacer()
                        if selected.contains(where: { $0.id == selectable.id }) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .tag(selectable.id)
            }
        }
        .listStyle(GroupedListStyle())
    }
    
    private func toggleSelection(_ selectable: Selectable) {
        if let existedIndex = selected.firstIndex(where: { $0.id == selectable.id }) {
            selected.remove(at: existedIndex)
        } else {
            selected.insert(selectable)
        }
    }
}

struct MultiSelectDetailView_Previews: PreviewProvider {
    struct IdentifiableString: Identifiable, Hashable, CustomStringConvertible {
        let string: String
        
        var id: String {
            return string
        }
        
        var description: String {
            return string
        }
    }
    
    @State static var selected: Set<IdentifiableString> = .init(["A", "C"].map { IdentifiableString(string: $0) })
    
    static var previews: some View {
        NavigationView {
            MultiSelectDetailView(
                options: ["A", "B", "C", "D"].map { IdentifiableString(string: $0) },
                selected: $selected
            )
        }
    }
}
