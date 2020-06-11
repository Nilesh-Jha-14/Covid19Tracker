//
//  MBProgressIndicator.swift
//  Go-jek-ContactApp
//
//  Created by JHA Nilesh Kumar on 21/03/20.
//  Copyright © 2020 JHA Nilesh Kumar. All rights reserved.
//

import Foundation
import MBProgressHUD

class MBProgressIndicator: NSObject {
    class func showIndicator(_ view : UIView){
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
    }
    
    class func hideIndicator(_ view : UIView){
        MBProgressHUD.hide(for: view, animated: true)
        
    }
}
