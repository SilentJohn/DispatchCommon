//
//  MultiSelectView.swift
//  DispatchCommon
//
//  Created by Jiang, John X. -ND on 10/26/20.
//

import SwiftUI

public struct MultiSelectView<Label, Selectable>: View where Label: View, Selectable: Hashable & Identifiable & CustomStringConvertible {
    let options: [Selectable]
    var selected: Binding<Set<Selectable>>
    let label: () -> Label
    
    private var allSelectedDescription: String {
        selected.wrappedValue
            .map { $0.description }
            .sorted()
            .joined(separator: "，")
    }
    
    public init(options: [Selectable], selected: Binding<Set<Selectable>>, @ViewBuilder label: @escaping () -> Label) {
        self.options = options
        self.selected = selected
        self.label = label
    }
    
    public var body: some View {
        NavigationLink(destination: multiSelectDetailView()) {
            HStack {
                label()
                Spacer()
                Text(allSelectedDescription)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    private func multiSelectDetailView() -> some View {
        MultiSelectDetailView(options: options, selected: selected)
            .navigationBarTitle("", displayMode: .inline)
    }
}

struct MultiSelectView_Previews: PreviewProvider {
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
            Form {
                MultiSelectView(
                    options: ["A", "B", "C"].map { IdentifiableString(string: $0) },
                    selected: $selected
                ) {
                    Text("Multi Select")
                }
            }
            .navigationTitle("Navigation Title")
        }
    }
}
