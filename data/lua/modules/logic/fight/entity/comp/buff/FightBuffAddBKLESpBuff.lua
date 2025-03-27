module("modules.logic.fight.entity.comp.buff.FightBuffAddBKLESpBuff", package.seeall)

slot0 = class("FightBuffAddBKLESpBuff")

function slot0.ctor(slot0)
end

function slot0.onBuffStart(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot2.fromUid) then
		return
	end

	if not lua_fight_sp_effect_bkle.configDict[slot4.skin] then
		return
	end

	if not FightHeroSpEffectConfig.instance:getBKLEAddBuffEffect(slot5) then
		return
	end

	slot0.entity = slot1
	slot0.buffMo = slot2
	slot0.wrap = slot1.effect:addHangEffect(slot7, slot6.hangPoint)

	FightRenderOrderMgr.instance:onAddEffectWrap(slot1.id, slot0.wrap)
	slot0.wrap:setLocalPos(0, 0, 0)

	if slot6.audio ~= 0 then
		AudioMgr.instance:trigger(slot8)
	end

	slot1.buff:setBuffEffectDict(slot2.uid, slot0.wrap)
end

function slot0.onBuffEnd(slot0)
	if not slot0.wrap then
		return
	end

	slot0.entity.effect:removeEffect(slot0.wrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0.entity.id, slot0.wrap)
	slot0.entity.buff:setBuffEffectDict(slot0.buffMo.uid, nil)

	slot0.wrap = nil
end

return slot0
