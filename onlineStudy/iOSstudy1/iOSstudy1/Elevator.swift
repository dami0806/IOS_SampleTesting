//
//  Elevator.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/30.
//

import SwiftUI

struct Elevator: View {
    @State var myElevator = ElevatorStruct()
    var body: some View {
        VStack{
            Text ("층수 : \(myElevator.level)")
            HStack{
                Button(action: {
                    myElevator.goDown()
                }, label: {
                    Text("Down")
                })
                Button(action: {
                    myElevator.goUp()
                }, label: {
                    Text("Up")
                })
            }
        }
    }


}
struct ElevatorStruct {
    var level : Int = 1
    mutating func goDown() {
        level = level - 1
    }
    mutating func goUp() {
        level = level + 1
    }
}
#Preview {
    Elevator()
}
