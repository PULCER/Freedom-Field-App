import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel = FreedomViewModel()

    var body: some View {
        VStack {
            HStack {
                TeamSelectorView { team in
                    viewModel.selectedTeam = team
                }
                Spacer()
                ClockInOutButton(isClockedIn: $viewModel.isClockedIn)
            }.padding()

            ScrollView {
                CalendarView(viewModel: viewModel)
                    .frame(maxHeight: .infinity)
            }

            Spacer()
        }
    }
}
