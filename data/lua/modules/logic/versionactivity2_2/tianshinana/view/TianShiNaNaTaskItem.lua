module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTaskItem", package.seeall)

local var_0_0 = class("TianShiNaNaTaskItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simagenormalbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_normalbg")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	arg_1_0._txttaskdes = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_taskdes")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._btnnotfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_notfinishbg")
	arg_1_0._gonojump = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_nojump")
	arg_1_0._btnfinishbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_normal/#btn_finishbg")
	arg_1_0._goallfinish = gohelper.findChild(arg_1_0.viewGO, "#go_normal/#go_allfinish")
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
	if arg_4_0._act167TaskMO.config.jumpId > 0 then
		GameFacade.jump(arg_4_0._act167TaskMO.config.jumpId)
	end
end

function var_0_0._btnfinishbgOnClick(arg_5_0)
	arg_5_0:_onOneClickClaimReward(arg_5_0._act167TaskMO.activityId)
	UIBlockHelper.instance:startBlock("TianShiNaNaTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(arg_5_0._delayFinish, arg_5_0, 0.5)
end

function var_0_0._btngetallOnClick(arg_6_0)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.OneClickClaimReward, arg_6_0._act167TaskMO.activityId)
	UIBlockHelper.instance:startBlock("TianShiNaNaTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(arg_6_0._delayFinishAll, arg_6_0, 0.5)
end

function var_0_0._delayFinish(arg_7_0)
	TaskRpc.instance:sendFinishTaskRequest(arg_7_0._act167TaskMO.config.id)
end

function var_0_0._delayFinishAll(arg_8_0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity167)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._animator = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0.viewTrs = arg_9_0.viewGO.transform
	arg_9_0._scrollRewards = gohelper.findChildComponent(arg_9_0.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function var_0_0._editableAddEvents(arg_10_0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.OneClickClaimReward, arg_10_0._onOneClickClaimReward, arg_10_0)
end

function var_0_0._editableRemoveEvents(arg_11_0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.OneClickClaimReward, arg_11_0._onOneClickClaimReward, arg_11_0)
end

function var_0_0._onOneClickClaimReward(arg_12_0, arg_12_1)
	if arg_12_0._act167TaskMO and arg_12_0._act167TaskMO.activityId == arg_12_1 and arg_12_0._act167TaskMO:alreadyGotReward() then
		arg_12_0._playFinishAnin = true

		arg_12_0._animator:Play("finish", 0, 0)
	end
end

function var_0_0.getAnimator(arg_13_0)
	return arg_13_0._animator
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._act167TaskMO = arg_14_1

	local var_14_0 = TianShiNaNaTaskListModel.instance:getRankDiff(arg_14_1)

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
	local var_17_0 = arg_17_0._act167TaskMO

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.id ~= -99999

	gohelper.setActive(arg_17_0._gogetall, not var_17_1)
	gohelper.setActive(arg_17_0._gonormal, var_17_1)

	if var_17_1 then
		if arg_17_0._playFinishAnin then
			arg_17_0._playFinishAnin = false

			arg_17_0._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(arg_17_0._goallfinish, false)
		gohelper.setActive(arg_17_0._btnnotfinishbg, false)
		gohelper.setActive(arg_17_0._btnfinishbg, false)
		gohelper.setActive(arg_17_0._gonojump, false)

		if var_17_0:isFinished() then
			gohelper.setActive(arg_17_0._goallfinish, true)
		elseif var_17_0:alreadyGotReward() then
			gohelper.setActive(arg_17_0._btnfinishbg, true)
		elseif var_17_0.config.jumpId > 0 then
			gohelper.setActive(arg_17_0._btnnotfinishbg, true)
		else
			gohelper.setActive(arg_17_0._gonojump, true)
		end

		local var_17_2 = var_17_0.config and var_17_0.config.offestProgress or 0

		arg_17_0._txtnum.text = math.max(var_17_0:getFinishProgress() + var_17_2, 0)
		arg_17_0._txttotal.text = math.max(var_17_0:getMaxProgress() + var_17_2, 0)
		arg_17_0._txttaskdes.text = var_17_0.config and var_17_0.config.desc or ""

		local var_17_3 = DungeonConfig.instance:getRewardItems(tonumber(var_17_0.config.bonus))
		local var_17_4 = {}

		for iter_17_0, iter_17_1 in ipairs(var_17_3) do
			var_17_4[iter_17_0] = {
				isIcon = true,
				materilType = iter_17_1[1],
				materilId = iter_17_1[2],
				quantity = iter_17_1[3]
			}
		end

		arg_17_0.item_list = var_17_4

		IconMgr.instance:getCommonPropItemIconList(arg_17_0, arg_17_0._onItemShow, var_17_4, arg_17_0._gorewards)

		arg_17_0._scrollRewards.horizontalNormalizedPosition = 0
	end
end

function var_0_0._onItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_1:onUpdateMO(arg_18_2)
	arg_18_1:setConsume(true)
	arg_18_1:showStackableNum2()
	arg_18_1:isShowEffect(true)
	arg_18_1:setAutoPlay(true)
	arg_18_1:setCountFontSize(48)
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0._rankDiffMoveId then
		ZProj.TweenHelper.KillById(arg_19_0._rankDiffMoveId)

		arg_19_0._rankDiffMoveId = nil
	end
end

var_0_0.prefabPath = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_taskitem.prefab"

return var_0_0
