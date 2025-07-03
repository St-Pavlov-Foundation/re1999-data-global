module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandTaskItem", package.seeall)

local var_0_0 = class("CooperGarlandTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_normal/#scroll_rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0._gonojump = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_nojump")
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
	if arg_4_0._mo.config.jumpId > 0 then
		GameFacade.jump(arg_4_0._mo.config.jumpId)
	end
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	arg_5_0:_onOneClickClaimReward(arg_5_0._mo.activityId)
	UIBlockHelper.instance:startBlock(CooperGarlandEnum.BlockKey.OneClickClaimReward, 0.5)
	TaskDispatcher.runDelay(arg_5_0._delayFinish, arg_5_0, 0.5)
end

function var_0_0._delayFinish(arg_6_0)
	TaskRpc.instance:sendFinishTaskRequest(arg_6_0._mo.config.id)
end

function var_0_0._btngetallOnClick(arg_7_0)
	CooperGarlandController.instance:dispatchEvent(CooperGarlandEvent.OneClickClaimReward, arg_7_0._mo.activityId)
	UIBlockHelper.instance:startBlock(CooperGarlandEnum.BlockKey.OneClickClaimReward, 0.5)
	TaskDispatcher.runDelay(arg_7_0._delayFinishAll, arg_7_0, 0.5)
end

function var_0_0._delayFinishAll(arg_8_0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity192)
end

function var_0_0._onOneClickClaimReward(arg_9_0, arg_9_1)
	if arg_9_0._mo and arg_9_0._mo.activityId == arg_9_1 and arg_9_0._mo:alreadyGotReward() then
		arg_9_0._playFinishAnim = true

		arg_9_0._animator:Play("finish", 0, 0)
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._animator = arg_10_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_10_0.viewTrs = arg_10_0.viewGO.transform
	arg_10_0._scrollRewards = gohelper.findChildComponent(arg_10_0.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function var_0_0._editableAddEvents(arg_11_0)
	CooperGarlandController.instance:registerCallback(CooperGarlandEvent.OneClickClaimReward, arg_11_0._onOneClickClaimReward, arg_11_0)
end

function var_0_0._editableRemoveEvents(arg_12_0)
	CooperGarlandController.instance:unregisterCallback(CooperGarlandEvent.OneClickClaimReward, arg_12_0._onOneClickClaimReward, arg_12_0)
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1)
	arg_13_0._mo = arg_13_1
	arg_13_0._scrollRewards.parentGameObject = arg_13_0._view._csListScroll.gameObject

	arg_13_0:_refreshUI()
	arg_13_0:_moveByRankDiff()
end

function var_0_0._refreshUI(arg_14_0)
	if not arg_14_0._mo then
		return
	end

	local var_14_0 = arg_14_0._mo.id ~= CooperGarlandEnum.Const.TaskMOAllFinishId

	gohelper.setActive(arg_14_0._gogetall, not var_14_0)
	gohelper.setActive(arg_14_0._gonormal, var_14_0)

	if not var_14_0 then
		return
	end

	if arg_14_0._playFinishAnim then
		arg_14_0._playFinishAnim = false

		arg_14_0._animator:Play("idle", 0, 1)
	end

	gohelper.setActive(arg_14_0._goallfinish, false)
	gohelper.setActive(arg_14_0._btnnotfinishbg, false)
	gohelper.setActive(arg_14_0._btnfinishbg, false)
	gohelper.setActive(arg_14_0._gonojump, false)

	if arg_14_0._mo:isFinished() then
		gohelper.setActive(arg_14_0._goallfinish, true)
	elseif arg_14_0._mo:alreadyGotReward() then
		gohelper.setActive(arg_14_0._btnfinishbg, true)
	elseif arg_14_0._mo.config.jumpId > 0 then
		gohelper.setActive(arg_14_0._btnnotfinishbg, true)
	else
		gohelper.setActive(arg_14_0._gonojump, true)
	end

	local var_14_1 = arg_14_0._mo.config and arg_14_0._mo.config.offestProgress or 0

	arg_14_0._txtnum.text = math.max(arg_14_0._mo:getFinishProgress() + var_14_1, 0)
	arg_14_0._txttotal.text = math.max(arg_14_0._mo:getMaxProgress() + var_14_1, 0)
	arg_14_0._txttaskdes.text = arg_14_0._mo.config and arg_14_0._mo.config.desc or ""

	local var_14_2 = DungeonConfig.instance:getRewardItems(tonumber(arg_14_0._mo.config.bonus))
	local var_14_3 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_2) do
		var_14_3[iter_14_0] = {
			isIcon = true,
			materilType = iter_14_1[1],
			materilId = iter_14_1[2],
			quantity = iter_14_1[3]
		}
	end

	arg_14_0.item_list = var_14_3

	IconMgr.instance:getCommonPropItemIconList(arg_14_0, arg_14_0._onItemShow, var_14_3, arg_14_0._gorewards)

	arg_14_0._scrollRewards.horizontalNormalizedPosition = 0
end

function var_0_0._onItemShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_1:onUpdateMO(arg_15_2)
	arg_15_1:setConsume(true)
	arg_15_1:showStackableNum2()
	arg_15_1:isShowEffect(true)
	arg_15_1:setAutoPlay(true)
	arg_15_1:setCountFontSize(48)
end

function var_0_0._moveByRankDiff(arg_16_0)
	local var_16_0 = CooperGarlandTaskListModel.instance:getRankDiff(arg_16_0._mo)

	if not var_16_0 or var_16_0 == 0 then
		return
	end

	if arg_16_0._rankDiffMoveId then
		ZProj.TweenHelper.KillById(arg_16_0._rankDiffMoveId)

		arg_16_0._rankDiffMoveId = nil
	end

	local var_16_1, var_16_2, var_16_3 = transformhelper.getLocalPos(arg_16_0.viewTrs)

	transformhelper.setLocalPosXY(arg_16_0.viewTrs, var_16_1, 165 * var_16_0)

	arg_16_0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_16_0.viewTrs, 0, 0.15)
end

function var_0_0.onSelect(arg_17_0, arg_17_1)
	return
end

function var_0_0.getAnimator(arg_18_0)
	return arg_18_0._animator
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0._rankDiffMoveId then
		ZProj.TweenHelper.KillById(arg_19_0._rankDiffMoveId)

		arg_19_0._rankDiffMoveId = nil
	end
end

return var_0_0
