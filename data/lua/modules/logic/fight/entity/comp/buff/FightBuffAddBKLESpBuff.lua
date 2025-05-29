module("modules.logic.fight.entity.comp.buff.FightBuffAddBKLESpBuff", package.seeall)

local var_0_0 = class("FightBuffAddBKLESpBuff")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onBuffStart(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_2.fromUid
	local var_2_1 = FightDataHelper.entityMgr:getById(var_2_0)

	if not var_2_1 then
		return
	end

	local var_2_2 = var_2_1.skin
	local var_2_3 = lua_fight_sp_effect_bkle.configDict[var_2_2]

	if not var_2_3 then
		return
	end

	local var_2_4 = FightHeroSpEffectConfig.instance:getBKLEAddBuffEffect(var_2_2)

	if not var_2_4 then
		return
	end

	arg_2_0.entity = arg_2_1
	arg_2_0.buffMo = arg_2_2
	arg_2_0.wrap = arg_2_1.effect:addHangEffect(var_2_4, var_2_3.hangPoint)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_2_1.id, arg_2_0.wrap)
	arg_2_0.wrap:setLocalPos(0, 0, 0)

	local var_2_5 = var_2_3.audio

	if var_2_5 ~= 0 then
		AudioMgr.instance:trigger(var_2_5)
	end

	arg_2_1.buff:addLoopBuff(arg_2_0.wrap)
end

function var_0_0.onBuffEnd(arg_3_0)
	if not arg_3_0.wrap then
		return
	end

	arg_3_0.entity.buff:removeLoopBuff(arg_3_0.wrap)
	arg_3_0.entity.effect:removeEffect(arg_3_0.wrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_3_0.entity.id, arg_3_0.wrap)

	arg_3_0.wrap = nil
end

return var_0_0
