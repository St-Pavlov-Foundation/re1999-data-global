module("modules.logic.versionactivity1_9.lucy.view.ActLucyTaskItem", package.seeall)

slot0 = class("ActLucyTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._scrollreward = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	slot0._goallfinish = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_getall/#simage_getallbg")
	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)

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
	RoleActivityController.instance:dispatchEvent(RoleActivityEvent.TabSwitch, slot0._actTaskMO.config.listenerType ~= "StoryFinish")
	ViewMgr.instance:closeView(ViewName.ActLucyTaskView)
end

function slot0._btnfinishbgOnClick(slot0)
	if RoleActivityController.instance:delayReward(RoleActivityEnum.AnimatorTime.TaskReward, slot0._actTaskMO) then
		slot0:_onOneClickClaimReward()
	end
end

function slot0._btngetallOnClick(slot0)
	if RoleActivityController.instance:delayReward(RoleActivityEnum.AnimatorTime.TaskReward, slot0._actTaskMO) then
		RoleActivityController.instance:dispatchEvent(RoleActivityEvent.OneClickClaimReward)
	end
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.viewTrs = slot0.viewGO.transform
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(RoleActivityController.instance, RoleActivityEvent.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(RoleActivityController.instance, RoleActivityEvent.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
end

function slot0._onOneClickClaimReward(slot0)
	if slot0._actTaskMO.hasFinished or slot0._actTaskMO.id == 0 then
		slot0._playFinishAnin = true

		slot0._animator:Play("finish", 0, 0)
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._scrollreward.parentGameObject = slot0._view._csListScroll.gameObject
	slot0._actTaskMO = slot1

	slot0:_refreshUI()
	slot0:_moveByRankDiff(RoleActivityTaskListModel.instance.instance:getRankDiff(slot1))
end

function slot0._moveByRankDiff(slot0, slot1)
	if slot1 and slot1 ~= 0 then
		if slot0._rankDiffMoveId then
			ZProj.TweenHelper.KillById(slot0._rankDiffMoveId)

			slot0._rankDiffMoveId = nil
		end

		slot2, slot3, slot4 = transformhelper.getLocalPos(slot0.viewTrs)

		transformhelper.setLocalPosXY(slot0.viewTrs, slot2, 165 * slot1)

		slot0._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(slot0.viewTrs, 0, RoleActivityEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._refreshUI(slot0)
	if not slot0._actTaskMO then
		return
	end

	slot2 = slot1.id ~= 0

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

		if slot1.finishCount > 0 or slot1.preFinish then
			gohelper.setActive(slot0._goallfinish, true)
		elseif slot1.hasFinished then
			gohelper.setActive(slot0._btnfinishbg, true)
		else
			gohelper.setActive(slot0._btnnotfinishbg, true)
		end

		slot0._txtnum.text = slot1.progress
		slot0._txttotal.text = slot1.config.maxProgress
		slot0._txttaskdes.text = slot1.config.taskDesc
		slot3 = ItemModel.instance:getItemDataListByConfigStr(slot1.config.bonus)
		slot0.item_list = slot3

		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, slot3, slot0._gorewards)
	end

	slot0._scrollreward.horizontalNormalizedPosition = 0
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

return slot0
