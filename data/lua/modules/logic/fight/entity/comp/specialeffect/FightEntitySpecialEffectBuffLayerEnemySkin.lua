module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayerEnemySkin", package.seeall)

slot0 = class("FightEntitySpecialEffectBuffLayerEnemySkin", FightEntitySpecialEffectBase)
slot1 = 3000

function slot0.initClass(slot0)
	slot0._effectWraps = {}
	slot0._buffId2Config = {}
	slot0._oldLayer = {}
	slot0._buffType = {}
	slot0.playCount = 0
	slot0.hideWhenPlayTimeline = {}

	slot0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, slot0._onSetBuffEffectVisible, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, slot0._onBeforeDeadEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SkillEditorRefreshBuff, slot0._onSkillEditorRefreshBuff, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0, LuaEventSystem.High)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlayTimeline, slot0.onBeforePlayTimeline, slot0)
end

function slot0.onBeforePlayTimeline(slot0, slot1)
	if slot0._entity.id == slot1 then
		slot0.playCount = slot0.playCount + 1

		for slot5, slot6 in ipairs(slot0.hideWhenPlayTimeline) do
			slot6:setActive(false, "FightEntitySpecialEffectBuffLayerEnemySkin_onBeforePlayTimeline")
		end
	end
end

function slot0.afterPlayTimeline(slot0)
	slot0.playCount = slot0.playCount - 1

	if slot0.playCount == 0 then
		for slot4, slot5 in ipairs(slot0.hideWhenPlayTimeline) do
			slot5:setActive(true, "FightEntitySpecialEffectBuffLayerEnemySkin_afterPlayTimeline")
		end
	end
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if slot0._entity:getMO() then
		for slot6, slot7 in pairs(slot1:getBuffDic()) do
			slot0:_onBuffUpdate(slot0._entity.id, FightEnum.EffectType.BUFFADD, slot7.buffId, slot7.uid, nil, slot7)
		end
	end
end

function slot0._onSkillEditorRefreshBuff(slot0)
	slot0:_releaseAllEffect()
	slot0:_onBeforeEnterStepBehaviour()
end

function slot0._onSetBuffEffectVisible(slot0, slot1, slot2, slot3)
	if slot0._entity.id == slot1 and slot0._effectWraps then
		for slot7, slot8 in pairs(slot0._effectWraps) do
			for slot12, slot13 in pairs(slot8) do
				slot13:setActive(slot2, slot3 or "FightEntitySpecialEffectBuffLayerEnemySkin")
			end
		end
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	if slot1:getMO() and slot4.id == slot0._entity.id and FightCardDataHelper.isBigSkill(slot2) then
		slot0:_onSetBuffEffectVisible(slot4.id, false, "FightEntitySpecialEffectBuffLayerEnemySkin_onSkillPlayStart")
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot1:getMO() and slot4.id == slot0._entity.id then
		if FightCardDataHelper.isBigSkill(slot2) then
			slot0:_onSetBuffEffectVisible(slot4.id, true, "FightEntitySpecialEffectBuffLayerEnemySkin_onSkillPlayStart")
		end

		slot0:afterPlayTimeline()
	end
end

function slot0.sortList(slot0, slot1)
	return slot1.layer < slot0.layer
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot1 ~= slot0._entity.id then
		return
	end

	if lua_fight_buff_layer_effect_enemy_skin.configDict[slot3] then
		if slot2 == FightEnum.EffectType.BUFFDEL or slot2 == FightEnum.EffectType.BUFFDELNOEFFECT then
			if not slot0._buffType[slot4] then
				return
			end

			if slot7 == FightEnum.BuffType.LayerSalveHalo then
				return
			end

			slot0:_refreshEffect(slot3, nil, 0, slot2)

			return
		end

		if not slot6 then
			return
		end

		slot0._buffType[slot4] = slot6.type

		if slot6.type == FightEnum.BuffType.LayerSalveHalo then
			return
		end

		if not slot0._entity:getMO() then
			return
		end

		slot8 = slot7.side == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
		slot10 = slot0:checkRefreshEffect(FightDataHelper.entityMgr:getOriginNormalList(slot8), slot6, slot1, slot2) or slot0:checkRefreshEffect(FightDataHelper.entityMgr:getOriginSpList(slot8), slot6, slot1, slot2)
	end
end

