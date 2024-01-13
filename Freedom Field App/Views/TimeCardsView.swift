import SwiftUI

import SwiftUI

struct TimeCardsView: View {
    @ObservedObject var viewModel: FreedomViewModel

    var body: some View {
        VStack {
    
            List(viewModel.timeCards) { entry in
                VStack(alignment: .leading) {
                    Text("Team: \(entry.teamName)")
                    Text("Clock In: \(formatDate(entry.clockInTime))")
                    Text("Clock Out: \(entry.clockOutTime.map(formatDate) ?? "N/A")")
                    Text("Duration: \(formatDuration(entry.duration))")
                }
            }

            Button("Submit") {
                viewModel.submitTimeCards()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }

    private func formatDuration(_ duration: TimeInterval?) -> String {
        guard let duration = duration else { return "N/A" }
        let hours = Int(duration) / 3600
        let minutes = Int(duration) / 60 % 60
        let seconds = Int(duration) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
