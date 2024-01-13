import SwiftUI

struct ClockInOutButton: View {
    @Binding var isClockedIn: Bool

    var body: some View {
        Button(action: {
            self.isClockedIn.toggle()
        }) {
            Text(isClockedIn ? "Clock Out" : "Clock In")
                .foregroundColor(.white)
                .padding()
                .background(isClockedIn ? Color.red : Color.green)
                .cornerRadius(10)
        }
    }
}

