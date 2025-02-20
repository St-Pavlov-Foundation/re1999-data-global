module("modules.logic.room.entity.RoomEmptyBlockEntity", package.seeall)

slot0 = class("RoomEmptyBlockEntity", RoomBaseBlockEntity)

function slot0.ctor(slot0, slot1)
	slot5 = slot1

	uv0.super.ctor(slot0, slot5)

	slot0._nearWaveList = {}
	slot0._nearRiverList = {}

	for slot5 = 1, 6 do
		table.insert(slot0._nearWaveList, false)
		table.insert(slot0._nearRiverList, false)
	end
end

function slot0.getTag(slot0)
	return SceneTag.RoomEmptyBlock
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
end

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
end

function slot0.refreshLand(slot0)
	slot0:refreshWater()
	slot0:refreshWaveEffect()
end

function slot0.refreshWater(slot0)
end

function slot0.refreshBlock(slot0)
	uv0.super.refreshBlock(slot0)
end

function slot0.refreshWaveEffect(slot0)
	slot2 = slot0:getMO().hexPoint
	slot3 = slot0._nearWaveList
	slot4 = slot0._nearRiverList

	for slot9 = 1, 6 do
		slot10 = HexPoint.directions[slot9]
		slot11 = false
		slot12 = false

		if RoomMapBlockModel.instance:getBlockMO(slot2.x + slot10.x, slot2.y + slot10.y) and slot13:isInMapBlock() then
			slot11 = true
			slot12 = slot13:hasRiver(true)
		end

		slot3[slot9] = slot11
		slot4[slot9] = slot12
	end

	slot6, slot7, slot8 = RoomWaveHelper.getWaveList(slot3, slot4)
	slot9 = false
	slot10 = RoomEnum.EffectKey.BlockWaveEffectKeys

	for slot14 = 1, #slot6 do
		if not slot0.effect:isSameResByKey(slot10[slot14], slot6[slot14]) then
			slot0.effect:addParams({
				[slot10[slot14]] = {
					res = slot15,
					ab = slot8[slot14],
					localRotation = Vector3(0, (slot7[slot14] - 1) * 60, 0)
				}
			})

			slot9 = true
		end
	end

	for slot14 = #slot6 + 1, 6 do
		if slot0.effect:getEffectRes(slot10[slot14]) then
			slot0.effect:removeParams({
				slot10[slot14]
			})

			slot9 = true
		end
	end

	if slot9 then
		slot0.effect:refreshEffect()
	end
end

function slot0.beforeDestroy(slot0)
	uv0.super.beforeDestroy(slot0)
end

function slot0.getMO(slot0)
	return RoomMapBlockModel.instance:getEmptyBlockMOById(slot0.id)
end

return slot0
