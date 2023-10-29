//
//  VariableType.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/29.
//

import SwiftUI

struct VariableType: View {
    
    var name: String = "Dami"
    var age: Int = 20
    var height: Float = 180.5
    var weight: Double = 50.6
    var havePet: Bool = false
    
    var body: some View {
        VStack{
            Text("\(name)")
            Text("\(age)")
            Text("\(height)")
            Text("\(weight)")
            Text("\(havePet.description)")
        }
    }
}

#Preview {
    VariableType()
}
struct VCPreViewVariableType:PreviewProvider {
    static var previews: some View {
        VariableType().previewDevice("iPhone 14 Pro")
        
    }
}
struct VCPreViewVariableType2:PreviewProvider {
    static var previews: some View {
        VariableType().previewDevice("iPhone 11")
        
    }
}
