//
//  ViewController.swift
//  Scrollview3PageTutorial
//
//  Created by Phadatare, Shankar (Syntel) on 3/6/17.
//  Copyright © 2017 Phadatare, Shankar (Syntel). All rights reserved.
//

import UIKit

enum PageOrder {
    case Current, Previous, Next
}

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var cardViewCurrent = CardView()
    var cardViewNext = CardView()
    var cardViewPrevious = CardView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupScreen()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - ScrollViewDelegate Methods
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        self.makeCardCenter()
    }
    
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        self.addPagesByOrder(pageOrder:.Previous)
        self.addPagesByOrder(pageOrder:.Current)
        self.addPagesByOrder(pageOrder:.Next)
        
    }
    
    // MARK: - Class Methods
    
    func setupScreen()  {
        
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize.init(width: self.view.frame.size.width*3, height: self.scrollView.frame.size.height);
        
        self.addPagesByOrder(pageOrder:.Previous)
        self.addPagesByOrder(pageOrder:.Current)
        self.addPagesByOrder(pageOrder:.Next)
        
        self.scrollView.scrollRectToVisible(CGRect.init(x: self.view.frame.size.width, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height), animated: false)
        
        self.scrollView.layoutIfNeeded()
        
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.4, animations: {
            self.scrollView.setContentOffset(CGPoint.init(x: self.scrollView.frame.width*2, y: 0), animated: false)
            
        }) { (Bool) in
            self.scrollRectToCenter()
            self.makeCardCenter()
        }
        
    }
    
    @IBAction func previousButtonAction(_ sender: Any) {
        
        UIView.animate(withDuration: 0.4, animations: {
            self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
        }) { (Bool) in
            self.scrollRectToCenter()
            self.makeCardCenter()
        }
        
    }
    
    func scrollRectToCenter() {
        
        self.scrollView.scrollRectToVisible(CGRect.init(x: self.view.frame.size.width, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height), animated: false)
    }
    
    func makeCardCenter() {
        
        scrollView.contentOffset = CGPoint(x: scrollView.frame.size.width, y: 0)
        
    }
    
    func addPagesByOrder(pageOrder: PageOrder) {
        
        switch pageOrder {
        case .Current:
            cardViewCurrent.view.frame = CGRect.init(x: self.scrollView.frame.size.width*1, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            self.addCard(card: cardViewCurrent)
            
        case .Next:
            cardViewNext.view.frame = CGRect.init(x: self.scrollView.frame.size.width*2, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            self.addCard(card: cardViewNext)
            
        case .Previous:
            cardViewPrevious.view.frame = CGRect.init(x: self.scrollView.frame.size.width*0, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height)
            self.addCard(card: cardViewPrevious)
            
        }
        
        self.scrollView.layoutIfNeeded()
    }
    
    func addCard(card: CardView) {
        
        self.scrollView.addSubview(card.view);
        
    }


}

