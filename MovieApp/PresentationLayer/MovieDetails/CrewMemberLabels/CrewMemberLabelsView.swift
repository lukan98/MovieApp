import UIKit

class CrewMemberLabelsView: UIView {

    let fontSize: CGFloat = 14

    var nameLabel: UILabel!
    var jobLabel: UILabel!

    override var intrinsicContentSize: CGSize {
        let width = nameLabel.intrinsicContentSize.width + jobLabel.intrinsicContentSize.width
        let height = nameLabel.intrinsicContentSize.height + jobLabel.intrinsicContentSize.height
        return CGSize(width: width, height: height)
    }

    init() {
        super.init(frame: .zero)

        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(name: String, job: String) {
        nameLabel.text = name
        jobLabel.text = job
    }

}
