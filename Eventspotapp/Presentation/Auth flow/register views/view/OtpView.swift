//
//  OtpView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 12/7/2023.
//

import SwiftUI

struct OtpView: View {
    @State private var otp: String = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("barr") // Replace with your image name or URL
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18) // Adjust the size of the image
                            .foregroundColor(.blue) // Change the color of the image as desired
                            .padding(14)
                            .overlay(
                                Circle()
                                
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 0.5)
                            )
                            .padding(.horizontal)
                            .padding(.bottom,8)
                        Spacer()
                    }
                }
            
                Text("Confirm your email")
                    .font(
                        .system( size: 30)
                    )
                    .bold()
                    .padding(.horizontal)
                
                    .kerning(0.374)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                Text("We’ve sent you a 6 digits code in your added email address")
                    .font(.system( size: 18))
                    .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(.horizontal)
                    .padding(.top,1)
                HStack{
                    ForEach(0..<6) { index in
                        digitField(at: index)
                    }
                }
                Text("Send code again")
                    .font(
                        Font.custom("SF Pro Text", size: 16)
                            .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.88, green: 0.27, blue: 0.35))
                Spacer()
                HStack(alignment: .center, spacing: 0) { Text("Continue")
                        .foregroundColor(.white)
                }
                .frame(maxWidth : .infinity, maxHeight: 48, alignment: .center)
                .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                .cornerRadius(4)
                .padding()
                .onTapGesture {
                    
                }
            }
        }
    }
            private func digitField(at index: Int) -> some View {
                    let binding = Binding<String>(
                        get: {
                            guard otp.count > index else { return "" }
                            let startIndex = otp.index(otp.startIndex, offsetBy: index)
                            let endIndex = otp.index(startIndex, offsetBy: 1)
                            return String(otp[startIndex..<endIndex])
                        },
                        set: {
                            guard $0.count <= 1 else { return }
                            if $0.isEmpty {
                                if otp.count > index {
                                    otp.remove(at: otp.index(otp.startIndex, offsetBy: index))
                                }
                            } else {
                                if otp.count < 6 {
                                    otp.insert(Character($0), at: otp.index(otp.startIndex, offsetBy: index))
                                }
                            }
                        }
                    )

                    return TextField("", text: binding)
                        .frame(maxWidth: 45)
                        .padding(.vertical)

                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)) { _ in
                                        if otp.count > 6 {
                                            otp = String(otp.prefix(6))
                                        }
                                    }
                }
}

struct OtpView_Previews: PreviewProvider {
    static var previews: some View {
        OtpView()
    }
}
