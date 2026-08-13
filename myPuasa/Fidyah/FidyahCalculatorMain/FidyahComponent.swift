//
//  FidyahComponent.swift
//  myPuasa
//
//  Created by STDC_22 on 10/08/2026.
//

import SwiftUI

// MARK: - Section Title

struct FidyahSectionTitle: View {

    let number: String
    let title: String

    var body: some View {

        HStack(spacing: 8) {

            Text(number)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(FidyahTheme.maroon)
                .frame(width: 27, height: 27)
                .background(
                    Circle()
                        .fill(FidyahTheme.cream)
                )

            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(.black)

            Spacer()
        }
    }
}


// MARK: - About Card

struct FidyahAboutCard: View {

    var body: some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack(spacing: 10) {

                Image(systemName: "info.circle.fill")
                    .font(.system(size: 21))
                    .foregroundStyle(FidyahTheme.maroon)

                Text("About the rate")
                    .font(.system(size: 18, weight: .bold))

            }


            Text(
                "This rate is based on the value of 1 cup (≈0.75kg) of staple food as determined by the selected state."
            )
            .font(.system(size: 14))
            .foregroundStyle(FidyahTheme.secondaryText)
            .lineSpacing(3)


            NavigationLink {
                FidyahView()
            } label: {

                HStack {

                    Text("View Full Guidelines")
                        .font(.system(size: 14, weight: .semibold))

                    Spacer()

                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 13, weight: .bold))
                }
                .foregroundStyle(FidyahTheme.maroon)
            }
        }
        .padding(20)
        .background(FidyahTheme.cream)
        .clipShape(
            RoundedRectangle(cornerRadius: 22)
        )
    }
}


// MARK: - Dropdown Card

struct FidyahDropdownCard<Content: View>: View {

    let icon: String
    let title: String
    let subtitle: String
    @Binding var isExpanded: Bool

    @ViewBuilder let content: () -> Content


    var body: some View {

        VStack(spacing: 0) {

            Button {

                withAnimation(.easeInOut(duration: 0.2)) {
                    isExpanded.toggle()
                }

            } label: {

                HStack(spacing: 14) {

                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(FidyahTheme.maroon)
                        .frame(width: 42, height: 42)
                        .background(
                            FidyahTheme.cream
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 12)
                        )


                    VStack(alignment: .leading, spacing: 3) {

                        Text(title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.black)

                        if !subtitle.isEmpty {

                            Text(subtitle)
                                .font(.system(size: 12))
                                .foregroundStyle(FidyahTheme.secondaryText)
                                .lineLimit(1)
                        }
                    }


                    Spacer()


                    Image(
                        systemName:
                            isExpanded
                            ? "chevron.up"
                            : "chevron.down"
                    )
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(.gray)
                }
                .padding(16)
            }
            .buttonStyle(.plain)


            if isExpanded {

                Divider()
                    .padding(.horizontal, 16)

                content()
                    .padding(.bottom, 8)
            }
        }
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    FidyahTheme.border,
                    lineWidth: 1
                )
        )
    }
}


// MARK: - Radio Card

struct FidyahRadioCard: View {

    let title: String
    let subtitle: String
    let selected: Bool
    let action: () -> Void


    var body: some View {

        Button {

            action()

        } label: {

            HStack(spacing: 14) {

                ZStack {

                    Circle()
                        .stroke(
                            selected
                            ? FidyahTheme.maroon
                            : Color.gray.opacity(0.35),
                            lineWidth: 2
                        )
                        .frame(
                            width: 23,
                            height: 23
                        )


                    if selected {

                        Circle()
                            .fill(FidyahTheme.maroon)
                            .frame(
                                width: 11,
                                height: 11
                            )
                    }
                }


                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {

                    Text(title)
                        .font(
                            .system(
                                size: 15,
                                weight: .semibold
                            )
                        )
                        .foregroundStyle(.black)

                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundStyle(
                            FidyahTheme.secondaryText
                        )
                }


                Spacer()
            }
            .padding(17)
            .background(
                selected
                ? FidyahTheme.cream
                : Color.white
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 19)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 19)
                    .stroke(
                        selected
                        ? FidyahTheme.maroon.opacity(0.25)
                        : FidyahTheme.border,
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}


// MARK: - Rice Card

struct FidyahRiceCard: View {

    let rice: FidyahRice
    let selected: Bool
    let action: () -> Void


    var body: some View {

        Button {

            action()

        } label: {

            HStack(spacing: 14) {

                ZStack {

                    Circle()
                        .stroke(
                            selected
                            ? FidyahTheme.maroon
                            : Color.gray.opacity(0.35),
                            lineWidth: 2
                        )
                        .frame(
                            width: 23,
                            height: 23
                        )


                    if selected {

                        Circle()
                            .fill(FidyahTheme.maroon)
                            .frame(
                                width: 11,
                                height: 11
                            )
                    }
                }


                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {

                    Text(
                        "RM \(rice.rate, specifier: "%.2f")"
                    )
                    .font(
                        .system(
                            size: 15,
                            weight: .bold
                        )
                    )
                    .foregroundStyle(.black)


                    Text(rice.name)
                        .font(.system(size: 12))
                        .foregroundStyle(
                            FidyahTheme.secondaryText
                        )
                        .multilineTextAlignment(.leading)
                }


                Spacer()
            }
            .padding(16)
            .background(
                selected
                ? FidyahTheme.cream
                : Color.white
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 18)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(
                        selected
                        ? FidyahTheme.maroon.opacity(0.25)
                        : FidyahTheme.border,
                        lineWidth: 1
                    )
            )
        }
        .buttonStyle(.plain)
    }
}


// MARK: - Year Picker

struct FidyahYearCard: View {

