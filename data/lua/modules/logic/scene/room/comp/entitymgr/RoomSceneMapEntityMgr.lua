module("modules.logic.scene.room.comp.entitymgr.RoomSceneMapEntityMgr", package.seeall)

slot0 = class("RoomSceneMapEntityMgr", BaseSceneUnitMgr)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	for slot7, slot8 in ipairs(RoomMapBlockModel.instance:getBlockMOList()) do
		slot9 = nil

		if not ((slot8.blockState ~= RoomBlockEnum.BlockState.Water or slot0:getUnit(SceneTag.RoomEmptyBlock, slot8.id)) and slot0:getUnit(SceneTag.RoomMapBlock, slot8.id)) then
			slot0:spawnMapBlock(slot8)
		else
			slot0:_refreshBlockEntiy(slot9, slot8)
		end
	end

	if not slot0:getUnit(SceneTag.Untagged, 1) then
		slot0:_spawnBlockEffect(RoomEnum.EffectKey.BlockCanPlaceKey, RoomBlockCanPlaceEntity, 1)
	end
end

function slot0.onSwitchMode(slot0)
	slot1 = RoomMapBlockModel.instance

	for slot6, slot7 in ipairs({
		SceneTag.RoomEmptyBlock,
		SceneTag.RoomMapBlock
	}) do
		if slot0:getTagUnitDict(slot7) then
			slot9 = {}

			for slot13, slot14 in pairs(slot8) do
				slot15 = nil

				if not ((slot7 ~= SceneTag.RoomEmptyBlock or slot1:getEmptyBlockMOById(slot13)) and slot1:getFullBlockMOById(slot13)) then
					table.insert(slot9, slot13)
				end
			end

			for slot13 = 1, #slot9 do
				slot0:removeUnit(slot7, slot9[slot13])
			end
		end
	end
end

function slot0._spawnBlockEffect(slot0, slot1, slot2, slot3)
	slot4 = slot0._scene.go.blockRoot
	slot5 = gohelper.create3d(slot4, slot1)
	slot6 = MonoHelper.addNoUpdateLuaComOnceToGo(slot5, slot2, slot3)

	gohelper.addChild(slot4, slot5)
	slot0:addUnit(slot6)

	return slot6
end

function slot0.spawnMapBlock(slot0, slot1)
	slot2 = slot0._scene.go.blockRoot

	if not slot1.hexPoint then
		logError("RoomSceneMapEntityMgr: 没有位置信息")

		return
	end

	slot4 = gohelper.create3d(slot2, RoomResHelper.getBlockName(slot3))
	slot5 = nil
	slot5 = (slot1.blockState ~= RoomBlockEnum.BlockState.Water or MonoHelper.addNoUpdateLuaComOnceToGo(slot4, RoomEmptyBlockEntity, slot1.id)) and MonoHelper.addNoUpdateLuaComOnceToGo(slot4, RoomMapBlockEntity, slot1.id)

	slot0:addUnit(slot5)
	gohelper.addChild(slot2, slot4)
	slot0:_refreshBlockEntiy(slot5, slot1)

	return slot5
end

function slot0._refreshBlockEntiy(slot0, slot1, slot2)
	slot3 = HexMath.hexToPosition(slot2.hexPoint, RoomBlockEnum.BlockSize)

	slot1:setLocalPos(slot3.x, 0, slot3.y)
	slot1:refreshBlock()
	slot1:refreshRotation()
end

function slot0.moveTo(slot0, slot1, slot2)
	slot3 = HexMath.hexToPosition(slot2, RoomBlockEnum.BlockSize)

	slot1:setLocalPos(slot3.x, 0, slot3.y)
end

function slot0.destroyBlock(slot0, slot1)
	slot0:removeUnit(slot1:getTag(), slot1.id)
end

function slot0.getBlockEntity(slot0, slot1, slot2)
	slot3 = (not slot2 or slot2 == SceneTag.RoomMapBlock) and slot0:getTagUnitDict(SceneTag.RoomMapBlock)

	if slot3 and slot3[slot1] then
		return slot4
	end

	slot3 = (not slot2 or slot2 == SceneTag.RoomEmptyBlock) and slot0:getTagUnitDict(SceneTag.RoomEmptyBlock)

	return slot3 and slot3[slot1]
end

function slot0.getMapBlockEntityDict(slot0)
	return slot0._tagUnitDict[SceneTag.RoomMapBlock]
end

function slot0.getPropertyBlock(slot0)
	if not slot0._propertyBlock then
		slot0._propertyBlock = UnityEngine.MaterialPropertyBlock.New()
	end

	return slot0._propertyBlock
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)

	if slot0._propertyBlock then
		slot0._propertyBlock:Clear()

		slot0._propertyBlock = nil
	end
end

return slot0
