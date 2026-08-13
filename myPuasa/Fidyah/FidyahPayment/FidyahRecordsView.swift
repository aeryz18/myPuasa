//
//  FidyahRecordsView.swift
//  myPuasa
//

import SwiftUI

struct FidyahRecordItem: Identifiable {
    let id = UUID()
    let dateString: String
    let amount: Double
    let days: Int
    let paymentMethod: String
    let stateName: String
}

struct FidyahRecordsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedFilter: String = "This Year"
    @State private var selectedRecordForReceipt: FidyahRecordItem? = nil
    
    private let filterOptions = ["This Year", "All Time", "2024", "2023"]
    
    // History records matching screenshot layout
    @State private var records: [FidyahRecordItem] = [
        FidyahRecordItem(dateString: "25 May 2024", amount: 35.00, days: 10, paymentMethod: "Online Banking", stateName: "Selangor"),
        FidyahRecordItem(dateString: "12 May 2024", amount: 15.00, days: 5, paymentMethod: "TnG eWallet", stateName: "Wilayah Persekutuan"),
        FidyahRecordItem(dateString: "10 August 2023", amount: 55.00, days: 15, paymentMethod: "QR DuitNow", stateName: "Johor"),
        FidyahRecordItem(dateString: "17 September 2022", amount: 35.00, days: 10, paymentMethod: "Credit/Debit Card", stateName: "Kedah")
    ]
    
    private var totalPaidThisYear: Double {
        records.prefix(2).reduce(0) { $0 + $1.amount }
    }
    
    private var totalDaysThisYear: Int {
        records.prefix(2).reduce(0) { $0 + $1.days }
    }
    
    var body: some View {
        ZStack {
            FidyahTheme.background
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    // Header Subtitle & Filter Dropdown
                    HStack {
                        Text("Track your Fidyah payments")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Menu {
                            ForEach(filterOptions, id: \.self) { option in
                                Button {
                                    selectedFilter = option
                                } label: {
                                    HStack {
                                        Text(option)
                                        if selectedFilter == option {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Text(selectedFilter)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                Image(systemName: "chevron.down.circle")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(FidyahTheme.cream)
                            .clipShape(Capsule())
                        }
                    }
                    .padding(.top, 8)
                    
                    // List of Fidyah Record Cards
                    VStack(spacing: 14) {
                        ForEach(records) { record in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(record.dateString)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                Text("RM \(record.amount, specifier: "%.2f")")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.primary)
                                
                                Button {
                                    selectedRecordForReceipt = record
                                } label: {
                                    Text("View Receipts")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(18)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(FidyahTheme.cream)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(FidyahTheme.border, lineWidth: 1)
                            )
                        }
                    }
                    
                    // Total Paid Summary Card at Bottom
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Total Paid (\(selectedFilter))")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("RM \(totalPaidThisYear, specifier: "%.2f")")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text("\(totalDaysThisYear) days")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(FidyahTheme.cream)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(FidyahTheme.border, lineWidth: 1)
                    )
                    .padding(.top, 4)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("My Fidyah Records")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedRecordForReceipt) { record in
            paymentReceipt(
                amountPaid: record.amount,
                paymentMethod: record.paymentMethod,
                stateName: record.stateName
            )
        }
    }
}

#Preview {
    NavigationStack {
        FidyahRecordsView()
    }
}
