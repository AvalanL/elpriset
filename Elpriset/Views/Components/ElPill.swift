import SwiftUI

struct ElPill<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(.vertical, ElSpacing.md)
            .padding(.horizontal, ElSpacing.base)
            .background(Color.elSurfaceDark)
            .clipShape(Capsule())
    }
}
