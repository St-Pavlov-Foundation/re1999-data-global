module("modules.logic.fight.entity.comp.buff.FightBuffSpecialCountCastBuff", package.seeall)

local var_0_0 = class("FightBuffSpecialCountCastBuff", FightBuffHandleClsBase)

function var_0_0.onBuffStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.entityMo = arg_1_1:getMO()
	arg_1_0.entity = arg_1_1
	arg_1_0.buffId = arg_1_2.buffId
	arg_1_0.buffCo = arg_1_2:getCO()
	arg_1_0.buffTypeId = arg_1_0.buffCo.typeId
	arg_1_0.entityId = arg_1_1.id

	local var_1_0 = lua_fight_sp_effect_wuerlixi.configDict[arg_1_0.buffTypeId]

	if not var_1_0 then
		logError(string.format("buffId : %s, buffTypeId 不存在 ： %s", arg_1_0.buffId, arg_1_0.buffTypeId))

		return
	end

	local var_1_1 = var_1_0 and var_1_0[arg_1_0.entityMo.skin]

	if not var_1_1 then
		return
	end

	arg_1_0.spCo = var_1_1

	local var_1_2 = arg_1_0:getCurEffectPoint()

	arg_1_0.effectWrap = arg_1_1.effect:addHangEffect(arg_1_0.spCo.effect, var_1_2)

	FightRenderOrderMgr.instance:onAddEffectWrap(arg_1_1.id, arg_1_0.effectWrap)
	arg_1_0.effectWrap:setLocalPos(0, 0, 0)
	arg_1_0.entity.buff:addLoopBuff(arg_1_0.effectWrap)

	arg_1_0.preHangPoint = var_1_2

	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_1_0.onUpdateBuff, arg_1_0)
end

function var_0_0.onUpdateBuff(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 ~= arg_2_0.entityId then
		return
	end

	local var_2_0 = arg_2_0:getCurEffectPoint()

	if var_2_0 == arg_2_0.preHangPoint then
		return
	end

	arg_2_0.preHangPoint = var_2_0

	local var_2_1 = arg_2_0.entity:getHangPoint(var_2_0)

	arg_2_0.effectWrap:setHangPointGO(var_2_1)
	arg_2_0.effectWrap:setLocalPos(0, 0, 0)
end

function var_0_0.getCurEffectPoint(arg_3_0)
	if arg_3_0.entityMo:hasBuffFeature(FightEnum.BuffType_SpecialCountCastChannel) then
		return arg_3_0.spCo.channelHangPoint
	else
		return arg_3_0.spCo.hangPoint
	end
end

function var_0_0.clear(arg_4_0)
	if not arg_4_0.effectWrap then
		return
	end

	arg_4_0.entity.buff:removeLoopBuff(arg_4_0.effectWrap)
	arg_4_0.entity.effect:removeEffect(arg_4_0.effectWrap)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_4_0.entity.id, arg_4_0.effectWrap)

	arg_4_0.effectWrap = nil

	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_4_0.onUpdateBuff, arg_4_0)
end

return var_0_0
