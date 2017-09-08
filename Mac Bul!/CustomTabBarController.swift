//
//  CustomTabBarController.swift
//  Mac Bul!
//
//  Created by Melisa Kısacık on 7.09.2017.
//  Copyright © 2017 MurathanBagdat. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        func animateTheTabBar(){
            if let view = item.value(forKey: "view") as? UIView{
                UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
                    view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }, completion: { (succes) in
                    if succes{
                        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut], animations: {
                            view.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                        }, completion: { (succes) in
                            if succes{
                                view.transform = .identity
                            }
                        })
                        
                    }
                })
            }
        }
        
        
        
        if item.tag == 0{
            animateTheTabBar()
        }else if item.tag == 1{
            animateTheTabBar()
        }
      
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller", viewController)
        print("index", tabBarController.selectedIndex )
        
    }

    

}
