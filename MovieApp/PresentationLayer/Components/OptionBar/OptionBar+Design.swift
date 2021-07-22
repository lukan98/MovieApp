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

        let placeholderData = ["Streaming", "On TV", "For Rent", "In theatres", "Showing near you"]

        for (id, title) in placeholderData.enumerated() {
            let underlinedButton = UnderlinedButton(title: title)
            optionButtonStack.addArrangedSubview(underlinedButton)
            underlinedButton.button.tag = id
            underlinedButton.addTarget(self, action: #selector(onCategorySelection), for: .touchUpInside)
        }
    }

    func styleViews() {
        scrollView.showsHorizontalScrollIndicator = false

        optionButtonStack.axis = .horizontal
        optionButtonStack.alignment = .center
        optionButtonStack.spacing = 22

        for subview in optionButtonStack.arrangedSubviews {
            guard let underlinedButton = subview as? UnderlinedButton else { return }

            if underlinedButton.button.tag == selectedCategory {
                underlinedButton.styleSelected()
            } else {
                underlinedButton.styleUnselected()
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

    @objc
    private func onCategorySelection(sender: UIButton) {
        guard
            let previouslySelected = optionButtonStack.arrangedSubviews[selectedCategory] as? UnderlinedButton,
            let newlySelected = optionButtonStack.arrangedSubviews[sender.tag] as? UnderlinedButton
        else {
            return
        }

        previouslySelected.styleUnselected()
        selectedCategory = sender.tag
        newlySelected.styleSelected()
    }

}
