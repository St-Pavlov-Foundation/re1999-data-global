module("modules.logic.rouge.model.RougeCollectionSlotMO", package.seeall)

slot0 = pureTable("RougeCollectionSlotMO", RougeCollectionMO)
slot1 = class("RougeCollectionSlotMO", RougeCollectionMO)

function slot1.init(slot0, slot1)
	uv0.super.init(slot0, slot1.item)
	slot0:updateRotation(slot1.rotation)
	slot0:updateBaseEffects(slot1.baseEffects)
	slot0:updateEffectRelations(slot1.relations)
	slot0:updateLeftTopPos(slot1.pos and Vector2(tonumber(slot1.pos.col), tonumber(slot1.pos.row)) or Vector2(0, 0))
	slot0:updateAttrValues(slot1.attr)
end

function slot1.updateInfo(slot0, slot1)
	slot0:initBaseInfo(slot1)
end

function slot1.getCenterSlotPos(slot0)
	return slot0.centerSlotPos
end

function slot1.getLeftTopPos(slot0)
	return slot0.pos or Vector2(0, 0)
end

function slot1.getRotation(slot0)
	return slot0.rotation or RougeEnum.CollectionRotation.Rotation_0
end

function slot1.updateLeftTopPos(slot0, slot1)
	slot0.pos = slot1 or Vector2.zero
	slot0.centerSlotPos = RougeCollectionHelper.getCollectionCenterSlotPos(slot0.cfgId, slot0.rotation, slot0.pos)
end

function slot1.updateRotation(slot0, slot1)
	slot0.rotation = slot1 or RougeEnum.CollectionRotation.Rotation_0

	if slot0.centerSlotPos then
		slot0:updateLeftTopPos(RougeCollectionHelper.getCollectionTopLeftSlotPos(slot0.cfgId, slot0.centerSlotPos, slot0.rotation))
	end
end

function slot1.copyOtherMO(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:copyOtherCollectionMO(slot1)

	slot0.centerSlotPos = slot1.getCenterSlotPos and slot1:getCenterSlotPos() or Vector2.zero
	slot0.pos = slot1.getLeftTopPos and slot1:getLeftTopPos() or Vector2.zero
	slot0.rotation = slot1:getRotation()
end

function slot1.updateBaseEffects(slot0, slot1)
	slot0.baseEffects = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.baseEffects, slot6)
		end
	end
end

function slot1.getBaseEffects(slot0)
	return slot0.baseEffects
end

function slot1.getBaseEffectCount(slot0)
	return slot0.baseEffects and #slot0.baseEffects
end

function slot1.updateEffectRelations(slot0, slot1)
	slot0.effectRelations = {}
	slot0.effectRelationMap = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = RougeCollectionRelationMO.New()

			slot7:init(slot6)
			table.insert(slot0.effectRelations, slot7)

			slot0.effectRelationMap[slot8] = slot0.effectRelationMap[slot7.showType] or {}

			table.insert(slot0.effectRelationMap[slot8], slot7)
		end
	end
end

function slot1.getEffectShowTypeRelations(slot0, slot1)
	return slot0.effectRelationMap and slot0.effectRelationMap[slot1]
end

function slot1.isEffectActive(slot0, slot1)
	if slot0:getEffectShowTypeRelations(slot1) then
		for slot6, slot7 in ipairs(slot2) do
			if tabletool.indexOf(slot0.baseEffects, slot7.effectIndex) and slot8 > 0 then
				return true
			end
		end
	end

	return false
end

function slot1.reset(slot0)
	slot0.id = 0
	slot0.rotation = RougeEnum.CollectionRotation.Rotation_0
end

return slot1
