module("modules.logic.versionactivity1_5.act142.view.Activity142TaskItem", package.seeall)

slot0 = class("Activity142TaskItem", ListScrollCellExtend)
slot1 = 0.2

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	slot0._scrollReward = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg")
	slot0._goallfinish = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity142Controller.instance:registerCallback(Activity142Event.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
	slot0._btngetall:AddClickListener(slot0._btngetallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	Activity142Controller.instance:unregisterCallback(Activity142Event.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
	slot0._btngetall:RemoveClickListener()
end

function slot0._onOneClickClaimReward(slot0)
	if slot0._taskMO:haveRewardToGet() then
		slot0._playFinishAnim = true

		slot0._animator:Play("finish", 0, 0)
	end
end

function slot0._btnnotfinishbgOnClick(slot0)
	if not slot0._taskMO then
		return
	end

	if Activity142Model.instance:isEpisodeOpen(Activity142Model.instance:getActivityId(), slot0._taskMO.config.episodeId) then
		Activity142Controller.instance:dispatchEvent(Activity142Event.ClickEpisode, slot1)
	else
		Activity142Helper.showToastByEpisodeId(slot1)
	end
end

function slot0._btnfinishbgOnClick(slot0)
	Activity142Controller.instance:delayRequestGetReward(uv0, slot0._taskMO)
	slot0:_onOneClickClaimReward()
end

function slot0._btngetallOnClick(slot0)
	Activity142Controller.instance:delayRequestGetReward(uv0, slot0._taskMO)
	Activity142Controller.instance:dispatchAllTaskItemGotReward()
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(Va3ChessEnum.ComponentType.Animator)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._taskMO = slot1
	slot0._scrollReward.parentGameObject = slot0._view._csListScroll.gameObject
	slot0._scrollReward.horizontalNormalizedPosition = 0

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if not slot0._taskMO then
		return
	end

	slot2 = slot1.id ~= Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID

	gohelper.setActive(slot0._gogetall, not slot2)
	gohelper.setActive(slot0._gonormal, slot2)

	if not slot2 then
		return
	end

	if slot0._playFinishAnim then
		slot0._playFinishAnim = false

		slot0._animator:Play("idle", 0, 1)
	end

	gohelper.setActive(slot0._btnfinishbg, false)
	gohelper.setActive(slot0._goallfinish, false)
	gohelper.setActive(slot0._btnnotfinishbg, false)

	if slot1:isFinished() then
		gohelper.setActive(slot0._btnfinishbg, true)
	elseif slot1:alreadyGotReward() then
		gohelper.setActive(slot0._goallfinish, true)
	else
		gohelper.setActive(slot0._btnnotfinishbg, true)
	end

	slot0._txtnum.text = slot1:getProgress()
	slot0._txttotal.text = slot1:getMaxProgress()
	slot0._txttaskdes.text = slot1.config and slot1.config.desc or ""

	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, ItemModel.instance:getItemDataListByConfigStr(slot1.config.bonus), slot0._gorewards)
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
end

return slot0
