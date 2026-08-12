
import SwiftUI

struct HealthSummaryView: View {
    
    let currentCycleLength: Int?
    let previousCycleLength: Int?
    
    let currentPeriodDays: Int
    let previousPeriodDays: Int
    
    let cycleComparison: String
    let cyclePattern: String
    
    var body: some View {
        
        VStack(spacing: 14) {
            
            // MARK: - Title
            
            Text("Health Summary")
                .font(.system(size: 18, weight: .bold))
            
            
            // MARK: - Cycle Length
            
            if currentCycleLength != nil &&
                previousCycleLength != nil {
                
                VStack(spacing: 8) {
                    
                    Text("Cycle Length")
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(cycleComparison)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    cycleRow(
                        title: "Last time",
                        value: previousCycleLength
                    )
                    
                    cycleRow(
                        title: "Current",
                        value: currentCycleLength
                    )
                }
            }
            
            
            // MARK: - Period Days
            
            HStack(spacing: 10) {
                
                informationBox(
                    title: "Current Period",
                    value: "\(currentPeriodDays) days"
                )
                
                informationBox(
                    title: "Previous Period",
                    value: previousPeriodDays > 0
                    ? "\(previousPeriodDays) days"
                    : "--"
                )
            }
            
            
            // MARK: - Cycle Pattern
            
            if cyclePattern != "Not enough data" {
                
                Text("Cycle Pattern: \(cyclePattern)")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 18)
                .stroke(
                    Color.gray.opacity(0.35),
                    lineWidth: 1
                )
        )
        .padding(.horizontal)
    }
    
    
    // MARK: - Cycle Row
    
    private func cycleRow(
        title: String,
        value: Int?
    ) -> some View {
        
        HStack(spacing: 8) {
            
            Text(title)
                .font(.system(size: 10))
            
            Capsule()
                .fill(Color.pink.opacity(0.75))
                .frame(height: 5)
            
            Text(
                value != nil
                ? "\(value!) days"
                : "--"
            )
            .font(
                .system(
                    size: 9,
                    weight: .semibold
                )
            )
        }
    }
    
    
    // MARK: - Information Box
    
    private func informationBox(
        title: String,
        value: String
    ) -> some View {
        
        VStack(spacing: 5) {
            
            Text(title)
                .font(.system(size: 9, weight: .medium))
                .foregroundColor(.gray)
            
            Text(value)
                .font(.system(size: 16, weight: .bold))
        }
        .frame(
            maxWidth: .infinity,
            minHeight: 55
        )
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.08))
        )
    }
}


// MARK: - Preview

#Preview {
    
    HealthSummaryView(
        currentCycleLength: 30,
        previousCycleLength: 31,
        currentPeriodDays: 5,
        previousPeriodDays: 5,
        cycleComparison: "The number of days in this cycle is 1 day less than the last time.",
        cyclePattern: "Consistent"
    )
    .padding()
}
