import UIKit

extension SearchBarView: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        addSubview(stackView)

        searchField = BaseSearchTextField()
        searchField.addTarget(self, action: #selector(showCancelButton), for: .editingDidBegin)

        let searchIcon = UIImageView(image: .search)
        searchIcon.contentMode = .center
        searchField.leftView = searchIcon

        let deleteButton = UIButton()
        deleteButton.setImage(.xImage, for: .normal)
        deleteButton.contentMode = .center
        deleteButton.addTarget(self, action: #selector(clearSearchBar), for: .touchUpInside)
        searchField.rightView = deleteButton
        deleteButton.isHidden = true
        stackView.addArrangedSubview(searchField)

        cancelButton = UIButton()
        cancelButton.addTarget(self, action: #selector(hideCancelButton), for: .touchUpInside)
        stackView.addArrangedSubview(cancelButton)
    }

    func styleViews() {
        searchField.backgroundColor = .gray
        searchField.layer.cornerRadius = 10
        searchField.leftViewMode = .always
        searchField.rightViewMode = .always

        let font = ProximaNova.medium.of(size: SearchBarView.fontSize)
        let color = UIColor.darkBlue

        let placeholder = NSAttributedString(
            string: "Search",
            attributes: [
                NSAttributedString.Key.font: font as Any,
                NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.5) as Any])
        searchField.attributedPlaceholder = placeholder

        searchField.font = ProximaNova.medium.of(size: SearchBarView.fontSize)
        searchField.textColor = .darkBlue

        let attributedTitle = NSAttributedString(
            string: "Cancel",
            attributes: [
                NSAttributedString.Key.font: font as Any,
                NSAttributedString.Key.foregroundColor: color as Any])
        cancelButton.setAttributedTitle(attributedTitle, for: .normal)
        cancelButton.isHidden = true
        cancelButton.alpha = 0
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(SearchBarView.defaultHeight)
        }

        stackView.spacing = SearchBarView.defaultSpacing
    }

    @objc
    private func clearSearchBar() {
        searchField.text = ""
    }

    @objc
    private func showCancelButton() {
        cancelButton.isHidden = false
        searchField.rightView?.isHidden = false
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.cancelButton.alpha = 1
                self.layoutIfNeeded()
            })
    }

    @objc
    private func hideCancelButton() {
        clearSearchBar()
        cancelButton.isHidden = true
        searchField.rightView?.isHidden = true
        searchField.resignFirstResponder()
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.cancelButton.alpha = 0
                self.layoutIfNeeded()
            })
    }

}
