module("modules.logic.fight.entity.comp.summoneditem.FightEntitySummonedItem", package.seeall)

local var_0_0 = class("FightEntitySummonedItem", FightBaseClass)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._entity = arg_1_1
	arg_1_0._data = arg_1_2
	arg_1_0._uid = arg_1_2.uid
	arg_1_0._effectDic = {}

	arg_1_0:com_registFightEvent(FightEvent.SummonedLevelChange, arg_1_0._onSummonedLevelChange)
	arg_1_0:com_registFightEvent(FightEvent.SummonedDelete, arg_1_0._onSummonedDelete)
	arg_1_0:com_registFightEvent(FightEvent.EntityEffectLoaded, arg_1_0._onEntityEffectLoaded)
	arg_1_0:com_registFightEvent(FightEvent.PlayRemoveSummoned, arg_1_0._onPlayRemoveSummoned)
	arg_1_0:com_registFightEvent(FightEvent.SetEntityAlpha, arg_1_0._onSetEntityAlpha)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish)
	arg_1_0:_refreshSummoned()
	arg_1_0:_initAniEffect()
end

function var_0_0._getData(arg_2_0)
	return arg_2_0._entity:getMO():getSummonedInfo():getData(arg_2_0._uid) or arg_2_0._data
end

function var_0_0._refreshSummoned(arg_3_0)
	local var_3_0 = arg_3_0._entity:getMO()

	arg_3_0._config = FightConfig.instance:getSummonedConfig(arg_3_0:_getData().summonedId, arg_3_0:_getData().level)
	arg_3_0._stanceConfig = lua_fight_summoned_stance.configDict[arg_3_0._config.stanceId]

	local var_3_1

	if arg_3_0._stanceConfig then
		var_3_1 = arg_3_0._stanceConfig["pos" .. arg_3_0:_getData().stanceIndex]
	else
		var_3_1 = {
			0,
			0,
			0
		}
	end

	arg_3_0._pos = {
		x = var_3_1[1],
		y = var_3_1[2],
		z = var_3_1[3]
	}

	arg_3_0:createEffect(arg_3_0._config.enterEffect, arg_3_0._config.enterTime)

	arg_3_0._loopEffect = arg_3_0:createEffect(arg_3_0._config.loopEffect)

	arg_3_0:_playAudio(arg_3_0._config.enterAudio)
end

function var_0_0._playAudio(arg_4_0, arg_4_1)
	if arg_4_1 ~= 0 then
		AudioMgr.instance:trigger(arg_4_1)
	end
end

function var_0_0._initAniEffect(arg_5_0)
	arg_5_0:createEffect(arg_5_0._config.aniEffect)
end

