import UIKit

extension OptionBarView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        scrollView = BaseScrollView()
        addSubview(scrollView)

        contentView = UIView()
        scrollView.addSubview(contentView)

        optionButtonStack = UIStackView()
        contentView.addSubview(optionButtonStack)
    }

    func setData(optionTitles: [String]) {
        for title in optionTitles {
            let underlinedButton = UnderlinedButtonView(title: title)
            optionButtonStack.addArrangedSubview(underlinedButton)
            underlinedButton.addTarget(self, action: #selector(onCategorySelection), for: .touchUpInside)
        }
        styleButtons()
    }

    func styleViews() {
        scrollView.showsHorizontalScrollIndicator = false

        optionButtonStack.axis = .horizontal
        optionButtonStack.alignment = .center
        optionButtonStack.spacing = 22

        styleButtons()
    }

    func styleButtons() {
        for (index, subview) in optionButtonStack.arrangedSubviews.enumerated() {
            guard let underlinedButton = subview as? UnderlinedButtonView else { return }

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
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    @objc
    private func onCategorySelection(sender: UIButton) {
        let view = optionButtonStack.arrangedSubviews.first(
            where: { view in
                guard let underlinedButton = view as? UnderlinedButtonView
                else {
                    return false
                }
                return underlinedButton.button == sender})

        guard
            let previouslySelected = optionButtonStack.arrangedSubviews[selectedCategoryIndex] as? UnderlinedButtonView,
            let newlySelected = view as? UnderlinedButtonView,
            let newlySelectedIndex = optionButtonStack.arrangedSubviews.firstIndex(of: newlySelected)
        else {
            return
        }

        previouslySelected.styleUnselected()
        selectedCategoryIndex = newlySelectedIndex
        categoryCollection.currentlySelectedIndex = selectedCategoryIndex
        newlySelected.styleSelected()
    }

}
