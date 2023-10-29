//
//  Condition.swift
//  iOSstudy1
//
//  Created by 박다미 on 2023/10/29.
//

import SwiftUI

struct Condition: View {
    var count = 7
    // var hasLogginIn = true
    var body: some View {
        if count > 4 {
            Text("숫자는 4보다 큽니다")
        }else{
            Text("숫자는 4와 같거나 작습니다")
        }
        //        if hasLogginIn{
        //            Text("로그아웃 하시겠습니까?")
        //        }else {
        //            Text("로그인 하시겠습니까?")
        //        }
        //        guard hasLogginIn else{Text("로그인 하시겠습니까?")}
        //        Text("로그아웃 하시겠습니까?")
        //    }
        
    }
}


#Preview {
    Condition()
}
