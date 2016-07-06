//
//  PagedScrollViewViewController.swift
//  iChallenge
//
//  Created by Jake on 7/2/16.
//  Copyright © 2016 Jake Zeal. All rights reserved.
//

import UIKit

// MARK: - PageControlOptions
struct PageControlOptions {
    struct Indicator {
        struct Color {
            static let Tint = UIColor.grayColor().colorWithAlphaComponent(0.3)
            static let CurrentTint = UIColor.darkGrayColor()
        }

        struct Size {
            static let Width = CGFloat(60.0)
            static let Height = CGFloat(30.0)
        }

        struct Padding {
            static let Vertical = CGFloat(15.0)
        }
    }
}

class Page: UIView {
    
    // MARK: - Properties
    let titleLabel: UILabel = UILabel()
    let imageView: UIImageView = UIImageView()
    let textLabel: UILabel = UILabel()
    
    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        prepareTitleLabel()
        prepareImageView()
        prepareTextLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycles
    override func layoutSubviews() {
        layoutTitleLabel()
        layoutImageView()
        layoutTextLabel()
    }
    
    // MARK: - Preparations
    func prepareTitleLabel() {
        titleLabel.font = UIFont.systemFontOfSize(36.0)
        titleLabel.text = ""
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .Center
        addSubview(titleLabel)
    }
    
    func prepareImageView() {
        imageView.contentMode = .ScaleAspectFit
        addSubview(imageView)
    }
    
    func prepareTextLabel() {
        textLabel.text = ""
        textLabel.textColor = UIColor.fuchsiaColor()
        textLabel.numberOfLines = 12
        textLabel.textAlignment = .Center
        addSubview(textLabel)
    }
    
    // MARK: - Layouts
    func layoutTitleLabel() {
        titleLabel.frame = CGRect(x: (bounds.size.width / 2) - (160), y: 8, width: 320, height: 100)
    }
    
    func layoutImageView() {
        imageView.frame = CGRect(x: (bounds.size.width / 2) - (200), y: 100, width: 400, height: 300)
    }
    
    func layoutTextLabel() {
        textLabel.frame = CGRect(x: (bounds.size.width / 2) - (160), y: CGRectGetMaxY(imageView.frame), width: 320, height: 300)
    }
}

// MARK: - Protocols
protocol PagedScrollViewControllerDelegate {
    func didPressEnterButton()
}


class PagedScrollViewController: UIViewController, UIScrollViewDelegate  {
    
    // MARK: - Properties
    var pages: [Page] = [Page]()
    let scrollView: UIScrollView = UIScrollView()
    let pageControl: UIPageControl = UIPageControl()
    let imageView: UIImageView = UIImageView()
    var delegate: PagedScrollViewControllerDelegate?
    
    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePages()
        prepareScrollView()
        preparePageControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutBackgroundImageView()
        layoutScrollView()
        layoutPages()
        layoutPageControl()
    }
    
    // MARK: - Preparations
    func preparePages() {
        for _ in 0 ..< 3 {
            let page: Page = Page()
            pages.append(page)
        }
    }
    
    private func prepareScrollView() {
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.delegate = self
        scrollView.pagingEnabled = true
        view.addSubview(self.scrollView)
    }
    
    private func preparePageControl() {
        pageControl.pageIndicatorTintColor = PageControlOptions.Indicator.Color.Tint
        pageControl.currentPageIndicatorTintColor = PageControlOptions.Indicator.Color.CurrentTint
        pageControl.currentPage = 0
        view.addSubview(self.pageControl)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // MARK: - Layouts
    private func layoutBackgroundImageView() {
        imageView.frame = view.bounds
    }
    
    private func layoutScrollView() {
        scrollView.frame = view.bounds
    }
    
    private func layoutPageControl() {
        let w = PageControlOptions.Indicator.Size.Width
        let h = PageControlOptions.Indicator.Size.Height
        let vp = PageControlOptions.Indicator.Padding.Vertical
        pageControl.frame = CGRect(x: (view.bounds.size.width / 2) - (w / 2), y: CGRectGetMaxY(view.bounds) - (h + vp), width: w, height: h)
    }
    
    private func layoutPages() {
        let sw = scrollView.bounds.size.width
        let sh = scrollView.bounds.size.height
        for i in 0 ..< pages.count {
            let p: Page = pages[i]
            p.frame = CGRect(x: CGRectGetMaxX(scrollView.bounds) * CGFloat(i), y: 0.0, width: sw, height: sh)
            p.titleLabel.text = titleForIndex(i)
            p.imageView.image = imageForIndex(i)
            p.textLabel.text = textForIndex(i)
            scrollView.addSubview(p)
        }
        scrollView.contentSize = CGSizeMake(sw * CGFloat(pages.count), sh)
        pageControl.numberOfPages = pages.count
    }
    
    // MARK: - Helper Methods
    func titleForIndex(index: Int) -> String {
        var title: String = ""
        switch (index) {
        case 0:
            title += ""
            break
        case 1:
            title += ""
            break
        case 2:
            title += ""
            break
        default:
            break
        }
        return title
    }
    
    func imageForIndex(index: Int) -> UIImage {
        var image: UIImage!
        switch (index) {
        case 0:
            image = UIImage(named: "steps")
            break
        case 1:
            image = UIImage(named: "headtohead")
        case 2:
            image = UIImage(named: "compete")
        default:
            break
        }
        return image
    }
    
    func textForIndex(index: Int) -> String {
        var text: String = ""
        switch (index) {
        case 0:
            text += "Welcome to iChallenge"
            break
        case 1:
            text += "Challenge yourself. Challenge others."
            break
        case 2:
            text += "Achieve your goals. Achieve highscores."
            break
        default:
            break
        }
        return text
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = CGRectGetWidth(self.scrollView.bounds)
        let pageFraction = self.scrollView.contentOffset.x / pageWidth
        pageControl.currentPage = Int(round(Float(pageFraction)))
        
        let page = pages[pageControl.currentPage]
        
        if pageControl.currentPage == pages.count - 1 {
            let button: UIButton = UIButton()
            button.backgroundColor = UIColor.blackColor()
            button.layer.borderColor = UIColor.blackColor().CGColor
            button.layer.borderWidth = 2.0
            button.layer.cornerRadius = 5.0
            button.setTitle("Enter", forState: .Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.frame = CGRect(x: (scrollView.bounds.size.width / 2) - (100), y: scrollView.bounds.size.height - 140, width: 200, height: 40)
            button.addTarget(self, action: #selector(PagedScrollViewController.enter), forControlEvents: .TouchUpInside)
            page.addSubview(button)
        }
    }
    
    func enter() {
//        dismissViewControllerAnimated(true, completion: nil)
        delegate?.didPressEnterButton()
    }
}

