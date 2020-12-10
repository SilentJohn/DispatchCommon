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
    
    private let timer = Timer.publish(every: 3, on: .main, in: .default).autoconnect()
    
    public init(_ views: [Page]) {
        viewControllers = views.map { UIHostingController(rootView: $0) }
    }
    
    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, currentPage: $currentPage)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }
        .onReceive(timer) { _ in
            currentPage = (currentPage + 1) % viewControllers.count
        }
    }
}
