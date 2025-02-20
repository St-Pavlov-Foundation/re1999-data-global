module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaTaskItem", package.seeall)

slot0 = class("TianShiNaNaTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0._gonojump = gohelper.findChild(slot0.viewGO, "#go_normal/#go_nojump")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg")
	slot0._goallfinish = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
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
	if slot0._act167TaskMO.config.jumpId > 0 then
		GameFacade.jump(slot0._act167TaskMO.config.jumpId)
	end
end

function slot0._btnfinishbgOnClick(slot0)
	slot0:_onOneClickClaimReward(slot0._act167TaskMO.activityId)
	UIBlockHelper.instance:startBlock("TianShiNaNaTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(slot0._delayFinish, slot0, 0.5)
end

function slot0._btngetallOnClick(slot0)
	TianShiNaNaController.instance:dispatchEvent(TianShiNaNaEvent.OneClickClaimReward, slot0._act167TaskMO.activityId)
	UIBlockHelper.instance:startBlock("TianShiNaNaTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(slot0._delayFinishAll, slot0, 0.5)
end

function slot0._delayFinish(slot0)
	TaskRpc.instance:sendFinishTaskRequest(slot0._act167TaskMO.config.id)
end

function slot0._delayFinishAll(slot0)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity167)
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.viewTrs = slot0.viewGO.transform
	slot0._scrollRewards = gohelper.findChildComponent(slot0.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function slot0._editableAddEvents(slot0)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
end

function slot0._editableRemoveEvents(slot0)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
end

function slot0._onOneClickClaimReward(slot0, slot1)
	if slot0._act167TaskMO and slot0._act167TaskMO.activityId == slot1 and slot0._act167TaskMO:alreadyGotReward() then
		slot0._playFinishAnin = true

		slot0._animator:Play("finish", 0, 0)
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._act167TaskMO = slot1
	slot0._scrollRewards.parentGameObject = slot0._view._csListScroll.gameObject

	slot0:_refreshUI()
	slot0:_moveByRankDiff(TianShiNaNaTaskListModel.instance:getRankDiff(slot1))
end

function slot0._moveByRankDiff(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		if slot0._rankDiffMoveId then
			ZProj.TweenHelper.KillById(slot0._rankDiffMoveId)

			slot0._rankDiffMoveId = nil
		end

		slot2, slot3, slot4 = transformhelper.getLocalPos(slot0.viewTrs)

		transformhelper.setLocalPosXY(slot0.viewTrs, slot2, 165 * slot1)

		slot0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(slot0.viewTrs, 0, 0.15)
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0._refreshUI(slot0)
	if not slot0._act167TaskMO then
		return
	end

	slot2 = slot1.id ~= -99999

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
		gohelper.setActive(slot0._gonojump, false)

		if slot1:isFinished() then
			gohelper.setActive(slot0._goallfinish, true)
		elseif slot1:alreadyGotReward() then
			gohelper.setActive(slot0._btnfinishbg, true)
		elseif slot1.config.jumpId > 0 then
			gohelper.setActive(slot0._btnnotfinishbg, true)
		else
			gohelper.setActive(slot0._gonojump, true)
		end

		slot3 = slot1.config and slot1.config.offestProgress or 0
		slot0._txtnum.text = math.max(slot1:getFinishProgress() + slot3, 0)
		slot0._txttotal.text = math.max(slot1:getMaxProgress() + slot3, 0)
		slot0._txttaskdes.text = slot1.config and slot1.config.desc or ""
		slot9 = slot1.config.bonus
		slot5 = {
			[slot9] = {
				isIcon = true,
				materilType = slot10[1],
				materilId = slot10[2],
				quantity = slot10[3]
			}
		}

		for slot9, slot10 in ipairs(DungeonConfig.instance:getRewardItems(tonumber(slot9))) do
			-- Nothing
		end

		slot0.item_list = slot5

		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, slot5, slot0._gorewards)

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
end

slot0.prefabPath = "ui/viewres/versionactivity_2_2/v2a2_tianshinana/v2a2_tianshinana_taskitem.prefab"

return slot0
