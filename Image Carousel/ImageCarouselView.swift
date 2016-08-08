//
//  CarouselPagerView.swift
//  Image Carousel
//
//  Created by Roberto Rumbaut on 8/8/16.
//  Copyright © 2016 Roberto Rumbaut. All rights reserved.
//

import UIKit

@IBDesignable
class ImageCarouselView: UIView {

    @IBInspectable var showPageControl: Bool = false {
        didSet {
            setupView()
        }
    }
    
    var carouselScrollView: UIScrollView!
    
    var images = [UIImage]() {
        didSet {
            setupView()
        }
    }
    
    var pageControl = UIPageControl()
    
    @IBInspectable var pageColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var currentPageColor: UIColor? {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        for view in subviews {
            view.removeFromSuperview()
        }
        
        carouselScrollView = UIScrollView(frame: bounds)
        carouselScrollView.backgroundColor = UIColor.blackColor()
        
        addImages()
        
        if showPageControl {
            addPageControl()
            carouselScrollView.delegate = self
        }
    }
    
    func addImages() {
        carouselScrollView.pagingEnabled = true
        carouselScrollView.contentSize = CGSizeMake(bounds.width * CGFloat(images.count), bounds.height)
        
        for i in 0..<images.count {
            let imageView = UIImageView(frame: CGRectMake(bounds.width * CGFloat(i), 0, bounds.width, bounds.height))
            imageView.image = images[i]
            imageView.contentMode = .ScaleAspectFill
            imageView.layer.masksToBounds = true
            carouselScrollView.addSubview(imageView)
            print("Added")
        }
        
        self.addSubview(carouselScrollView)
    }
    
    func addPageControl() {
        pageControl.numberOfPages = images.count
        pageControl.sizeToFit()
        pageControl.currentPage = 0
        pageControl.center = CGPointMake(self.center.x, bounds.height - pageControl.bounds.height/2 - 8)
        
        if let pageColor = self.pageColor {
            pageControl.pageIndicatorTintColor = pageColor
        }
        if let currentPageColor = self.currentPageColor {
            pageControl.currentPageIndicatorTintColor = currentPageColor
        }
        
        self.addSubview(pageControl)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
    }

}

extension ImageCarouselView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentPage = round(scrollView.contentOffset.x / self.bounds.width)
        
        self.pageControl.currentPage = Int(currentPage)
    }
    
}
