//
//  SwiftUIView.swift
//  AproPOS UI
//
//  Created by Edi Sachdev on 6/7/2022.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var myButton: UIButton!

  override func viewDidLoad() {
   super.viewDidLoad()
    
   let optionsClosure = { (action: UIAction) in
     print(action.title)
   }
   myButton.menu = UIMenu(children: [
     UIAction(title: "Option 1", state: .on, handler: optionsClosure),
     UIAction(title: "Option 2", handler: optionsClosure),
     UIAction(title: "Option 3", handler: optionsClosure)
   ])
  }
}
