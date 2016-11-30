//
//  TSHJPageMenu.swift
//  N-Students
//
//  Created by 王木木 on 16/11/22.
//  Copyright © 2016年 E-edu Space. All rights reserved.
//

import UIKit

enum TSPageMenuOption {
    
    case ShowsHorizontalScrollIndicator(Bool)
    
    case ShowsVerticalScrollIndicator(Bool)
    
    case IsBounces(Bool)         
    
    case IsScrollEnabled(Bool)
    
    case BottomViewColor(UIColor)
    
    case BottomViewHeight(CGFloat)
    
    case PagingEnabled(Bool)
    
    case AlwaysBounceVertical(Bool)
    
    case ScrollMenuBackgroundColor(UIColor)
    
    case AlwaysBounceHorizontal(Bool)
    
    case MenuHeight(CGFloat)
    
    case MenuWidth(CGFloat)
    
    case MenuBackColor(UIColor)
    
    case MenutitleColor(UIColor)
    
}

class TSHJPageMenu: UIViewController, UIGestureRecognizerDelegate {
    
    var controllerArray : [UIViewController] = []
    
    let controllerScrollView = UIScrollView()
    
    let menuScrollView = UIScrollView()
    
    let bottomView = UIView()
    
    var menuItemWidths : [CGFloat] = []
    
    var scrollMenuBackgroundColor = UIColor.white
    
    private let defaultMenuWidth: CGFloat = 70.0
    
    var bottomViewColor = UIColor.gray
    
    var menuBackColor = UIColor.white
    
    var menutitleColor = UIColor.black
    
    var isAlwaysBounceHorizontal = false
    
    var BottomViewHeight: CGFloat = 2.0
    
    var menuHeight : CGFloat = 44.0
    
    var menuWidth : CGFloat = 0.0
    
    var alwaysBounceVertical: Bool = false
    
    var showsHorizontalScrollIndicator: Bool = false
    
    var showsVerticalScrollIndicator: Bool = false
    
    var isScrollEnabled = true
    
    var isBounces = true
    
    var vcArray:[Int] = [0]
    
    init(viewControllers: [UIViewController], frame: CGRect, options: [String: AnyObject]?) {
        super.init(nibName: nil, bundle: nil)
        
        controllerArray = viewControllers
        
        self.view.frame = frame
        
    }
    
    convenience init(viewControllers: [UIViewController], frame: CGRect, pageMenuOptions: [TSPageMenuOption]?) {
        self.init(viewControllers:viewControllers, frame:frame, options:nil)
        
        if let options = pageMenuOptions {
            
            for option in options {
                
                switch (option) {
                    
                case let .ShowsHorizontalScrollIndicator(value):
                    
                    showsHorizontalScrollIndicator = value
                    
                case let .IsScrollEnabled(value):
                    
                    isScrollEnabled = value
                    
                case let .PagingEnabled(value):
                    
                    isScrollEnabled = value
                    
                case let .AlwaysBounceVertical(value):
                    
                    alwaysBounceVertical = value
                    
                case let .ShowsVerticalScrollIndicator(value):
                    
                    showsVerticalScrollIndicator = value
                    
                case let .ScrollMenuBackgroundColor(value):
                    
                    scrollMenuBackgroundColor = value
                    
                case let .BottomViewColor(value):
                    
                    bottomViewColor = value
                    
                case let .AlwaysBounceHorizontal(value):
                    
                    isAlwaysBounceHorizontal = value
                    
                case let .MenuHeight(value):
                    
                    menuHeight = value
                    
                case let .MenuWidth(value):
                    
                    menuWidth = value
                    
                case let .MenuBackColor(value):
                    
                    menuBackColor = value
                    
                case let .MenutitleColor(value):
                    
                    menutitleColor = value
                    
                default:
                    
                    break
                    
                }
                
            }
            
        }
        
        self.createUI()
        
        self.setConstraint()
        
        if menuScrollView.subviews.isEmpty {
            
            self.configureUserInterface()
            
            self.setmenuScrollView()
            
        }
        
    }
    
    func createUI() {
        
        self.view.addSubview(menuScrollView)
        
        self.view.addSubview(controllerScrollView)
        
        controllerScrollView.delegate = self
        
        controllerScrollView.isPagingEnabled = isScrollEnabled
        
        controllerScrollView.alwaysBounceHorizontal = isAlwaysBounceHorizontal
        
        controllerScrollView.alwaysBounceVertical = alwaysBounceVertical
        
        controllerScrollView.bounces = isBounces
        
        controllerScrollView.isScrollEnabled = isScrollEnabled
        
        controllerScrollView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        
        controllerScrollView.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        
        menuScrollView.backgroundColor = scrollMenuBackgroundColor
        
        menuScrollView.showsHorizontalScrollIndicator = false
        
        menuScrollView.showsVerticalScrollIndicator = false
        
        let menuItemTapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                  action: #selector((handleMenuItemTap(gestureRecognizer:))))
        
        menuItemTapGestureRecognizer.numberOfTapsRequired = 1
        
        menuItemTapGestureRecognizer.numberOfTouchesRequired = 1
        
        menuItemTapGestureRecognizer.delegate = self
        
        menuScrollView.addGestureRecognizer(menuItemTapGestureRecognizer)
        
        bottomView.backgroundColor = bottomViewColor
        
    }
    
