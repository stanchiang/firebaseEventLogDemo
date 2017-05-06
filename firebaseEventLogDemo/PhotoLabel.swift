//
//  PhotoLabel.swift
//  PhotoChallenge
//
//  Created by Freddy Hernandez on 12/29/15.
//  Copyright © 2015 Freddy Hernandez. All rights reserved.
//

import UIKit

class PhotoLabel: UILabel {
	
	var panRecognizer: UIPanGestureRecognizer?
	var longPressRecognizer: UILongPressGestureRecognizer?
	var pinchRecognizer: UIPinchGestureRecognizer?
	var rotationRecognizer: UIRotationGestureRecognizer?
	
	var sizeStage:Int = 0
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		isUserInteractionEnabled = true
		numberOfLines = 0
        
		panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(PhotoLabel.move))
		panRecognizer?.delegate = self
		
		longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(PhotoLabel.deletePhotoLabel))
		longPressRecognizer?.minimumPressDuration = 1.5
		longPressRecognizer?.delegate = self
		
		pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(PhotoLabel.stretch))
		pinchRecognizer?.delegate = self
		
		rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(PhotoLabel.handleRotate))
        rotationRecognizer?.delegate = self
		
		self.addGestureRecognizer(panRecognizer!)
		self.addGestureRecognizer(longPressRecognizer!)
		self.addGestureRecognizer(pinchRecognizer!)
		self.addGestureRecognizer(rotationRecognizer!)
		
		/***
		Center the text and change the font name, size, and color
		***/
		textAlignment = .center
		font = UIFont(name: "Futura", size: 20.0)
		textColor = UIColor.red
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	

	/***
	Panning on the label will drag
	***/
	func move() {
		let translation = panRecognizer?.translation(in: self.superview!)
		self.center.x += (translation?.x)!
		self.center.y += (translation?.y)!
		panRecognizer?.setTranslation(CGPoint.zero, in: self)
	}
	
	func deletePhotoLabel() {
		
		self.removeFromSuperview()
	}
	
	func stretch() {
		
		if let recognizer = pinchRecognizer {
			switch recognizer.state {
			case UIGestureRecognizerState.began:
				break
			case UIGestureRecognizerState.changed:
				recognizer.view?.transform = (recognizer.view?.transform)!.scaledBy(x: recognizer.scale, y: recognizer.scale)
				recognizer.scale = 1.0
			case UIGestureRecognizerState.ended:
				break
			default: break
			}
		}
	}
	
	func handleRotate() {
		if let recognizer = rotationRecognizer {
			recognizer.view?.transform = (recognizer.view?.transform)!.rotated(by: recognizer.rotation)
			recognizer.rotation = 0.0
		}
	}
}

extension PhotoLabel : UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}


























