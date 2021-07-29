struct MockedFavorites {

    static var favorites = [497698, 155, 238, 240, 496243, 278, 497] {
        didSet {
            print(favorites)
        }
    }

}
