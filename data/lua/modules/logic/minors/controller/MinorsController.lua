module("modules.logic.minors.controller.MinorsController", package.seeall)

local var_0_0 = class("MinorsController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	if SettingsModel.instance:isJpRegion() then
		PlayerController.instance:registerCallback(PlayerEvent.PlayerbassinfoChange, arg_4_0._onPlayerbassinfoChange, arg_4_0)
	end
end

function var_0_0.confirmDateOfBirthVerify(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = string.format("%s-%s-%s", arg_5_1, arg_5_2, arg_5_3)

	PlayerRpc.instance:sendSetBirthdayRequest(var_5_0)
end

function var_0_0._onPlayerbassinfoChange(arg_6_0)
	if arg_6_0._isPayLimit ~= arg_6_0:isPayLimit() then
		arg_6_0:dispatchEvent(MinorsEvent.PayLimitFlagUpdate)
	end
end

function var_0_0.isPayLimit(arg_7_0)
	if SettingsModel.instance:isJpRegion() then
		arg_7_0._isPayLimit = string.nilorempty(PlayerModel.instance:getPlayerBirthday())

		return arg_7_0._isPayLimit
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
