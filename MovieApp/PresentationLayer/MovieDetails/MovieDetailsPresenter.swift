import Foundation

class MovieDetailsPresenter {

    var castMembers: [CastMemberViewModel]

    private let useCase: MovieUseCaseProtocol

    init(useCase: MovieUseCaseProtocol) {
        self.useCase = useCase
        self.castMembers = []
    }

    func getMovieDetails(
        _ completionHandler: @escaping (Result<DetailedMovieViewModel, RequestError>) -> Void,
        for movieId: Int = 103
    ) {
        useCase.getMovieDetails(for: movieId) { result in
            DispatchQueue.main.async {
                completionHandler(result.map { DetailedMovieViewModel(from: $0) } )
            }
        }
    }

    func getMovieCredits(
        maximumCrewMembers max: Int,
        _ completionHandler: @escaping (Result<CreditsViewModel, RequestError>) -> Void,
        for movieId: Int = 103
    ) {
        useCase.getMovieCredits(for: movieId) { [weak self] result in
            switch result {
            case .success(let creditsModel):
                let creditsViewModel = CreditsViewModel(from: creditsModel)
                self?.castMembers = creditsViewModel.cast
                DispatchQueue.main.async {
                    completionHandler(.success(creditsViewModel))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            }
        }
    }

}
