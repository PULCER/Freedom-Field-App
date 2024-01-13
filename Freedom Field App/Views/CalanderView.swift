import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: FreedomViewModel

    var body: some View {
           ScrollView {
               VStack(spacing: 0) {
                   ForEach(generateTimeSlots(), id: \.self.0) { (time, isHour) in
                       ZStack(alignment: .top) {
                           TimeSlotView(time: time, isHour: isHour, isCurrentTime: time == currentTimeFormatted())

                           if let event = viewModel.eventForCurrentTeam(), isEventTimeSlot(event: event, time: time, isHour: isHour) {
                               Rectangle()
                                   .fill(Color.blue.opacity(0.3))
                                   .frame(height: isHour ? 30 : 15) // Adjusted slot height
                           }
                       }
                       .frame(height: isHour ? 30 : 15) // Adjusted slot height
                   }
               }
           }
           .padding()
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .border(Color.gray, width: 1)
           .padding()
       }
}

extension CalendarView {
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
        for hour in 5..<22 {
            let hourString = "\(hour <= 12 ? hour : hour - 12) \(hour < 12 ? "AM" : "PM")"
            slots.append((hourString, true))  // True for full hour
            slots.append(("", false))  // False for half hour
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


