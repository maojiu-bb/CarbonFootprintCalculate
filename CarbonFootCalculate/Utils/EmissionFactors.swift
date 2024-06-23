//
//  File.swift
//  CarbonFootCalculate
//
//  Created by 钟钰 on 2024/6/22.
//

import Foundation

struct EmissionFactors {
    static let transportation: [String: Double] = [
        "Car": 0.271, // 每公里排放量，单位：kg CO2e
        "Public transport": 0.105,
        "Bicycle": 0.0,
        "Walk": 0.0
    ]
    
    static let energy: Double = 0.233 // 每千瓦时排放量，单位：kg CO2e
    
    static let diet: [String: Double] = [
        "Balanced diet": 2.5, // 每日排放量，单位：kg CO2e
        "Vegetarian": 1.5,
        "Carnivorous": 3.5
    ]
}
