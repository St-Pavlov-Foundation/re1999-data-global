module("modules.logic.fight.entity.comp.specialeffect.FightSceneSpecialEffect0_HuanJingKa", package.seeall)

local var_0_0 = class("FightSceneSpecialEffect0_HuanJingKa", FightEntitySpecialEffectBase)
local var_0_1 = "v1a3_huanjing/v1a3_scene_huanjing_effect_01"
local var_0_2 = "v1a3_scene_huanjing_effect_01"
local var_0_3 = "v1a3_scene_huanjing_effect_03"
local var_0_4 = "v1a3_scene_huanjing_effect_04"

function var_0_0.initClass(arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_1_0._onRoundSequenceFinish, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnFightReconnectLastWork, arg_1_0._onFightReconnectLastWork, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.EntityEffectLoaded, arg_1_0._onEntityEffectLoaded, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
end

function var_0_0._onBuffUpdate(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0:_isEffectBuff(arg_2_3) then
		arg_2_0:_dealHuanJingChangJingTeXiao(arg_2_1, arg_2_2, arg_2_3)
	end
end

function var_0_0._dealHuanJingChangJingTeXiao(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = FightHelper.getEntity(arg_3_1)
	local var_3_1 = var_3_0 and var_3_0:getMO()

	if var_3_1 and var_3_1.side == FightEnum.EntitySide.MySide and arg_3_2 == FightEnum.EffectType.BUFFADD then
		arg_3_0:_showEffect()
	end
end

function var_0_0._showEffect(arg_4_0)
	if arg_4_0._playing then
		return
	end

	arg_4_0._playing = true
	arg_4_0._aniName = var_0_2

	if not arg_4_0._effectWrap then
		arg_4_0._effectWrap = arg_4_0._entity.effect:addGlobalEffect(var_0_1)
	else
		arg_4_0._effectWrap:setActive(true)
		arg_4_0:_refreshAni()
	end
end

function var_0_0._onEntityEffectLoaded(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= arg_5_0._entity.id then
		return
	end

	if arg_5_2.path == FightHelper.getEffectUrlWithLod(var_0_1) then
		local var_5_0 = gohelper.findChild(arg_5_2.effectGO, "root")

		arg_5_0._ani = gohelper.onceAddComponent(var_5_0, typeof(UnityEngine.Animator))

		arg_5_0:_refreshAni()
	end
end

function var_0_0._refreshAni(arg_6_0)
	if arg_6_0._ani then
		if arg_6_0._aniName == var_0_3 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_dreamland02)
		elseif arg_6_0._aniName ~= var_0_4 then
			AudioMgr.instance:trigger(AudioEnum.UI.play_effects_fight_dreamland01)
		end

		arg_6_0._ani:Play(arg_6_0._aniName)
	end
end

function var_0_0._hideEffect(arg_7_0)
	arg_7_0._aniName = var_0_3

	arg_7_0:_refreshAni()
end

function var_0_0._onRoundSequenceFinish(arg_8_0)
	if not arg_8_0:_detectHaveBuff() and arg_8_0._effectWrap then
		if not arg_8_0._playing then
			return
		end

		arg_8_0._playing = false

		arg_8_0:_hideEffect()
	end
end

function var_0_0._onFightReconnectLastWork(arg_9_0)
	if arg_9_0:_detectHaveBuff() then
		arg_9_0:_showEffect()
	end
end

function var_0_0._detectHaveBuff(arg_10_0)
	local var_10_0 = false
	local var_10_1 = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_2 = iter_10_1:getMO()

		if var_10_2 then
			local var_10_3 = var_10_2:getBuffDic()

			for iter_10_2, iter_10_3 in pairs(var_10_3) do
				if arg_10_0:_isEffectBuff(iter_10_3.buffId) then
					var_10_0 = true

					break
				end
			end

			if var_10_0 then
				break
			end
		end
	end

	return var_10_0
end

function var_0_0._isEffectBuff(arg_11_0, arg_11_1)
	local var_11_0 = lua_skill_buff.configDict[arg_11_1]

	if var_11_0 and (var_11_0.typeId == 2130101 or var_11_0.typeId == 2130102 or var_11_0.typeId == 2130103 or var_11_0.typeId == 2130104 or var_11_0.typeId == 4130030 or var_11_0.typeId == 4130031 or var_11_0.typeId == 4130059 or var_11_0.typeId == 4130060 or var_11_0.typeId == 4130061 or var_11_0.typeId == 4130062) then
		return true
	end
end

function var_0_0._onSkillPlayStart(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1:getMO() and FightCardDataHelper.isBigSkill(arg_12_2) and arg_12_0:_detectHaveBuff() and arg_12_0._effectWrap then
		arg_12_0:_hideEffect()
	end
end

function var_0_0._onSkillPlayFinish(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1:getMO() and FightCardDataHelper.isBigSkill(arg_13_2) and arg_13_0:_detectHaveBuff() and arg_13_0._effectWrap then
		arg_13_0._aniName = var_0_4

		arg_13_0:_refreshAni()
	end
end

function var_0_0._releaseEffect(arg_14_0)
	if arg_14_0._effectWrap then
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_14_0._entity.id, arg_14_0._effectWrap)

		arg_14_0._effectWrap = nil
	end
end

function var_0_0.releaseSelf(arg_15_0)
	arg_15_0:_releaseEffect()
end

return var_0_0
