//
//  Diff.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/30.
//

import SwiftUI

struct Diff: View {
    let myCar = Car(name: "다미카", owner: "다미")
    @ObservedObject var myKar = Kar(name: "다미카2", owner: "다미2")
   
    var body: some View {
        VStack{
            Text("\(myCar.name)의 주인은 \(myCar.owner)입니다")
            Button(action: {
                var broCar = myCar
                broCar.name = "동생차"
                broCar.owner = "동생"
                
                myKar.sayHi()
                broCar.sayHi()
            }
                   ,label: {
                
                Text("출발")
            })
        }
    }
}
struct Car {
    var name: String
    var owner: String
    func sayHi(){
        print("Hi \(owner)")
    }
}
class Kar: ObservableObject {
    @Published var name: String
    var owner: String
    
    init(name: String, owner: String) {
        self.name = name
        self.owner = owner
    }
    func sayHi(){
        print("Hi \(owner)")
    }
    
}
#Preview {
    Diff()
}
