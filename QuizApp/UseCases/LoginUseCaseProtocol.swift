protocol LoginUseCaseProtocol {
    func checkLogin(name : String, password : String, router : AppRouterProtocol, completion: @escaping (Session)-> Void) 
}
