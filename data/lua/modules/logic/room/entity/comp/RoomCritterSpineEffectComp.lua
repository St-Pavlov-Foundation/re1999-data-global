module("modules.logic.room.entity.comp.RoomCritterSpineEffectComp", package.seeall)

slot0 = class("RoomCritterSpineEffectComp", RoomBaseSpineEffectComp)

function slot0.onInit(slot0, slot1)
	slot2 = slot0.entity:getMO()
	slot0._critterId = slot2.critterId
	slot0._skinId = slot2:getSkinId()
end

function slot0._logNotPoint(slot0, slot1)
	logNormal(string.format("[export_魔精交互特效] 魔精挂点找不到, critterId:%s skinId:%s  id:%s  animName:%s point:%s", slot0._critterId, slot1.skinId, slot1.id, slot1.animName, slot1.point))
end

function slot0._logResError(slot0, slot1)
	logError(string.format("RoomCritterSpineEffectComp 加载失败, critterId:%s skinId:%s  id:%s  animName:%s  effectRes:%s", slot0._critterId, slot1.skinId, slot1.id, slot1.animName, slot1.effectRes))
end

function slot0.getEffectCfgList(slot0)
	if slot0.entity:getMO() then
		return CritterConfig.instance:getCritterEffectList(slot1:getSkinId())
	end
end

function slot0.play(slot0, slot1)
	uv0.super.play(slot0, slot1)

	if CritterConfig.instance:getCritterInteractionAudioList(slot0.entity:getMO() and slot2.critterId, slot1) then
		for slot8, slot9 in ipairs(slot4) do
			AudioMgr.instance:trigger(slot9, slot0.go)
		end
	end
end

function slot0.getSpineComp(slot0)
	return slot0.entity.critterspine
end

return slot0
