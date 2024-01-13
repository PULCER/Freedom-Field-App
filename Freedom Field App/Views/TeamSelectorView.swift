import SwiftUI

struct TeamSelectorView: View {
    var selectedTeam: String
    var onTeamSelected: (String) -> Void

    var body: some View {
        Menu(selectedTeam.isEmpty ? "Select Team" : selectedTeam) {
            Button("Team A", action: { onTeamSelected("Team A") })
            Button("Team B", action: { onTeamSelected("Team B") })
            Button("Team C", action: { onTeamSelected("Team C") })
        }
    }
}
