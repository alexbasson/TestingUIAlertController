@testable import TestingUIAlertController
import SwiftUI
import Quick
import ViewInspector

extension QuickSpec {
    func onViewDidAppear<Content>(
        _ subject: Content,
        callback: @escaping (InspectableView<ViewType.View<Content>>) throws -> Void
    ) where Content: View, Content: DidAppearable {
        var mutableSubject = subject

        let subjectDidAppearExpectation = mutableSubject.on(\.didAppear) { try callback($0) }

        hostSwiftUIView(mutableSubject)

        self.wait(for: [subjectDidAppearExpectation], timeout: 10.0)
    }
}

func hostSwiftUIView<Content>(_ view: Content) where Content: View {
    hostView(PlaceholderViewController(rootView: view))
}

func hostView(_ viewController: UIViewController) {
    hostView(UINavigationController(rootViewController: viewController))
}

func hostView(_ navigationController: UINavigationController) {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = navigationController
    window.rootViewController?.view.translatesAutoresizingMaskIntoConstraints = false
    window.makeKeyAndVisible()
    window.layoutIfNeeded()

    _ = navigationController.view
    _ = navigationController.viewControllers.first?.view
}
