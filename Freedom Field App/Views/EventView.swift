//
//  EventView.swift
//  Freedom Field App
//
//  Created by Anthony Howell on 1/12/24.
//

import SwiftUI


struct EventView: View {
    var event: Event
    var height: CGFloat
    var action: () -> Void

    var body: some View {
        Rectangle()
            .fill(Color.blue.opacity(0.3))
            .frame(height: height)
            .onTapGesture {
                action()
            }
    }
}
