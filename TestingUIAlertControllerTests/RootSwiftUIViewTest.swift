@testable import TestingUIAlertController
import Quick
import Nimble
import ViewInspector
import SwiftUI
import UIKit

class RootSwiftUIViewTest: QuickSpec {
    @State var binding = false

    override func spec() {
        var subject: RootSwiftUIView!

        beforeEach {
            subject = RootSwiftUIView()
        }

        describe("tapping the button") {
            it("shows an alert") {
                self.onViewDidAppear(subject) { view in
                    try? view.find(button: "Show Alert").tap()

                    let alert = try? view.find(button: "Show Alert").alert()

                    expect(alert).notTo(beNil())
                    expect(try? alert?.title().string()).to(equal("Important message"))
                    expect(try? alert?.message().string()).to(equal("Wear sunscreen"))
                }
            }

            context("when tapping the primary button") {
                it("displays 'Did it' on the screen") {
                    self.onViewDidAppear(subject) { view in
                        expect(try? view.find(text: "Did it")).to(beNil())

                        try? view.find(button: "Show Alert").tap()

                        guard let alert = try? view.find(button: "Show Alert").alert() else {
                            fail("Expected alert not to be nil")
                            return
                        }

                        try? alert.primaryButton().tap()

                        expect(try? view.find(text: "Did it")).notTo(beNil())
                    }
                }
            }

            context("when tapping the secondary button") {
                it("displays 'Cancelled it' on the screen") {
                    self.onViewDidAppear(subject) { view in
                        expect(try? view.find(text: "Cancelled it")).to(beNil())

                        try? view.find(button: "Show Alert").tap()

                        guard let alert = try? view.find(button: "Show Alert").alert() else {
                            fail("Expected alert not to be nil")
                            return
                        }

                        try? alert.secondaryButton().tap()

                        expect(try? view.find(text: "Cancelled it")).notTo(beNil())
                    }
                }
            }
        }
    }
}

extension RootSwiftUIView: Inspectable {}
extension InspectableAlert: AlertProvider {}
