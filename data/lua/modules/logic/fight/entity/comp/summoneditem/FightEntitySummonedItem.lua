module("modules.logic.fight.entity.comp.summoneditem.FightEntitySummonedItem", package.seeall)

slot0 = class("FightEntitySummonedItem", FightBaseClass)

function slot0.onAwake(slot0, slot1, slot2)
	slot0._entity = slot1
	slot0._data = slot2
	slot0._uid = slot2.uid
	slot0._effectDic = {}

	slot0:com_registFightEvent(FightEvent.SummonedLevelChange, slot0._onSummonedLevelChange)
	slot0:com_registFightEvent(FightEvent.SummonedDelete, slot0._onSummonedDelete)
	slot0:com_registFightEvent(FightEvent.EntityEffectLoaded, slot0._onEntityEffectLoaded)
	slot0:com_registFightEvent(FightEvent.PlayRemoveSummoned, slot0._onPlayRemoveSummoned)
	slot0:com_registFightEvent(FightEvent.SetEntityAlpha, slot0._onSetEntityAlpha)
	slot0:com_registFightEvent(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart)
	slot0:com_registFightEvent(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish)
	slot0:_refreshSummoned()
	slot0:_initAniEffect()
end

function slot0._getData(slot0)
	return slot0._entity:getMO():getSummonedInfo():getData(slot0._uid) or slot0._data
end

function slot0._refreshSummoned(slot0)
	slot1 = slot0._entity:getMO()
	slot0._config = FightConfig.instance:getSummonedConfig(slot0:_getData().summonedId, slot0:_getData().level)
	slot0._stanceConfig = lua_fight_summoned_stance.configDict[slot0._config.stanceId]
	slot2 = nil
	slot2 = (not slot0._stanceConfig or slot0._stanceConfig["pos" .. slot0:_getData().stanceIndex]) and {
		0,
		0,
		0
	}
	slot0._pos = {
		x = slot2[1],
		y = slot2[2],
		z = slot2[3]
	}

	slot0:createEffect(slot0._config.enterEffect, slot0._config.enterTime)

	slot0._loopEffect = slot0:createEffect(slot0._config.loopEffect)

	slot0:_playAudio(slot0._config.enterAudio)
end

function slot0._playAudio(slot0, slot1)
	if slot1 ~= 0 then
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0._initAniEffect(slot0)
	slot0:createEffect(slot0._config.aniEffect)
end

function slot0._onSetEntityAlpha(slot0, slot1, slot2)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot2 and slot0._aniEffect then
		slot0:_playAni("idle" .. slot0:_getData().level)
	end

	slot0:_setLoopEffectState(slot2)
end

function slot0.createEffect(slot0, slot1, slot2)
	if not string.nilorempty(slot1) then
		slot2 = slot2 and slot2 / 1000

		slot0._entity.effect:addHangEffect(slot1, ModuleEnum.SpineHangPointRoot, nil, slot2, slot0._pos):setLocalPos(slot0._pos.x, slot0._pos.y, slot0._pos.z)

		if not slot2 then
			slot0._effectDic[slot3.uniqueId] = slot3
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot3)

		return slot3
	end
end

function slot0._onEntityEffectLoaded(slot0, slot1, slot2)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot2.path == slot0._config.aniEffect then
		slot0._aniEffect = SLFramework.AnimatorPlayer.Get(slot2.effectGO)
		slot3 = nil

		slot0:_playAni(slot0:_getData().level == 1 and "enter" or string.format("level%d_%d", slot0:_getData().level - 1, slot0:_getData().level))
	end
end

function slot0._playAni(slot0, slot1)
	if slot0._aniEffect and slot0._aniEffect:HasState(0, UnityEngine.Animator.StringToHash(slot1)) then
		slot0._aniEffect:play(slot1, nil, )
	end
end

function slot0._setLoopEffectState(slot0, slot1, slot2)
	if slot0._loopEffect then
		slot0._loopEffect:setActive(slot1, slot2 or "FightEntitySummonedItem")
	end
end

function slot0._onSkillPlayStart(slot0, slot1)
	if slot0._entity.id == slot1.id then
		slot0:_setLoopEffectState(false, "FightEntitySummonedItemTimeline")
	end
end

function slot0._onSkillPlayFinish(slot0, slot1)
	if slot0._entity.id == slot1.id then
		slot0:_setLoopEffectState(true, "FightEntitySummonedItemTimeline")
	end
end

function slot0._onSummonedLevelChange(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot2 == slot0:_getData().uid then
		slot0:_playAni(string.format("level%d_%d", slot3, slot4))

		slot0._lastLoopEffect = slot0._loopEffect

		slot0:_refreshSummoned()

		if slot0._loopEffect.effectGO then
			slot0:_releaseLastLoopEffect()
		else
			slot0:com_registFightEvent(FightEvent.EntityEffectLoaded, slot0._onChangeEffectLoaded)
		end
	end
end

function slot0._onChangeEffectLoaded(slot0, slot1, slot2)
	if slot2 == slot0._loopEffect then
		slot0:com_cancelFightEvent(FightEvent.EntityEffectLoaded, slot0._onChangeEffectLoaded)
		slot0:_releaseLastLoopEffect()
	end
end

function slot0._releaseLastLoopEffect(slot0)
	if slot0._lastLoopEffect then
		slot0:_releaseEffect(slot0._lastLoopEffect)
	end
end

function slot0._onPlayRemoveSummoned(slot0, slot1, slot2)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot2 == slot0:_getData().uid then
		slot0._removeEffectWrap = slot0:createEffect(slot0._config.closeEffect)

		if slot0._removeEffectWrap then
			if slot0._removeEffectWrap.effectGO then
				slot0:_releaseLoopEffect()
			else
				slot0:com_registFightEvent(FightEvent.EntityEffectLoaded, slot0._onRemoveEffectLoaded)
			end
		else
			slot0:_releaseLoopEffect()
		end

		slot0:_playAudio(slot0._config.closeAudio)
	end
end

function slot0._releaseLoopEffect(slot0)
	if slot0._loopEffect then
		slot0:_releaseEffect(slot0._loopEffect)

		slot0._loopEffect = nil
	end
end

function slot0._onRemoveEffectLoaded(slot0, slot1, slot2)
	if slot0._removeEffectWrap == slot2 then
		slot0:com_cancelFightEvent(FightEvent.EntityEffectLoaded, slot0._onRemoveEffectLoaded)
		slot0:_releaseLoopEffect()
	end
end

function slot0._onSummonedDelete(slot0, slot1, slot2)
	if slot1 ~= slot0._entity.id then
		return
	end

	if slot2 == slot0:_getData().uid then
		slot0:disposeSelf()
	end
end

function slot0._releaseEffect(slot0, slot1)
	slot0._effectDic[slot1.uniqueId] = nil

	FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot1)
	slot0._entity.effect:removeEffect(slot1)
end

function slot0.releaseSelf(slot0)
	for slot4, slot5 in pairs(slot0._effectDic) do
		slot0:_releaseEffect(slot5)
	end
end

return slot0
