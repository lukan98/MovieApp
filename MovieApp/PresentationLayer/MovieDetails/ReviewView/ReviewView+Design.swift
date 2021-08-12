import UIKit
import SnapKit

extension ReviewView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        headerView = UIView()
        addSubview(headerView)

        titleLabel = UILabel()
        headerView.addSubview(titleLabel)

        subtitleLabel = UILabel()
        headerView.addSubview(subtitleLabel)

        dateLabel = UILabel()
        headerView.addSubview(dateLabel)

        avatarImageView = UIImageView()
        headerView.addSubview(avatarImageView)

        reviewLabel = UILabel()
        addSubview(reviewLabel)

        let onTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleExpandCollapse))
        reviewLabel.addGestureRecognizer(onTapGesture)
    }

    func styleViews() {
        titleLabel.font = UIFont(name: "ProximaNova-Bold", size: 18)
        titleLabel.textColor = .black

        dateLabel.font = UIFont(name: "ProximaNova-Medium", size: 14)
        dateLabel.textColor = UIColor(named: "Gray2")

        avatarImageView.layer.masksToBounds = true
        avatarImageView.contentMode = .scaleAspectFit

        reviewLabel.font = UIFont(name: "ProximaNova-Medium", size: 14)
        reviewLabel.textColor = UIColor(named: "Gray2")
        reviewLabel.numberOfLines = numberOfLines
        reviewLabel.contentMode = .top
        reviewLabel.isUserInteractionEnabled = true
    }

    func styleSubtitleLabel(for author: String) {
        let font = UIFont(name: "ProximaNova-Medium", size: 14)
        let defaultAttrs = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor(named: "Gray2")]
        let authorAttrs = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.black]

        let subtitleString = "Written by \(author) on"
        let authorRange = NSString(string: subtitleString).range(of: author)
        let attributedString = NSMutableAttributedString(
            string: subtitleString,
            attributes: defaultAttrs as [NSAttributedString.Key : Any])
        attributedString.addAttributes(authorAttrs as [NSAttributedString.Key : Any], range: authorRange)

        subtitleLabel.attributedText = attributedString
    }

    func styleAvatar() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height * 0.5
    }

    func defineLayoutForViews() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        avatarImageView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(spacing)
            $0.size.equalTo(CGSize(width: 60, height: 60))
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(3 * spacing)
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.bottom.equalTo(dateLabel.snp.top).offset(-spacing)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(3 * spacing)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    @objc
    private func toggleExpandCollapse(tapGesture: UITapGestureRecognizer) {
        if let label = tapGesture.view as? UILabel {
            UIView.transition(with: label, duration: 0.2, options: .transitionCrossDissolve) {
                if label.numberOfLines == self.numberOfLines {
                    label.numberOfLines = 0
                } else if label.numberOfLines == 0 {
                    label.numberOfLines = self.numberOfLines
                }
            }
        }
    }

}
