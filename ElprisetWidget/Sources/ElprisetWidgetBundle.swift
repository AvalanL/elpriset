import WidgetKit
import SwiftUI

@main
struct ElprisetWidgetBundle: WidgetBundle {
    var body: some Widget {
        SmallPriceWidget()
        MediumPriceWidget()
        LargePriceWidget()
        LockScreenPriceWidget()
    }
}
