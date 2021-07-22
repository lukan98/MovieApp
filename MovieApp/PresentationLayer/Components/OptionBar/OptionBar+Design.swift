import UIKit

extension OptionBar: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        scrollView = UIScrollView()
        addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        optionButtonStack = UIStackView()
        contentView.addSubview(optionButtonStack)

        for id in 0..<10 {
            let button = UIButton()
            button.tag = id
            button.addTarget(self, action: #selector(onCategorySelection), for: .touchUpInside)
            optionButtonStack.addArrangedSubview(button)
        }
    }

    func styleViews() {
        scrollView.showsHorizontalScrollIndicator = false

        optionButtonStack.axis = .horizontal
        optionButtonStack.alignment = .center
        optionButtonStack.spacing = 22

        for subview in optionButtonStack.arrangedSubviews {
            guard let button = subview as? UIButton else { return }

            if button.tag == selectedCategory {
                styleSelectedButton(sender: button)
            } else {
                styleUnselectedButton(sender: button)
            }
        }
    }

    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }

        optionButtonStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
    }

    private func styleUnselectedButton(sender: UIButton) {
        guard let button = optionButtonStack.arrangedSubviews[sender.tag] as? UIButton else { return }

        let font = UIFont(name: "ProximaNova-Medium", size: 16)
        let attributedTitle = NSAttributedString(
            string: "Placeholder",
            attributes: [NSAttributedString.Key.font: font as Any])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(UIColor(named: "Gray3"), for: .normal)
    }

    private func styleSelectedButton(sender: UIButton) {
        guard let button = optionButtonStack.arrangedSubviews[sender.tag] as? UIButton else { return }

        let font = UIFont(name: "ProximaNova-Bold", size: 16)
        let underlineColor = UIColor(named: "DarkBlue")
        let attributedTitle = NSAttributedString(
            string: "Placeholder",
            attributes: [NSAttributedString.Key.font: font as Any,
                         NSAttributedString.Key.underlineColor : underlineColor as Any,
                         NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
    }

    @objc
    private func onCategorySelection(sender: UIButton) {
        guard
            let previouslySelected = optionButtonStack.arrangedSubviews[selectedCategory] as? UIButton
        else {
            return
        }

        styleUnselectedButton(sender: previouslySelected)
        selectedCategory = sender.tag
        styleSelectedButton(sender: sender)
    }

}
