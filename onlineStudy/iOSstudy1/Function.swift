//
//  Function.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/29.
//

import SwiftUI

struct Function: View {
    @State var inputNumber: Int = 4
    var body: some View {
        VStack {
            Text("Input Number is \(inputNumber)")
            Button(action: {
               
                inputNumber = plusFive(with: inputNumber)
            }, label: {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            })
        }
    }
    func plusFive(with input: Int) ->Int {
      
        
        return input + 5
    }
}

#Preview {
    Function()
}
