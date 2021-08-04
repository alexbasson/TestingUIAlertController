import UIKit
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet weak var showAlertButton: UIButton!
    @IBOutlet weak var label: UILabel!

    @IBAction func showAlertButtonTapped() {
        let alertController = UIAlertController(title: "some title", message: "some message", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alertController.addAction(cancelAction)

        let changeLabelAction = UIAlertAction(title: "Change label", style: .default) { _ in
            self.dismiss(animated: true)
            self.label.text = "changed label"
        }
        alertController.addAction(changeLabelAction)

        present(alertController, animated: true)
    }
}

extension UIAlertAction {
    typealias ActionHandler = (UIAlertAction) -> Void
    private static var _handlers = [String: ActionHandler]()

    convenience init(title: String?, style: UIAlertAction.Style, actionHandler: @escaping ActionHandler) {
        self.init(title: title, style: style, handler: actionHandler)
        self.handler = actionHandler
    }

    var handler: ActionHandler? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIAlertAction._handlers[tmpAddress]
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIAlertAction._handlers[tmpAddress] = newValue
        }
    }
}
