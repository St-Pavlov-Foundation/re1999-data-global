module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessTaskItem", package.seeall)

slot0 = class("Activity1_3ChessTaskItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._simagenormalbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_normal/#simage_normalbg")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num")
	slot0._txttotal = gohelper.findChildText(slot0.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	slot0._txttaskdes = gohelper.findChildText(slot0.viewGO, "#go_normal/#txt_taskdes")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	slot0.scrollReward = gohelper.findChild(slot0.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._btnnotfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_notfinishbg")
	slot0._btnfinishbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_normal/#btn_finishbg")
	slot0._goallfinish = gohelper.findChild(slot0.viewGO, "#go_normal/#go_allfinish")
	slot0._gogetall = gohelper.findChild(slot0.viewGO, "#go_getall")
	slot0._simagegetallbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_getall/#simage_getallbg")
	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_getall/#btn_getall")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	Activity1_3ChessController.instance:registerCallback(Activity1_3ChessEvent.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
	slot0._btnnotfinishbg:AddClickListener(slot0._btnnotfinishbgOnClick, slot0)
	slot0._btnfinishbg:AddClickListener(slot0._btnfinishbgOnClick, slot0)
	slot0._btngetall:AddClickListener(slot0._btngetallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	Activity1_3ChessController.instance:unregisterCallback(Activity1_3ChessEvent.OneClickClaimReward, slot0._onOneClickClaimReward, slot0)
	slot0._btnnotfinishbg:RemoveClickListener()
	slot0._btnfinishbg:RemoveClickListener()
	slot0._btngetall:RemoveClickListener()
end

function slot0._btnnotfinishbgOnClick(slot0)
	if not slot0._taskMO then
		return
	end

	if Activity1_3ChessController.instance:isEpisodeOpen(slot0._taskMO.config.episodeId) then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickEpisode, slot1)
	else
		Activity1_3ChessController.instance:showToastByEpsodeId(slot1)
	end
end

function slot0._btnfinishbgOnClick(slot0)
	Activity1_3ChessController.instance:delayRequestGetReward(0.2, slot0._taskMO)
	slot0:_onOneClickClaimReward()
end

function slot0._btngetallOnClick(slot0)
	Activity1_3ChessController.instance:delayRequestGetReward(0.2, slot0._taskMO)
	Activity1_3ChessController.instance:dispatchAllTaskItemGotReward()
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0._onOneClickClaimReward(slot0)
	if slot0._taskMO:haveRewardToGet() then
		slot0._playFinishAnin = true

		slot0._animator:Play("finish", 0, 0)
	end
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._taskMO = slot1
	slot0.scrollReward.parentGameObject = slot0._view._csListScroll.gameObject

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

slot1 = -100

function slot0._refreshUI(slot0)
	if not slot0._taskMO then
		return
	end

	slot2 = slot1.id ~= uv0

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

		if slot1:isFinished() then
			gohelper.setActive(slot0._btnfinishbg, true)
		elseif slot1:alreadyGotReward() then
			gohelper.setActive(slot0._goallfinish, true)
		else
			gohelper.setActive(slot0._btnnotfinishbg, true)
		end

		slot3 = slot1.config and slot1.config.offestProgress or 0
		slot0._txtnum.text = math.max(slot1:getProgress() + slot3, 0)
		slot0._txttotal.text = math.max(slot1:getMaxProgress() + slot3, 0)
		slot0._txttaskdes.text = slot1.config and slot1.config.desc or ""
		slot4 = ItemModel.instance:getItemDataListByConfigStr(slot1.config.bonus)
		slot0.item_list = slot4

		IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onItemShow, slot4, slot0._gorewards)
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
end

slot0.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_taskitem.prefab"

return slot0
