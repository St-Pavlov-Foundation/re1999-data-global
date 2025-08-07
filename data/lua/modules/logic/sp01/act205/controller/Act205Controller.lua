module("modules.logic.sp01.act205.controller.Act205Controller", package.seeall)

local var_0_0 = class("Act205Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.onDailyRefresh, arg_3_0)
end

function var_0_0.onDailyRefresh(arg_4_0)
	if not ActivityHelper.isOpen(Act205Enum.ActId) then
		return
	end

	Activity205Rpc.instance:sendAct205GetInfoRequest(Act205Enum.ActId, function()
		arg_4_0:dispatchEvent(Act205Event.OnDailyRefresh)
	end, arg_4_0)
end

function var_0_0.openGameStartView(arg_6_0, arg_6_1)
	if not Act205Model.instance:isAct205Open(true) then
		return
	end

	arg_6_0.activityId = arg_6_1

	Activity205Rpc.instance:sendAct205GetInfoRequest(arg_6_1, arg_6_0.realOpenGameStartView, arg_6_0)
end

function var_0_0.realOpenGameStartView(arg_7_0)
	local var_7_0 = Act205Model.instance:getCurOpenGameStageId()

	if not var_7_0 then
		GameFacade.showToast(ToastEnum.ActivityNotOpen)

		return
	end

	local var_7_1 = {
		activityId = arg_7_0.activityId,
		gameStageId = var_7_0
	}

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(arg_7_0.activityId)
	ViewMgr.instance:openView(ViewName.Act205GameStartView, var_7_1)
end

function var_0_0.openRuleTipsView(arg_8_0)
	ViewMgr.instance:openView(ViewName.Act205RuleTipsView)
end

function var_0_0.openOceanSelectView(arg_9_0, arg_9_1)
	if not Act205Model.instance:isGameStageOpen(Act205Enum.GameStageId.Ocean, true) then
		return
	end

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(Act205Enum.ActId, function()
		ViewMgr.instance:openView(ViewName.Act205OceanSelectView, arg_9_1)
	end, arg_9_0)
end

function var_0_0.openOceanShowView(arg_11_0, arg_11_1)
	if not Act205Model.instance:isGameStageOpen(Act205Enum.GameStageId.Ocean, true) then
		return
	end

	ViewMgr.instance:openView(ViewName.Act205OceanShowView, arg_11_1)
	ViewMgr.instance:closeView(ViewName.Act205GameStartView)
end

function var_0_0.openOceanResultView(arg_12_0, arg_12_1)
	ViewMgr.instance:openView(ViewName.Act205OceanResultView, arg_12_1)
end

function var_0_0.setPlayerPrefs(arg_13_0, arg_13_1, arg_13_2)
	if string.nilorempty(arg_13_1) or not arg_13_2 then
		return
	end

	if type(arg_13_2) == "number" then
		GameUtil.playerPrefsSetNumberByUserId(arg_13_1, arg_13_2)
	else
		GameUtil.playerPrefsSetStringByUserId(arg_13_1, arg_13_2)
	end
end

function var_0_0.getPlayerPrefs(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2 or ""

	if string.nilorempty(arg_14_1) then
		return var_14_0
	end

	if type(var_14_0) == "number" then
		var_14_0 = GameUtil.playerPrefsGetNumberByUserId(arg_14_1, var_14_0)
	else
		var_14_0 = GameUtil.playerPrefsGetStringByUserId(arg_14_1, var_14_0)
	end

	return var_14_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
