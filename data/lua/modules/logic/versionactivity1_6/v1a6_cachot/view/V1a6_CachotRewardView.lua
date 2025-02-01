module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRewardView", package.seeall)

slot0 = class("V1a6_CachotRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._goScroll = gohelper.findChild(slot0.viewGO, "scroll_view")
	slot0._scrollRect = gohelper.findChildScrollRect(slot0.viewGO, "scroll_view")
	slot0._rewarditem = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/Content/rewarditem")
	slot0._rewarditemParent = slot0._rewarditem.transform.parent.gameObject
	slot0._btnexit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_exit")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnexit:AddClickListener(slot0._onClickExit, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventChange, slot0._refreshView, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectEventRemove, slot0._onRemoveEvent, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnReceiveFightReward, slot0._checkCloseView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, slot0._playOpenAnim, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnexit:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectEventChange, slot0._refreshView, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectEventRemove, slot0._onRemoveEvent, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnReceiveFightReward, slot0._checkCloseView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, slot0._playOpenAnim, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
	slot0:_refreshView()

	slot0._scrollRect.horizontalNormalizedPosition = 0
end

function slot0._onRemoveEvent(slot0, slot1)
	if slot1 and slot1 ~= slot0.viewParam then
		return
	end

	if not slot0.viewParam:getDropList() or #slot2 == 0 then
		slot0._isAllRewardGeted = true
	end
end

function slot0._checkCloseView(slot0)
	if slot0._isAllRewardGeted then
		slot0:closeThis()
	end
end

function slot0._refreshView(slot0, slot1)
	if slot1 and slot1 ~= slot0.viewParam then
		return
	end

	if not slot0.viewParam:getDropList() or #slot2 == 0 then
		slot0:closeThis()

		return
	end

	gohelper.CreateObjList(slot0, slot0._setitem, slot2, slot0._rewarditemParent, slot0._rewarditem, V1a6_CachotRewardItem)
end

function slot0._setitem(slot0, slot1, slot2, slot3)
	slot1:updateMo(slot2, slot0._goScroll)
end

function slot0._onClickExit(slot0)
	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.CachotAbandonAward, MsgBoxEnum.BoxType.Yes_No, luaLang("cachot_abandon_award"), nil, , , slot0.abandonAward, nil, , slot0, nil, )
end

function slot0._playOpenAnim(slot0)
	gohelper.setActive(slot0.viewGO, false)
	gohelper.setActive(slot0.viewGO, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_open)
end

function slot0.abandonAward(slot0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventId, slot0.closeThis, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
