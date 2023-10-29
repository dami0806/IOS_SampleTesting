//
//  ViewController.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/29.
//

import UIKit
import SwiftUI

class ViewController: UIViewController{
    
}
struct ContentView: View {
   
    var place: String = "Paris"
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hi")
            Text("Hi")
            Text("Hi")
            
        }
        .padding()
    }
}


struct VCPreContentView:PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 14 Pro")
   
    }
}
struct VCPreContentView2:PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 11")
       
    }
}

