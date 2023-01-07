//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Артем Кривдин on 25.12.2022.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/22", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
