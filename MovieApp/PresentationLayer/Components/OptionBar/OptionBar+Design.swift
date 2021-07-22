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

        for title in placeholderData {
            let underlinedButton = UnderlinedButton(title: title)
            optionButtonStack.addArrangedSubview(underlinedButton)
            underlinedButton.addTarget(self, action: #selector(onCategorySelection), for: .touchUpInside)
        }
    }

    func styleViews() {
        scrollView.showsHorizontalScrollIndicator = false

        optionButtonStack.axis = .horizontal
        optionButtonStack.alignment = .center
        optionButtonStack.spacing = 22

        for (index, subview) in optionButtonStack.arrangedSubviews.enumerated() {
            guard let underlinedButton = subview as? UnderlinedButton else { return }

            if index == selectedCategoryIndex {
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
        let view = optionButtonStack.arrangedSubviews.first(
            where: { view in
                guard let underlinedButton = view as? UnderlinedButton
                else {
                    return false
                }
                return underlinedButton.button == sender})

        guard
            let previouslySelected = optionButtonStack.arrangedSubviews[selectedCategoryIndex] as? UnderlinedButton,
            let newlySelected = view as? UnderlinedButton,
            let newlySelectedIndex = optionButtonStack.arrangedSubviews.firstIndex(of: newlySelected)
        else {
            return
        }

        previouslySelected.styleUnselected()
        selectedCategoryIndex = newlySelectedIndex
        newlySelected.styleSelected()
    }

}
