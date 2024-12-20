//
//  UIView.swift
//  CoreStructure_iOS
//
//  Created by Rath! on 26/8/24.
//

import UIKit

//MARK: for animate show heide
extension UIView{
    
    func animateShow(duration: TimeInterval = 0.5) {
        self.isHidden = false // Make the view visible
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1 // Fade in
        })
    }
    
    func animateHide(duration: TimeInterval = 0.5) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0 // Fade out
        }) { completed in
            self.isHidden = true // Hide the view after the animation
        }
    }
}

extension UIView{
    
    func isHasSafeAreaInsets() -> Bool {
        // Check if any of the insets are greater than zero
        if self.safeAreaInsets.top > 0 {
            return true
        }else{
            return false
        }
    }
    
    //MARK: calculate text label width
    func calculateLabelWidth(text: String, font: UIFont) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = font
        label.sizeToFit()
        return label.frame.width
    }
    
}

//MARK: Handle addGestureRecognizer have param UIView
extension UIView{
    
    func addGestureRecognizer(target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true // Ensure user interaction is enabled
    }
}

//MARK: Handle cornerRadius
extension UIView{
    enum RoundCornersAt{
        case topRight
        case topLeft
        case bottomRight
        case bottomLeft
    }
    
    //multiple corners using CACornerMask
    func roundCorners(corners:[RoundCornersAt], radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [
            corners.contains(.topRight) ? .layerMaxXMinYCorner:.init(),
            corners.contains(.topLeft) ? .layerMinXMinYCorner:.init(),
            corners.contains(.bottomRight) ? .layerMaxXMaxYCorner:.init(),
            corners.contains(.bottomLeft) ? .layerMinXMaxYCorner:.init(),
        ]
    }
}

//MARK: Handle UITapGestureRecognizer and UIPanGestureRecognizer
extension UIView {
    
    static var didTapGesture:(()->())?
    static var dropHeight: CGFloat = 200 // Dismiss view contoller
    
    // Adds a tap gesture recognizer to dismiss the view
    func addTapGesture(target: Any,action: Selector ) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
    }
    
    // Adds a pan gesture recognizer to a specified control view
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        
        switch gesture.state {
        case .changed:
            // Move the view with the gesture
            if translation.y > 0 {
                self.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
            
        case .ended:
            print("translation.y ===> \(translation.y)")
            
            // Dismiss the view if the swipe is downward
//            if translation.y > UIView.dropHeight {
//                cancelDismiss()
//            } else {
//                // Reset position
                UIView.animate(withDuration: 0.1) {
                    self.transform = .identity
                }
//            }
        default:
            
            break
        }
    }
    
    @objc private func cancelDismiss() {
        // Dismissal logic
        
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }


    }
}



//MARK: Keyborad on button
extension UIView{
    //    deinit {
    //        NotificationCenter.default.removeObserver(self)
    //    }
    
    static var actionKeyboardWillShow: ((_ keyboardHeight: CGFloat)->())?
    static var actionKeyboardWillHide: (()->())?
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let  keyboardHeight = keyboardFrame.cgRectValue.height + 20
            
            print("keyboardHeight ==> ",keyboardHeight)
            
            UIView.actionKeyboardWillShow?(keyboardHeight)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.actionKeyboardWillHide?()
    }
}


//MARK: Create
extension UIView {

    func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        // Create a flexible space to push the buttons to the right
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        // Create a "Done" button
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain, target: self,
                                         action: #selector(doneButtonTapped))
        
        // Create a "Done" button
//        let cancelButton = UIBarButtonItem(title: "Cancel",
//                                         style: .plain, target: self,
//                                         action: #selector(cancelButtonTapped))

        // Add buttons to the toolbar
        toolbar.items = [flexibleSpace, doneButton]
        return toolbar
    }

    @objc func doneButtonTapped() {
        // Dismiss keyboard
        self.endEditing(true)
    }
    
    
//    @objc func cancelButtonTapped() {
//        // Dismiss keyboard
//
//        self.endEditing(true)
//    }
//    
}


