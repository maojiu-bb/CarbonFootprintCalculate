//
//  HistoryItem.swift
//  CarbonFootCalculate
//
//  Created by 钟钰 on 2024/6/22.
//

import SwiftUI

struct HistoryItem: View {
    var history: History
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Date: ")
                    .bold()
                Spacer()
                Text("\(history.date.formatted())")
            }
            HStack {
                Text("Total Carbon Footprint: ")
                    .bold()
                Spacer()
                Text("\(history.total, specifier: "%.2f") kg CO2e")
            }
            HStack {
                Text("Traffic: ")
                    .bold()
                Spacer()
                Text("\(history.trafficl, specifier: "%.2f") kg CO2e")
            }
            HStack {
                Text("Energy Use: ")
                    .bold()
                Spacer()
                Text("\(history.energy, specifier: "%.2f") kg CO2e")
            }
            HStack {
                Text("Diet: ")
                    .bold()
                Spacer()
                Text("\(history.diet, specifier: "%.2f") kg CO2e")
            }
            Section(
                header: Text("Tips:"),
                content: {
                    if history.tips.isEmpty {
                        Text("No Tips")
                    }
                    ForEach(history.tips, id: \.self) {
                        tip in
                        Text(tip)
                    }
                }
            )
        }
        .padding()
        .background(.white)
        .clipShape(
            .rect(cornerRadius: 5)
        )
    }
}