function var_0_0._onSetEntityAlpha(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= arg_6_0._entity.id then
		return
	end

	if arg_6_2 and arg_6_0._aniEffect then
		arg_6_0:_playAni("idle" .. arg_6_0:_getData().level)
	end

	arg_6_0:_setLoopEffectState(arg_6_2)
end

function var_0_0.createEffect(arg_7_0, arg_7_1, arg_7_2)
	if not string.nilorempty(arg_7_1) then
		arg_7_2 = arg_7_2 and arg_7_2 / 1000

		local var_7_0 = arg_7_0._entity.effect:addHangEffect(arg_7_1, ModuleEnum.SpineHangPointRoot, nil, arg_7_2, arg_7_0._pos)

		var_7_0:setLocalPos(arg_7_0._pos.x, arg_7_0._pos.y, arg_7_0._pos.z)

		if not arg_7_2 then
			arg_7_0._effectDic[var_7_0.uniqueId] = var_7_0
		end

		FightRenderOrderMgr.instance:onAddEffectWrap(arg_7_0._entity.id, var_7_0)

		return var_7_0
	end
end

function var_0_0._onEntityEffectLoaded(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= arg_8_0._entity.id then
		return
	end

	if arg_8_2.path == arg_8_0._config.aniEffect then
		arg_8_0._aniEffect = SLFramework.AnimatorPlayer.Get(arg_8_2.effectGO)

		local var_8_0
		local var_8_1 = arg_8_0:_getData().level == 1 and "enter" or string.format("level%d_%d", arg_8_0:_getData().level - 1, arg_8_0:_getData().level)

		arg_8_0:_playAni(var_8_1)
	end
end

function var_0_0._playAni(arg_9_0, arg_9_1)
	if arg_9_0._aniEffect then
		local var_9_0 = UnityEngine.Animator.StringToHash(arg_9_1)

		if arg_9_0._aniEffect:HasState(0, var_9_0) then
			arg_9_0._aniEffect:play(arg_9_1, nil, nil)
		end
	end
end

function var_0_0._setLoopEffectState(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._loopEffect then
		arg_10_0._loopEffect:setActive(arg_10_1, arg_10_2 or "FightEntitySummonedItem")
	end
end

function var_0_0._onSkillPlayStart(arg_11_0, arg_11_1)
	if arg_11_0._entity.id == arg_11_1.id then
		arg_11_0:_setLoopEffectState(false, "FightEntitySummonedItemTimeline")
	end
end

function var_0_0._onSkillPlayFinish(arg_12_0, arg_12_1)
	if arg_12_0._entity.id == arg_12_1.id then
		arg_12_0:_setLoopEffectState(true, "FightEntitySummonedItemTimeline")
	end
end

function var_0_0._onSummonedLevelChange(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_1 ~= arg_13_0._entity.id then
		return
	end

	if arg_13_2 == arg_13_0:_getData().uid then
		local var_13_0 = string.format("level%d_%d", arg_13_3, arg_13_4)

		arg_13_0:_playAni(var_13_0)

		arg_13_0._lastLoopEffect = arg_13_0._loopEffect

		arg_13_0:_refreshSummoned()

		if arg_13_0._loopEffect.effectGO then
			arg_13_0:_releaseLastLoopEffect()
		else
			arg_13_0:com_registFightEvent(FightEvent.EntityEffectLoaded, arg_13_0._onChangeEffectLoaded)
		end
	end
end

function var_0_0._onChangeEffectLoaded(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 == arg_14_0._loopEffect then
		arg_14_0:com_cancelFightEvent(FightEvent.EntityEffectLoaded, arg_14_0._onChangeEffectLoaded)
		arg_14_0:_releaseLastLoopEffect()
	end
end

function var_0_0._releaseLastLoopEffect(arg_15_0)
	if arg_15_0._lastLoopEffect then
		arg_15_0:_releaseEffect(arg_15_0._lastLoopEffect)
	end
end

function var_0_0._onPlayRemoveSummoned(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= arg_16_0._entity.id then
		return
	end

	if arg_16_2 == arg_16_0:_getData().uid then
		arg_16_0._removeEffectWrap = arg_16_0:createEffect(arg_16_0._config.closeEffect)

		if arg_16_0._removeEffectWrap then
			if arg_16_0._removeEffectWrap.effectGO then
				arg_16_0:_releaseLoopEffect()
			else
				arg_16_0:com_registFightEvent(FightEvent.EntityEffectLoaded, arg_16_0._onRemoveEffectLoaded)
			end
		else
			arg_16_0:_releaseLoopEffect()
		end

		arg_16_0:_playAudio(arg_16_0._config.closeAudio)
	end
end

function var_0_0._releaseLoopEffect(arg_17_0)
	if arg_17_0._loopEffect then
		arg_17_0:_releaseEffect(arg_17_0._loopEffect)

		arg_17_0._loopEffect = nil
	end
end

function var_0_0._onRemoveEffectLoaded(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._removeEffectWrap == arg_18_2 then
		arg_18_0:com_cancelFightEvent(FightEvent.EntityEffectLoaded, arg_18_0._onRemoveEffectLoaded)
		arg_18_0:_releaseLoopEffect()
	end
end

function var_0_0._onSummonedDelete(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= arg_19_0._entity.id then
		return
	end

	if arg_19_2 == arg_19_0:_getData().uid then
		arg_19_0:disposeSelf()
	end
end

function var_0_0._releaseEffect(arg_20_0, arg_20_1)
	arg_20_0._effectDic[arg_20_1.uniqueId] = nil

	FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_20_0._entity.id, arg_20_1)
	arg_20_0._entity.effect:removeEffect(arg_20_1)
end

function var_0_0.onLogicExit(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._effectDic) do
		arg_21_0:_releaseEffect(iter_21_1)
	end
end

return var_0_0
