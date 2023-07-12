//
//  OtpView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 12/7/2023.
//

import SwiftUI

struct OtpView: View {
    @State private var otp: String = ""

    var body: some View {
        VStack{
            Image("b_arrow")
                .frame(maxWidth: .infinity, maxHeight: 33.33333, alignment: .topLeading)
                .padding()
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
