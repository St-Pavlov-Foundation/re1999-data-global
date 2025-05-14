module("modules.logic.room.entity.comp.RoomBuildingClockComp", package.seeall)

local var_0_0 = class("RoomBuildingClockComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1

	local var_2_0 = arg_2_0:getMO()

	arg_2_0._audioExtendType = var_2_0.config.audioExtendType
	arg_2_0._audioExtendIds = string.splitToNumber(var_2_0.config.audioExtendIds, "#") or {}
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.OnHourReporting, arg_3_0._onHourReporting, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.OnHourReporting, arg_4_0._onHourReporting, arg_4_0)
end

function var_0_0.beforeDestroy(arg_5_0)
	arg_5_0:removeEventListeners()
end

function var_0_0._onHourReporting(arg_6_0, arg_6_1)
	if RoomController.instance:isEditMode() or not arg_6_1 then
		return
	end

	if arg_6_0._audioExtendType == RoomBuildingEnum.AudioExtendType.Clock12Hour then
		local var_6_0 = (arg_6_1 - 1) % 12 + 1
		local var_6_1 = arg_6_0._audioExtendIds[var_6_0]

		RoomHelper.audioExtendTrigger(var_6_1, arg_6_0.go)
	end
end

function var_0_0.getMO(arg_7_0)
	return arg_7_0.entity:getMO()
end

return var_0_0
