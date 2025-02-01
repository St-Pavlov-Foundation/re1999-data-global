module("modules.logic.room.entity.comp.RoomCharacterSpineEffectComp", package.seeall)

slot0 = class("RoomCharacterSpineEffectComp", RoomBaseSpineEffectComp)

function slot0.onInit(slot0, slot1)
	slot2 = slot0.entity:getMO()
	slot0._skinId = slot2.skinId
	slot0._heroId = slot2.heroId
end

function slot0._logNotPoint(slot0, slot1)
	logNormal(string.format("[export_角色交互特效] 角色挂点找不到, heroId:%s skinId:%s  id:%s  animName:%s point:%s", slot0._heroId, slot0._skinId, slot1.id, slot1.animName, slot1.point))
end

function slot0._logResError(slot0, slot1)
	logError(string.format("RoomCharacterSpineEffectComp 加载失败, heroId:%s skinId:%s  id:%s  animName:%s  effectRes:%s", slot0._heroId, slot0._skinId, slot1.id, slot1.animName, slot1.effectRes))
end

function slot0.getEffectCfgList(slot0)
	slot2 = {}

	if RoomConfig.instance:getCharacterEffectList(slot0.entity:getMO() and slot1.skinId) then
		for slot7, slot8 in ipairs(slot3) do
			if not RoomCharacterEnum.maskInteractAnim[slot8.animName] then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

function slot0.getSpineComp(slot0)
	return slot0.entity.characterspine
end

function slot0.onPlayShowEffect(slot0, slot1, slot2, slot3)
	slot0:_specialIdleEffect(slot1, slot2, slot3)
end

function slot0._specialIdleEffect(slot0, slot1, slot2, slot3)
	if RoomCharacterEnum.CharacterAnimStateName.SpecialIdle == slot1 and slot0._prefabNameDict then
		slot4 = slot0._prefabNameDict[slot3]

		gohelper.setActive(gohelper.findChild(slot2, slot4 .. "_r"), slot0.entity.characterspine:getLookDir() == SpineLookDir.Left)
		gohelper.setActive(gohelper.findChild(slot2, slot4 .. "_l"), slot5 == SpineLookDir.Right)
	end
end

return slot0
