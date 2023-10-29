//
//  MyCollections.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/29.
//

import SwiftUI

struct MyCollections: View {
    var foods : [String] = ["eggs", "bananas", "beans"]
    var jazzs: Set<String> = ["bibidudu", "labdap", "dididudu"]
    var hiphop: Set<String> = ["labdap", "rap","wow"]
    var koEngDict = ["사과":"Apple", "바나나":"Banana"]
    
    var body: some View {
        VStack{
//            Text(hiphop.intersection(jazzs).description)
//            Button(action: {
//                var intersectionMusic = hiphop.intersection(jazzs)
//                intersectionMusic.description
//            }, label: {
//                Text("hit!")
//            })
//            Text(foods[0])
//            Text(foods[1])
//            Text(foods[2])
            Text(koEngDict["사과"]!)
        }
    }
}

struct VCPreViewMyCollections:PreviewProvider {
    static var previews: some View {
        MyCollections().previewDevice("iPhone 14 Pro")
        
    }
}
struct VCPreViewMyCollections2:PreviewProvider {
    static var previews: some View {
        MyCollections().previewDevice("iPhone 11")
        
    }
}
