//
//  CaptionableImageView.swift
//  PhotoChallenge
//
//  Created by Freddy Hernandez on 1/3/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit

let FilterNames = ["CIComicEffect", "CIColorInvert", "CIColorPosterize", "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant", "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess", "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone", "CICrystallize", "CIEdges", "CIEdgeWork", "CIHexagonalPixellate"]

class CaptionableImageView: UIImageView {

	var originalImage: UIImage!
	fileprivate var filterIndex:Int = -1
	
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(CaptionableImageView.updateFilterIndex(_:)))
        swipeLeftRecognizer.direction = .left
        swipeLeftRecognizer.numberOfTouchesRequired = 1
        swipeLeftRecognizer.delegate = self
        
        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(CaptionableImageView.updateFilterIndex(_:)))
        swipeRightRecognizer.direction = .right
        swipeRightRecognizer.numberOfTouchesRequired = 1
        swipeRightRecognizer.delegate = self
        
        addGestureRecognizer(swipeLeftRecognizer)
        addGestureRecognizer(swipeRightRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    	
	var currentImage: UIImage {
		get {
			UIGraphicsBeginImageContextWithOptions(frame.size, true, 0)
			drawHierarchy(in: bounds, afterScreenUpdates: true)
			let result = UIGraphicsGetImageFromCurrentImageContext()
			UIGraphicsEndImageContext()
			
			return result!
		}
	}
	
	func updateFilterIndex(_ sender:UISwipeGestureRecognizer) {
		
		
		switch sender.direction {
		case UISwipeGestureRecognizerDirection.right:
			if filterIndex == -1 {
				filterIndex = FilterNames.count - 1
			} else {
				filterIndex -= 1
			}
		case UISwipeGestureRecognizerDirection.left:
			if filterIndex == FilterNames.count - 1 {
				filterIndex = -1
			} else {
				filterIndex += 1
			}
		default:break
		}
		
		updateImageWithFilter()
	}
	
	func updateImageWithFilter() {
		
		if filterIndex == -1 {
			image = originalImage!
		} else {
			let filterName = FilterNames[filterIndex]
			let stillImageFilter = CIFilter(name: filterName, withInputParameters: [kCIInputImageKey:CIImage(image: originalImage!)!])
			
			image = UIImage(ciImage: stillImageFilter?.value(forKey: kCIOutputImageKey) as! CIImage, scale: 1.0, orientation: UIImageOrientation.up)
		}
	}
	
	func insertCaptionWithText(_ text:String) {
		
		let label = PhotoLabel()
		label.text = text
		label.frame = CGRect(x: 0, y: 0, width: (self.superview?.bounds.width)!, height: 60)
		label.center = center
		addSubview(label)
	}
	
	func removeCaptions() {
		for photoLabel in subviews {
			photoLabel.removeFromSuperview()
		}
	}
	
}

extension CaptionableImageView : UIGestureRecognizerDelegate {
	
	
	//Prevent the filter from changing if the user is trying to drag a label
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		

		if subviews.count > 0 {
			for photoLabel in subviews {
				if (photoLabel as! PhotoLabel).panRecognizer == otherGestureRecognizer {
					return true
				}
				
			}
		}

		return false
	}
}
