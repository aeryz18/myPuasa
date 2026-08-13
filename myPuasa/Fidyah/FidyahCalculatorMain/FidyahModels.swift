//
//  FidyahModels.swift
//  myPuasa
//
//  Created by STDC_22 on 10/08/2026.
//

import Foundation


enum FidyahCalculationMethod: String, CaseIterable, Identifiable {
    case food = "Using Food"
    case cash = "Using Cash Value"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .food:
            return "Using Food (1 cup / day)"
        case .cash:
            return "Using Cash Value"
        }
    }

    var subtitle: String {
        switch self {
        case .food:
            return "= 0.75kg of staple food"
        case .cash:
            return "Based on current state rate"
        }
    }
}




struct FidyahRice: Identifiable, Hashable {

    let id = UUID()
    let name: String
    let rate: Double
}




struct FidyahState: Identifiable, Hashable {

    let id = UUID()
    let name: String
    let authority: String
    let rate: Double
    let riceTypes: [FidyahRice]
}




enum FidyahReason: String, CaseIterable, Identifiable {


    case chronicIllness = "Chronic Illness"
    case oldAge = "Old Age"
    case delayedFasting = "Delayed Fasting"
    case pregnancy = "Pregnancy / Breastfeeding"

    var id: String { rawValue }
}




struct FidyahSummaryItem: Identifiable {

    let id = UUID()
    let year: Int
    let days: Int
    let rate: Double
    let multiplier: Int

    var total: Double {
        Double(days) * rate * Double(multiplier)
    }
}
