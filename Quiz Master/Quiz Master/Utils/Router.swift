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
        case session(category: Category, diff: Difficulty)
        case result(category: Category, diff: Difficulty)
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
    
    func popTo(to destination: Destination) {
        navigateUp()
        navigate(to: destination)
    }
}
