//
//  DetailsViewModel.swift
//  AnimFy
//
//  Created by António Bastião on 30.01.21.
//

class DetailsViewModel {

    private let _repository: DataRepositoryProtocol

    init(dataRepository repository: DataRepositoryProtocol) {
        _repository = repository
    }

    func getData(datumID id: String) -> DataCellModel? {
        _repository.dataList.first { model in
            model.datumID == id
        }
    }
}
