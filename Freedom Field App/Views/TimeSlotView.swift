import SwiftUI

struct TimeSlotView: View {
    let time: String
    var isHour: Bool
    var isCurrentTime: Bool = false

    var body: some View {
        VStack {
            HStack {
                if isHour {
                    Text(time)
                        .frame(width: 50, alignment: .leading)
                } else {
                    Spacer().frame(width: 50)
                }
                
                Rectangle()
                    .fill(isCurrentTime ? Color.red : (isHour ? Color.gray : Color.clear))
                    .frame(height: isHour ? 2 : 1)
                Spacer()
            }
            if isHour {
                Spacer().frame(height: 20)
            }
        }
    }
}
