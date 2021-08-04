@testable import TestingUIAlertController
import Quick
import Nimble
import UIKit

class ViewControllerTest: QuickSpec {
    override func spec() {
        var subject: ViewController!

        describe("ViewController") {
            beforeEach {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                subject = storyboard.instantiateViewController(identifier: "ViewController")

                guard let window = UIApplication.shared.keyWindow else { fail("Expected a window"); return }
                window.rootViewController = subject
                window.makeKeyAndVisible()
                RunLoop.main.run(until: Date())
            }

            describe("when the showAlertButton is tapped") {
                var alertController: UIAlertController!

                beforeEach {
                    subject.showAlertButton.tap()
                    alertController = subject.presentedViewController as? UIAlertController
                }

                it("displays an alert") {
                    expect(alertController.preferredStyle).to(equal(UIAlertController.Style.alert))
                }

                describe("when tapping on 'Cancel'") {
                    beforeEach {
                        guard let cancelAction = alertController.action(withTitle: "Cancel") else {
                            fail("Expected action with title 'Cancel' to exist")
                            return
                        }
                        cancelAction.tap()
                    }

                    it("dismisses the alert controller") {
                        expect(subject.presentedViewController).toEventually(beNil())
                    }

                    it("does not change the label") {
                        expect(subject.label.text).toEventually(equal("label"))
                    }
                }

                describe("when tapping on 'Change label'") {
                    beforeEach {
                        guard let changeLabelAction = alertController.action(withTitle: "Change label") else {
                            fail("Expected action with title 'Change label' to exist")
                            return
                        }
                        changeLabelAction.tap()
                    }

                    it("dismisses the alert controller") {
                        expect(subject.presentedViewController).toEventually(beNil())
                    }

                    it("changes the label") {
                        expect(subject.label.text).toEventually(equal("changed label"))
                    }
                }
            }
        }
    }
}

extension UIApplication {
    var keyWindow: UIWindow? {
        self.windows.first(where: { $0.isKeyWindow })
    }
}

extension UIControl {
    func tap() {
        self.sendActions(for: .touchUpInside)
    }
}

extension UIAlertController {
    func action(withTitle title: String) -> UIAlertAction? {
        self.actions.first(where: { $0.title == title })
    }
}

extension UIAlertAction {
    func tap() {
        self.handler?(self)
    }
}
