import UIKit

class ReviewsViewController: UIPageViewController {

    var reviewViewControllers: [UIViewController] = []

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = nil
    }

    func setData(for reviews: [ReviewViewModel]) {
        for review in reviews {
            let reviewViewController = ReviewViewController()
            reviewViewController.setInitialData(for: review)
            reviewViewControllers.append(reviewViewController)
        }

        guard let initialReviewVC = reviewViewControllers.first else { return }

        setViewControllers(
            [initialReviewVC],
            direction: .forward,
            animated: false)
    }
}

// MARK: UIPageViewControllerDataSource
extension ReviewsViewController: UIPageViewControllerDataSource {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = reviewViewControllers.firstIndex(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return reviewViewControllers.last }

        guard reviewViewControllers.count > previousIndex else { return nil }

        return reviewViewControllers[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = reviewViewControllers.firstIndex(of: viewController) else { return nil }

        let nextIndex = viewControllerIndex + 1

        guard nextIndex < reviewViewControllers.count else { return reviewViewControllers.first }

        guard reviewViewControllers.count > nextIndex else { return nil }

        return reviewViewControllers[nextIndex]
    }
}
