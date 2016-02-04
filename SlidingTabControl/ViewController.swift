//
//  ViewController.swift
//  SlidingTabControl
//
//  Created by TechNexus on 2/2/16.
//  Copyright © 2016 TechNexus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topMenuContainerView : UIView!
    
    @IBOutlet weak var topMenuCollectionView : UICollectionView!
    
    @IBOutlet weak var topMenuScrollView : UIScrollView!
    @IBOutlet weak var highlightView : UIView!
    
    @IBOutlet weak var highlightViewLeftConstraint : NSLayoutConstraint!
    
    @IBOutlet weak var firstTabView : UIView!
    @IBOutlet weak var secondTabView : UIView!
    @IBOutlet weak var thirdTabView : UIView!
    @IBOutlet weak var fourthTabView : UIView!

    
    
    var tabArray : Array<String> = ["RED","BLUE","GREEN","YELLOW"]
    var collectionViewCellWidth = 202
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        settingUpView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func settingUpView(){
        
        self.topMenuScrollView.contentSize = CGSizeMake(CGFloat(tabArray.count * collectionViewCellWidth), self.topMenuScrollView.contentSize.height)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        return true
        
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate ,UIScrollViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tabArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("TopBarCollectionViewCell", forIndexPath: indexPath) as! TopBarCollectionViewCell
        collectionCell.titleLbl.text = tabArray[indexPath.row]
        return collectionCell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)

        self.animateHighlightView(indexPath)
    }
    
    func animateHighlightView(indexPath: NSIndexPath){
        
        let amountToMove = CGFloat(collectionViewCellWidth * indexPath.row)
        highlightViewLeftConstraint.constant = amountToMove
        
        UIView.animateWithDuration(0.25) { () -> Void in
            
            self.view.layoutIfNeeded()
            
            switch(indexPath.row){
            case 0 :
                self.firstTabView.hidden = false
                self.secondTabView.hidden = true
                self.thirdTabView.hidden = true
                self.fourthTabView.hidden = true
            case 1 :
                self.firstTabView.hidden = true
                self.secondTabView.hidden = false
                self.thirdTabView.hidden = true
                self.fourthTabView.hidden = true
                
            case 2 :
                self.firstTabView.hidden = true
                self.secondTabView.hidden = true
                self.thirdTabView.hidden = false
                self.fourthTabView.hidden = true
                
            case 3 :
                self.firstTabView.hidden = true
                self.secondTabView.hidden = true
                self.thirdTabView.hidden = true
                self.fourthTabView.hidden = false
                
            default :
                print("default executed")
            }

        }

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        self.topMenuScrollView.setContentOffset(self.topMenuCollectionView.contentOffset, animated: false)
    }
    
}

