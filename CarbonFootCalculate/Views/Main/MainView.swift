//
//  MainView.swift
//  CarbonFootCalculate
//
//  Created by 钟钰 on 2024/6/22.
//

import SwiftUI

struct MainView: View {
    @State var transportationMode: String = "Car"
    @State private var distance: Double = 0.0
    @State private var energyUsage: Double = 0.0
    @State private var dietType: String = "Balanced diet"
    @AppStorage("carbonFootprintHistory") private var historyData: Data = Data()
    @State private var histories: [History] = []
    
    func loadHistory() {
        if let decodedHistory = try? JSONDecoder().decode([History].self, from: historyData) {
            histories = decodedHistory
        }
    }
    
    var body: some View {
        NavigationSplitView {
            VStack{
                List {
                    Section(
                        header: Text("Transportation"),
                        content: {
                            Picker("TransportationMode", selection: $transportationMode) {
                                ForEach(EmissionFactors.transportation.keys.sorted(), id: \.self) {
                                    Text($0)
                                }
                            }
                            TextField("Distance(mile)", value: $distance, format: .number)
                                .keyboardType(.decimalPad)
                        }
                    )
                    Section(
                        header: Text("Energy Use"),
                        content: {
                            TextField("Monthly energy use(Kilowatt-hour)", value: $energyUsage, format: .number)
                                .keyboardType(.decimalPad)
                        }
                    )
                    Section(
                        header: Text("Diet"),
                        content: {
                            Picker("DietType", selection: $dietType) {
                                ForEach(EmissionFactors.diet.keys.sorted(), id: \.self) {
                                    Text($0)
                                }
                            }
                            
                        }
                    )
                    
                    NavigationLink {
                        ResultView(
                            history: $histories,
                            historyData: $historyData,
                            transportationMode: transportationMode,
                            distance: distance,
                            energyUsage: energyUsage,
                            dietType: dietType
                        )
                    } label: {
                        
                        Text("Calculate Carbon Footprint")
                            .foregroundStyle(.blue)
                        
                    }
                }
            }
            .navigationTitle("Calculator")
            .toolbar {
                NavigationLink {
                    HistoryList(historyData: $historyData, histories: $histories)
                } label: {
                    Image(systemName: "clock")
                }
            }.onAppear {
                loadHistory()
            }
        } detail: {
            Text("calculate")
        }
    }
}

#Preview {
    MainView()
}