    func setmenuScrollView() {
        
        let count = controllerArray.count
        
        var width = self.view.frame.size.width / CGFloat(count)
        
        if width < defaultMenuWidth {
            
            width = defaultMenuWidth
            
            menuScrollView.contentSize = CGSize.init(width: width * CGFloat(count),
                                                     height: 0)
            
        }
        
        menuWidth = width
        
        for (index, _) in controllerArray.enumerated() {
            
            let menuView = TSMenuItemView(titleName: "王木木")
            
            menuView.frame = CGRect.init(x: CGFloat(index) * width,
                                         y: 0,
                                         width: width,
                                         height: menuHeight)
            
            menuScrollView.addSubview(menuView)
            
            menuView.titleLabel.frame = CGRect.init(x: 0,
                                                    y: 0,
                                                    width: width,
                                                    height: menuHeight)
            
            menuView.backgroundColor = menuBackColor
            
            menuView.titleLabel.textColor = menutitleColor
            
        }
        
        bottomView.frame.size.width = width
        
        menuScrollView.addSubview(bottomView)
        
    }
    
    func setConstraint() {
        
        menuScrollView.frame = CGRect.init(x: 0,
                                           y: 0,
                                           width: self.view.frame.size.width,
                                           height: menuHeight)
        
        controllerScrollView.frame = CGRect.init(x: 0,
                                                 y: menuHeight,
                                                 width: self.view.frame.size.width,
                                                 height: self.view.frame.size.height - menuHeight)
        
        let frameY = menuHeight - BottomViewHeight
        
        bottomView.frame = CGRect.init(x: 0,
                                       y: frameY,
                                       width: 0,
                                       height: BottomViewHeight)
        
    }
    
    func configureUserInterface() {
        
        guard let vc = controllerArray.first else { return }
        
        let screenWidth = self.view.frame.size.width
        
        let height = self.view.frame.size.height - menuHeight
        
        let contentSizeWidth = screenWidth * CGFloat(controllerArray.count)
        
        controllerScrollView.contentSize = CGSize(width: contentSizeWidth,
                                                  height: 0)
        
        vc.view.frame = CGRect.init(x: 0,
                                    y: 0,
                                    width: screenWidth,
                                    height: height)
        
        self.addChildViewController(vc)
        
        controllerScrollView.addSubview(vc.view)
        
    }
    
    func handleMenuItemTap(gestureRecognizer : UITapGestureRecognizer) {
        let tappedPoint : CGPoint = gestureRecognizer.location(in: menuScrollView)
        
        let index = Int(tappedPoint.x / menuWidth)
        
        loadPage(index: index)
        
        UIView.animate(withDuration: 0.2) {
            
            self.controllerScrollView.contentOffset.x = self.view.frame.size.width * CGFloat(index)
        }
        
        menuScrollViewPositioning(index: index)
        
    }
    
    func menuScrollViewPositioning(index: Int) {
        
        
        UIView.animate(withDuration: 0.2) {
            
            self.bottomView.frame.origin.x = CGFloat(index) * self.menuWidth
            
            if index != 0 && index != self.controllerArray.count - 1 {
                
                let ementX = CGFloat(index - 1) * self.menuWidth
                
                let menuX = self.menuScrollView.contentOffset.x
                
                if ementX < menuX {
                    
                    self.menuScrollView.contentOffset.x = CGFloat(index - 1) * self.menuWidth
                    
                }
                
                let ementTwoX = CGFloat(index + 2) * self.menuWidth
                
                let menuTwoX = self.menuScrollView.contentOffset.x + self.view.frame.size.width
                
                if ementTwoX > menuTwoX {
                    
                    self.menuScrollView.contentOffset.x = (CGFloat((index + 1)) * self.menuWidth) - ( self.view.frame.size.width -  self.menuWidth)
                    
                }
                
            }
            
        }
        
    }
    
    func loadPage(index: Int) {
        
        for vctag in vcArray {
            
            if vctag == index { return }
            
        }
        
        let count = controllerArray.count
        
        if index >= count || index < 0 { return }
        
        let vc = controllerArray[index]
        
        let screenWidth = self.view.frame.size.width
        
        let height = CGFloat(self.view.frame.size.height - menuHeight)
        
        let width = (CGFloat(index)) * screenWidth
        
        vc.view.frame = CGRect.init(x: width,
                                    y: 0.0,
                                    width: screenWidth,
                                    height: height)
        
        self.addChildViewController(vc)
        
        controllerScrollView.addSubview(vc.view)
        
        vcArray.append(index)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TSHJPageMenu: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let screenWidth = self.view.frame.size.width
        
        let offset = scrollView.contentOffset.x
        
        var index: CGFloat = offset / CGFloat(screenWidth)
        
        if offset == 0 { index = 0 }
        
        menuScrollViewPositioning(index: Int(index))
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let screenWidth = self.view.frame.size.width
        
        let offset = scrollView.contentOffset.x + screenWidth
        
        let index: Int = Int(offset / CGFloat(screenWidth))
        
        loadPage(index: index)
        
        loadPage(index: index - 1)
        
    }
    
}

class TSMenuItemView: UIView {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createUI()
        
    }
    
    convenience init(titleName: String) {
        self.init()
        
        self.titleLabel.text = titleName
        
    }
    
    func createUI() {
        
        self.addSubview(titleLabel)
        
        self.titleLabel.textAlignment = .center
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.titleLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
