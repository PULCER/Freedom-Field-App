import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = FreedomViewModel()
    @State private var showingTimeCards = false

    var body: some View {
        VStack {
            HStack {
                TeamSelectorView(selectedTeam: viewModel.selectedTeam) { team in
                    viewModel.selectedTeam = team
                }
                Spacer()
                ClockInOutButton(isClockedIn: $viewModel.isClockedIn, elapsedTime: $viewModel.elapsedTime, action: viewModel.toggleClockIn)
            }.padding()
            
            ScrollView {
                CalendarView(viewModel: viewModel)
                    .frame(maxHeight: .infinity)
            }

            Spacer()

            HStack {
                           Button("TimeCards") {
                               showingTimeCards = true
                           }
                           .sheet(isPresented: $showingTimeCards) {
                               TimeCardsView(viewModel: viewModel)
                           }
                           Spacer()
                           Button("Settings") {
                               // Settings action
                           }
                       }.padding()
        }
    }
}
