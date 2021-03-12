//
//  DetailsViewModelTest.swift
//  AnimFyTests
//
//  Created by António Bastião on 30.01.21.
//

import XCTest
@testable import AnimFy

/*class DetailsViewModelTest: XCTestCase {

    var SUT : DetailsViewModel!
    var repoMock: DataRepositoryProtocol!

    override func setUpWithError() throws {
        repoMock = DateRepositoryMock()
        SUT = DetailsViewModel(dataRepository: repoMock)
    }

    override func tearDownWithError() throws {
        repoMock = nil
        SUT = nil
    }

    func testDetailsViewModelGetsValidDataCellByID() throws {

        let dataCell = SUT.getData(datumID: "1stID")

        assert (dataCell != nil)
    }

    func testDetailsViewModelGetsNilDataCellByID() throws {

        let dataCell = SUT.getData(datumID: "InvalidID")

        assert (dataCell == nil)
    }

}*/

/*class DateRepositoryMock: DataRepositoryProtocol {

    var type: DataRepositoryType = .manga

    var dataList: Array<DataCellModel>

    var statusDelegate: StatusDelegateProtocol!

    init() {
        dataList = [
            DataCellModel(id: "1stID", title: "First Cell", imageURL: URL(string: "https://first.cell.anim.fy")),
            DataCellModel(id: "2ndID", title: "Second Cell", imageURL: URL(string: "https://second.cell.anim.fy")),
            DataCellModel(id: "3rdID", title: "Third Cell", imageURL: URL(string: "https://thirs.cell.anim.fy"))
        ]

    }

    func downloadCollection() {
        // intentionally left empty since isn't relevant for this test
    }

    func getDatumDetailsBy(id: String) {
        // todo
    }


}*/
