//
//  FidyahCalView.swift
//  myPuasa
//
//  Created by STDC_22 on 10/08/2026.
//

import SwiftUI

struct FidyahCalView: View {

    @StateObject private var vm = FidyahViewModel()

    @State private var stateExpanded = false
    @State private var reasonExpanded = false
    @State private var showPayment = false


    var body: some View {
        
        NavigationStack {
            ScrollView(
                .vertical,
                showsIndicators: false
            ) {
                
                VStack(
                    alignment: .leading,
                    spacing: 18
                ) {
                    
                    
                    
                    VStack(
                        alignment: .leading,
                        spacing: 6
                    ) {
                        
                        HStack {
                            Text("Fidyah Calculator")
                                .font(
                                    .system(
                                        size: 31,
                                        weight: .bold
                                    )
                                )
                            
                            Spacer()
                            
                            NavigationLink {
                                FidyahRecordsView()
                            } label: {
                                HStack(spacing: 6) {
                                    ZStack {
                                        Circle()
                                            .fill(FidyahTheme.maroon)
                                            .frame(width: 26, height: 26)
                                        Image(systemName: "clock.fill")
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                    }
                                    
                                    Text("History")
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .foregroundColor(FidyahTheme.maroon)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(FidyahTheme.cream)
                                .clipShape(Capsule())
                            }
                        }
                        }
                        
                        
                        
                        Text(
                            "Calculate your fidyah contribution"
                        )
                        .font(.system(size: 14))
                        .foregroundStyle(
                            FidyahTheme.secondaryText
                        )
                    }
                    
                    
                    
                    
                    FidyahAboutCard()
                    
                    
                    
                    
                    FidyahSectionTitle(
                        number: "1",
                        title: "Select Your State"
                    )
                    
                    
                    FidyahDropdownCard(
                        icon: "mappin.and.ellipse",
                        title: vm.selectedState.name,
                        subtitle: vm.selectedState.authority,
                        isExpanded: $stateExpanded
                    ) {
                        
                        VStack(spacing: 0) {
                            
                            ForEach(vm.states) { state in
                                
                                Button {
                                    
                                    vm.changeState(state)
                                    
                                    withAnimation {
                                        stateExpanded = false
                                    }
                                    
                                } label: {
                                    
                                    HStack {
                                        
                                        VStack(
                                            alignment: .leading,
                                            spacing: 3
                                        ) {
                                            
                                            Text(state.name)
                                                .font(
                                                    .system(
                                                        size: 14,
                                                        weight: .semibold
                                                    )
                                                )
                                                .foregroundStyle(.black)
                                            
                                            Text(state.authority)
                                                .font(.system(size: 11))
                                                .foregroundStyle(
                                                    FidyahTheme.secondaryText
                                                )
                                        }
                                        
                                        Spacer()
                                        
                                        if state.id ==
                                            vm.selectedState.id {
                                            
                                            Image(
                                                systemName:
                                                    "checkmark.circle.fill"
                                            )
                                            .foregroundStyle(
                                                FidyahTheme.maroon
                                            )
                                        }
                                    }
                                    .padding(
                                        .horizontal,
                                        18
                                    )
                                    .padding(
                                        .vertical,
                                        12
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                    
                    
                    FidyahSectionTitle(
                        number: "2",
                        title: "Reason for Fidyah"
                    )
                    
                    
                    FidyahDropdownCard(
                        icon: "heart.text.square.fill",
                        title: vm.selectedReason.rawValue,
                        subtitle: "Select your reason",
                        isExpanded: $reasonExpanded
                    ) {
                        
                        VStack(spacing: 0) {
                            
                            ForEach(
                                FidyahReason.allCases
                            ) { reason in
                                
                                Button {
                                    
                                    vm.selectedReason = reason
                                    
                                    withAnimation {
                                        reasonExpanded = false
                                    }
                                    
                                } label: {
                                    
                                    HStack {
                                        
                                        Text(reason.rawValue)
                                            .font(.system(size: 14))
                                            .foregroundStyle(.black)
                                        
                                        Spacer()
                                        
                                        if reason ==
                                            vm.selectedReason {
                                            
                                            Image(
                                                systemName:
                                                    "checkmark.circle.fill"
                                            )
                                            .foregroundStyle(
                                                FidyahTheme.maroon
                                            )
                                        }
                                    }
                                    .padding(
                                        .horizontal,
                                        18
                                    )
                                    .padding(
                                        .vertical,
                                        13
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    
                    
                   
                    
                    FidyahSectionTitle(
                        number: "3",
                        title: "Calculation Method"
                    )
                    
                    
                    FidyahRadioCard(
                        title: FidyahCalculationMethod.food.title,
                        subtitle: FidyahCalculationMethod.food.subtitle,
                        selected:
                            vm.calculationMethod == .food
                    ) {
                        
                        withAnimation(.easeInOut(duration: 0.2)) {
                            
                            vm.calculationMethod = .food
                        }
                    }
                    
                    
                    FidyahRadioCard(
                        title: FidyahCalculationMethod.cash.title,
                        subtitle: FidyahCalculationMethod.cash.subtitle,
                        selected:
                            vm.calculationMethod == .cash
                    ) {
                        
                        withAnimation(.easeInOut(duration: 0.2)) {
                            
                            vm.calculationMethod = .cash
                        }
                    }
                    
                    
                   
                    
                    if vm.calculationMethod == .food {
                        
                        FidyahSectionTitle(
                            number: "4",
                            title: "Jenis Beras"
                        )
                        
                        
                        VStack(spacing: 10) {
                            
                            ForEach(
                                vm.selectedState.riceTypes
                            ) { rice in
                                
                                FidyahRiceCard(
                                    rice: rice,
                                    selected:
                                        rice.id ==
                                    vm.selectedRice.id
                                ) {
                                    
                                    withAnimation(
                                        .easeInOut(
                                            duration: 0.2
                                        )
                                    ) {
                                        
                                        vm.selectedRice = rice
                                    }
                                }
                            }
                        }
                    }
                    
                    
                   
                    
                    FidyahSectionTitle(
                        number:
                            vm.calculationMethod == .food
                        ? "5"
                        : "4",
                        title: "Fasting Details"
                    )
                    
                    
                    HStack(
                        alignment: .top,
                        spacing: 12
                    ) {
                        
                        FidyahYearCard(
                            year: $vm.selectedYear
                        )
                        
                        FidyahDaysCard(
                            days: $vm.numberOfDays
                        )
                    }
                    
                    
                   
                    
                    Toggle(
                        isOn: $vm.linkToTracker
                    ) {
                        VStack(
                            alignment: .leading,
                            spacing: 3
                        ) {
                            Text("Link to your tracker")
                                .font(
                                    .system(
                                        size: 14,
                                        weight: .semibold
                                    )
                                )
                            
                            if vm.linkToTracker {
                                Text("Synced: \(vm.syncedFastCount) uncompleted fast(s) from 2025 & prior (2026 excluded)")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundStyle(FidyahTheme.maroon)
                            } else {
                                Text(
                                    "Keep this record connected to your fasting tracker."
                                )
                                .font(.system(size: 11))
                                .foregroundStyle(
                                    FidyahTheme.secondaryText
                                )
                            }
                        }
                    }
                    .tint(FidyahTheme.maroon)
                    .padding(16)
                    .background(Color.white)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                    )
                    .onChange(of: vm.linkToTracker) { _, newValue in
                        if newValue {
                            vm.syncWithFastingTracker()
                        }
                    }
                    
                    
                    
                    
                    FidyahPrimaryButton(
                        title: "Add to Summary",
                        disabled:
                            vm.numberOfDays <= 0
                    ) {
                        
                        withAnimation(
                            .spring(
                                response: 0.35
                            )
                        ) {
                            
                            vm.addRecord()
                        }
                    }
                    
                    
                   
                    
                    if !vm.summaryItems.isEmpty {
                        
                        FidyahSectionTitle(
                            number: "6",
                            title: "Summary"
                        )
                        
                        
                        VStack(spacing: 0) {
                            
                            
                            
                            HStack {
                                Text("Year")
                                Spacer()
                                Text("Days")
                                Spacer()
                                Text("Gandaan")
                                Spacer()
                                Text("Rate")
                                Spacer()
                                Text("Total")
                                Color.clear
                                    .frame(width: 20, height: 1)
                            }
                            .font(
                                .system(
                                    size: 12,
                                    weight: .bold
                                )
                            )
                            .padding(12)
                            .background(
                                FidyahTheme.cream
                            )
                            
                            
                            ForEach(
                                vm.summaryItems
                            ) { item in
                                
                                HStack {
                                    
                                    Text(
                                        "\(item.year)"
                                    )
                                    
                                    Spacer()
                                    
                                    Text(
                                        "\(item.days)"
                                    )
                                    
                                    Spacer()
                                    
                                    Text(
                                        "\(item.multiplier)x"
                                    )
                                    .fontWeight(.bold)
                                    .foregroundStyle(FidyahTheme.maroon)
                                    
                                    Spacer()
                                    
                                    Text(
                                        "RM \(item.rate, specifier: "%.2f")"
                                    )
                                    
                                    Spacer()
                                    
                                    Text(
                                        "RM \(item.total, specifier: "%.2f")"
                                    )
                                    .fontWeight(.semibold)
                                    
                                    
                                    Button {
                                        
                                        withAnimation {
                                            
                                            vm.deleteRecord(
                                                item
                                            )
                                        }
                                        
                                    } label: {
                                        
                                        Image(
                                            systemName:
                                                "trash"
                                        )
                                        .foregroundStyle(
                                            .red
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                                .font(.system(size: 12))
                                .padding(12)
                                
                                Divider()
                            }
                        }
                        .background(Color.white)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 18
                            )
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: 18
                            )
                            .stroke(
                                FidyahTheme.border,
                                lineWidth: 1
                            )
                        )
                    }
                    
                    
                    
                    
                    FidyahAmountCard(
                        amount:
                            vm.summaryItems.isEmpty
                        ? vm.currentAmount
                        : vm.grandTotal,
                        days:
                            vm.summaryItems.isEmpty
                        ? vm.numberOfDays
                        : vm.summaryItems.reduce(0) {
                            $0 + $1.days
                        },
                        rate: vm.currentRate,
                        multiplier: vm.currentMultiplier
                    )
                    
                    
                    
                    
                    FidyahPrimaryButton(
                        title: "Proceed Payment",
                        disabled:
                            vm.summaryItems.isEmpty
                    ) {
                      showPayment = true
                        
                    }
                    
                    
                    Spacer(
                        minLength: 30
                    )
                }
                .padding(.horizontal, 18)
                .padding(.top, 20)
            }
            .background(
                FidyahTheme.background
                    .ignoresSafeArea()
            )
            .sheet(isPresented: $showPayment) {
                paymentView(
                    stateName: vm.selectedState.name,
                    rate: vm.currentRate,
                    days: vm.summaryItems.isEmpty ? vm.numberOfDays : vm.summaryItems.reduce(0) { $0 + $1.days },
                    totalAmount: vm.summaryItems.isEmpty ? vm.currentAmount : vm.grandTotal
                )
            }
            .onAppear {
                if vm.linkToTracker {
                    vm.syncWithFastingTracker()
                }
            }
        }
    }



#Preview {

    FidyahCalView()
}

