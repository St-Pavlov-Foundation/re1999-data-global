module("modules.logic.room.entity.comp.RoomBuildingInteractComp", package.seeall)

slot0 = class("RoomBuildingInteractComp", RoomBaseEffectKeyComp)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
end

function slot0.onRebuildEffectGO(slot0)
end

function slot0.onReturnEffectGO(slot0)
end

function slot0.startInteract(slot0)
	if not slot0.entity:getMO() then
		return
	end

	if not slot1:getInteractMO() then
		return
	end

	slot3 = slot2:getHeroIdList()

	if not RoomCameraController.instance:getRoomScene() then
		return
	end

	for slot8, slot9 in ipairs(slot3) do
		if slot4.charactermgr:getCharacterEntity(slot9, SceneTag.RoomCharacter) and slot10.interactActionComp then
			slot10.interactActionComp:startInteract(slot1.buildingUid, slot8, slot2.config.showTime * 0.001)
		end
	end

	if slot2.config and not string.nilorempty(slot2.config.buildingAnim) then
		slot0.entity:playAnimator(slot2.config.buildingAnim)
	end
end

function slot0.getPointGOByName(slot0, slot1)
	if slot0.entity.effect:getGameObjectsByName(slot0._effectKey, slot1) and #slot2 > 0 then
		return slot2[1]
	end
end

function slot0.getPointGOTrsByName(slot0, slot1)
	if slot0.entity.effect:getGameObjectsTrsByName(slot0._effectKey, slot1) and #slot2 > 0 then
		return slot2[1]
	end
end

return slot0
