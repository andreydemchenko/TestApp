//
//  ViewController.swift
//  TestApp
//
//  Created by andreydem on 24.09.2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var revivsView: UIView!
    
    @IBOutlet weak var criticsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = nil
    }
   
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        revivsView.isHidden = true
        criticsView.isHidden = true
        
        if sender.selectedSegmentIndex == 0 {
            revivsView.isHidden = false
        } else {
            criticsView.isHidden = false
        }
    }
    
}

