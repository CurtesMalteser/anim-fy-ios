//
//  Created by António Bastião on 01.12.20.
//  Copyright © 2020 António Bastião. All rights reserved.
//

import UIKit

extension UIWindow {

    func injectRootViewControllerAsMapVC(dataController: DataController) {
        let navigationController = rootViewController as! UINavigationController
        let mapViewController = navigationController.topViewController as! MapViewController
        mapViewController.dataController = dataController
    }

}
