//import Foundation
//import SwiftUI
//
//struct CarbonFootprint: Identifiable, Codable {
//    var id = UUID()
//    let date: Date
//    let totalEmissions: Double
//    let transportEmissions: Double
//    let energyEmissions: Double
//    let dietEmissions: Double
//}
//
//struct Demo: View {
//    @State private var transportationMode: String = "汽车"
//    @State private var distance: Double = 0.0
//    @State private var energyUsage: Double = 0.0
//    @State private var dietType: String = "均衡饮食"
//    @State private var totalEmissions: Double = 0.0
//    @State private var showResults: Bool = false
//    @AppStorage("carbonFootprintHistory") private var historyData: Data = Data()
//    
//    @State private var history: [CarbonFootprint] = []
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Form {
//                    Section(header: Text("交通")) {
//                        Picker("交通方式", selection: $transportationMode) {
//                            ForEach(EmissionFactors.transportation.keys.sorted(), id: \.self) {
//                                Text($0)
//                            }
//                        }
//                        TextField("距离（公里）", value: $distance, format: .number)
//                            .keyboardType(.decimalPad)
//                    }
//                    
//                    Section(header: Text("能源使用")) {
//                        TextField("月度能源使用（千瓦时）", value: $energyUsage, format: .number)
//                            .keyboardType(.decimalPad)
//                    }
//                    
//                    Section(header: Text("饮食")) {
//                        Picker("饮食类型", selection: $dietType) {
//                            ForEach(EmissionFactors.diet.keys.sorted(), id: \.self) {
//                                Text($0)
//                            }
//                        }
//                    }
//                    
//                    Button("计算碳足迹") {
//                        calculateCarbonFootprint()
//                        showResults = true
//                    }
//                }
//                
//                if showResults {
//                    NavigationLink(destination: CarbonFootprintResultView(
//                        totalEmissions: totalEmissions,
//                        transportEmissions: EmissionFactors.transportation[transportationMode]! * distance,
//                        energyEmissions: EmissionFactors.energy * energyUsage,
//                        dietEmissions: EmissionFactors.diet[dietType]!,
//                        history: $history,
//                        historyData: $historyData
//                    )) {
//                        Text("查看结果")
//                            .padding()
//                    }
//                }
//            }
//            .padding()
//            .navigationTitle("碳足迹计算器")
//            .toolbar {
//                NavigationLink(destination: HistoryView(history: $history, historyData: $historyData)) {
//                    Text("查看历史记录")
//                }
//            }
//            .onAppear {
//                loadHistory()
//            }
//        }
//    }
//    
//    func calculateCarbonFootprint() {
//        let transportEmissions = EmissionFactors.transportation[transportationMode]! * distance
//        let energyEmissions = EmissionFactors.energy * energyUsage
//        let dietEmissions = EmissionFactors.diet[dietType]!
//        
//        totalEmissions = transportEmissions + energyEmissions + dietEmissions
//    }
//    
//    func loadHistory() {
//        if let decodedHistory = try? JSONDecoder().decode([CarbonFootprint].self, from: historyData) {
//            history = decodedHistory
//        }
//    }
//}
//
//struct CarbonFootprintResultView: View {
//    var totalEmissions: Double
//    var transportEmissions: Double
//    var energyEmissions: Double
//    var dietEmissions: Double
//    
//    @Binding var history: [CarbonFootprint]
//    @Binding var historyData: Data
//
//    var body: some View {
//        VStack {
//            Text("总碳足迹: \(totalEmissions, specifier: "%.2f") kg CO2e")
//            List {
//                Text("交通: \(transportEmissions, specifier: "%.2f") kg CO2e")
//                Text("能源使用: \(energyEmissions, specifier: "%.2f") kg CO2e")
//                Text("饮食: \(dietEmissions, specifier: "%.2f") kg CO2e")
//            }
//            Button("保存记录") {
//                saveHistory()
//            }
//            
//            ForEach(getReductionTips(), id: \.self) { tip in
//                Text(tip)
//                    .padding()
//            }
//        }
//        .padding()
//        .navigationTitle("结果")
//    }
//    
//    func getReductionTips() -> [String] {
//        var tips = [String]()
//        if transportEmissions > 100 {
//            tips.append("考虑减少驾车次数，改用公共交通或骑自行车")
//        }
//        if energyEmissions > 100 {
//            tips.append("考虑使用节能电器，减少电力消耗")
//        }
//        if dietEmissions > 100 {
//            tips.append("考虑减少肉类消费，增加植物性食物")
//        }
//        return tips
//    }
//
//    func saveHistory() {
//        let newFootprint = CarbonFootprint(
//            date: Date(),
//            totalEmissions: totalEmissions,
//            transportEmissions: transportEmissions,
//            energyEmissions: energyEmissions,
//            dietEmissions: dietEmissions
//        )
//        history.append(newFootprint)
//        if let encodedHistory = try? JSONEncoder().encode(history) {
//            historyData = encodedHistory
//        }
//    }
//}
//
//struct HistoryView: View {
//    @Binding var history: [CarbonFootprint]
//    @Binding var historyData: Data
//
//    var body: some View {
//        List {
//            ForEach(history) { record in
//                VStack(alignment: .leading) {
//                    Text("日期: \(record.date, formatter: dateFormatter)")
//                    Text("总碳足迹: \(record.totalEmissions, specifier: "%.2f") kg CO2e")
//                    Text("交通: \(record.transportEmissions, specifier: "%.2f") kg CO2e")
//                    Text("能源使用: \(record.energyEmissions, specifier: "%.2f") kg CO2e")
//                    Text("饮食: \(record.dietEmissions, specifier: "%.2f") kg CO2e")
//                }
//            }
//            .onDelete(perform: deleteHistory)
//        }
//        .navigationTitle("历史记录")
//        .toolbar {
//            EditButton()
//        }
//    }
//    
//    func deleteHistory(at offsets: IndexSet) {
//        history.remove(atOffsets: offsets)
//        if let encodedHistory = try? JSONEncoder().encode(history) {
//            historyData = encodedHistory
//        }
//    }
//
//    private var dateFormatter: DateFormatter {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .none
//        return formatter
//    }
//}
//
//#Preview {
//    Demo()
//}
