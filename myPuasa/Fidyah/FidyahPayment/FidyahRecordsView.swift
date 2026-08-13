//
//  FidyahRecordsView.swift
//  myPuasa
//

import SwiftUI

struct FidyahRecordItem: Identifiable, Equatable, Codable {
    var id: UUID = UUID()
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
    
    // History records read from active user profile
    private var records: [FidyahRecordItem] {
        UserStore.shared.currentUser.fidyahRecords
    }
    
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
