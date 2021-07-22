import UIKit

extension UnderlinedButton: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        button = UIButton()
        addSubview(button)

        underline = UIView()
        addSubview(underline)
    }

    func styleViews() {
        underline.backgroundColor = UIColor(named: "DarkBlue")
        underline.alpha = 0
    }

    func defineLayoutForViews() {
        button.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }

        underline.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(underlineThickness)
        }
    }

    func styleSelected() {
        let font = UIFont(name: "ProximaNova-Bold", size: 16)
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: font as Any])

        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.button.setAttributedTitle(attributedTitle, for: .normal)
                self.button.setTitleColor(.black, for: .normal)
                self.underline.alpha = 1})
    }

    func styleUnselected() {
        let font = UIFont(name: "ProximaNova-Medium", size: 16)
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: font as Any])

        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.button.setAttributedTitle(attributedTitle, for: .normal)
                self.button.setTitleColor(UIColor(named: "Gray3"), for: .normal)
                self.underline.alpha = 0})
    }

}