function slot0.checkRefreshEffect(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot2.buffId

	for slot9, slot10 in ipairs(slot1) do
		if lua_fight_buff_layer_effect_enemy_skin.configDict[slot5][slot10.originSkin] or lua_fight_buff_layer_effect_enemy_skin.configDict[slot5][0] then
			slot12 = {}

			for slot16, slot17 in pairs(slot11) do
				table.insert(slot12, slot17)
			end

			table.sort(slot12, uv0.sortList)

			slot13 = slot2 and slot2.layer or 0

			if FightSkillBuffMgr.instance:buffIsStackerBuff(lua_skill_buff.configDict[slot5]) then
				slot13 = FightSkillBuffMgr.instance:getStackedCount(slot3, slot2)
			end

			slot0:_refreshEffect(slot5, slot12, slot13, slot4)

			return true
		end
	end
end

function slot0._refreshEffect(slot0, slot1, slot2, slot3, slot4)
	if not slot0._effectWraps then
		return
	end

	if not slot0._effectWraps[slot1] then
		slot0._effectWraps[slot1] = {}
	end

	slot5 = slot0._oldLayer[slot1] or 0
	slot0._oldLayer[slot1] = slot3

	if (slot4 == FightEnum.EffectType.BUFFDEL or slot4 == FightEnum.EffectType.BUFFDELNOEFFECT) and slot3 == 0 then
		if slot0._buffId2Config[slot1] and not string.nilorempty(slot6.destroyEffect) then
			slot8 = slot0._entity.effect:addHangEffect(slot6.destroyEffect, slot6.destroyEffectRoot, nil, (slot6.releaseDestroyEffectTime > 0 and slot6.releaseDestroyEffectTime or uv0) / 1000)

			slot8:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot8)

			if slot6.destroyEffectAudio > 0 then
				AudioMgr.instance:trigger(slot6.destroyEffectAudio)
			end
		end

		slot0:_releaseBuffIdEffect(slot1)

		return
	end

	slot6 = nil

	for slot10, slot11 in ipairs(slot2) do
		if slot11.layer <= slot3 then
			slot6 = slot11

			break
		end
	end

	if not slot6 then
		slot0:_releaseBuffIdEffect(slot1)

		return
	end

	slot0._buffId2Config[slot1] = slot6
	slot9 = slot0._buffId2Config[slot1] ~= slot6

	if not slot0._effectWraps[slot1][slot6.layer] and not string.nilorempty(slot6.loopEffect) then
		slot10 = slot0._entity.effect:addHangEffect(slot6.loopEffect, slot6.loopEffectRoot)

		slot10:setLocalPos(0, 0, 0)
		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot10)

		slot0._effectWraps[slot1][slot7] = slot10

		slot10:setActive(false)

		if slot6.hideWhenPlayTimeline == 1 then
			table.insert(slot0.hideWhenPlayTimeline, slot10)
		end
	end

	if slot9 then
		slot0:_hideEffect(slot1)

		if not string.nilorempty(slot6.createEffect) then
			slot11 = slot0._entity.effect:addHangEffect(slot6.createEffect, slot6.createEffectRoot, nil, (slot6.releaseCreateEffectTime > 0 and slot6.releaseCreateEffectTime or uv0) / 1000)

			slot11:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot11)

			if slot6.createAudio > 0 then
				AudioMgr.instance:trigger(slot6.createAudio)
			end
		end

		if slot6.delayTimeBeforeLoop > 0 then
			TaskDispatcher.runDelay(function ()
				uv0:_refreshEffectState(uv1)
			end, slot0, slot6.delayTimeBeforeLoop / 1000)
		else
			slot0:_refreshEffectState(slot1)
		end
	else
		if slot6.loopEffectAudio > 0 then
			AudioMgr.instance:trigger(slot6.loopEffectAudio)
		end

		slot0:_refreshEffectState(slot1)

		if slot4 == FightEnum.EffectType.BUFFUPDATE and slot5 < slot3 then
			if not string.nilorempty(slot6.addLayerEffect) then
				slot11 = slot0._entity.effect:addHangEffect(slot6.addLayerEffect, slot6.addLayerEffectRoot, nil, (slot6.releaseAddLayerEffectTime > 0 and slot6.releaseAddLayerEffectTime or uv0) / 1000)

				slot11:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot11)
			end

			if slot6.addLayerAudio > 0 then
				AudioMgr.instance:trigger(slot6.addLayerAudio)
			end
		end
	end
end

function slot0._refreshEffectState(slot0, slot1)
	if not slot0 then
		return
	end

	if slot0._effectWraps and slot0._effectWraps[slot1] then
		for slot7, slot8 in pairs(slot2) do
			slot8:setActive(slot0._buffId2Config[slot1].layer == slot7)
		end
	end
end

function slot0._hideEffect(slot0, slot1)
	if slot0._effectWraps and slot0._effectWraps[slot1] then
		for slot6, slot7 in pairs(slot2) do
			slot7:setActive(false)
		end
	end
end

function slot0._releaseAllEffect(slot0)
	if slot0._effectWraps then
		for slot4, slot5 in pairs(slot0._effectWraps) do
			slot0:_releaseBuffIdEffect(slot4)
		end

		slot0._effectWraps = nil
	end
end

function slot0._releaseBuffIdEffect(slot0, slot1)
	if slot0._effectWraps then
		for slot5, slot6 in pairs(slot0._effectWraps[slot1]) do
			slot0:_releaseEffect(slot6)
		end

		slot0._effectWraps[slot1] = nil
	end
end

function slot0._releaseEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.hideWhenPlayTimeline) do
		if slot6 == slot1 then
			table.remove(slot0.hideWhenPlayTimeline, slot5)

			break
		end
	end

	slot0._entity.effect:removeEffect(slot1)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot1)
end

function slot0._onBeforeDeadEffect(slot0, slot1)
	if slot1 == slot0._entity.id then
		slot0:_releaseAllEffect()
	end
end

function slot0.releaseSelf(slot0)
	slot0:_releaseAllEffect()
end

return slot0
