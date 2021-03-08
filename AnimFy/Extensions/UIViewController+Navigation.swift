//
//  Created by António Bastião on 03.12.20.
//  Copyright © 2020 António Bastião. All rights reserved.
//

import UIKit

extension UIViewController {

    // Present view controller
    func presentViewControllerWithInject<T: UIViewController>(storyboard: UIStoryboard?,
                                                              identifier: String,
                                                              navigationController: UINavigationController?,
                                                              injectArgs: (_ targetVC: T) -> Void) {

        let viewController = storyboard?.instantiateViewController(withIdentifier: identifier) as! T

        injectArgs(viewController)

        let navViewController: UINavigationController = UINavigationController(rootViewController: viewController)
        navViewController.modalPresentationStyle = .fullScreen

        navigationController?.present(navViewController, animated: true)
    }

}
