module("modules.logic.versionactivity1_5.aizila.view.AiZiLaTaskItem", package.seeall)

local var_0_0 = class("AiZiLaTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
	arg_1_0._gomainTaskTitle = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_mainTaskTitle")
	arg_1_0._gotaskTitle = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_taskTitle")
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
	if arg_4_0._aizilaTaskMO then
		local var_4_0 = arg_4_0._aizilaTaskMO.config.episodeId

		if AiZiLaModel.instance:getEpisodeMO(var_4_0) then
			AiZiLaModel.instance:setCurEpisodeId(var_4_0)
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.SelectEpisode)
			AiZiLaController.instance:openEpsiodeDetailView(var_4_0)
		else
			AiZiLaHelper.showToastByEpsodeId(var_4_0)
		end
	end
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	if AiZiLaController.instance:delayReward(AiZiLaEnum.AnimatorTime.TaskReward, arg_5_0._aizilaTaskMO) then
		arg_5_0:_onOneClickClaimReward(arg_5_0._aizilaTaskMO.activityId)
	end
end

function var_0_0._btngetallOnClick(arg_6_0)
	if AiZiLaController.instance:delayReward(AiZiLaEnum.AnimatorTime.TaskReward, arg_6_0._aizilaTaskMO) then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.OneClickClaimReward, arg_6_0._aizilaTaskMO.activityId)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._initAnim = true
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	arg_7_0.viewTrs = arg_7_0.viewGO.transform
	arg_7_0._gonormalTrs = arg_7_0._gonormal.transform
	arg_7_0._scrollRewards = gohelper.findChildComponent(arg_7_0.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function var_0_0._editableAddEvents(arg_8_0)
	AiZiLaController.instance:registerCallback(AiZiLaEvent.OneClickClaimReward, arg_8_0._onOneClickClaimReward, arg_8_0)
end

function var_0_0._editableRemoveEvents(arg_9_0)
	AiZiLaController.instance:unregisterCallback(AiZiLaEvent.OneClickClaimReward, arg_9_0._onOneClickClaimReward, arg_9_0)
end

function var_0_0._onOneClickClaimReward(arg_10_0, arg_10_1)
	if arg_10_0._aizilaTaskMO and arg_10_0._aizilaTaskMO.activityId == arg_10_1 and arg_10_0._aizilaTaskMO:alreadyGotReward() then
		arg_10_0._playFinishAnin = true

		arg_10_0._animator:Play("finish", 0, 0)
	end
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0._animator
end

function var_0_0._onInitOpenAnim(arg_12_0)
	if not arg_12_0.__isRunInitAnim then
		arg_12_0.__isRunInitAnim = true

		if arg_12_0._index and arg_12_0._index <= 5 then
			arg_12_0:_playAnim(UIAnimationName.Open, true)

			arg_12_0._isHasOpenAnimTask = true

			TaskDispatcher.runDelay(arg_12_0._playInitOpenAnim, arg_12_0, 0.05 + 0.06 * arg_12_0._index)
		end
	end
end

function var_0_0._playInitOpenAnim(arg_13_0)
	arg_13_0:_playAnim(UIAnimationName.Open, false)
end

function var_0_0._playAnim(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:getAnimator()

	if var_14_0 then
		var_14_0.speed = arg_14_2 and 0 or 1

		var_14_0:Play(arg_14_1, 0, arg_14_3 and 1 or 0)
		var_14_0:Update(0)
	end
end

function var_0_0.onUpdateMO(arg_15_0, arg_15_1)
	arg_15_0:_onInitOpenAnim()

	arg_15_0._aizilaTaskMO = arg_15_1

	local var_15_0 = AiZiLaTaskListModel.instance:getRankDiff(arg_15_1)

	arg_15_0._scrollRewards.parentGameObject = arg_15_0._view._csMixScroll.gameObject

	arg_15_0:_refreshUI()
	arg_15_0:_moveByRankDiff(var_15_0)
end

function var_0_0._moveByRankDiff(arg_16_0, arg_16_1)
	if arg_16_1 and arg_16_1 ~= 0 then
		if arg_16_0._rankDiffMoveId then
			ZProj.TweenHelper.KillById(arg_16_0._rankDiffMoveId)

			arg_16_0._rankDiffMoveId = nil
		end

		local var_16_0, var_16_1, var_16_2 = transformhelper.getLocalPos(arg_16_0.viewTrs)

		transformhelper.setLocalPosXY(arg_16_0.viewTrs, var_16_0, AiZiLaEnum.UITaskItemHeight.ItemCell * arg_16_1)

		arg_16_0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(arg_16_0.viewTrs, 0, AiZiLaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function var_0_0.onSelect(arg_17_0, arg_17_1)
	return
end

function var_0_0._getOffsetY(arg_18_0)
	if arg_18_0._aizilaTaskMO and arg_18_0._aizilaTaskMO.showTypeTab then
		return AiZiLaEnum.UITaskItemHeight.ItemTab * -0.5
	end

	return 0
end

function var_0_0._refreshUI(arg_19_0)
	local var_19_0 = arg_19_0._aizilaTaskMO

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0.id ~= AiZiLaEnum.TaskMOAllFinishId

	gohelper.setActive(arg_19_0._gogetall, not var_19_1)
	gohelper.setActive(arg_19_0._gonormal, var_19_1)

	if var_19_1 then
		if arg_19_0._playFinishAnin then
			arg_19_0._playFinishAnin = false

			arg_19_0._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(arg_19_0._goallfinish, false)
		gohelper.setActive(arg_19_0._btnnotfinishbg, false)
		gohelper.setActive(arg_19_0._btnfinishbg, false)
		gohelper.setActive(arg_19_0._gomainTaskTitle, var_19_0.showTypeTab and var_19_0:isMainTask())
		gohelper.setActive(arg_19_0._gotaskTitle, var_19_0.showTypeTab and not var_19_0:isMainTask())
		transformhelper.setLocalPosXY(arg_19_0._gonormalTrs, 0, arg_19_0:_getOffsetY())

		if var_19_0:isFinished() then
			gohelper.setActive(arg_19_0._goallfinish, true)
		elseif var_19_0:alreadyGotReward() then
			gohelper.setActive(arg_19_0._btnfinishbg, true)
		else
			gohelper.setActive(arg_19_0._btnnotfinishbg, true)
		end

		local var_19_2 = var_19_0.config and var_19_0.config.offestProgress or 0

		arg_19_0._txtnum.text = math.max(var_19_0:getFinishProgress() + var_19_2, 0)
		arg_19_0._txttotal.text = math.max(var_19_0:getMaxProgress() + var_19_2, 0)
		arg_19_0._txttaskdes.text = var_19_0.config and var_19_0.config.desc or ""

		local var_19_3 = ItemModel.instance:getItemDataListByConfigStr(var_19_0.config.bonus)

		arg_19_0.item_list = var_19_3

		IconMgr.instance:getCommonPropItemIconList(arg_19_0, arg_19_0._onItemShow, var_19_3, arg_19_0._gorewards)

		arg_19_0._scrollRewards.horizontalNormalizedPosition = 0
	end
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

	if arg_21_0._playInitOpenAnimTask then
		arg_21_0._playInitOpenAnimTask = nil

		TaskDispatcher.cancelTask(arg_21_0._playInitOpenAnim, arg_21_0)
	end
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_taskitem.prefab"

return var_0_0
