//
//  PageControl.swift
//  Quiz Master
//
//  Created by Izzat Syamil on 21/04/2024.
//

import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
   
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = QUESTION_COUNT
        control.isUserInteractionEnabled = false
        control.addTarget(
            context.coordinator, 
            action: #selector(Coordinator.updateCurrentPage(sender:)), 
            for: .valueChanged
        )
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
    
    class Coordinator: NSObject {
        var control: PageControl
        
        init(_ control: PageControl) {
            self.control = control
        }
        
        @objc
        func updateCurrentPage(sender: UIPageControl) {
            control.currentPage = sender.currentPage
        }
    }
}
