-- chunkname: @modules/logic/minors/model/DateOfBirthSelectionViewListModel.lua

module("modules.logic.minors.model.DateOfBirthSelectionViewListModel", package.seeall)

local DateOfBirthSelectionViewListModel = class("DateOfBirthSelectionViewListModel", ListScrollModel)

DateOfBirthSelectionViewListModel.instance = DateOfBirthSelectionViewListModel.New()

return DateOfBirthSelectionViewListModel
