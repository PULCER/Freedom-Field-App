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
}

