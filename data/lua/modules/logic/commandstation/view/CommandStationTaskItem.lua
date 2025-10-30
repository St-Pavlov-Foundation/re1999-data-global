module("modules.logic.commandstation.view.CommandStationTaskItem", package.seeall)

local var_0_0 = class("CommandStationTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._simagenormalbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg2")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_normal/#scroll_rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._gonojump = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_nojump")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0._gounopen = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_unopen")
	arg_1_0._txtUnOpen = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#go_unopen/image_Tag/#txt_UnOpen")
	arg_1_0._goexpire = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_expire")
	arg_1_0._goopen = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_open")
	arg_1_0._goxunyou = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_xunyou")
	arg_1_0._gocatch = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_catch")
	arg_1_0._txtOpen = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#go_open/image_Tag/#txt_Open")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnnotfinishbg:AddClickListener(arg_2_0._btnnotfinishbgOnClick, arg_2_0)
	arg_2_0._btnfinishbg:AddClickListener(arg_2_0._btnfinishbgOnClick, arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnnotfinishbg:RemoveClickListener()
	arg_3_0._btnfinishbg:RemoveClickListener()
	arg_3_0._btngetall:RemoveClickListener()
end

function var_0_0._btnnotfinishbgOnClick(arg_4_0)
	if arg_4_0._taskMO.config.jumpId and arg_4_0._taskMO.config.jumpId > 0 and GameFacade.jump(arg_4_0._taskMO.config.jumpId) then
		ViewMgr.instance:closeView(ViewName.CommandStationTaskView)
	end
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	arg_5_0:_onOneClickClaimReward()
	UIBlockHelper.instance:startBlock("CommandStationTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(arg_5_0._delayFinish, arg_5_0, 0.5)
end

function var_0_0._btngetallOnClick(arg_6_0)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.OneClickClaimReward)
	UIBlockHelper.instance:startBlock("CommandStationTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(arg_6_0._delayFinishAll, arg_6_0, 0.5)
end

function var_0_0._delayFinish(arg_7_0)
	TaskRpc.instance:sendFinishTaskRequest(arg_7_0._taskMO.config.id)
end

function var_0_0._delayFinishAll(arg_8_0)
	local var_8_0 = TaskEnum.TaskType.CommandStationNormal

	if CommandStationTaskListModel.instance.curSelectType ~= 1 then
		var_8_0 = TaskEnum.TaskType.CommandStationCatch
	end

	TaskRpc.instance:sendFinishAllTaskRequest(var_8_0)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._animator = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0.viewTrs = arg_9_0.viewGO.transform
	arg_9_0._scrollRewards = gohelper.findChildComponent(arg_9_0.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function var_0_0._editableAddEvents(arg_10_0)
	CommandStationController.instance:registerCallback(CommandStationEvent.OneClickClaimReward, arg_10_0._onOneClickClaimReward, arg_10_0)
end

function var_0_0._editableRemoveEvents(arg_11_0)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OneClickClaimReward, arg_11_0._onOneClickClaimReward, arg_11_0)
end

function var_0_0._onOneClickClaimReward(arg_12_0)
	if arg_12_0._taskMO and arg_12_0._taskMO:alreadyGotReward() then
		arg_12_0._playFinishAnin = true

		arg_12_0._animator:Play("finish", 0, 0)
	end
end

function var_0_0.getAnimator(arg_13_0)
	return arg_13_0._animator
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._taskMO = arg_14_1

	local var_14_0 = CommandStationTaskListModel.instance:getRankDiff(arg_14_1)

	arg_14_0._scrollRewards.parentGameObject = arg_14_0._view._csListScroll.gameObject

	arg_14_0:_refreshUI()
	arg_14_0:_moveByRankDiff(var_14_0)
end

function var_0_0._moveByRankDiff(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_1 ~= 0 then
		if arg_15_0._rankDiffMoveId then
			ZProj.TweenHelper.KillById(arg_15_0._rankDiffMoveId)

			arg_15_0._rankDiffMoveId = nil
		end

		local var_15_0, var_15_1, var_15_2 = transformhelper.getLocalPos(arg_15_0.viewTrs)

		transformhelper.setLocalPosXY(arg_15_0.viewTrs, var_15_0, 165 * arg_15_1)

		arg_15_0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_15_0.viewTrs, 0, 0.15)
	end
end

function var_0_0.onSelect(arg_16_0, arg_16_1)
	return
end

function var_0_0._refreshUI(arg_17_0)
	local var_17_0 = arg_17_0._taskMO

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.id ~= -99999

	gohelper.setActive(arg_17_0._gogetall, not var_17_1)
	gohelper.setActive(arg_17_0._gonormal, var_17_1)

	if var_17_1 then
		if arg_17_0._playFinishAnin then
			arg_17_0._playFinishAnin = false

			arg_17_0._animator:Play("idle", 0, 0)
		end

		gohelper.setActive(arg_17_0._goallfinish, false)
		gohelper.setActive(arg_17_0._btnnotfinishbg, false)
		gohelper.setActive(arg_17_0._btnfinishbg, false)
		gohelper.setActive(arg_17_0._gonojump, false)
		gohelper.setActive(arg_17_0._goopen, false)
		gohelper.setActive(arg_17_0._goexpire, false)
		gohelper.setActive(arg_17_0._gounopen, false)

		local var_17_2 = arg_17_0:_getActStatus(var_17_0)

		if var_17_2 and var_17_0:isFinished() then
			gohelper.setActive(arg_17_0._goallfinish, true)
		elseif var_17_0:alreadyGotReward() then
			gohelper.setActive(arg_17_0._btnfinishbg, true)
			gohelper.setActive(arg_17_0._goexpire, false)
		elseif var_17_2 and var_17_0.config.jumpId and var_17_0.config.jumpId > 0 then
			gohelper.setActive(arg_17_0._btnnotfinishbg, true)
		else
			gohelper.setActive(arg_17_0._gonojump, var_17_2)
		end

		local var_17_3 = var_17_0.config and var_17_0.config.offestProgress or 0

		arg_17_0._txtnum.text = math.max(var_17_0:getFinishProgress() + var_17_3, 0)
		arg_17_0._txttotal.text = math.max(var_17_0:getMaxProgress() + var_17_3, 0)
		arg_17_0._txttaskdes.text = var_17_0.config and var_17_0.config.desc or ""

		local var_17_4 = ItemModel.instance:getItemDataListByConfigStr(var_17_0.config.bonus)

		arg_17_0.item_list = var_17_4

		IconMgr.instance:getCommonPropItemIconList(arg_17_0, arg_17_0._onItemShow, var_17_4, arg_17_0._gorewards)

		arg_17_0._scrollRewards.horizontalNormalizedPosition = 0

		if CommandStationTaskListModel.instance:isCatchTaskType() then
			arg_17_0._txttaskdes.text = string.format(var_17_0.config and var_17_0.config.desc or "", var_17_0:getMaxProgress())
		end

		local var_17_5 = var_17_0.config.taskType == CommandStationEnum.TaskShowType.Normal

		gohelper.setActive(arg_17_0._simagenormalbg, var_17_5)
		gohelper.setActive(arg_17_0._simagenormalbg2, not var_17_5)
		gohelper.setActive(arg_17_0._goxunyou, not var_17_5 and var_17_0.config.taskType == CommandStationEnum.TaskShowType.Parade)
		gohelper.setActive(arg_17_0._gocatch, not var_17_5 and var_17_0.config.taskType == CommandStationEnum.TaskShowType.Overseas)
	end
end

function var_0_0._getActStatus(arg_18_0, arg_18_1)
	if CommandStationTaskListModel.instance:isCatchTaskType() then
		return true
	end

	TaskDispatcher.cancelTask(arg_18_0._delayRefreshActivityStatus, arg_18_0)

	local var_18_0 = arg_18_1.config and arg_18_1.config.activityid

	if not var_18_0 or var_18_0 <= 0 then
		return true
	end

	local var_18_1 = ActivityHelper.getActivityStatus(var_18_0)

	if var_18_1 == ActivityEnum.ActivityStatus.NotOpen then
		gohelper.setActive(arg_18_0._gounopen, true)

		local var_18_2 = ActivityModel.instance:getActStartTime(var_18_0) / 1000 - ServerTime.now()
		local var_18_3 = string.format("%s%s", TimeUtil.secondToRoughTime2(var_18_2))

		arg_18_0._txtUnOpen.text = string.format(luaLang("seasonmainview_timeopencondition"), var_18_3)

		TaskDispatcher.runDelay(arg_18_0._delayRefreshActivityStatus, arg_18_0, var_18_2)

		return false
	end

	if var_18_1 == ActivityEnum.ActivityStatus.Expired then
		gohelper.setActive(arg_18_0._goexpire, true)

		local var_18_4 = gohelper.findChild(arg_18_0._goexpire, "image_Disable")
		local var_18_5 = gohelper.findChild(arg_18_0._goexpire, "image_ClaimedTick")
		local var_18_6 = arg_18_1:isFinished()

		gohelper.setActive(var_18_4, not var_18_6)
		gohelper.setActive(var_18_5, var_18_6)

		return false
	end

	gohelper.setActive(arg_18_0._goopen, true)

	local var_18_7 = ActivityModel.instance:getActEndTime(var_18_0) / 1000 - ServerTime.now()

	arg_18_0._txtOpen.text = TimeUtil.SecondToActivityTimeFormat(var_18_7)

	TaskDispatcher.runDelay(arg_18_0._delayRefreshActivityStatus, arg_18_0, var_18_7)

	return true
end

function var_0_0._delayRefreshActivityStatus(arg_19_0)
	arg_19_0:_refreshUI()
end

function var_0_0._onItemShow(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_1:onUpdateMO(arg_20_2)
	arg_20_1:setConsume(true)
	arg_20_1:showStackableNum2()
	arg_20_1:isShowEffect(true)
	arg_20_1:setAutoPlay(true)
	arg_20_1:setCountFontSize(48)
end

function var_0_0.onDestroyView(arg_21_0)
	if arg_21_0._rankDiffMoveId then
		ZProj.TweenHelper.KillById(arg_21_0._rankDiffMoveId)

		arg_21_0._rankDiffMoveId = nil
	end

	TaskDispatcher.cancelTask(arg_21_0._delayRefreshActivityStatus, arg_21_0)
end

var_0_0.prefabPath = "ui/viewres/commandstation/commandstation_taskitem.prefab"

return var_0_0
