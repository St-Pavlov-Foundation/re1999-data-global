-- chunkname: @modules/logic/minors/controller/MinorsController.lua

module("modules.logic.minors.controller.MinorsController", package.seeall)

local MinorsController = class("MinorsController", BaseController)

function MinorsController:onInit()
	return
end

function MinorsController:reInit()
	return
end

function MinorsController:onInitFinish()
	return
end

function MinorsController:addConstEvents()
	if SettingsModel.instance:isJpRegion() then
		PlayerController.instance:registerCallback(PlayerEvent.PlayerbassinfoChange, self._onPlayerbassinfoChange, self)
	end
end

function MinorsController:confirmDateOfBirthVerify(year, month, day)
	local birthday = string.format("%s-%s-%s", year, month, day)

	PlayerRpc.instance:sendSetBirthdayRequest(birthday)
end

function MinorsController:_onPlayerbassinfoChange()
	local last = self._isPayLimit
	local now = self:isPayLimit()

	if last ~= now then
		self:dispatchEvent(MinorsEvent.PayLimitFlagUpdate)
	end
end

function MinorsController:isPayLimit()
	if SettingsModel.instance:isJpRegion() then
		self._isPayLimit = string.nilorempty(PlayerModel.instance:getPlayerBirthday())

		return self._isPayLimit
	end

	return false
end

MinorsController.instance = MinorsController.New()

return MinorsController
