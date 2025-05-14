module("modules.logic.rouge.map.map.event.RougeMapEventComp", package.seeall)

local var_0_0 = class("RougeMapEventComp", UserDataDispose)

function var_0_0.init(arg_1_0)
	return
end

function var_0_0.handleEvent(arg_2_0, arg_2_1)
	arg_2_0.eventCo = arg_2_1

	local var_2_0 = arg_2_0.eventCo.type
	local var_2_1 = var_0_0.EventHandleDict[var_2_0]

	if not var_2_1 then
		logError("not handle event type : " .. tostring(var_2_0))

		return
	end

	var_2_1(arg_2_0)
end

function var_0_0.emptyHandle(arg_3_0)
	logWarn("empty handle")
end

function var_0_0.fightHandle(arg_4_0)
	logError("进入战斗")
end

function var_0_0.storeHandle(arg_5_0)
	logError("打开商店")
end

function var_0_0.choiceHandle(arg_6_0)
	logError("打开选项")
end

var_0_0.EventHandleDict = {
	[RougeMapEnum.EventType.Empty] = var_0_0.emptyHandle,
	[RougeMapEnum.EventType.NormalFight] = var_0_0.fightHandle,
	[RougeMapEnum.EventType.HardFight] = var_0_0.fightHandle,
	[RougeMapEnum.EventType.EliteFight] = var_0_0.fightHandle,
	[RougeMapEnum.EventType.BossFight] = var_0_0.fightHandle,
	[RougeMapEnum.EventType.Reward] = var_0_0.choiceHandle,
	[RougeMapEnum.EventType.Choice] = var_0_0.choiceHandle,
	[RougeMapEnum.EventType.Store] = var_0_0.storeHandle,
	[RougeMapEnum.EventType.Rest] = var_0_0.choiceHandle
}

function var_0_0.destroy(arg_7_0)
	return
end

return var_0_0
