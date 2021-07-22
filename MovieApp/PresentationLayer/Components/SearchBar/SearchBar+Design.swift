import UIKit

extension SearchBar: ConstructViewsProtocol {

    func buildViews() {
        createViews()
        styleViews()
    }

    func createViews() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        addSubview(stackView)

        searchField = BaseSearchField()
        searchField.addTarget(self, action: #selector(showCancelButton), for: .editingDidBegin)

        let searchIcon = UIImageView(image: UIImage(named: "Search"))
        searchIcon.contentMode = .center
        searchField.leftView = searchIcon

        let deleteButton = UIButton()
        deleteButton.setImage(UIImage(named: "X"), for: .normal)
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
        searchField.backgroundColor = UIColor(named: "Gray")
        searchField.layer.cornerRadius = 10
        searchField.leftViewMode = .always
        searchField.rightViewMode = .always

        let font = UIFont(name: "ProximaNova-Medium", size: SearchBar.fontSize)
        let color = UIColor(named: "DarkBlue")

        let placeholder = NSAttributedString(
            string: "Search",
            attributes: [
                NSAttributedString.Key.font: font as Any,
                NSAttributedString.Key.foregroundColor: color?.withAlphaComponent(0.5) as Any])
        searchField.attributedPlaceholder = placeholder

        searchField.font = UIFont(name: "ProximaNova-Medium", size: SearchBar.fontSize)
        searchField.textColor = UIColor(named: "DarkBlue")

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
            $0.height.equalTo(SearchBar.defaultHeight)
        }

        stackView.spacing = SearchBar.defaultSpacing
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
