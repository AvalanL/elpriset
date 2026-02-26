import SwiftUI

struct ElSegmentedControl: View {
    let items: [String]
    @Binding var selectedIndex: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items.indices, id: \.self) { index in
                Button {
                    withAnimation(.spring(duration: 0.3, bounce: 0.2)) {
                        selectedIndex = index
                    }
                } label: {
                    Text(items[index])
                        .font(.elLabelMedium)
                        .fontWeight(selectedIndex == index ? .semibold : .medium)
                        .foregroundStyle(selectedIndex == index ? Color.elTextPrimary : .elTextSecondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .background {
                            if selectedIndex == index {
                                RoundedRectangle(cornerRadius: ElRadius.sm)
                                    .fill(Color.elBackground)
                                    .shadow(color: .black.opacity(0.08), radius: 3, y: 1)
                            }
                        }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(2)
        .background(Color.elBackgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: ElRadius.sm))
    }
}
