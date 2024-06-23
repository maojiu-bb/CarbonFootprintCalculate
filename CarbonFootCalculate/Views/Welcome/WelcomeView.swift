//
//  WelcomeView.swift
//  CarbonFootCalculate
//
//  Created by 钟钰 on 2024/6/22.
//

import SwiftUI

struct WelcomeView: View {
    @State private var currentPage = 0
    @Binding var showWelcome: Bool
    
    let items = [
        (imageName: "welcome1", title: "CarbonFootprintCalculator", subTitle: "Use CarbonFootprintCalculator to track your carbon footprint every day."),
        (imageName: "welcome2", title: "Track Your Activities", subTitle: "Easily log your daily activities and see how they impact your carbon footprint."),
        (imageName: "welcome3", title: "Start Your Journey", subTitle: "Get started with CarbonFootCalculate and make a difference today.")
    ]
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentPage) {
                ForEach(0..<items.count, id: \.self) { index in
                    WelcomeItem(
                        currentPage: $currentPage,
                        showWelcome: $showWelcome,
                        isLast: index == items.count - 1,
                        imageName: items[index].imageName,
                        title: items[index].title,
                        subTitle: items[index].subTitle,
                        totalPages: items.count
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationBarHidden(true)
        }
    }
}
