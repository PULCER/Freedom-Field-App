import Foundation

struct Event {
    var team: String
    var startTime: String
    var endTime: String

    func durationInSlots() -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"

        guard let start = formatter.date(from: startTime),
              let end = formatter.date(from: endTime) else { return 0 }

        let duration = Calendar.current.dateComponents([.minute], from: start, to: end)
        return (duration.minute ?? 0) / 30
    }
}

struct TimeCardEntry: Identifiable {
    let id = UUID()
    var teamName: String
    var clockInTime: Date
    var clockOutTime: Date?
    var duration: TimeInterval?
}

