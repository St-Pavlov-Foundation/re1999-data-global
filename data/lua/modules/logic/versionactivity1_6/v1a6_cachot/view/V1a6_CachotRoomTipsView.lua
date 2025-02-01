module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTipsView", package.seeall)

slot0 = class("V1a6_CachotRoomTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._txtRoomInfo = gohelper.findChildTextMesh(slot0.viewGO, "#go_tips/#txt_mapname")
	slot0._txtRoomNameEn = gohelper.findChildTextMesh(slot0.viewGO, "#go_tips/#txt_mapnameen")
	slot0._tipsAnim = slot0._gotips:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEvents(slot0)
	slot0.viewContainer:registerCallback(V1a6_CachotEvent.RoomChangeAnimEnd, slot0.showRoomInfo, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0.viewContainer:unregisterCallback(V1a6_CachotEvent.RoomChangeAnimEnd, slot0.showRoomInfo, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gotips, false)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.LoadingView or slot1 == ViewName.V1a6_CachotLoadingView or slot1 == ViewName.V1a6_CachotLayerChangeView then
		slot0:showRoomInfo()
	end
end

function slot0.showRoomInfo(slot0)
	if ViewMgr.instance:isOpen(ViewName.LoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLoadingView) or ViewMgr.instance:isOpen(ViewName.V1a6_CachotLayerChangeView) then
		return
	end

	gohelper.setActive(slot0._gotips, true)
	slot0._tipsAnim:Play("go_mapname_in", 0, 0)

	slot1 = V1a6_CachotModel.instance:getRogueInfo().room
	slot2 = lua_rogue_room.configDict[slot1]
	slot3, slot4 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(slot1)
	slot0._txtRoomInfo.text = string.format("%s（%d/%d）", slot2.name, slot3, slot4)
	slot0._txtRoomNameEn.text = slot2.nameEn

	TaskDispatcher.cancelTask(slot0.playHideTipsGo, slot0)
	TaskDispatcher.cancelTask(slot0.hideTipsGo, slot0)
	TaskDispatcher.runDelay(slot0.playHideTipsGo, slot0, 4.167)
end

function slot0.playHideTipsGo(slot0)
	if not slot0._tipsAnim then
		return
	end

	slot0._tipsAnim:Play("go_mapname_out", 0, 0)
	TaskDispatcher.runDelay(slot0.hideTipsGo, slot0, 0.433)
end

function slot0.hideTipsGo(slot0)
	gohelper.setActive(slot0._gotips, false)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.playHideTipsGo, slot0)
	TaskDispatcher.cancelTask(slot0.hideTipsGo, slot0)
end

return slot0
