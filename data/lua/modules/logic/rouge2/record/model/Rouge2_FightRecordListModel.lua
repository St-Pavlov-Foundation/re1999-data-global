-- chunkname: @modules/logic/rouge2/record/model/Rouge2_FightRecordListModel.lua

module("modules.logic.rouge2.record.model.Rouge2_FightRecordListModel", package.seeall)

local Rouge2_FightRecordListModel = class("Rouge2_FightRecordListModel", ListScrollModel)

function Rouge2_FightRecordListModel:initList()
	local tempList = {}
	local infoList = Rouge2_FightRecordController.instance:getRecordList()
	local maxRecordNum = Rouge2_FightRecordController.instance:getMaxRecordNum()

	for i = 1, maxRecordNum do
		table.insert(tempList, infoList[i])
	end

	self:setList(tempList)
end

function Rouge2_FightRecordListModel:getViewType()
	return self._viewType
end

function Rouge2_FightRecordListModel:setViewType(viewType)
	self._viewType = viewType or Rouge2_Enum.RecordViewType.Show
end

Rouge2_FightRecordListModel.instance = Rouge2_FightRecordListModel.New()

return Rouge2_FightRecordListModel
