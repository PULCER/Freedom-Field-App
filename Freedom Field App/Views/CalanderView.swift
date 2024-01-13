import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: FreedomViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.generateTimeSlots(), id: \.self.0) { (time, isHour) in
                    ZStack(alignment: .top) {
                        TimeSlotView(time: time, isHour: isHour)

                        if let event = viewModel.eventForCurrentTeam(), viewModel.isEventTimeSlot(event: event, time: time, isHour: isHour) {
                            Rectangle()
                                .fill(Color.blue.opacity(0.3))
                                .frame(height: isHour ? 30 : 15)
                        }
                    }
                    .frame(height: isHour ? 30 : 15)
                }
            }
            .overlay(
                CurrentTimeIndicator(viewModel: viewModel),
                alignment: .topLeading
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(Color.gray, width: 1)
        .padding()
    }
}

struct CurrentTimeIndicator: View {
    @ObservedObject var viewModel: FreedomViewModel

    var body: some View {
        GeometryReader { geometry in
            let yPosition = viewModel.yPositionForCurrentHour(in: geometry.size.height)
            Rectangle()
                .fill(Color.red)
                .frame(width: geometry.size.width, height: 4) 
                .offset(y: yPosition)
        }
    }
}
