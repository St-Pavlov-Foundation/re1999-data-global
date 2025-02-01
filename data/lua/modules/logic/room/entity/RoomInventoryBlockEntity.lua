module("modules.logic.room.entity.RoomInventoryBlockEntity", package.seeall)

slot0 = class("RoomInventoryBlockEntity", RoomBaseBlockEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1.entityId)

	slot0.isWaterReform = slot1.isWaterReform
end

function slot0.getTag(slot0)
	return SceneTag.RoomInventoryBlock
end

function slot0.init(slot0, slot1)
	slot0._scene = GameSceneMgr.instance:getCurScene()

	uv0.super.init(slot0, slot1)
end

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
end

function slot0.onReviseResParams(slot0, slot1)
	slot1.layer = UnityLayer.SceneOrthogonalOpaque
	slot1.batch = false
	slot1.highlight = false
	slot1.isInventory = true
end

function slot0.onEffectRebuild(slot0)
	uv0.super.onEffectRebuild(slot0)
	slot0:_refreshLinkGO()
	slot0._scene.inventorymgr:refreshInventoryBlock()
end

function slot0._refreshLinkGO(slot0)
	if not slot0:getMO() then
		return
	end

	slot2 = RoomEnum.EffectKey.BlockLandKey

	for slot7 = 1, #slot1:getResourceList() do
		if RoomResourceEnum.ResourceLinkGOPath[slot3[slot7]] and RoomResourceEnum.ResourceLinkGOPath[slot8][slot7] and slot0.effect:getGameObjectByPath(slot2, RoomResourceEnum.ResourceLinkGOPath[slot8][slot7]) then
			gohelper.setActive(slot9, false)
		end
	end

	if RoomBlockEnum.BlockLinkEffectGOPath[slot1:getDefineBlockType()] and slot0.effect:getGameObjectByPath(slot2, RoomBlockEnum.BlockLinkEffectGOPath[slot4]) then
		gohelper.setActive(slot5, false)
	end

	if slot0.effect:getGameObjectsByName(slot2, RoomEnum.EntityChildKey.NightLightGOKey) then
		for slot9, slot10 in ipairs(slot5) do
			gohelper.setActive(slot10, false)
		end
	end
end

function slot0.refreshRotation(slot0, slot1)
	uv0.super.refreshRotation(slot0, slot1)
	slot0._scene.inventorymgr:refreshInventoryBlock()
end

function slot0.getMO(slot0)
	if slot0.isWaterReform then
		if not slot0._waterBlockMO then
			slot1 = RoomBlockMO.New()

			slot1:init(RoomConfig.instance:getWaterReformTypeBlockCfg(RoomConfig.instance:getWaterTypeByBlockId(slot0.id)))

			slot1.blockState = RoomBlockEnum.BlockState.WaterReform

			if slot1.defineId == RoomBlockEnum.EmptyDefineId then
				slot1.rotate = math.random(0, 6)
			end

			slot0._waterBlockMO = slot1
		end

		return slot0._waterBlockMO
	else
		return RoomInventoryBlockModel.instance:getInventoryBlockMOById(slot0.id)
	end
end

return slot0
