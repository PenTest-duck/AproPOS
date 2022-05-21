//
//  OrderViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 21/5/22.
//

import Foundation
import Firebase
import FirebaseFirestore

final class OrderViewModel: ObservableObject {
    @Published var orders = [OrderModel]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("orders").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }

            self.orders = documents.map { queryDocumentSnapshot -> OrderModel in
                let data = queryDocumentSnapshot.data()
                let tableNumber = data["tableNumber"] as? Int ?? 0
                let startTimeEvent = (data["startTime"] as? Timestamp)?.dateValue() ?? Date()
                let status = data["status"] as? String ?? ""
                let orderedMenuItems = data["orderedMenuItems"] as? [[String: Int]] ?? []

                return OrderModel(id: .init(), tableNumber: tableNumber, startTimeEvent: startTimeEvent, status: status, orderedMenuItems: orderedMenuItems)
            }
        }
    }
}
