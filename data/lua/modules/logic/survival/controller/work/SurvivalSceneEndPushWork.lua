module("modules.logic.survival.controller.work.SurvivalSceneEndPushWork", package.seeall)

local var_0_0 = class("SurvivalSceneEndPushWork", SurvivalMsgPushWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_1_0 then
		arg_1_0:onDone(true)

		return
	end

	var_1_0.inSurvival = false
	SurvivalMapModel.instance.result = arg_1_0._msg.isWin and SurvivalEnum.MapResult.Win or SurvivalEnum.MapResult.Lose

	SurvivalMapModel.instance.resultData:init(arg_1_0._msg)

	if ViewMgr.instance:isOpen(ViewName.SurvivalLoadingView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onViewClose, arg_1_0)
	else
		arg_1_0:_tweenToPlayerAndDestoryUnit()
	end
end

function var_0_0._onViewClose(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.SurvivalLoadingView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onViewClose, arg_2_0)
		arg_2_0:_tweenToPlayerAndDestoryUnit()
	end
end

function var_0_0._tweenToPlayerAndDestoryUnit(arg_3_0)
	ViewMgr.instance:closeAllModalViews()

	local var_3_0 = arg_3_0._msg.reason == 1 or arg_3_0._msg.reason == 2 or arg_3_0._msg.reason == 4

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Survival or not var_3_0 then
		arg_3_0:openResultView()

		return
	end

	local var_3_1 = SurvivalMapModel.instance:getSceneMo()
	local var_3_2 = var_3_1.player
	local var_3_3, var_3_4, var_3_5 = SurvivalHelper.instance:hexPointToWorldPoint(var_3_2.pos.q, var_3_2.pos.r)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(var_3_3, var_3_4, var_3_5))

	local var_3_6 = var_3_1:getUnitByPos(var_3_2.pos, true, true)

	if var_3_6 then
		for iter_3_0 = #var_3_6, 1, -1 do
			local var_3_7 = var_3_6[iter_3_0]

			var_3_1:deleteUnit(var_3_7.id, false)
		end
	end

	local var_3_8 = SurvivalMapHelper.instance:getEntity(0)

	if var_3_8 and var_3_2:isDefaultModel() then
		UIBlockHelper.instance:startBlock("SurvivalCheckMapEndWork", 1.9)
		var_3_8:playAnim("die")
		TaskDispatcher.runDelay(arg_3_0.openResultView, arg_3_0, 1.9)
	else
		arg_3_0:openResultView()
	end
end

function var_0_0.openResultView(arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_4_0.onViewClose, arg_4_0)
	ViewMgr.instance:openView(ViewName.SurvivalMapResultPanelView, {
		isWin = SurvivalMapModel.instance.result == SurvivalEnum.MapResult.Win
	})

	if not arg_4_0.context.fastExecute then
		arg_4_0.context.fastExecute = true
	end
end

function var_0_0.onViewClose(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.SurvivalMapResultView then
		arg_5_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_6_0)
	var_0_0.super.clearWork(arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_6_0.onViewClose, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.openResultView, arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_6_0._onViewClose, arg_6_0)
end

return var_0_0
