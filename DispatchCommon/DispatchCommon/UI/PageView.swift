//
//  PageView.swift
//  DispatchCommon
//
//  Created by Jiang, John X. -ND on 10/18/20.
//

import SwiftUI

public struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @State var currentPage = 0
    
    public init(_ views: [Page]) {
        viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
    }
}
