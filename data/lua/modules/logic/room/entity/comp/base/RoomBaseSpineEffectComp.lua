module("modules.logic.room.entity.comp.base.RoomBaseSpineEffectComp", package.seeall)

slot0 = class("RoomBaseSpineEffectComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._isHasEffectGODict = {}
	slot0._prefabNameDict = {}
	slot0._animNameDict = {}
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._effectCfgList = {}

	tabletool.addValues(slot0._effectCfgList, slot0:getEffectCfgList())
	slot0:onInit()
end

function slot0._logNotPoint(slot0, slot1)
end

function slot0._logResError(slot0, slot1)
end

function slot0.getEffectCfgList(slot0)
	return nil
end

function slot0.getSpineComp(slot0)
	return nil
end

function slot0.onPlayShowEffect(slot0, slot1, slot2, slot3)
end

function slot0.addResToLoader(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._effectCfgList) do
		slot1:addPath(slot0:_getEffecResAb(slot6.effectRes))
	end
end

function slot0._getEffecRes(slot0, slot1)
	return RoomResHelper.getCharacterEffectPath(slot1)
end

function slot0._getEffecResAb(slot0, slot1)
	return RoomResHelper.getCharacterEffectABPath(slot1)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.isHasEffectGO(slot0, slot1)
	if slot0._isHasEffectGODict[slot1] then
		return true
	end

	return false
end

function slot0.play(slot0, slot1)
	slot0._curAnimState = slot1

	if slot0._isHasEffectGODict[slot0._curAnimState] or slot0._isHasEffectGODict[slot1] then
		for slot6, slot7 in pairs(slot0._animEffectGODic) do
			gohelper.setActive(slot7, false)

			if slot0._animNameDict[slot6] == slot1 then
				gohelper.setActive(slot7, true)
				slot0:onPlayShowEffect(slot1, slot7, slot6)
			end
		end
	end
end

function slot0.spawnEffect(slot0, slot1)
	slot3 = slot0:getSpineComp() and slot2:getSpineGO()
	slot0._animEffectGODic = slot0._animEffectGODic or {}
	slot0._prefabNameDict = slot0._prefabNameDict or {}
	slot0._isHasEffectGODict = slot0._isHasEffectGODict or {}
	slot0._animNameDict = slot0._animNameDict or {}

	for slot7, slot8 in ipairs(slot0._effectCfgList) do
		if gohelper.isNil(slot0._animEffectGODic[slot8.id]) then
			slot12 = true

			if slot1:getAssetItem(slot0:_getEffecResAb(slot8.effectRes)) and slot11:GetResource(slot0:_getEffecRes(slot8.effectRes)) then
				slot12 = false

				if gohelper.isNil(gohelper.findChild(slot3, RoomCharacterHelper.getSpinePointPath(slot8.point))) then
					slot0:_logNotPoint(slot8)

					slot16 = slot3 or slot0.entity.containerGO
				end

				slot17 = slot14.name
				slot18 = gohelper.clone(slot14, slot16, slot17)
				slot0._animNameDict[slot9] = slot8.animName
				slot0._animEffectGODic[slot9] = slot18
				slot0._prefabNameDict[slot9] = slot17
				slot0._isHasEffectGODict[slot8.animName] = true

				gohelper.setActive(slot18, false)
			end

			if slot12 then
				slot0:_logResError(slot8)
			end
		end
	end
end

function slot0.clearEffect(slot0)
	if slot0._animEffectGODic then
		for slot4, slot5 in pairs(slot0._animEffectGODic) do
			rawset(slot0._animEffectGODic, slot4, nil)
			gohelper.destroy(slot5)
		end

		slot0._animEffectGODic = nil
		slot0._isHasEffectGODict = {}
		slot0._prefabNameDict = {}
		slot0._animNameDict = {}
	end
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
	slot0:clearEffect()
end

return slot0
