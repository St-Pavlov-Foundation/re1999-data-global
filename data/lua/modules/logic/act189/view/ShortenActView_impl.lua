module("modules.logic.act189.view.ShortenActView_impl", package.seeall)

slot0 = class("ShortenActView_impl", Activity189BaseView)

function slot0._getStyleItem(slot0, slot1)
	return slot0._styleItemList[slot1]
end

function slot0._getCurStyleId(slot0)
	if not slot0._curStyleId then
		slot0._curStyleId = slot0:getStyleCO().id
	end

	return slot0._curStyleId
end

function slot0._getCurStyleItem(slot0)
	return slot0:_getStyleItem(slot0:_getCurStyleId())
end

function slot0._editableInitView(slot0)
	if isDebugBuild then
		assert(slot0._txttime)
	end

	slot0._styleItemList = {}

	slot0:_regStyleItem(slot0._go28days, ShortenAct_28days, Activity189Enum.Style._28)
	slot0:_regStyleItem(slot0._go35days, ShortenAct_35days, Activity189Enum.Style._35)
end

function slot0._regStyleItem(slot0, slot1, slot2, slot3)
	slot4 = slot2.New({
		parent = slot0,
		baseViewContainer = slot0.viewContainer
	})

	slot4:setIndex(slot3)
	slot4:init(slot1)
	gohelper.setActive(slot1, slot0:_getCurStyleId() == slot3)

	slot0._styleItemList[slot3] = slot4

	return slot4
end

function slot0.onOpen(slot0)
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)
	uv0.super.onOpen(slot0)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189OnceBonusReply, slot0._onReceiveGetAct189OnceBonusReply, slot0)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, slot0._onReceiveGetAct189InfoReply, slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity.play_ui_mln_page_turn_20260901)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_styleItemList")
	uv0.super:onDestroyView(slot0)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189OnceBonusReply, slot0._onReceiveGetAct189OnceBonusReply, slot0)
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, slot0._onReceiveGetAct189InfoReply, slot0)
	uv0.super.onClose(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshTimeTick()
	slot0:_refreshStyleItem()
	uv0.super.onUpdateParam(slot0)
end

function slot0._refreshTimeTick(slot0)
	slot0._txttime.text = slot0:getRemainTimeStr()
end

function slot0._refreshStyleItem(slot0)
	slot0:_getCurStyleItem():onUpdateMO()
end

function slot0._onReceiveGetAct189OnceBonusReply(slot0)
	slot0:_refreshStyleItem()
end

function slot0._onReceiveGetAct189InfoReply(slot0)
	slot0:_refreshStyleItem()
end

function slot0.getStyleCO(slot0)
	return ShortenActConfig.instance:getStyleCO()
end

function slot0.getBonusList(slot0)
	return ShortenActConfig.instance:getBonusList()
end

function slot0.onItemClick(slot0)
	if slot0:isClaimable() then
		Activity189Controller.instance:sendGetAct189OnceBonusRequest(slot0:actId())

		return false
	end

	return true
end

function slot0.isClaimable(slot0)
	return ShortenActModel.instance:isClaimable()
end

return slot0
