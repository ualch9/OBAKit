//
//  Router.swift
//  OBAKit
//
//  Created by Aaron Brethorst on 5/26/19.
//

import UIKit

/// Provides an standard interface for navigating between view controllers that works
/// regardless of how inter-controller navigation is designed to work in the app.
///
/// For example, this router can be used identically when the app is configured to
/// use floating panels or standard `UINavigationController` stacks.
///
public class ViewRouter: NSObject {
    private let application: Application

    public init(application: Application) {
        self.application = application
        super.init()
    }

    /// Modally presents the specified view controller.
    /// - Parameter presentedController: The modally-presented controller.
    /// - Parameter fromController: The controller that presents `presentedController`.
    /// - Parameter isModalInPresentation: When running on iOS 13 and above, this is the value that will be set for
    ///                                    `presentedController.isModalInPresentation`, which controls whether
    ///                                    a modal view controller can be interactively dismissed by the user. Defaults
    ///                                    to `false`, mirroring iOS's behavior.
    public func present(
        _ presentedController: UIViewController,
        from fromController: UIViewController,
        isModalInPresentation: Bool = false
    ) {
        if #available(iOS 13.0, *) {
            presentedController.isModalInPresentation = isModalInPresentation
        }

        fromController.present(presentedController, animated: true, completion: nil)
    }

    /// Navigates from `fromController` to `viewController`.
    ///
    /// - Parameters:
    ///   - viewController: The 'to' view controller.
    ///   - fromController: The 'from' view controller.
    public func navigate(to viewController: UIViewController, from fromController: UIViewController) {
        assert(fromController.navigationController != nil)
        fromController.navigationController?.pushViewController(viewController, animated: true)
    }

    public func navigateTo(stopID: String, from fromController: UIViewController) {
        let stopController = StopViewController(application: application, stopID: stopID)
        navigate(to: stopController, from: fromController)
    }

    public func navigateTo(stop: Stop, from fromController: UIViewController) {
        let stopController = StopViewController(application: application, stop: stop)
        navigate(to: stopController, from: fromController)
    }
}