//
//  ResultView.swift
//  CarbonFootCalculate
//
//  Created by 钟钰 on 2024/6/22.
//

import SwiftUI

struct ResultView: View {
    @Binding var history: [History]
    @Binding var historyData: Data
    @State private var totalEmissions: Double = 0.0
    @State private var transportEmissions: Double = 0.0
    @State private var energyEmissions: Double = 0.0
    @State private var dietEmissions: Double = 0.0
    var transportationMode: String
    var distance: Double
    var energyUsage: Double
    var dietType: String
    
    private func calculateCarbonFootprint() {
        transportEmissions = EmissionFactors.transportation[transportationMode]! * distance
        energyEmissions = EmissionFactors.energy * energyUsage
        dietEmissions = EmissionFactors.diet[dietType]!
        
        totalEmissions = transportEmissions + energyEmissions + dietEmissions
        
        saveHistory()
    }
    
    func getReductionTips() -> [String] {
        var tips = [String]()
        if transportEmissions > 100 {
            tips.append("Consider driving less and switching to public transport or cycling")
        }
        if energyEmissions > 100 {
            tips.append("Consider using energy-efficient appliances to reduce your electricity consumption")
        }
        if dietEmissions > 100 {
            tips.append("Consider reducing meat consumption and increasing plant-based foods")
        }
        return tips
    }
    
    func saveHistory() {
        let newFootprint = History(
            date: Date(),
            total: totalEmissions,
            trafficl: transportEmissions,
            energy: energyEmissions,
            diet: dietEmissions,
            tips: getReductionTips()
        )
        history.append(newFootprint)
        if let encodedHistory = try? JSONEncoder().encode(history) {
            historyData = encodedHistory
        }
    }
    
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                HStack {
                    Text("Total Carbon Footprint: ")
                        .bold()
                    Spacer()
                    Text("\(totalEmissions, specifier: "%.2f") kg CO2e")
                }
                .padding()
                HStack {
                    Text("Traffic: ")
                        .bold()
                    Spacer()
                    Text("\(transportEmissions, specifier: "%.2f") kg CO2e")
                }
                .padding()
                HStack {
                    Text("Energy Use: ")
                        .bold()
                    Spacer()
                    Text("\(energyEmissions, specifier: "%.2f") kg CO2e")
                }
                .padding()
                HStack {
                    Text("Diet: ")
                        .bold()
                    Spacer()
                    Text("\(dietEmissions, specifier: "%.2f") kg CO2e")
                }
                .padding()
            }
            
             Section(
                header: Text("Tips"),
                content: {
                    if getReductionTips().isEmpty {
                        Text("No Tips")
                    }
                    ForEach(getReductionTips(), id: \.self) {
                        tip in
                        Text(tip)
                    }
                }
            )
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            calculateCarbonFootprint()
        }
    }
}

//#Preview {
//    ResultView(
//        transportationMode: "Car",
//        distance: 100.0,
//        energyUsage: 100.0,
//        dietType: "Balanced diet"
//    )
//}
