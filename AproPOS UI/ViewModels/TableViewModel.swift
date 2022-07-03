//
//  TableViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 3/7/22.
//

import Foundation

final class TableViewModel: ObservableObject {
    @Published var tables = [TableModel]()
    @Published var tableRepository = TableRepository()
    
}
