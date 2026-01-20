-- chunkname: @modules/logic/survival/model/SurvivalModel.lua

module("modules.logic.survival.model.SurvivalModel", package.seeall)

local SurvivalModel = class("SurvivalModel", BaseModel)

function SurvivalModel:onInit()
	self._outsideInfo = SurvivalOutSideInfoMo.New()
	self._report = nil
	self._survivalSettleInfo = nil
	self._lastIndex = nil
	self._isUseSimpleDesc = PlayerPrefsHelper.getNumber(PlayerPrefsKey.SurvivalDescSimply, 1)
	self.summaryActPosOffset = 0
end

function SurvivalModel:reInit()
	self:onInit()
	SurvivalMapHelper.instance:clear()
end

function SurvivalModel:onGetInfo(info)
	self._outsideInfo:init(info)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnOutInfoChange)
end

function SurvivalModel:getOutSideInfo()
	return self._outsideInfo
end

function SurvivalModel:getRewardState(rewardId, rewardScore)
	return self._outsideInfo:getRewardState(rewardId, rewardScore)
end

function SurvivalModel:setDailyReport(report)
	self._report = report
end

function SurvivalModel:getDailyReport()
	return self._report
end

function SurvivalModel:setSurvivalSettleInfo(info)
	self._survivalSettleInfo = info
end

function SurvivalModel:getSurvivalSettleInfo()
	return self._survivalSettleInfo
end

function SurvivalModel:changeDescSimple()
	self._isUseSimpleDesc = 1 - self._isUseSimpleDesc

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SurvivalDescSimply, self._isUseSimpleDesc)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnEquipDescSimpleChange)
end

function SurvivalModel:setBossFightLastIndex(index)
	self._lastIndex = index
end

function SurvivalModel:getBossFightLastIndex()
	local index = self._lastIndex

	self._lastIndex = nil

	return index
end

SurvivalModel.instance = SurvivalModel.New()

return SurvivalModel
