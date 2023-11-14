//
//  Half.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/29.
//

import SwiftUI

struct Half: View {
    var names: [String] = ["다미","유미","명훈","깜찍","망둥이"]
    
    var body: some View {
        List {
            ForEach(names, id: \.self) { name in
                var welcome = sayHi(to:name)
                if name == "다미" {
                    Text("기다렸어요. \(welcome)")
                }else{
                    Text(welcome)
                }
            }
            
        }
    }
    func sayHi(to name: String) -> String {
        return "\(name)님 반갑습니다"
    }
}

#Preview {
    Half()
}
