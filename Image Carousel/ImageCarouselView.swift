//
//  CarouselPagerView.swift
//  Image Carousel
//
//  Created by Roberto Rumbaut on 8/8/16.
//  Copyright © 2016 Roberto Rumbaut. All rights reserved.
//

import UIKit

protocol ImageCarouselViewDelegate {
    func scrolledToPage(_ page: Int)
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
        carouselScrollView.backgroundColor = UIColor.black
        carouselScrollView.showsHorizontalScrollIndicator = false
        
        addImages()
        
        if showPageControl {
            addPageControl()
            carouselScrollView.delegate = self
        }
    }
    
    func addImages() {
        carouselScrollView.isPagingEnabled = true
        carouselScrollView.contentSize = CGSize(width: bounds.width * CGFloat(images.count), height: bounds.height)
        
        for i in 0..<images.count {
            let imageView = UIImageView(frame: CGRect(x: bounds.width * CGFloat(i), y: 0, width: bounds.width, height: bounds.height))
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            imageView.isUserInteractionEnabled = true
            carouselScrollView.addSubview(imageView)
            print("Added")
        }
        
        self.addSubview(carouselScrollView)
    }
    
    func addPageControl() {
        pageControl.numberOfPages = images.count
        pageControl.sizeToFit()
        pageControl.currentPage = 0
        pageControl.center = CGPoint(x: self.center.x, y: bounds.height - pageControl.bounds.height/2 - 8)
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = self.currentPage
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scrolledToPage(self.currentPage)
    }
    
}
