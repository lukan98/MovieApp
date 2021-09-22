import Resolver

extension Resolver: ResolverRegistering {

    public static func registerAllServices() {
        registerClients()
        registerDataSources()
        registerRepositories()
        registerUseCases()
        registerPresenters()
    }

}
