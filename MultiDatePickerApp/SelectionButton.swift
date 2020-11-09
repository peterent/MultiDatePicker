//
//  SelectionButton.swift
//  MultiDatePickerApp
//
//  Created by Peter Ent on 11/3/20.
//

import SwiftUI

struct SelectionButtonZ: View {
    @EnvironmentObject var monthModel: MonthDataModel
    
    var action: () -> Void
    
    var body: some View {
        Button ( action: {self.action()} ) {
            Text(monthModel.selectionAsString)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.4))
        )
    }
}

struct SelectionButton_Previews: PreviewProvider {
    @StateObject static var monthModel = MonthDataModel()
    static var previews: some View {
        SelectionButtonZ() {
            monthModel.selectDay(monthModel.days[0])
        }
        .environmentObject(monthModel)
    }
}
