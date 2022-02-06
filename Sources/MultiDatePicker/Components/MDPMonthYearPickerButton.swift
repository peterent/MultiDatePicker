//
//  MonthYearPickerButton.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

/**
 * The MDPMonthYearPickerButton sits at the top of the MDPMonthView and displays the current month
 * and year showing in the view. Tapping this control switches the main view to the month/year
 * picker.
 *
 * This is a quick way for the user to jump the year or month without having to the < or >
 * buttons.
 */
struct MDPMonthYearPickerButton: View {
    @EnvironmentObject var monthDataModel: MDPModel
    
    @Binding var isPresented: Bool
    
    var body: some View {
        Button( action: {withAnimation { isPresented.toggle()} } ) {
            HStack {
                Text(monthDataModel.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(self.isPresented ? .accentColor : .black)
                Image(systemName: "chevron.right")
                    .rotationEffect(self.isPresented ? .degrees(90) : .degrees(0))
            }
        }
    }
}

struct MonthYearPickerButton_Previews: PreviewProvider {
    static var previews: some View {
        MDPMonthYearPickerButton(isPresented: .constant(false))
    }
}
