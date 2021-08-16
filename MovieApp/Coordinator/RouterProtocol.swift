import UIKit

protocol RouterProtocol: AnyObject {
    
    var navigationController: UINavigationController { get set }

    func start(in window: UIWindow)

}
