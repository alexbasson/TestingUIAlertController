import SwiftUI

extension View {
    func inspectableAlert(isPresented: Binding<Bool>, content: @escaping () -> Alert) -> some View {
        return self.modifier(InspectableAlert(isPresented: isPresented, alertBuilder: content))
    }
}

struct InspectableAlert: ViewModifier {

    let isPresented: Binding<Bool>
    let alertBuilder: () -> Alert

    func body(content: Self.Content) -> some View {
        content.alert(isPresented: isPresented, content: alertBuilder)
    }
}
