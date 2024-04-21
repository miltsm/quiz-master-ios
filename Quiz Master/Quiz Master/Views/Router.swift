//
//  Router.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    enum Destination : Hashable {
        case session(category: Category, level: Level)
    }
    
    @Published var path: NavigationPath
    
    init() {
        self.path = NavigationPath()
    }
    
    func navigate(to destination: Destination) {
        path.append(destination)
    }
    
    func navigateUp() {
        path.removeLast()
    }
}
