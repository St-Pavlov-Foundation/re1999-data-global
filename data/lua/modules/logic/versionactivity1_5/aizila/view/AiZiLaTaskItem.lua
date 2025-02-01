module("modules.logic.versionactivity1_5.aizila.view.AiZiLaTaskItem", package.seeall)

slot0 = class("AiZiLaTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg")
	slot0._goallfinish = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0._gomainTaskTitle = gohelper.findChild(slot0.viewGO, "#go_normal/#go_mainTaskTitle")
	slot0._gotaskTitle = gohelper.findChild(slot0.viewGO, "#go_normal/#go_taskTitle")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_getall/#simage_getallbg")
	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
	slot0._btngetall:AddClickListener(slot0._btngetallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
	slot0._btngetall:RemoveClickListener()
end

function slot0._btnnotfinishbgOnClick(slot0)
	if slot0._aizilaTaskMO then
		if AiZiLaModel.instance:getEpisodeMO(slot0._aizilaTaskMO.config.episodeId) then
			AiZiLaModel.instance:setCurEpisodeId(slot1)
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.SelectEpisode)
			AiZiLaController.instance:openEpsiodeDetailView(slot1)
		else
			AiZiLaHelper.showToastByEpsodeId(slot1)
		end
	end
end

function slot0._btnfinishbgOnClick(slot0)
	if AiZiLaController.instance:delayReward(AiZiLaEnum.AnimatorTime.TaskReward, slot0._aizilaTaskMO) then
		slot0:_onOneClickClaimReward(slot0._aizilaTaskMO.activityId)
	end
end

function slot0._btngetallOnClick(slot0)
	if AiZiLaController.instance:delayReward(AiZiLaEnum.AnimatorTime.TaskReward, slot0._aizilaTaskMO) then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.OneClickClaimReward, slot0._aizilaTaskMO.activityId)
	end
end

function slot0._editableInitView(slot0)
	slot0._initAnim = true
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	slot0.viewTrs = slot0.viewGO.transform
	slot0._gonormalTrs = slot0._gonormal.transform
	slot0._scrollRewards = gohelper.findChildComponent(slot0.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function slot0._editableAddEvents(slot0)
	AiZiLaController.instance:registerCallback(AiZiLaEvent.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
end

function slot0._editableRemoveEvents(slot0)
	AiZiLaController.instance:unregisterCallback(AiZiLaEvent.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
end

function slot0._onOneClickClaimReward(slot0, slot1)
	if slot0._aizilaTaskMO and slot0._aizilaTaskMO.activityId == slot1 and slot0._aizilaTaskMO:alreadyGotReward() then
		slot0._playFinishAnin = true

		slot0._animator:Play("finish", 0, 0)
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0._onInitOpenAnim(slot0)
	if not slot0.__isRunInitAnim then
		slot0.__isRunInitAnim = true

		if slot0._index and slot0._index <= 5 then
			slot0:_playAnim(UIAnimationName.Open, true)

			slot0._isHasOpenAnimTask = true

			TaskDispatcher.runDelay(slot0._playInitOpenAnim, slot0, 0.05 + 0.06 * slot0._index)
		end
	end
end

function slot0._playInitOpenAnim(slot0)
	slot0:_playAnim(UIAnimationName.Open, false)
end

function slot0._playAnim(slot0, slot1, slot2, slot3)
	if slot0:getAnimator() then
		slot4.speed = slot2 and 0 or 1

		slot4:Play(slot1, 0, slot3 and 1 or 0)
		slot4:Update(0)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:_onInitOpenAnim()

	slot0._aizilaTaskMO = slot1
	slot0._scrollRewards.parentGameObject = slot0._view._csMixScroll.gameObject

	slot0:_refreshUI()
	slot0:_moveByRankDiff(AiZiLaTaskListModel.instance:getRankDiff(slot1))
end

function slot0._moveByRankDiff(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		if slot0._rankDiffMoveId then
			ZProj.TweenHelper.KillById(slot0._rankDiffMoveId)

			slot0._rankDiffMoveId = nil
		end

		slot2, slot3, slot4 = transformhelper.getLocalPos(slot0.viewTrs)

		transformhelper.setLocalPosXY(slot0.viewTrs, slot2, AiZiLaEnum.UITaskItemHeight.ItemCell * slot1)

		slot0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(slot0.viewTrs, 0, AiZiLaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0._getOffsetY(slot0)
	if slot0._aizilaTaskMO and slot0._aizilaTaskMO.showTypeTab then
		return AiZiLaEnum.UITaskItemHeight.ItemTab * -0.5
	end

	return 0
end

function slot0._refreshUI(slot0)
	if not slot0._aizilaTaskMO then
		return
	end

	slot2 = slot1.id ~= AiZiLaEnum.TaskMOAllFinishId

	gohelper.setActive(slot0._gogetall, not slot2)
	gohelper.setActive(slot0._gonormal, slot2)

	if slot2 then
		if slot0._playFinishAnin then
			slot0._playFinishAnin = false

			slot0._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(slot0._goallfinish, false)
		gohelper.setActive(slot0._btnnotfinishbg, false)
		gohelper.setActive(slot0._btnfinishbg, false)
		gohelper.setActive(slot0._gomainTaskTitle, slot1.showTypeTab and slot1:isMainTask())
		gohelper.setActive(slot0._gotaskTitle, slot1.showTypeTab and not slot1:isMainTask())
		transformhelper.setLocalPosXY(slot0._gonormalTrs, 0, slot0:_getOffsetY())

		if slot1:isFinished() then
			gohelper.setActive(slot0._goallfinish, true)
		elseif slot1:alreadyGotReward() then
			gohelper.setActive(slot0._btnfinishbg, true)
		else
			gohelper.setActive(slot0._btnnotfinishbg, true)
		end

		slot3 = slot1.config and slot1.config.offestProgress or 0
		slot0._txtnum.text = math.max(slot1:getFinishProgress() + slot3, 0)
		slot0._txttotal.text = math.max(slot1:getMaxProgress() + slot3, 0)
		slot0._txttaskdes.text = slot1.config and slot1.config.desc or ""
		slot4 = ItemModel.instance:getItemDataListByConfigStr(slot1.config.bonus)
		slot0.item_list = slot4

		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, slot4, slot0._gorewards)

		slot0._scrollRewards.horizontalNormalizedPosition = 0
	end
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
end

function slot0.onDestroyView(slot0)
	if slot0._rankDiffMoveId then
		ZProj.TweenHelper.KillById(slot0._rankDiffMoveId)

		slot0._rankDiffMoveId = nil
	end

	if slot0._playInitOpenAnimTask then
		slot0._playInitOpenAnimTask = nil

		TaskDispatcher.cancelTask(slot0._playInitOpenAnim, slot0)
	end
end

slot0.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_taskitem.prefab"

return slot0
