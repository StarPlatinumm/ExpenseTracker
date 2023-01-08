//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Артем Кривдин on 25.12.2022.
//

import Foundation
import Combine
import Collections
import Alamofire

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        AF.request(url).responseDecodable(of: [Transaction].self) { [weak self] response in
            switch response.result {
            case .success:
                do {
                    self?.transactions = try JSONDecoder().decode([Transaction].self, from: response.data!)
                    print("Finished fetching transactions")
                } catch {
                    print("Error decoding response: \(error)")
                }
            case .failure(let error):
                print("Error fetching transactions: ", error.localizedDescription)
            }
        }
    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        return TransactionGroup(grouping: transactions) { $0.month }
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
        let today = "02/17/2022".dateParced() // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter { $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roudedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
        }
        
        return cumulativeSum
    }
}
