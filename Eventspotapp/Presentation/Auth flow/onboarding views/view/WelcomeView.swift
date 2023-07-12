//
//  WelcomeView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 12/7/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Image("welcome")
            .foregroundColor(.clear)
            .frame(maxWidth: .infinity)
            
           
            Text("Create and Join Events with few clicks.")
                .bold()
                .font(.system(size: 34))

            .kerning(0.374)
            .foregroundColor(.black)
            .frame(width: .infinity,  alignment: .topLeading)
            .padding(.vertical)
            Text("Create or Join events in your area with an outstanding event organizing app with simple steps.")
                .font(.system( size: 18))
              .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
              .frame(width: .infinity, height: 80, alignment: .topLeading)
            Spacer()
            HStack(alignment: .center, spacing: 0) { Text("Get Started")
                    .foregroundColor(.white)
            }

            .frame(maxWidth : .infinity, maxHeight: 48, alignment: .center)
            .background(Color(red: 0.88, green: 0.27, blue: 0.35))
            .cornerRadius(4)
            .padding()
            .onTapGesture {
                
            }
            Text("Already registered in the app? Login")
              .font(
                Font.custom("SF Pro Text", size: 16)
                  .weight(.medium)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(Color(red: 0.13, green: 0.15, blue: 0.17))

        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