    @Binding var year: Int

    var body: some View {

        VStack(alignment: .leading, spacing: 9) {

            Text("Year")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(
                    FidyahTheme.secondaryText
                )


            Picker(
                "Year",
                selection: $year
            ) {
                let currentYr = Calendar.current.component(.year, from: Date())
                ForEach(
                    Array((2015...currentYr).reversed()),
                    id: \.self
                ) { year in
                    Text("\(year)")
                        .tag(year)
                }
            }
            .pickerStyle(.menu)
            .tint(.black)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 11)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
        }
    }
}


// MARK: - Days Stepper

struct FidyahDaysCard: View {

    @Binding var days: Int

    var body: some View {

        VStack(alignment: .leading, spacing: 9) {

            Text("Number of Days")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(
                    FidyahTheme.secondaryText
                )


            HStack {

                Button {

                    if days > 1 {
                        days -= 1
                    }

                } label: {

                    Image(systemName: "minus")
                        .font(.system(size: 13, weight: .bold))
                        .frame(width: 34, height: 34)
                        .background(
                            FidyahTheme.cream
                        )
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)


                Spacer()


                Text("\(days)")
                    .font(
                        .system(
                            size: 18,
                            weight: .bold
                        )
                    )


                Spacer()


                Button {

                    if days < 365 {
                        days += 1
                    }

                } label: {

                    Image(systemName: "plus")
                        .font(.system(size: 13, weight: .bold))
                        .frame(width: 34, height: 34)
                        .background(
                            FidyahTheme.cream
                        )
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 14)
            )
        }
    }
}


// MARK: - Amount Card

struct FidyahAmountCard: View {

    let amount: Double
    let days: Int
    let rate: Double
    var multiplier: Int = 1


    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            HStack {

                Image(systemName: "calculator.fill")
                    .foregroundStyle(
                        FidyahTheme.maroon
                    )

                Text("Estimated Fidyah Amount")
                    .font(
                        .system(
                            size: 16,
                            weight: .bold
                        )
                    )

                Spacer()
            }


            Text(
                "RM \(amount, specifier: "%.2f")"
            )
            .font(
                .system(
                    size: 34,
                    weight: .bold
                )
            )
            .foregroundStyle(
                FidyahTheme.maroon
            )


            if multiplier > 1 {
                Text("\(days) day\(days == 1 ? "" : "s") × RM \(rate, specifier: "%.2f") × \(multiplier) yrs (gandaan)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(FidyahTheme.maroon)
            } else {
                Text("\(days) day\(days == 1 ? "" : "s") × RM \(rate, specifier: "%.2f")")
                    .font(.system(size: 13))
                    .foregroundStyle(
                        FidyahTheme.secondaryText
                    )
            }
        }
        .padding(20)
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .background(FidyahTheme.cream)
        .clipShape(
            RoundedRectangle(cornerRadius: 22)
        )
    }
}


// MARK: - Primary Button

struct FidyahPrimaryButton: View {

    let title: String
    let disabled: Bool
    let action: () -> Void


    var body: some View {

        Button {

            action()

        } label: {

            Text(title)
                .font(
                    .system(
                        size: 16,
                        weight: .bold
                    )
                )
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    disabled
                    ? Color.gray.opacity(0.35)
                    : FidyahTheme.maroon
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 17)
                )
        }
        .disabled(disabled)
    }
}
