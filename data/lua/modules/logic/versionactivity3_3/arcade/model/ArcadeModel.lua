-- chunkname: @modules/logic/versionactivity3_3/arcade/model/ArcadeModel.lua

module("modules.logic.versionactivity3_3.arcade.model.ArcadeModel", package.seeall)

local ArcadeModel = class("ArcadeModel", BaseModel)

function ArcadeModel:onInit()
	return
end

function ArcadeModel:reInit()
	return
end

function ArcadeModel:getAct222Id()
	return VersionActivity3_3Enum.ActivityId.Arcade
end

function ArcadeModel:isAct222Open(isToast)
	local actId = self:getAct222Id()
	local status, toastId, toastParam
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if actInfoMo then
		status, toastId, toastParam = ActivityHelper.getActivityStatusAndToast(actId)
	else
		toastId = ToastEnum.ActivityEnd
	end

	if isToast and toastId then
		GameFacade.showToast(toastId, toastParam)
	end

	local result = status == ActivityEnum.ActivityStatus.Normal

	return result
end

ArcadeModel.instance = ArcadeModel.New()

return ArcadeModel
