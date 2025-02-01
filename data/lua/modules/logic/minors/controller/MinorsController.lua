module("modules.logic.minors.controller.MinorsController", package.seeall)

slot0 = class("MinorsController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	if SettingsModel.instance:isJpRegion() then
		PlayerController.instance:registerCallback(PlayerEvent.PlayerbassinfoChange, slot0._onPlayerbassinfoChange, slot0)
	end
end

function slot0.confirmDateOfBirthVerify(slot0, slot1, slot2, slot3)
	PlayerRpc.instance:sendSetBirthdayRequest(string.format("%s-%s-%s", slot1, slot2, slot3))
end

function slot0._onPlayerbassinfoChange(slot0)
	if slot0._isPayLimit ~= slot0:isPayLimit() then
		slot0:dispatchEvent(MinorsEvent.PayLimitFlagUpdate)
	end
end

function slot0.isPayLimit(slot0)
	if SettingsModel.instance:isJpRegion() then
		slot0._isPayLimit = string.nilorempty(PlayerModel.instance:getPlayerBirthday())

		return slot0._isPayLimit
	end

	return false
end

slot0.instance = slot0.New()

return slot0
