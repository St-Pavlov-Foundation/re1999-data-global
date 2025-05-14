module("modules.logic.rouge.map.controller.RougeMapTipPopController", package.seeall)

local var_0_0 = class("RougeMapTipPopController")

function var_0_0.init(arg_1_0)
	if arg_1_0.inited then
		return
	end

	arg_1_0.inited = true
	arg_1_0.waitTipsList = {}
	arg_1_0.showing = false

	RougeMapController.instance:registerCallback(RougeMapEvent.onCreateMapDoneFlowDone, arg_1_0.popNextTip, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0.popNextTip, arg_1_0)
end

function var_0_0.addPopTip(arg_2_0, arg_2_1)
	if not arg_2_0.waitTipsList or string.nilorempty(arg_2_1) then
		return
	end

	table.insert(arg_2_0.waitTipsList, arg_2_1)
	arg_2_0:popNextTip()
end

function var_0_0.addPopTipByInteractId(arg_3_0, arg_3_1)
	local var_3_0 = lua_rouge_interactive.configDict[arg_3_1]

	if not var_3_0 then
		logError("not found interact id .. " .. tostring(arg_3_1))

		return
	end

	arg_3_0:addPopTip(var_3_0.tips)
end

function var_0_0.addPopTipByEffect(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = lua_rouge_effect.configDict[iter_4_1]

		if not var_4_0 then
			logError("not found effect id .. " .. tostring(iter_4_1))
		else
			arg_4_0:addPopTip(var_4_0.tips)
		end
	end
end

function var_0_0.popNextTip(arg_5_0)
	if RougeMapModel.instance:getMapState() <= RougeMapEnum.MapState.WaitFlow then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.RougeNextLayerView) then
		return
	end

	if arg_5_0.showing then
		return
	end

	local var_5_0 = table.remove(arg_5_0.waitTipsList, 1)

	if string.nilorempty(var_5_0) then
		return
	end

	arg_5_0.showing = true

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onShowTip, var_5_0)
	TaskDispatcher.runDelay(arg_5_0._onHideTip, arg_5_0, RougeMapEnum.TipShowDuration)
end

function var_0_0._onHideTip(arg_6_0)
	arg_6_0.showing = false

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onHideTip)
	TaskDispatcher.runDelay(arg_6_0.popNextTip, arg_6_0, RougeMapEnum.TipShowInterval)
end

function var_0_0.clear(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onHideTip, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.popNextTip, arg_7_0)

	arg_7_0.showing = false

	if arg_7_0.waitTipsList then
		tabletool.clear(arg_7_0.waitTipsList)
	end

	RougeMapController.instance:unregisterCallback(RougeMapEvent.onCreateMapDoneFlowDone, arg_7_0.popNextTip, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_7_0.popNextTip, arg_7_0)

	arg_7_0.inited = nil
end

function var_0_0.getTipsByEffectId(arg_8_0)
	return lua_rouge_effect.configDict[arg_8_0].tips
end

var_0_0.instance = var_0_0.New()

return var_0_0
