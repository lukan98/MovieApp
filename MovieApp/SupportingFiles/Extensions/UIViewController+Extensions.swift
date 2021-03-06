import UIKit

extension UIViewController {

    func styleForTabBar(title: String, image: UIImage?, selectedImage: UIImage?, font: UIFont?) {
        let verticalInset: CGFloat = 5
        tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage)
        tabBarItem.setTitleTextAttributes(
            [NSAttributedString.Key.font: font as Any],
            for: .normal)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -verticalInset)
        tabBarItem.imageInsets = UIEdgeInsets(top: -verticalInset, left: 0, bottom: verticalInset, right: 0)
    }

}
