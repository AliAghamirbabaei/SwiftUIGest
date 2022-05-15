//
//  ContentView.swift
//  SwiftUIGest
//
//  Created by Ali Aghamirbabaei on 5/13/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            let dragGesture = DragGesture()
                .onChanged { value in
                    offset = value.translation
                    
                }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }
            
            let pressGesture = LongPressGesture()
                .onEnded { value in
                    withAnimation {
                        isDragging = true
                    }
                }
            
            let combined = pressGesture.sequenced(before: dragGesture)
            
            Circle()
                .fill(.red)
                .frame(width: 50, height: 50)
                .padding()
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
            
            // Double tap gesture
            Text("Tap Gesture")
                .padding()
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }
            
            // long press gesture
            Text("Long Press Gesture")
                .padding()
                .onLongPressGesture(minimumDuration: 3) {
                    print("Long pressed!")
                } onPressingChanged: { inProgress in
                    print("Pressing state is: \(inProgress)")
                }
            
            Text("Rotate me")
                .padding()
                .rotationEffect(finalAmount + currentAmount)
                .gesture(
                    RotationGesture()
                        .onChanged { angle in
                            currentAmount = angle
                        }
                        .onEnded { _ in
                            finalAmount += currentAmount
                            currentAmount = .zero
                        }
                )
            
            // This will add gesture layer to top level. so always have first priority on tap.
            Text("High Priority Gesture")
                .padding()
                .highPriorityGesture(
                    TapGesture()
                        .onEnded {
                         print("You tapped on me.")
                        }
                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
