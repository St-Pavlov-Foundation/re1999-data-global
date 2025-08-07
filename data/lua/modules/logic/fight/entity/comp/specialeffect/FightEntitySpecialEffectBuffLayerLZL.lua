module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBuffLayerLZL", package.seeall)

local var_0_0 = class("FightEntitySpecialEffectBuffLayerLZL", FightEntitySpecialEffectBase)

function var_0_0.initClass(arg_1_0)
	arg_1_0.entity = arg_1_0._entity
	arg_1_0.entityId = arg_1_0.entity.id
	arg_1_0.curEffectWrap = nil

	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0.onBuffUpdate, arg_1_0)
end

function var_0_0.onBuffUpdate(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 ~= arg_2_0.entityId then
		return
	end

	if arg_2_2 ~= FightEnum.EffectType.BUFFUPDATE and arg_2_2 ~= FightEnum.EffectType.BUFFADD then
		return
	end

	local var_2_0 = lua_skill_buff.configDict[arg_2_3]
	local var_2_1 = var_2_0 and var_2_0.typeId

	if not var_2_1 then
		return
	end

	local var_2_2 = lua_fight_lzl_buff_float.configDict[var_2_1]

	if not var_2_2 then
		return
	end

	local var_2_3 = arg_2_0.entity and arg_2_0.entity:getMO()

	if not var_2_3 then
		return
	end

	local var_2_4 = var_2_3:getBuffMO(arg_2_4)

	if not var_2_4 then
		return
	end

	local var_2_5 = var_2_4.layer

	var_2_2 = var_2_2[var_2_5] or var_2_2[311601]

	if not var_2_2 then
		logError(string.format("冷周六飘字表没找到buffTypeId = `%s`, layer = `%s` 的配置", var_2_1, var_2_5))

		return
	end

	local var_2_6 = var_2_2[var_2_3.skin]

	if not var_2_6 then
		logError(string.format("冷周六飘字表没找到buffTypeId = `%s`, layer = `%s`, skinId = `%s` 的配置", var_2_1, var_2_5, var_2_3.skin))

		return
	end

	arg_2_0:removeEffect()

	local var_2_7 = var_2_6.effect
	local var_2_8 = var_2_6.effectRoot
	local var_2_9 = var_2_6.effectAudio
	local var_2_10 = var_2_6.duration

	arg_2_0.curEffectWrap = arg_2_0.entity.effect:addHangEffect(var_2_7, var_2_8, nil, var_2_10)

	arg_2_0.curEffectWrap:setLocalPos(0, 0, 0)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_2_1, arg_2_0.curEffectWrap)

	if var_2_9 > 0 then
		FightAudioMgr.instance:playAudio(var_2_9)
	end
end

function var_0_0.removeEffect(arg_3_0)
	if arg_3_0.curEffectWrap then
		arg_3_0.entity.effect:removeEffect(arg_3_0.curEffectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_3_0.entityId, arg_3_0.curEffectWrap)

		arg_3_0.curEffectWrap = nil
	end
end

function var_0_0.releaseSelf(arg_4_0)
	arg_4_0:removeEffect()
	var_0_0.super.releaseSelf(arg_4_0)
end

function var_0_0.disposeSelf(arg_5_0)
	var_0_0.super.disposeSelf(arg_5_0)
end

return var_0_0
