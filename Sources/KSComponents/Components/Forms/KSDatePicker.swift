import SwiftUI

public struct KSDatePicker: View {
    @Binding var date: Date
    let label: String?
    let displayedComponents: DatePickerComponents

    public init(
        date: Binding<Date>,
        label: String? = nil,
        displayedComponents: DatePickerComponents = [.date, .hourAndMinute]
    ) {
        self._date = date
        self.label = label
        self.displayedComponents = displayedComponents
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: KS.Spacing.xs) {
            if let label {
                Text(label)
                    .font(KS.Typography.labelMedium)
                    .foregroundStyle(KS.Colors.textSecondary)
            }

            DatePicker("", selection: $date, displayedComponents: displayedComponents)
                .labelsHidden()
                .tint(KS.Colors.primary)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        KSDatePicker(date: .constant(Date()), label: "Select Date & Time")
        KSDatePicker(date: .constant(Date()), label: "Date Only", displayedComponents: .date)
        KSDatePicker(date: .constant(Date()), label: "Time Only", displayedComponents: .hourAndMinute)
    }
    .padding()
}
