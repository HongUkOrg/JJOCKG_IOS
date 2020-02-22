//
//  cartoonContainerViewViewController.swift
//  letter_mouse
//
//  Created by David Park on 23/07/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class cartoonContainerViewController: EZSwipeController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        navigationBarShouldNotExist = true
        // Do any additional setup after loading the view.
    }
    override func setupView() {
        datasource = self
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension cartoonContainerViewController: EZSwipeControllerDataSource {
    func viewControllerData() -> [UIViewController] {
        
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "cartoon_01_view") as! cartoon01ViewController
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "cartoon_02_view") as! cartoon02ViewController
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "cartoon_03_view") as! cartoon03ViewController
        let vc4 = self.storyboard?.instantiateViewController(withIdentifier: "cartoon_04_view") as! cartoon04ViewController
        let vc5 = self.storyboard?.instantiateViewController(withIdentifier: "cartoon_05_view") as! cartoon05ViewController
        let vc6 = self.storyboard?.instantiateViewController(withIdentifier: "cartoon_06_view") as! cartoon06ViewController
        let vc7 = self.storyboard?.instantiateViewController(withIdentifier: "cartoon_07_view") as! cartoon07ViewController
        let vc8 = self.storyboard?.instantiateViewController(withIdentifier: "cartoon_08_view") as! cartoon08ViewController
        
        return [vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8]
    }
}
