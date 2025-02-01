module("modules.logic.room.view.critter.summon.RoomCritterSummonPoolItem", package.seeall)

slot0 = class("RoomCritterSummonPoolItem", ListScrollCellExtend)

function slot0.onUpdateMO(slot0, slot1)
	if not slot0._iconItem and IconMgr.instance:_getIconInstance(IconMgrConfig.UrlCritterIcon, slot0.viewGO) then
		slot0._iconItem = MonoHelper.addNoUpdateLuaComOnceToGo(slot2, RoomCritterSummonPoolIcon)
	end

	slot0._iconItem:onUpdateMO(slot1)
	slot0._iconItem:setCustomClick(slot0.onClicKCallback, slot0, slot1)
end

function slot0.onClicKCallback(slot0, slot1)
	CritterController.instance:openRoomCritterDetailView(true, slot1:getCritterMo(), true)
end

return slot0
