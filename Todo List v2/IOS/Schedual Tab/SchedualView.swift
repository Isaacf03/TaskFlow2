import SwiftUI

extension Date: Identifiable {
    public var id: Date {
        return self
    }
}

struct ScheduleView: View {
    // State variables to track the current year and selected date
    @State private var currentYear = Calendar.current.component(.year, from: Date())
    @State private var selectedDate: Date? = nil
    
    private let calendar = Calendar.current
    
    // Function to get the number of days in a specific month
    private func numberOfDaysInMonth(_ month: Int) -> Int {
        let dateComponents = DateComponents(year: currentYear, month: month)
        guard let date = calendar.date(from: dateComponents) else { return 0 }
        return calendar.range(of: .day, in: .month, for: date)!.count
    }
    
    var body: some View {
        ScrollView {
            // Loop through each month of the year
            ForEach(1...12, id: \.self) { month in
                VStack {
                    // Display current month
                    Text("\(calendar.monthSymbols[month - 1]) \(currentYear)")
                        .font(.title)
                        .padding()
                    
                    // Grid of day views for the current month
                    let daysInMonth = numberOfDaysInMonth(month)
                    let gridItems = [GridItem](repeating: GridItem(.flexible()), count: 7)
                    
                    LazyVGrid(columns: gridItems, spacing: 10) {
                        ForEach(1...daysInMonth, id: \.self) { day in
                            DayView(date: dateForDay(month: month, day: day))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .onTapGesture {
                                    // Set the selected date when a day is tapped
                                    selectedDate = dateForDay(month: month, day: day)
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .sheet(item: $selectedDate) { date in
            // Display a detailed view for the selected date
            DetailedDayView(date: date)
        }
    }
    
    // Function to get the date for a specific day in a specific month
    private func dateForDay(month: Int, day: Int) -> Date {
        let dateComponents = DateComponents(year: currentYear, month: month, day: day)
        return calendar.date(from: dateComponents)!
    }
}

struct DayView: View {
    let date: Date
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text(formatter.string(from: date))
                .font(.title)
                .padding()
            
            // Customize the day view as needed
            // For demonstration purposes, we just display the date
        }
        .background(Color.blue.opacity(0.2))
        .cornerRadius(10)
    }
}

struct DetailedDayView: View {
    let date: Date
    
    var body: some View {
        Text("Details for \(date)")
            .padding()
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
