import SwiftUI
import Charts

struct GraphTabView: View {
    @State private var selectedInterval = "Daily"
    @State private var totalClicks = 0
    @State private var selectedBarData: (x: String, y: Int)?
    
    var body: some View {
        VStack {
            Text("Total\n\(totalClicks) clicks")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            
            Picker("Select Interval", selection: $selectedInterval) {
                Text("Daily").tag("Daily")
                Text("Weekly").tag("Weekly")
                Text("Monthly").tag("Monthly")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if selectedInterval == "Daily" {
                DailyGraphView(totalClicks: $totalClicks, selectedBarData: $selectedBarData)
            } else if selectedInterval == "Weekly" {
                WeeklyGraphView(totalClicks: $totalClicks)
            } else if selectedInterval == "Monthly" {
                MonthlyGraphView(totalClicks: $totalClicks)
            }
            
            if let selectedData = selectedBarData {
                Text("Selected Bar: \(selectedData.x), \(selectedData.y) clicks")
            }
        }
        .tabItem {
            Label("Clicks", systemImage: "hand.tap.fill")
        }
    }
}

struct DailyGraphView: View {
    @Binding var totalClicks: Int
    @Binding var selectedBarData: (x: String, y: Int)?
    @State private var selectedBarIndex: Int?
    
    var body: some View {
        GeometryReader { geometry in
            Chart {
                ForEach(Dailyclicks, id: \.day) { data in
                    BarMark(
                        x: .value("Day", data.day, unit: .day),
                        y: .value("Clicks", data.clicks)
                    )
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.pink, Color.red]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height - 25)
        }
        .onAppear {
            let dailyTotalClicks = Dailyclicks.map { $0.clicks }.reduce(0, +)
            totalClicks = dailyTotalClicks
        }
    }
}

let Dailyclicks: [(day: Date, clicks: Int)] = [
    (day: date(year: 2024, month: 3, day: 16), clicks: 3),
    (day: date(year: 2024, month: 3, day: 17), clicks: 6),
    (day: date(year: 2024, month: 3, day: 18), clicks: 4),
    (day: date(year: 2024, month: 3, day: 19), clicks: 8),
    (day: date(year: 2024, month: 3, day: 20), clicks: 9),
    (day: date(year: 2024, month: 3, day: 21), clicks: 5),
    (day: date(year: 2024, month: 3, day: 22), clicks: 7)
]


struct WeeklyGraphView: View {
    @Binding var totalClicks: Int

    struct WeeklyClickData {
        var name: String
        var customXAxisName: String
        var clicks: Int
    }

    var body: some View {
        GeometryReader { geometry in
            Chart {
                ForEach(Weeklyclicks, id: \.name) { clickData in
                    BarMark(
                        x: .value("Week", date(from: clickData.name), unit: .weekOfMonth),
                        y: .value("Clicks", clickData.clicks)
                    )
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.pink, Color.red]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height - 25)
        }
        .onAppear {
            let weeklyTotalClicks = Weeklyclicks.map { $0.clicks }.reduce(0, +)
            totalClicks = weeklyTotalClicks
        }
    }

    let Weeklyclicks: [WeeklyClickData] = [
        WeeklyClickData(name: "2024-03-1", customXAxisName: "Week 1", clicks: 18),
        WeeklyClickData(name: "2024-03-8", customXAxisName: "Week 2", clicks: 24),
        WeeklyClickData(name: "2024-03-15", customXAxisName: "Week 3", clicks: 28),
        WeeklyClickData(name: "2024-03-22", customXAxisName: "Week 4", clicks: 22),
        WeeklyClickData(name: "2024-03-29", customXAxisName: "Week 4", clicks: 35)
    ]

    func date(from dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString) ?? Date()
    }
}



struct MonthlyGraphView: View {
    @Binding var totalClicks: Int
    
    var body: some View {
        GeometryReader { geometry in
            Chart {
                ForEach(Monthlyclicks, id: \.day) {
                    BarMark(
                        x: .value("Month", $0.day, unit: .month),
                        y: .value("Clicks", $0.clicks)
                    )
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.pink, Color.red]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(5)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height - 25)
        }
        
        .onAppear {
            let monthlyTotalClicks = Monthlyclicks.map { $0.clicks }.reduce(0, +)
            totalClicks = monthlyTotalClicks
        }
    }
    
    let Monthlyclicks: [(day: Date, clicks: Int)] = [
        (day: date(year: 2023, month: 11), clicks: 94),
        (day: date(year: 2023, month: 12), clicks: 116),
        (day: date(year: 2024, month: 1), clicks: 109),
        (day: date(year: 2024, month: 2), clicks: 121),
        (day: date(year: 2024, month: 3), clicks: 101)
    ]
}

struct GraphTabView_Previews: PreviewProvider {
    static var previews: some View {
        GraphTabView()
    }
}

func date(year: Int, month: Int, day: Int = 1) -> Date {
    Calendar.current.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}

