module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayerNaNa", package.seeall)

slot0 = class("FightEntitySpecialEffectBuffLayerNaNa", FightEntitySpecialEffectBase)

function slot0.initClass(slot0)
	slot0.entity = slot0._entity
	slot0.entityId = slot0.entity.id
	slot0.curEffectWrap = nil

	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0.onBuffUpdate, slot0)
end

function slot0.onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot0.entityId then
		return
	end

	if slot2 ~= FightEnum.EffectType.BUFFUPDATE and slot2 ~= FightEnum.EffectType.BUFFADD then
		return
	end

	if not (lua_skill_buff.configDict[slot3] and slot5.typeId) then
		return
	end

	if not lua_fight_buff_layer_effect_nana.configDict[slot6] then
		return
	end

	if not (slot0.entity and slot0.entity:getMO()) then
		return
	end

	if not slot8:getBuffMO(slot4) then
		return
	end

	if not slot7[slot9.exInfo] then
		logError(string.format("Z战斗配置-buff层数特效 表没找到buffTypeId = `%s`, layer = `%s` 的配置", slot6, slot10))

		return
	end

	slot0:removeEffect()

	slot0.curEffectWrap = slot0.entity.effect:addHangEffect(slot7.effect, slot7.effectRoot, slot7.duration)

	slot0.curEffectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot1, slot0.curEffectWrap)

	if slot7.effectAudio > 0 then
		FightAudioMgr.instance:playAudio(slot13)
	end
end

function slot0.removeEffect(slot0)
	if slot0.curEffectWrap then
		slot0.entity.effect:removeEffect(slot0.curEffectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entityId, slot0.curEffectWrap)
	end
end

function slot0.releaseSelf(slot0)
	slot0:removeEffect()
	uv0.super.releaseSelf(slot0)
end

function slot0.disposeSelf(slot0)
	uv0.super.disposeSelf(slot0)
end

return slot0
