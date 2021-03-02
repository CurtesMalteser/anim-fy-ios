//
//  DetailsViewModel.swift
//  AnimFy
//
//  Created by António Bastião on 30.01.21.
//

class DetailsViewModel {

    private let _repository: DataRepositoryProtocol

    private let _datumID : String

    private var _dataCell: Array<DetailsSectionProtocol> = []
    var dataCell: Array<DetailsSectionProtocol> {
        get {
            _dataCell
        }
    }

    init(datumID: String, dataRepository repository: DataRepositoryProtocol) {
        _datumID = datumID
        _repository = repository
        getData()
    }

    private func getData() {
        if let datumDetails = _repository.getDatumDetailsBy(id: _datumID) {
            _dataCell = datumDetails
        }
    }

    func saveUserOption(cell rowCell: UserOptionRowModel) {
        print("saveUserOption \(rowCell)")

    }
}
