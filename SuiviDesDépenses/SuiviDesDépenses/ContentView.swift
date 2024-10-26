//
//  ContentView.swift
//  SuiviDesDépenses
//
//  Created by Thierry Sarr on 26/10/2024.
//

import SwiftUI

struct Expense: Identifiable {
    let id = UUID()
    var description: String
    var amount: Double
}

struct ContentView: View {
    @State private var expenses = [Expense]()
    @State private var newDescription = ""
    @State private var newAmount = ""
    
    var total: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Description", text: $newDescription)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Amount", text: $newAmount)
                        .keyboardType(.decimalPad)
                        .padding(.horizontal)
                    
                    Button(action: addExpense) {
                        Text("Add")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom)
                
                List {
                    ForEach(expenses) { expense in
                        HStack {
                            Text(expense.description)
                            Spacer()
                            Text("\(expense.amount, specifier: "%.2f")€")
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: deleteExpense)
                }
                
                Text("Total: \(total, specifier: "%.2f")€")
                    .font(.title)
                    .padding()
            }
            .navigationTitle("Suivi des Dépenses")
        }
    }
    
    func addExpense() {
        if let amount = Double(newAmount), !newDescription.isEmpty {
            let expense = Expense(description: newDescription, amount: amount)
            expenses.append(expense)
            newAmount = ""
            newDescription = ""
        }
    }
    
    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
