import Foundation

class FreedomViewModel: ObservableObject {
    @Published var isClockedIn = false
    @Published var selectedTeam: String = ""

    var events: [Event] = [
        Event(team: "Team A", startTime: "8 AM", endTime: "12 PM"),
        Event(team: "Team B", startTime: "9 AM", endTime: "5 PM"),
        Event(team: "Team C", startTime: "6 AM", endTime: "7 PM")
    ]

    func eventForCurrentTeam() -> Event? {
        events.first { $0.team == selectedTeam }
    }

    func currentTimeFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: Date())
    }

    func minutesSince5AM(from time: String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"

        guard let date = formatter.date(from: time) else { return 0 }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0

        return (hours - 5) * 60 + minutes
    }

    func generateTimeSlots() -> [(String, Bool)] {
        var slots = [(String, Bool)]()
        for hour in 0..<24 {
            let hourString = "\(hour == 0 || hour == 12 ? 12 : hour % 12) \(hour < 12 ? "AM" : "PM")"
            slots.append((hourString, true))
            slots.append(("", false))
        }
        return slots
    }


    func isEventTimeSlot(event: Event, time: String, isHour: Bool) -> Bool {
        let eventStart = minutesSince5AM(from: event.startTime)
        let eventEnd = minutesSince5AM(from: event.endTime)
        let slotStart = minutesSince5AM(from: time)
        let slotEnd = slotStart + (isHour ? 60 : 30)  // 60 minutes for full hour, 30 for half

        return slotStart < eventEnd && slotEnd > eventStart
    }
}
