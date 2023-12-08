import SwiftUI

struct AlertsTabView: View {
    @State private var alertsData: [AlertModel] = []

    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack {
                ForEach(alertsData.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(alertsData[index].iconColor, lineWidth: 2)
                        .frame(width: 350, height: 75)
                        .overlay(AlertItem(alert: alertsData[index]))
                        .padding()
                }
            }
            .navigationBarTitle("Alerts", displayMode: .inline)
        }
        .tabItem {
            Label("Alerts", systemImage: "exclamationmark.circle.fill")
        }
        .onAppear {
            // Create 5 initial alerts with specific dates
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            for i in 0..<5 {
                if let date = dateFormatter.date(from: "11/\(22 + i)/2023") {
                    let newAlert = AlertModel(
                        iconName: "exclamationmark.circle.fill",
                        iconColor: Color.blue,
                        iconBackgroundColor: Color.blue.opacity(0.2),
                        title: "Grandma needed help!",
                        timestamp: formattedTimestamp(date: date)
                    )
                    alertsData.append(newAlert)
                }
            }
        }
        .onReceive(timer) { _ in
            withAnimation {
                let newDate = Date()
                let newAlert = AlertModel(
                    iconName: "exclamationmark.circle.fill",
                    iconColor: Color.red,
                    iconBackgroundColor: Color.red.opacity(0.2),
                    title: "Grandma needs help!",
                    timestamp: formattedTimestamp(date: newDate)
                )
                alertsData.append(newAlert)
            }
        }
    }

    private func formattedTimestamp(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy HH:mm:ss"
        return formatter.string(from: date)
    }
}

struct AlertTabView_Previews: PreviewProvider {
    static var previews: some View {
        AlertsTabView()
    }
}

