//
//  Loop.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/29.
//

import SwiftUI

struct Loop: View {
    let names : [String] = ["다미", "유미", "명훈", "학영", "경일"]
    var body: some View {
        VStack{
            ForEach(names, id: \.self) { item in
                Text(item)
            }
        }
    }
}

#Preview {
    Loop()
}
 
