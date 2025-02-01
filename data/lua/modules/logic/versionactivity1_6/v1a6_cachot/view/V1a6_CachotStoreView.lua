module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreView", package.seeall)

slot0 = class("V1a6_CachotStoreView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnexit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_exit")
end

function slot0.addEvents(slot0)
	slot0._btnexit:AddClickListener(slot0._onClickExit, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateGoodsInfos, slot0._refreshView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnexit:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateGoodsInfos, slot0._refreshView, slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_store_open)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	V1a6_CachotStoreListModel.instance:setList(V1a6_CachotModel.instance:getGoodsInfos() or {})
end

function slot0._onClickExit(slot0)
	RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, slot0.viewParam.eventId, slot0.closeThis, slot0)
end

return slot0
