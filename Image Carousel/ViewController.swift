//
//  ViewController.swift
//  Image Carousel
//
//  Created by Roberto Rumbaut on 8/8/16.
//  Copyright © 2016 Roberto Rumbaut. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageCarouselView: ImageCarouselView!
    
    var images: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images = [ UIImage(named: "1")!,
                   UIImage(named: "2")!,
                   UIImage(named: "3")!,
                   UIImage(named: "4")! ]
        
        imageCarouselView.images = images
    }
}

