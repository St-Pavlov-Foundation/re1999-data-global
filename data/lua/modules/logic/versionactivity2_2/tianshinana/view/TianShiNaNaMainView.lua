module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainView", package.seeall)

local var_0_0 = class("TianShiNaNaMainView", BaseView)
local var_0_1 = 43.99266
local var_0_2 = 3409

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/#go_time/#txt_limittime")
	arg_1_0._taskAnimator = gohelper.findChild(arg_1_0.viewGO, "#btn_task/ani"):GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._gopath = gohelper.findChild(arg_1_0.viewGO, "#go_path")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	arg_1_0._gostageitem = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/#go_stages/#go_StageItem")
	arg_1_0._pathAnims = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 10 do
		arg_1_0._pathAnims[iter_1_0] = gohelper.findChild(arg_1_0._goscrollcontent, "path/path/image" .. iter_1_0):GetComponent(typeof(UnityEngine.Animator))
		arg_1_0._pathAnims[iter_1_0].speed = 0
	end

	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._gopath, nil, arg_2_0._onDrag, nil, nil, arg_2_0, nil, true)
	arg_2_0._btntask:AddClickListener(arg_2_0._onClickTask, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0._refreshTask, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EnterLevelScene, arg_2_0._onEnterLevelScene, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeStarChange, arg_2_0._onStarChange, arg_2_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.EpisodeFinish, arg_2_0._onEpisodeFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._gopath)
	arg_3_0._btntask:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0._refreshTask, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EnterLevelScene, arg_3_0._onEnterLevelScene, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeStarChange, arg_3_0._onStarChange, arg_3_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.EpisodeFinish, arg_3_0._onEpisodeFinish, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_refreshTask()
	gohelper.setActive(arg_4_0._gostageitem, false)
	RedDotController.instance:addRedDot(arg_4_0._gored, RedDotEnum.DotNode.V2a2TianShiNaNaTaskRed, VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	local var_4_0 = TianShiNaNaConfig.instance:getEpisodeCoList(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	local var_4_1 = VersionActivity2_2Enum.ActivityId.TianShiNaNa
	local var_4_2 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. var_4_1, "1")
	local var_4_3

	var_4_3 = tonumber(var_4_2) or 1

	local var_4_4 = Mathf.Clamp(var_4_3, 1, #var_4_0)

	arg_4_0:setDragPosX(544.6 * (var_4_4 - 1) - recthelper.getWidth(arg_4_0._gopath.transform) / 2 - 150)

	TianShiNaNaModel.instance.curSelectIndex = var_4_4
	arg_4_0._stages = {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_5 = gohelper.findChild(arg_4_0._gostages, "stage" .. iter_4_0)

		if var_4_5 then
			local var_4_6 = gohelper.clone(arg_4_0._gostageitem, var_4_5, "root")
			local var_4_7 = gohelper.findChild(var_4_6, "#go_EvenStage")
			local var_4_8 = gohelper.findChild(var_4_6, "#go_OddStage")

			gohelper.setActive(var_4_7, iter_4_0 % 2 == 1)
			gohelper.setActive(var_4_8, iter_4_0 % 2 == 0)
			gohelper.setActive(var_4_6, true)

			arg_4_0._stages[iter_4_0] = MonoHelper.addNoUpdateLuaComOnceToGo(iter_4_0 % 2 == 0 and var_4_8 or var_4_7, TianShiNaNaStageItem)

			arg_4_0._stages[iter_4_0]:initCo(var_4_0[iter_4_0], iter_4_0)
		else
			logError("关卡节点不存在，请找集成处理 stage" .. iter_4_0)
		end
	end

	arg_4_0:refreshTime()
	TaskDispatcher.runRepeat(arg_4_0.refreshTime, arg_4_0, 60)

	local var_4_9 = TianShiNaNaModel.instance:getUnLockMaxIndex()

	for iter_4_1 = 1, 10 do
		if iter_4_1 <= var_4_9 and var_4_0[iter_4_1 + 1] then
			arg_4_0._pathAnims[iter_4_1]:Play("idle", 0, 0)
		else
			arg_4_0._pathAnims[iter_4_1]:Play("open", 0, 0)
		end
	end
end

function var_0_0._onStarChange(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0._stages[arg_5_1 + 1] then
		return
	end

	if arg_5_2 == 0 and arg_5_0._pathAnims[arg_5_1] then
		arg_5_0._pathAnims[arg_5_1]:Play("open", 0, 0)

		arg_5_0._pathAnims[arg_5_1].speed = 1
	end
end

function var_0_0._onEpisodeFinish(arg_6_0)
	if not arg_6_0._gopath then
		return
	end

	local var_6_0 = VersionActivity2_2Enum.ActivityId.TianShiNaNa
	local var_6_1 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2TianShiNaNaSelect .. var_6_0, "1")
	local var_6_2

	var_6_2 = tonumber(var_6_1) or 1

	local var_6_3 = Mathf.Clamp(var_6_2, 1, #arg_6_0._stages)

	arg_6_0:setDragPosX(544.6 * (var_6_3 - 1) - recthelper.getWidth(arg_6_0._gopath.transform) / 2 - 150, true)
end

function var_0_0._onClickTask(arg_7_0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaTaskView)
end

function var_0_0.refreshTime(arg_8_0)
	arg_8_0._txtlimittime.text = TianShiNaNaHelper.getLimitTimeStr()
end

function var_0_0._refreshTask(arg_9_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a2TianShiNaNaTaskRed, VersionActivity2_2Enum.ActivityId.TianShiNaNa) then
		arg_9_0._taskAnimator:Play("loop", 0, 0)
	else
		arg_9_0._taskAnimator:Play("idle", 0, 0)
	end
end

function var_0_0._onViewClose(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.TianShiNaNaLevelView then
		arg_10_0._viewAnimator:Play("open", 0, 0)
	end
end

function var_0_0._onEnterLevelScene(arg_11_0)
	arg_11_0._viewAnimator:Play("close", 0, 0)
	UIBlockHelper.instance:startBlock("TianShiNaNaMainView_onEnterLevelScene", 0.34, arg_11_0.viewName)
	TaskDispatcher.runDelay(arg_11_0._realEnterGameView, arg_11_0, 0.34)
end

function var_0_0._realEnterGameView(arg_12_0)
	ViewMgr.instance:openView(ViewName.TianShiNaNaLevelView)
end

function var_0_0._onDrag(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = recthelper.getAnchorX(arg_13_0._goscrollcontent.transform) + arg_13_2.delta.x

	arg_13_0:setDragPosX(-var_13_0)
end

function var_0_0.setDragPosX(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = 0
	local var_14_1 = UnityEngine.Screen.width / UnityEngine.Screen.height
	local var_14_2 = 1.7777777777777777

	if var_14_2 - var_14_1 < 0 then
		var_14_0 = (var_14_1 / var_14_2 - 1) * recthelper.getWidth(arg_14_0._gopath.transform) / 2
		var_14_0 = Mathf.Clamp(var_14_0, 0, 400)
	end

	if var_14_0 <= var_0_2 - var_14_0 then
		arg_14_1 = Mathf.Clamp(arg_14_1, var_14_0, var_0_2 - var_14_0)
	else
		arg_14_1 = var_14_0
	end

	if arg_14_1 == arg_14_0._nowDragPosX then
		return
	end

	arg_14_0:killTween()

	if arg_14_2 and arg_14_0._nowDragPosX then
		arg_14_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_14_0._nowDragPosX, arg_14_1, 0.5, arg_14_0._onFrameTween, nil, arg_14_0)
	else
		arg_14_0._nowDragPosX = arg_14_1

		transformhelper.setLocalPos(arg_14_0._goscrollcontent.transform, -arg_14_1, 0, 0)

		local var_14_3 = -arg_14_1 * var_0_1 / var_0_2

		TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.DragMainScene, var_14_3)
	end
end

function var_0_0._onFrameTween(arg_15_0, arg_15_1)
	arg_15_0._nowDragPosX = arg_15_1

	transformhelper.setLocalPos(arg_15_0._goscrollcontent.transform, -arg_15_1, 0, 0)

	local var_15_0 = -arg_15_1 * var_0_1 / var_0_2

	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.DragMainScene, var_15_0)
end

function var_0_0.killTween(arg_16_0)
	if arg_16_0._tweenId then
		ZProj.TweenHelper.KillById(arg_16_0._tweenId)

		arg_16_0._tweenId = nil
	end
end

function var_0_0.onClose(arg_17_0)
	arg_17_0:killTween()
	TaskDispatcher.cancelTask(arg_17_0.refreshTime, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._realEnterGameView, arg_17_0)
end

return var_0_0
