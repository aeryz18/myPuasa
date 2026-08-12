import Foundation
import Combine

@MainActor
final class FidyahViewModel: ObservableObject {

    

    let states: [FidyahState]

    // MARK: - Selected Values

    @Published var selectedState: FidyahState

    @Published var selectedReason: FidyahReason = .chronicIllness

    @Published var calculationMethod: FidyahCalculationMethod = .food

    @Published var selectedRice: FidyahRice

    @Published var selectedYear: Int

    @Published var numberOfDays: Int = 1

    @Published var linkToTracker: Bool = false

    

    @Published var summaryItems: [FidyahSummaryItem] = []

    

    init() {

        let selangorRice = [

            FidyahRice(
                name: "Beras Super Special Tempatan 5%",
                rate: 2.00
            ),

            FidyahRice(
                name: "Beras Perang, Beras Pulut, Beras Wangi",
                rate: 4.30
            ),

            FidyahRice(
                name: "Beras Herba Ponni, Beras Jepun, Basmathi",
                rate: 6.30
            )
        ]


        let johorRice = [

            FidyahRice(
                name: "Beras Super Special Tempatan 5%",
                rate: 2.00
            ),

            FidyahRice(
                name: "Beras Perang",
                rate: 4.00
            ),

            FidyahRice(
                name: "Beras Basmathi",
                rate: 6.00
            )
        ]


        let kedahRice = [

            FidyahRice(
                name: "Beras Super Special Tempatan 5%",
                rate: 2.00
            ),

            FidyahRice(
                name: "Beras Wangi",
                rate: 4.00
            ),

            FidyahRice(
                name: "Beras Basmathi",
                rate: 6.00
            )
        ]


        states = [

            FidyahState(
                name: "Selangor",
                authority: "Majlis Agama Islam Selangor (MAIS)",
                rate: 3.50,
                riceTypes: selangorRice
            ),

            FidyahState(
                name: "Johor",
                authority: "Majlis Agama Islam Negeri Johor",
                rate: 3.00,
                riceTypes: johorRice
            ),

            FidyahState(
                name: "Kedah",
                authority: "Lembaga Zakat Negeri Kedah",
                rate: 2.50,
                riceTypes: kedahRice
            )
        ]


        selectedState = states[0]

        selectedRice = states[0].riceTypes[0]

        selectedYear = Calendar.current.component(
            .year,
            from: Date()
        )
    }


    // MARK: - Current Rate

    var currentRate: Double {

        switch calculationMethod {

        case .food:
            return selectedRice.rate

        case .cash:
            return selectedState.rate
        }
    }


    // MARK: - Current Amount

    var currentAmount: Double {

        Double(numberOfDays) * currentRate
    }


    // MARK: - Summary Total

    var grandTotal: Double {

        summaryItems.reduce(0) { total, item in
            total + item.total
        }
    }


    // MARK: - Change State

    func changeState(_ state: FidyahState) {

        selectedState = state

        // Automatically select first rice
        // from the newly selected state.

        if let firstRice = state.riceTypes.first {

            selectedRice = firstRice
        }
    }


    // MARK: - Add Summary

    func addRecord() {

        guard numberOfDays > 0 else {
            return
        }


        let item = FidyahSummaryItem(

            year: selectedYear,

            days: numberOfDays,

            rate: currentRate
        )


        summaryItems.append(item)
    }


    // MARK: - Delete Summary

    func deleteRecord(
        _ item: FidyahSummaryItem
    ) {

        summaryItems.removeAll {

            $0.id == item.id
        }
    }


    // MARK: - Clear Summary

    func clearSummary() {

        summaryItems.removeAll()
    }
}
