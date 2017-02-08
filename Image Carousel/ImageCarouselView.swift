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
    
    @IBInspectable var pageControlMaxItems: Int = 10 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var autoScroll: Bool = false {
        didSet {
            print("AutoScroll")
        }
    }
    
    @IBInspectable var time: Float = 3.0 {
        didSet {
            print(time)
        }
    }
    
    var pageLabel = UILabel()
    
    var counter = 1
    
    var banderaForTimer = true
    
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
        if images.count <= pageControlMaxItems {
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
        } else {
            pageLabel.text = "1 / \(images.count)"
            pageLabel.font = UIFont.systemFont(ofSize: 10.0, weight: UIFontWeightLight)
            pageLabel.frame.size = CGSize(width: 40, height: 20)
            pageLabel.textAlignment = .center
            pageLabel.layer.cornerRadius = 10
            pageLabel.layer.masksToBounds = true
            
            pageLabel.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.3)
            pageLabel.textColor = UIColor.white
            pageLabel.center = CGPoint(x: self.center.x, y: bounds.height - pageLabel.bounds.height/2 - 8)
            
            self.addSubview(pageLabel)
        }
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
        if autoScroll {
            _ = Timer.scheduledTimer(timeInterval: TimeInterval(time), target: self, selector: #selector(scrollToPage), userInfo: nil, repeats: true)
            self.carouselScrollView.isUserInteractionEnabled = false
        }
    }
    
    @objc private func scrollToPage() {
        var frame: CGRect = self.carouselScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(self.counter)
        frame.origin.y = 0;
        print(frame.origin.x)
        print(self.counter)
        print(self.images.count)
        self.carouselScrollView.scrollRectToVisible(frame, animated: true)
        if self.counter == images.count - 1 {
            self.counter = 0
        } else {
            self.counter += 1
        }
    }
    
}

extension ImageCarouselView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = self.currentPage
        self.pageLabel.text = "\(self.currentPage+1) / \(images.count)"
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.delegate?.scrolledToPage(self.currentPage)
    }
    
}
