//
//  ApiTest.swift
//  Tracker
//
//  Created by John Johnston on 6/14/22.
//

import SwiftUI

struct ApiTest: View {
    var body: some View {
        VStack{
            
        }.onAppear{
            FoodResponse.getResponse()
        }
    }
}

struct ApiTest_Previews: PreviewProvider {
    static var previews: some View {
        ApiTest()
    }
}
