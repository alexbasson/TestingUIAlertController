import Foundation
import SwiftUI

class SwiftUIViewHostingController: UIHostingController<RootSwiftUIView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: RootSwiftUIView())
    }
}
