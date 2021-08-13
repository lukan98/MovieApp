import UIKit

class ReviewViewController: UIViewController {

    let spacing = 5

    var review: ReviewViewModel!
    var reviewView: ReviewView!

    override func viewDidLoad() {
        super.viewDidLoad()

        buildViews()
        setData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        reviewView.layoutIfNeeded()
        reviewView.truncateReviewText()
    }

    func setInitialData(for review: ReviewViewModel) {
        self.review = review
    }

    private func setData() {
        reviewView.setData(for: review)
    }

}
