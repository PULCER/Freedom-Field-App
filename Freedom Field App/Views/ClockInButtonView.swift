import SwiftUI

struct ClockInOutButton: View {
    @Binding var isClockedIn: Bool
    @Binding var elapsedTime: String
    var action: () -> Void

    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Text(isClockedIn ? "Clock Out" : "Clock In")
                if isClockedIn {
                    Text(elapsedTime)
                }
            }
            .foregroundColor(.white)
            .padding()
            .background(isClockedIn ? Color.red : Color.green)
            .cornerRadius(10)
        }
    }
}
