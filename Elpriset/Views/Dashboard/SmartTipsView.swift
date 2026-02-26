import SwiftUI

struct SmartTipsView: View {
    let tips: [CostCalculator.SmartTip]

    var body: some View {
        VStack(alignment: .leading, spacing: ElSpacing.md) {
            Text("Smarta tips")
                .font(.elHeadingMedium)
                .foregroundStyle(Color.elTextPrimary)

            ForEach(tips) { tip in
                ElCard(style: .green) {
                    HStack(spacing: ElSpacing.md) {
                        Image(systemName: tip.icon)
                            .font(.system(size: 20))
                            .foregroundStyle(Color.elGreenDark)
                            .frame(width: 32, height: 32)
                            .background(Color.elGreenDark.opacity(0.15))
                            .clipShape(Circle())

                        Text(tip.text)
                            .font(.elBodyMedium)
                            .foregroundStyle(Color.elTextOnGreen)
                    }
                }
            }
        }
    }
}
