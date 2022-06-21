//
//  MenuViewModel.swift
//  AproPOS UI
//
//  Created by Chris Yoo on 24/5/22.
//

import Foundation

final class MenuViewModel: ObservableObject {
    @Published var menuList = [MenuItemModel]()
    @Published var menuRepository = MenuRepository()
    
    
}
