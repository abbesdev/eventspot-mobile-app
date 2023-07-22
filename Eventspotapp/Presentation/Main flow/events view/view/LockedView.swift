//
//  LockedView.swift
//  Eventspotapp
//
//  Created by Mohamed Abbes on 22/7/2023.
//

import SwiftUI

struct LockedView: View {
    //variables
    @State private var isYearlySelected = false

    
    var body: some View {
        VStack{
            VStack(alignment: .center, spacing: 28) {
                VStack(alignment: .center, spacing: 18) {
                    
                    Text("Become an organizer")
                      .font(
                        .system( size: 31)
                          .weight(.bold)
                      )
                      .multilineTextAlignment(.center)
                      .foregroundColor(Color(red: 0.2, green: 0.23, blue: 0.29))
                      .frame(width: 363, alignment: .top)
                    
                    // On Mobile/Caption
                    Text("Choose a membership plan according to your needs and audience")
                      .font(
                        .system( size: 14)
                          .weight(.light)
                      )
                      .multilineTextAlignment(.center)
                      .foregroundColor(Color(red: 0.58, green: 0.63, blue: 0.72))
                      .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                           Button(action: {
                               isYearlySelected = false
                           }) {
                               Text("Per month")
                                   .font(.system(size: 14).weight(.light))
                                   .foregroundColor(isYearlySelected ? .black : .white)
                                   .padding(.horizontal, 14)
                                   .padding(.vertical, 10)
                                   .background(isYearlySelected ? Color.white : Color(red: 0.88, green: 0.27, blue: 0.35))
                                   .cornerRadius(100)
                                   .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(isYearlySelected ? 0.1 : 0.06), radius: isYearlySelected ? 1.5 : 1, x: 0, y: 1)
                                   .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(isYearlySelected ? 0.1 : 0.06), radius: isYearlySelected ? 2.5 : 1.5, x: 0, y: 1)
                           }
                           
                           Button(action: {
                               isYearlySelected = true
                           }) {
                               Text("Per year")
                                   .font(.system(size: 14).weight(.light))
                                   .foregroundColor(isYearlySelected ? .white : .black)
                                   .padding(.horizontal, 14)
                                   .padding(.vertical, 10)
                                   .background(isYearlySelected ? Color(red: 0.88, green: 0.27, blue: 0.35) : Color.white)
                                   .cornerRadius(100)
                                   .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(isYearlySelected ? 0.06 : 0.1), radius: isYearlySelected ? 1 : 1.5, x: 0, y: 1)
                                   .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(isYearlySelected ? 0.06 : 0.1), radius: isYearlySelected ? 1.5 : 2.5, x: 0, y: 1)
                           }
                       }
                       .padding(6)
                       .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                       .cornerRadius(100)
                       .overlay(
                           RoundedRectangle(cornerRadius: 100)
                               .inset(by: 0.5)
                               .stroke(Color(red: 0.95, green: 0.96, blue: 0.97), lineWidth: 1)
                       )
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        VStack(alignment: .leading, spacing: 26) {
                            VStack(alignment: .leading, spacing: 14) {
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    
                                    VStack(alignment: .leading, spacing: 4) { // On Mobile/Header 4
                                        Text("Pro")
                                          .font(
                                            .system(size: 25)
                                              .weight(.bold)
                                          )
                                          .foregroundColor(Color(red: 0.2, green: 0.23, blue: 0.29))
                                        VStack(alignment: .center, spacing: 9) { VStack(alignment: .leading, spacing: 10) { Text("A pro plan for exclusive events organizers.")
                                                .font(.system( size: 14))
                                                .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                                                .frame(width: 298, alignment: .topLeading) }
                                                .padding(0)
                                                .frame(width: 298, alignment: .topLeading) }
                                        .padding(0)
                                        .frame(width: 298, alignment: .center)
                                        
                                        
                                    }
                                    .padding(0)
                                    
                                    HStack(alignment: .center, spacing: 2) {
                                        Text("$")
                                          .font(
                                            .system( size: 32)
                                              .weight(.semibold)
                                          )
                                          .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                                        
                                        // On Mobile/Header 3
                                        Text(isYearlySelected ? "99": "10")
                                          .font(
                                            .system( size: 31)
                                              .weight(.bold)
                                          )
                                          .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                                        
                                        HStack(alignment: .top, spacing: 0) { // On Desktop/Text Button
                                            Text(isYearlySelected ? "per year":"per month")
                                              .font(
                                                .system( size: 16)
                                                  .weight(.medium)
                                              )
                                              .foregroundColor(Color(red: 0.4, green: 0.44, blue: 0.52)) }
                                        .padding(.horizontal, 0)
                                        .padding(.top, 0)
                                        .padding(.bottom, 8)
                                        .frame(height: 24, alignment: .topLeading)
                                    }
                                    .padding(0)
                                    .frame(height: 66, alignment: .leading)
                                    
                                }
                                .padding(0)
                                
                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame(width: 284, height: 1)
                                  .background(Color(red: 0.94, green: 0.95, blue: 0.96))
                                
                                VStack(alignment: .leading, spacing: 22) {
                                    
                                    HStack(alignment: .center, spacing: 12) {
                                        HStack(alignment: .center, spacing: 7.02722) { Image("tick")
                                            .frame(width: 24, height: 24) }
                                        .padding(16.86532)
                                        .frame(width: 41.99191, height: 41.99191, alignment: .center)
                                        .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                                        .cornerRadius(83.98381)
                                        
                                        VStack(alignment: .leading, spacing: 12) { // On Mobile/Input Placeholder
                                            Text("Unlimited events")
                                              .font(.system( size: 14))
                                              .foregroundColor(Color(red: 0.2, green: 0.23, blue: 0.29))
                                            
                                            
                                        }
                                        .padding(0)
                                    }
                                    .padding(0)
                                    
                                    HStack(alignment: .center, spacing: 12) {
                                        HStack(alignment: .center, spacing: 7.02722) { Image("tick")
                                            .frame(width: 24, height: 24) }
                                        .padding(16.86532)
                                        .frame(width: 41.99191, height: 41.99191, alignment: .center)
                                        .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                                        .cornerRadius(83.98381)
                                        
                                        VStack(alignment: .leading, spacing: 12) { // On Mobile/Input Placeholder
                                            // On Mobile/Input Placeholder
                                            Text("Unlimited tickets sales")
                                              .font(.system( size: 14))
                                              .foregroundColor(Color(red: 0.2, green: 0.23, blue: 0.29))
                                            
                                            
                                        }
                                        .padding(0)
                                    }
                                    .padding(0)
                                    
                                    
                                    
                                }
                                .padding(0)
                                
                                
                                
                                
                                
                            }
                            .padding(0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .center, spacing: 32) {
                                
                                Text("Get Started")
                                  .font(
                                    .system( size: 14)
                                      .weight(.medium)
                                  )
                                  .foregroundColor(.white)
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                            .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                            .cornerRadius(4)
                            .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.05), radius: 1, x: 0, y: 1)
                            .overlay(
                              RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(.white, lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .frame(width: 332, alignment: .leading)
                        .background(.white)
                        .cornerRadius(24)
                        .overlay(
                          RoundedRectangle(cornerRadius: 24)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.94, green: 0.95, blue: 0.96), lineWidth: 1)
                        )
                        
                        VStack(alignment: .leading, spacing: 26) {
                            VStack(alignment: .leading, spacing: 14) {
                                
                                VStack(alignment: .leading, spacing: 16) {
                                    
                                    VStack(alignment: .leading, spacing: 4) { // On Mobile/Header 4
                                        Text("Basic")
                                          .font(
                                            .system(size: 25)
                                              .weight(.bold)
                                          )
                                          .foregroundColor(Color(red: 0.2, green: 0.23, blue: 0.29))
                                        VStack(alignment: .center, spacing: 9) { VStack(alignment: .leading, spacing: 10) { Text("A basic plan for new events organizers.")
                                                .font(.system( size: 14))
                                                .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
                                                .frame(width: 298, alignment: .topLeading) }
                                                .padding(0)
                                                .frame(width: 298, alignment: .topLeading) }
                                        .padding(0)
                                        .frame(width: 298, alignment: .center)
                                        
                                        
                                    }
                                    .padding(0)
                                    
                                    HStack(alignment: .center, spacing: 2) {
                                        Text("$")
                                          .font(
                                            .system( size: 32)
                                              .weight(.semibold)
                                          )
                                          .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                                        
                                        // On Mobile/Header 3
                                        Text("\( isYearlySelected ? "49":"5")")
                                          .font(
                                            .system( size: 31)
                                              .weight(.bold)
                                          )
                                          .foregroundColor(Color(red: 0.06, green: 0.09, blue: 0.16))
                                        
                                        HStack(alignment: .top, spacing: 0) { // On Desktop/Text Button
                                            Text(isYearlySelected ? "per year":"per month")
                                              .font(
                                                .system( size: 16)
                                                  .weight(.medium)
                                              )
                                              .foregroundColor(Color(red: 0.4, green: 0.44, blue: 0.52)) }
                                        .padding(.horizontal, 0)
                                        .padding(.top, 0)
                                        .padding(.bottom, 8)
                                        .frame(height: 24, alignment: .topLeading)
                                    }
                                    .padding(0)
                                    .frame(height: 66, alignment: .leading)
                                    
                                }
                                .padding(0)
                                
                                Rectangle()
                                  .foregroundColor(.clear)
                                  .frame(width: 284, height: 1)
                                  .background(Color(red: 0.94, green: 0.95, blue: 0.96))
                                
                                VStack(alignment: .leading, spacing: 22) {
                                    
                                    HStack(alignment: .center, spacing: 12) {
                                        HStack(alignment: .center, spacing: 7.02722) { Image("tick")
                                            .frame(width: 24, height: 24) }
                                        .padding(16.86532)
                                        .frame(width: 41.99191, height: 41.99191, alignment: .center)
                                        .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                                        .cornerRadius(83.98381)
                                        
                                        VStack(alignment: .leading, spacing: 12) { // On Mobile/Input Placeholder
                                            Text("Up to 10 events")
                                              .font(.system( size: 14))
                                              .foregroundColor(Color(red: 0.2, green: 0.23, blue: 0.29))
                                            
                                            
                                        }
                                        .padding(0)
                                    }
                                    .padding(0)
                                    
                                    HStack(alignment: .center, spacing: 12) {
                                        HStack(alignment: .center, spacing: 7.02722) { Image("tick")
                                            .frame(width: 24, height: 24) }
                                        .padding(16.86532)
                                        .frame(width: 41.99191, height: 41.99191, alignment: .center)
                                        .background(Color(red: 0.97, green: 0.98, blue: 0.98))
                                        .cornerRadius(83.98381)
                                        
                                        VStack(alignment: .leading, spacing: 12) { // On Mobile/Input Placeholder
                                            // On Mobile/Input Placeholder
                                            Text("Unlimited tickets sales")
                                              .font(.system( size: 14))
                                              .foregroundColor(Color(red: 0.2, green: 0.23, blue: 0.29))
                                            
                                            
                                        }
                                        .padding(0)
                                    }
                                    .padding(0)
                                    
                                    
                                    
                                }
                                .padding(0)
                                
                                
                                
                                
                                
                            }
                            .padding(0)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack(alignment: .center, spacing: 32) {
                                
                                Text("Get Started")
                                  .font(
                                    .system( size: 14)
                                      .weight(.medium)
                                  )
                                  .foregroundColor(.white)
                            }
                            .padding(.horizontal, 18)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                            .background(Color(red: 0.88, green: 0.27, blue: 0.35))
                            .cornerRadius(4)
                            .shadow(color: Color(red: 0.06, green: 0.09, blue: 0.16).opacity(0.05), radius: 1, x: 0, y: 1)
                            .overlay(
                              RoundedRectangle(cornerRadius: 4)
                                .inset(by: 0.5)
                                .stroke(.white, lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 18)
                        .frame(width: 332, alignment: .leading)
                        .background(.white)
                        .cornerRadius(24)
                        .overlay(
                          RoundedRectangle(cornerRadius: 24)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.94, green: 0.95, blue: 0.96), lineWidth: 1)
                        )
                    }
                }
                   }
               }
              






                
            
            .padding(.horizontal, 20)
            .padding(.vertical, 0)
            .frame(width: 394, alignment: .center)
        }
    }


struct LockedView_Previews: PreviewProvider {
    static var previews: some View {
        LockedView()
    }
}
