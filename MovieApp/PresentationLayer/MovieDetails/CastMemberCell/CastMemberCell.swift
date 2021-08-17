import UIKit
import Kingfisher

class CastMemberCell: UICollectionViewCell {

    static let cellIdentifier = String(describing: CastMemberCell.self)

    let spacing: CGFloat = 10
    let cornerRadius: CGFloat = 10

    var profileImageView: UIImageView!
    var castMemberNameLabel: UILabel!
    var characterNameLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        buildViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(for castMember: CastMemberViewModel) {
        let profileUrl = URL(string: castMember.profileSource ?? "")
        profileImageView.kf.setImage(with: profileUrl, placeholder: UIImage.personPlaceholder)

        castMemberNameLabel.text = castMember.name

        characterNameLabel.text = castMember.characterName
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = cornerRadius

        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 20
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
    
}
