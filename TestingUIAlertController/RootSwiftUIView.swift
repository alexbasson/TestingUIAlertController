import SwiftUI

protocol DidAppearable {
    var didAppear: ((Self) -> Void)? { get set }
}

struct RootSwiftUIView: View, DidAppearable {
    @State private var showingAlert = false
    var didAppear: ((RootSwiftUIView) -> Void)?

    @State private var showDidIt = false
    @State private var showCancelledIt = false

    var body: some View {
        Group {
            Button(action: {
                showingAlert = true
            }) {
                Text("Show Alert")
            }
            .inspectableAlert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Important message"),
                    message: Text("Wear sunscreen"),
                    primaryButton: .default(Text("Do it")) {
                        showDidIt = true
                    },
                    secondaryButton: .cancel(Text("Cancel")) {
                        showCancelledIt = true
                    }
                )
            }
            .padding(.bottom, 16)

            if showingAlert {
                Text("showing alert")
            }

            if showDidIt {
                Text("Did it")
            }

            if showCancelledIt {
                Text("Cancelled it")
            }

            Button(action: {
                showDidIt = false
                showCancelledIt = false
            }) {
                Text("Reset it")
            }
            .padding(.top, 16)
        }
        .onAppear {
            self.didAppear?(self)
        }
    }
}
