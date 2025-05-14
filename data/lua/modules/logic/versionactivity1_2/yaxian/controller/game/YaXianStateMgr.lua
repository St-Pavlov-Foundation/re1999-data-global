module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianStateMgr", package.seeall)

local var_0_0 = class("YaXianStateMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._curEventData = nil
	arg_1_0._curEvent = nil
end

var_0_0.EventClzMap = {
	[YaXianGameEnum.GameStateType.Battle] = YaXianStateBattle,
	[YaXianGameEnum.GameStateType.UseItem] = YaXianStateUseItem,
	[YaXianGameEnum.GameStateType.FinishEvent] = YaXianStateFinishEvent
}

function var_0_0.setCurEvent(arg_2_0, arg_2_1)
	if arg_2_1 ~= nil and not string.nilorempty(arg_2_1.param) then
		arg_2_0._curEventData = cjson.decode(arg_2_1.param)
	else
		arg_2_0._curEventData = nil
	end

	arg_2_0:buildEventState()
end

function var_0_0.setCurEventByObj(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0._curEventData = arg_3_1
	else
		arg_3_0._curEventData = nil
	end

	arg_3_0:buildEventState()
end

function var_0_0.buildEventState(arg_4_0)
	local var_4_0

	if not arg_4_0._curEventData then
		var_4_0 = YaXianGameEnum.GameStateType.Normal
	else
		var_4_0 = arg_4_0._curEventData.eventType
	end

	if arg_4_0._curEvent and arg_4_0._curEvent:getStateType() == var_4_0 then
		return
	end

	local var_4_1 = var_0_0.EventClzMap[var_4_0]

	if var_4_1 then
		arg_4_0:disposeEventState()

		arg_4_0._curEvent = var_4_1.New()

		arg_4_0._curEvent:init(arg_4_0._curEventData)
		arg_4_0._curEvent:start()
	end
end

function var_0_0.setLockState(arg_5_0)
	arg_5_0:disposeEventState()

	arg_5_0._curEventData = nil
	arg_5_0._curEvent = YaXianStateLock.New()

	arg_5_0._curEvent:init()
	arg_5_0._curEvent:start()
end

function var_0_0.disposeEventState(arg_6_0)
	if arg_6_0._curEvent ~= nil then
		arg_6_0._curEvent:dispose()

		arg_6_0._curEvent = nil
	end
end

function var_0_0.getCurEvent(arg_7_0)
	return arg_7_0._curEvent
end

function var_0_0.removeAll(arg_8_0)
	arg_8_0:disposeEventState()
end

return var_0_0
