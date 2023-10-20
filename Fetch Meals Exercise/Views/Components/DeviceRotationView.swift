//
//  DeviceRotationView.swift
//  Fetch Meals Exercise
//
//  Created by Alexander Lopez on 20/10/23.
//

import SwiftUI

struct DeviceRotationView<Content: View>: View {
    @State private var orientation: UIDeviceOrientation = UIDevice.current.orientation
    @ViewBuilder let content: (UIDeviceOrientation) -> Content
    
    var body: some View {
        content(orientation)
            .onAppear()
            .onReceive(
                NotificationCenter.default
                .publisher(for: UIDevice.orientationDidChangeNotification),
                perform: { _ in
                    let newOrientation = UIDevice.current.orientation
                    guard newOrientation.isLandscape || newOrientation.isPortrait else { return }
                    
                    orientation = newOrientation
            })
    }
}

#Preview {
    DeviceRotationView { orientation in
        if orientation.isLandscape {
            Text("Landscape")
        } else {
            Text("Portrait")
        }
    }
}
