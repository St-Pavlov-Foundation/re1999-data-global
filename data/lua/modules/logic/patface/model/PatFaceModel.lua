-- chunkname: @modules/logic/patface/model/PatFaceModel.lua

module("modules.logic.patface.model.PatFaceModel", package.seeall)

local PatFaceModel = class("PatFaceModel", BaseModel)
local SkipToggleStatus = {
	Disable = 0,
	Enable = 1
}

function PatFaceModel:onInit()
	self:clear()

	local skipStatus = false

	if isDebugBuild then
		skipStatus = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMToolViewSkipPatFace)
	end

	local isSkip = skipStatus == SkipToggleStatus.Enable

	self:setIsSkipPatFace(isSkip)
end

function PatFaceModel:reInit()
	self:clear()
end

function PatFaceModel:getIsPatting()
	return self._isPattingFace and true or false
end

function PatFaceModel:getIsSkipPatFace()
	return self._isSkipPatFace and true or false
end

function PatFaceModel:setIsPatting(isPatting)
	if isPatting == self._isPattingFace then
		return
	end

	self._isPattingFace = isPatting
end

function PatFaceModel:setIsSkipPatFace(isSkipPatFace, isToast)
	local isSkip = isSkipPatFace and true or false

	self._isSkipPatFace = isSkip

	local toastId = isSkip and ToastEnum.SkipPatFace or ToastEnum.CancelSkipPatFace

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMToolViewSkipPatFace, isSkip and SkipToggleStatus.Enable or SkipToggleStatus.Disable)

	if isToast then
		GameFacade.showToast(toastId)
	end
end

function PatFaceModel:clear()
	self:setIsPatting(false)
	PatFaceModel.super.clear(self)
end

PatFaceModel.instance = PatFaceModel.New()

return PatFaceModel
