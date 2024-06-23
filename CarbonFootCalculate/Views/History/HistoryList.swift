//
//  HistoryList.swift
//  CarbonFootCalculate
//
//  Created by 钟钰 on 2024/6/22.
//

import SwiftUI

struct HistoryList: View {
    @Binding var historyData: Data
    @Binding var histories: [History]
    
    private func deleteHistory(at offsets: IndexSet) {
        histories.remove(atOffsets: offsets)
        if let encodedHistory = try? JSONEncoder().encode(histories) {
            historyData = encodedHistory
        }
    }
    
    var body: some View {
        List {
            ForEach(histories, id: \.self) {
                history in
                HistoryItem(history: history)
            }
            .onDelete(perform: deleteHistory)
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            EditButton()
        }
    }
}

