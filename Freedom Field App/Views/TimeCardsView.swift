import SwiftUI

struct TimeCardsView: View {
    @ObservedObject var viewModel: FreedomViewModel

    var body: some View {
        VStack {
                   List($viewModel.timeCards) { $entry in
                       if entry.isEditable {
                           TimeCardEditView(entry: $entry, onDelete: {
                               deleteTimeCard(entry)
                           })
                       } else {
                           TimeCardDisplayView(entry: entry)
                               .onTapGesture {
                                   entry.isEditable = true
                               }
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
    private func deleteTimeCard(_ entry: TimeCardEntry) {
           if let index = viewModel.timeCards.firstIndex(where: { $0.id == entry.id }) {
               viewModel.timeCards.remove(at: index)
           }
       }

}

struct TimeCardEditView: View {
    @Binding var entry: TimeCardEntry
    @State private var durationText: String
    var onDelete: () -> Void

    init(entry: Binding<TimeCardEntry>, onDelete: @escaping () -> Void) {
        self._entry = entry
        self._durationText = State(initialValue: formatDuration(entry.duration.wrappedValue))
        self.onDelete = onDelete
    }

    var body: some View {
        VStack {
            TextField("Team Name", text: $entry.teamName)
            DatePicker("Clock In", selection: $entry.clockInTime, displayedComponents: .date)
            DatePicker("Clock Out", selection: Binding($entry.clockOutTime)!, displayedComponents: .date)

            TextField("Duration (hh:mm:ss)", text: $durationText)
                .onSubmit {
                    updateDuration()
                }

            Button("Save") {
                updateDuration()
                entry.isEditable = false
            }
            Button("Discard") {
                entry.isEditable = false
            }
            Button("Delete") {
                                onDelete()
                            }
        }
    }

    private func updateDuration() {
        let components = durationText.split(separator: ":").compactMap { Int($0) }
        if components.count == 3 {
            let duration = TimeInterval(components[0] * 3600 + components[1] * 60 + components[2])
            entry.duration = duration
        }
    }
}


struct TimeCardDisplayView: View {
    var entry: TimeCardEntry
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Team: \(entry.teamName)")
            Text("Clock In: \(formatDate(entry.clockInTime))")
            Text("Clock Out: \(entry.clockOutTime.map(formatDate) ?? "N/A")")
            Text("Duration: \(formatDuration(entry.duration))")
        }
    }
}

 func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter.string(from: date)
}

 func formatDuration(_ duration: TimeInterval?) -> String {
    guard let duration = duration else { return "N/A" }
    let hours = Int(duration) / 3600
    let minutes = Int(duration) / 60 % 60
    let seconds = Int(duration) % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}

