import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: FreedomViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.generateTimeSlots(), id: \.self.0) { (time, isHour) in
                    ZStack(alignment: .top) {
                        TimeSlotView(time: time, isHour: isHour, isCurrentTime: time == viewModel.currentTimeFormatted())

                        if let event = viewModel.eventForCurrentTeam(), viewModel.isEventTimeSlot(event: event, time: time, isHour: isHour) {
                            Rectangle()
                                .fill(Color.blue.opacity(0.3))
                                .frame(height: isHour ? 30 : 15)
                        }
                    }
                    .frame(height: isHour ? 30 : 15)
                }
            }
        }
           .padding()
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .border(Color.gray, width: 1)
           .padding()
       }
}
