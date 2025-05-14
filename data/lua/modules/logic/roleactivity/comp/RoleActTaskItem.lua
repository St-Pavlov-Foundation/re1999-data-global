module("modules.logic.roleactivity.comp.RoleActTaskItem", package.seeall)

local var_0_0 = class("RoleActTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._scrollreward = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0._gogetall = gohelper.findChild(arg_1_0.viewGO, "#go_getall")
	arg_1_0._simagegetallbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_getall/#simage_getallbg")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)

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
	local var_4_0 = arg_4_0._actTaskMO.config.listenerType ~= "StoryFinish"

	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.TabSwitch, var_4_0)
	ViewMgr.instance:closeView(arg_4_0._view.viewName)
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	if RoleActivityController.instance:delayReward(RoleActivityEnum.AnimatorTime.TaskReward, arg_5_0._actTaskMO) then
		arg_5_0:_onOneClickClaimReward()
	end
end

function var_0_0._btngetallOnClick(arg_6_0)
	if RoleActivityController.instance:delayReward(RoleActivityEnum.AnimatorTime.TaskReward, arg_6_0._actTaskMO) then
		RoleActivityController.instance:dispatchEvent(RoleActivityEvent.OneClickClaimReward)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0.viewTrs = arg_7_0.viewGO.transform
end

function var_0_0._editableAddEvents(arg_8_0)
	arg_8_0:addEventCb(RoleActivityController.instance, RoleActivityEvent.OneClickClaimReward, arg_8_0._onOneClickClaimReward, arg_8_0)
end

function var_0_0._editableRemoveEvents(arg_9_0)
	arg_9_0:removeEventCb(RoleActivityController.instance, RoleActivityEvent.OneClickClaimReward, arg_9_0._onOneClickClaimReward, arg_9_0)
end

function var_0_0._onOneClickClaimReward(arg_10_0)
	if arg_10_0._actTaskMO.hasFinished or arg_10_0._actTaskMO.id == 0 then
		arg_10_0._playFinishAnin = true

		arg_10_0._animator:Play("finish", 0, 0)
	end
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0._animator
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0._scrollreward.parentGameObject = arg_12_0._view._csListScroll.gameObject
	arg_12_0._actTaskMO = arg_12_1

	local var_12_0 = RoleActivityTaskListModel.instance.instance:getRankDiff(arg_12_1)

	arg_12_0:_refreshUI()
	arg_12_0:_moveByRankDiff(var_12_0)
end

function var_0_0._moveByRankDiff(arg_13_0, arg_13_1)
	if arg_13_1 and arg_13_1 ~= 0 then
		if arg_13_0._rankDiffMoveId then
			ZProj.TweenHelper.KillById(arg_13_0._rankDiffMoveId)

			arg_13_0._rankDiffMoveId = nil
		end

		local var_13_0, var_13_1, var_13_2 = transformhelper.getLocalPos(arg_13_0.viewTrs)

		transformhelper.setLocalPosXY(arg_13_0.viewTrs, var_13_0, 165 * arg_13_1)

		arg_13_0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_13_0.viewTrs, 0, RoleActivityEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0._refreshUI(arg_14_0)
	local var_14_0 = arg_14_0._actTaskMO

	if not var_14_0 then
		return
	end

	local var_14_1 = var_14_0.id ~= 0

	gohelper.setActive(arg_14_0._gogetall, not var_14_1)
	gohelper.setActive(arg_14_0._gonormal, var_14_1)

	if var_14_1 then
		if arg_14_0._playFinishAnin then
			arg_14_0._playFinishAnin = false

			arg_14_0._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(arg_14_0._goallfinish, false)
		gohelper.setActive(arg_14_0._btnnotfinishbg, false)
		gohelper.setActive(arg_14_0._btnfinishbg, false)

		if var_14_0.finishCount > 0 or var_14_0.preFinish then
			gohelper.setActive(arg_14_0._goallfinish, true)
		elseif var_14_0.hasFinished then
			gohelper.setActive(arg_14_0._btnfinishbg, true)
		else
			gohelper.setActive(arg_14_0._btnnotfinishbg, true)
		end

		arg_14_0._txtnum.text = var_14_0.progress
		arg_14_0._txttotal.text = var_14_0.config.maxProgress
		arg_14_0._txttaskdes.text = var_14_0.config.taskDesc

		local var_14_2 = ItemModel.instance:getItemDataListByConfigStr(var_14_0.config.bonus)

		arg_14_0.item_list = var_14_2

		IconMgr.instance:getCommonPropItemIconList(arg_14_0, arg_14_0._onItemShow, var_14_2, arg_14_0._gorewards)
	end

	arg_14_0._scrollreward.horizontalNormalizedPosition = 0
end

function var_0_0._onItemShow(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_1:onUpdateMO(arg_15_2)
	arg_15_1:setConsume(true)
	arg_15_1:showStackableNum2()
	arg_15_1:isShowEffect(true)
	arg_15_1:setAutoPlay(true)
	arg_15_1:setCountFontSize(48)
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0._rankDiffMoveId then
		ZProj.TweenHelper.KillById(arg_16_0._rankDiffMoveId)

		arg_16_0._rankDiffMoveId = nil
	end
end

return var_0_0
