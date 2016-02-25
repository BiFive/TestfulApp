//
//  StartupViewController.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 25/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logo.image = UIImage.animatedImageNamed("act", duration: 0.5)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupAnimation() {
//        var images = [UIImage]()
//        for i in 1...6 {
//            if let image = UIImage(named: "act\(i)") {
//                images.append(image)
//            }
//        }
        self.logo.image = UIImage.animatedImageNamed("act", duration: 0.5)
    }

}
