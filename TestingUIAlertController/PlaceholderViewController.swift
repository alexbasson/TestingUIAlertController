import UIKit
import SwiftUI

class PlaceholderViewController<Content>: UIViewController where Content: View {
    private let rootView: UIHostingController<Content>

    init(rootView: Content) {
        self.rootView = UIHostingController(rootView: rootView)
        super.init(nibName: "PlaceholderViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.addChild(rootView)
        self.view.addSubview(rootView.view)

        rootView.view.translatesAutoresizingMaskIntoConstraints = false
        rootView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        rootView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        rootView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rootView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
