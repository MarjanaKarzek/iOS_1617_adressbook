//
//  ViewController.swift
//  Ue6-Karzek
//
//  Created by Marjana Karzek on 18/01/17.
//  Copyright © 2017 Marjana Karzek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var customView: CustomView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func moveGesture(_ sender: Any) {
        if let recognizer = sender as? UIPanGestureRecognizer{
            customView.transform.translatedBy(x: recognizer.translation(in: customView).x, y: recognizer.translation(in: customView).y)
            print("move")
        }
    }

    @IBAction func rotateGesture(_ sender: Any) {
    }
}

