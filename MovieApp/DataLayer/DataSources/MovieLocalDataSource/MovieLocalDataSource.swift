import RealmSwift

class MovieLocalDataSource: MovieLocalDataSourceProtocol {

    func save(_ movies: [MovieDataSourceModel], with category: CategoryDataSourceModel) {
        guard let realm = try? Realm()
        else {
            print("Couldn't create realm")
            return
        }

        do {
            try realm.write {
                movies.forEach { movie in
                    if let localMovieModel = realm.object(
                        ofType: MovieLocalDataSourceModel.self,
                        forPrimaryKey: movie.id) {
                        localMovieModel.categories.insert(category)
                        realm.add(localMovieModel, update: .modified)
                    } else {
                        realm.add(
                            MovieLocalDataSourceModel(from: movie, category: category),
                            update: .modified)
                    }
                }
            }

            let localMovies = realm.objects(MovieLocalDataSourceModel.self)
            localMovies.forEach { movie in
                print("\(movie.name), \(movie.categories.count)")
            }
        } catch {
            print("An error ocurred while writing to the realm")
        }
    }

}
