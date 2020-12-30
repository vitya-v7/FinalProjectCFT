//
//  LaunchScreenAnimationViewController.swift
//  ViperCoreDataDZ
//
//  Created by Admin on 21.12.2020.
//  Copyright © 2020 Viktor Deryabin. All rights reserved.
//

import UIKit

class LaunchScreenAnimationViewController: UIViewController {

    @IBOutlet var logo: UIImageView!

    override func viewDidLayoutSubviews() {
        UIView.animate(withDuration: 3) {
            let newWidth = self.view.frame.size.width * 2
            let newHeight = self.view.frame.size.height * 2
            let newXPosition = newWidth - self.view.frame.size.width
            let newYPosition = self.view.frame.size.height - newHeight

            self.logo.frame = CGRect(x: -(newXPosition / 2),
                                     y: newYPosition / 2,
                                     width: newWidth,
                                     height: newHeight)

            UIView.animate(withDuration: 3.5) {
                self.logo.alpha = 0
            } completion: { animationDone in
                if (animationDone) {
                    let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        }
    }
}
