import SwiftUI

struct PaymentTicketSheet: View {
    let event: EventResponse
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            VStack {
                Text("Payment Ticket")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Divider() // Add a divider for visual separation
                
                // Display the event details in the payment ticket
                VStack(alignment: .leading, spacing: 10) {
                    TicketDetailRow(title: "Event:", value: event.title)
                    TicketDetailRow(title: "Date:", value: "\(event.startDate1)", formatter: dateOnlyFormatter)
                    TicketDetailRow(title: "Location:", value: event.location)
                    TicketDetailRow(title: "Price:", value: String(format: "$%.2f", event.tickets.first?.price ?? 0.0))
                }
                .padding()
                
                Divider() // Add another divider
                
                // Add payment and confirmation buttons here
                Button(action: {
                    // Add your payment logic here
                    // For demonstration purposes, just close the sheet when the button is tapped
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Pay Now")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .buttonStyle(PlainButtonStyle()) // Remove default button styling
                
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 4)
            
            // Close the payment ticket sheet when tapped outside
            Spacer()
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }

    }
    
    private let dateOnlyFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

// Helper view for displaying ticket details in a row format
struct TicketDetailRow: View {
    let title: String
    let value: String
    var formatter: DateFormatter? = nil

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            if let formatter = formatter {
                Text("\(value)")
            } else {
                Text(value)
            }
        }
    }
}
