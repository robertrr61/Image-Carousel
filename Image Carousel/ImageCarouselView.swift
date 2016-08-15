//
//  CarouselPagerView.swift
//  Image Carousel
//
//  Created by Roberto Rumbaut on 8/8/16.
//  Copyright © 2016 Roberto Rumbaut. All rights reserved.
//

import UIKit

protocol ImageCarouselViewDelegate {
    func scrolledToPage(page: Int)
}

@IBDesignable
class ImageCarouselView: UIView {
    
    var delegate: ImageCarouselViewDelegate?
    
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
    
    var currentPage: Int! {
        return Int(round(carouselScrollView.contentOffset.x / self.bounds.width))
    }
    
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
        carouselScrollView.showsHorizontalScrollIndicator = false
        
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
            imageView.userInteractionEnabled = true
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
        self.pageControl.currentPage = self.currentPage
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.delegate?.scrolledToPage(self.currentPage)
    }
    
}
