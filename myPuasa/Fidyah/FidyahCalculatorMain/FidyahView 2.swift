//
//  FidyahView.swift
//  myPuasa
//
//  Created by STDCX_MACBOOK PRO 32 on 09/08/2026.
//

import SwiftUI

struct FidyahView2: View {

    @StateObject private var vm = FidyahViewModel()

    @State private var stateExpanded = false
    @State private var reasonExpanded = false


    var body: some View {

        ScrollView(
            .vertical,
            showsIndicators: false
        ) {

            VStack(
                alignment: .leading,
                spacing: 18
            ) {

                // MARK: Header

                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {

                    Text("Fidyah Calculator")
                        .font(
                            .system(
                                size: 32,
                                weight: .bold
                            )
                        )

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
                                            .font(
                                                .system(size: 11)
                                            )
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
                                .padding(.horizontal, 18)
                                .padding(.vertical, 12)
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
                                        .font(
                                            .system(size: 14)
                                        )
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
                                .padding(.horizontal, 18)
                                .padding(.vertical, 13)
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
                    title:
                        FidyahCalculationMethod.food.title,

                    subtitle:
                        FidyahCalculationMethod.food.subtitle,

                    selected:
                        vm.calculationMethod == .food
                ) {

                    withAnimation {

                        vm.calculationMethod = .food
                    }
                }


                FidyahRadioCard(
                    title:
                        FidyahCalculationMethod.cash.title,

                    subtitle:
                        FidyahCalculationMethod.cash.subtitle,

                    selected:
                        vm.calculationMethod == .cash
                ) {

                    withAnimation {

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

                                withAnimation {

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

                        Text(
                            "Link to your tracker"
                        )
                        .font(
                            .system(
                                size: 14,
                                weight: .semibold
                            )
                        )


                        Text(
                            "Keep this record connected to your fasting tracker."
                        )
                        .font(
                            .system(size: 11)
                        )
                        .foregroundStyle(
                            FidyahTheme.secondaryText
                        )
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
                        number:
                            vm.calculationMethod == .food
                            ? "6"
                            : "5",

                        title: "Summary"
                    )


                    VStack(spacing: 0) {

                        

                        HStack {

                            Text("Year")

                            Spacer()

                            Text("Days")

                            Spacer()

                            Text("Rate")

                            Spacer()

                            Text("Total")
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
                            .font(
                                .system(size: 11)
                            )
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

                    rate: vm.currentRate
                )


               

                FidyahPrimaryButton(

                    title: "Proceed Payment",

                    disabled:
                        vm.summaryItems.isEmpty

                ) {

                   
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
    }
}


#Preview {

    FidyahView2()
}
