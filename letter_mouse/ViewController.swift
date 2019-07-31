//
//  ViewController.swift
//  letter_mouse
//
//  Created by mac on 23/03/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var mainGIF: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did loaded on main")
         self.navigationController?.isNavigationBarHidden = true
        
    
        let jeremyGif = UIImage.gifImageWithName("main_g")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0, y: 0, width: self.mainGIF.frame.size.width, height: self.mainGIF.frame.size.height)
        
        mainGIF.addSubview(imageView)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5 ) {
            self.performSegue(withIdentifier: "toCartoonContainer", sender: self)
        }
    }
    @IBOutlet var splashView: UIView!
    

}
