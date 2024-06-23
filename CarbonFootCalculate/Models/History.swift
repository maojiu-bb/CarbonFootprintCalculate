//
//  History.swift
//  CarbonFootCalculate
//
//  Created by 钟钰 on 2024/6/22.
//

import Foundation

struct History: Hashable, Encodable, Decodable {
    var date: Date = Date.now
    var total: Double = 0.0
    var trafficl: Double = 0.0
    var energy: Double = 0.0
    var diet: Double = 0.0
    var tips: [String] = []
}
