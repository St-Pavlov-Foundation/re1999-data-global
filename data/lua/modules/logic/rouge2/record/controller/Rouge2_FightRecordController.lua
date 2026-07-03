-- chunkname: @modules/logic/rouge2/record/controller/Rouge2_FightRecordController.lua

module("modules.logic.rouge2.record.controller.Rouge2_FightRecordController", package.seeall)

local Rouge2_FightRecordController = class("Rouge2_FightRecordController", BaseController)

function Rouge2_FightRecordController:replaceNewRecord(index)
	local newRecord = self:_getNewRecord()

	self:replaceRecord(index, newRecord)
end

function Rouge2_FightRecordController:replaceRecord(index, recordInfo)
	if not self:checkIndexValid(index) then
		return
	end

	self:removeRecord(index)
	self:_tempAdd(recordInfo, index)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnUpdateRecordInfo)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSaveRecordDone)
end

function Rouge2_FightRecordController:_tempAdd(recordInfo, index)
	self:_initRecordInfoList()

	self._recordInfoList[index] = recordInfo
end

function Rouge2_FightRecordController:_tempRemove(index)
	self:_initRecordInfoList()
	table.remove(self._recordInfoList, index)
end

function Rouge2_FightRecordController:_initRecordInfoList()
	if not self._recordInfoList then
		self._recordInfoList = {}

		local infoList = Rouge2_OutsideModel.instance:getReviewInfoList()

		tabletool.addValues(self._recordInfoList, infoList)
	end
end

function Rouge2_FightRecordController:getRecordList()
	self:_initRecordInfoList()

	return self._recordInfoList
end

function Rouge2_FightRecordController:removeRecord(index)
	if not self:checkIndexValid(index) then
		return
	end

	self:_tempRemove(index)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnUpdateRecordInfo)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSaveRecordDone)
end

function Rouge2_FightRecordController:getMaxRecordNum()
	return 20
end

function Rouge2_FightRecordController:getMinRecordDifficulty()
	return 0
end

function Rouge2_FightRecordController:_getNewRecord()
	local resultInfo = Rouge2_Model.instance:getRougeResult()

	return resultInfo and resultInfo.reviewInfo
end

function Rouge2_FightRecordController:checkIndexValid(index)
	return index and index > 0 and index <= self:getMaxRecordNum()
end

Rouge2_FightRecordController.instance = Rouge2_FightRecordController.New()

return Rouge2_FightRecordController
