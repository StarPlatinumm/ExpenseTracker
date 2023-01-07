//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Артем Кривдин on 25.12.2022.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
