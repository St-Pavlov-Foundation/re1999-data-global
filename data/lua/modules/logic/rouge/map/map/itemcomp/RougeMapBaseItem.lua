module("modules.logic.rouge.map.map.itemcomp.RougeMapBaseItem", package.seeall)

slot0 = class("RougeMapBaseItem", UserDataDispose)

function slot0.init(slot0)
	slot0:__onInit()

	slot0.id = nil
	slot0.scenePos = nil
end

function slot0.setId(slot0, slot1)
	slot0.id = slot1
end

function slot0.getScenePos(slot0)
	return slot0.scenePos
end

function slot0.getMapPos(slot0)
	return 0, 0, 0
end

function slot0.getActorPos(slot0)
	return 0, 0, 0
end

function slot0.getUiPos(slot0, slot1)
	return recthelper.worldPosToAnchorPos2(slot0:getScenePos(), slot1)
end

function slot0.getClickArea(slot0)
	return Vector4(100, 100, 0, 0)
end

function slot0.checkInClickArea(slot0, slot1, slot2, slot3)
	if not slot0:isActive() then
		return
	end

	slot4, slot5 = slot0:getUiPos(slot3)
	slot6 = slot0:getClickArea()
	slot8 = slot6.y / 2
	slot5 = slot5 + slot6.w

	if slot1 >= slot4 + slot6.z - slot6.x / 2 and slot1 <= slot4 + slot7 and slot2 >= slot5 - slot8 and slot2 <= slot5 + slot8 then
		return true
	end
end

function slot0.onClick(slot0)
end

function slot0.isActive(slot0)
	return true
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0
