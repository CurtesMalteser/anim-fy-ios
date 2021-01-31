//
//  DetailsViewModel.swift
//  AnimFy
//
//  Created by António Bastião on 30.01.21.
//

class DetailsViewModel {

    private let _repository: DataRepositoryProtocol

    private var _datumID : String!

    private var _dataCell: DataCellModel? = nil
    var dataCell: DataCellModel? {
        get {
            _dataCell
        }
    }

    init(datumID: String, dataRepository repository: DataRepositoryProtocol) {
        _datumID = datumID
        _repository = repository
        getData(datumID: _datumID)
    }

    private func getData(datumID id: String) -> DataCellModel? {
        _dataCell = _repository.dataList.first { model in
            model.datumID == id
        }
        return _dataCell
    }

}
