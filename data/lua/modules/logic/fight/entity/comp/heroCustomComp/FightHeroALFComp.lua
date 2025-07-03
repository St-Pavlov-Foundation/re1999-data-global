module("modules.logic.fight.entity.comp.heroCustomComp.FightHeroALFComp", package.seeall)

local var_0_0 = class("FightHeroALFComp", FightHeroCustomCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.entity:getMO()

	arg_1_0.alfTimeLineCo = lua_fight_sp_effect_alf_timeline.configDict[var_1_0.skin]

	if not arg_1_0.alfTimeLineCo then
		logError("阿莱夫插牌timeline未配置，skinId : " .. tostring(var_1_0.skin))
	end
end

function var_0_0.addEventListeners(arg_2_0)
	FightController.instance:registerCallback(FightEvent.AfterAddUseCardContainer, arg_2_0.onAfterAddUseCardOnContainer, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.AfterAddUseCardContainer, arg_3_0.onAfterAddUseCardOnContainer, arg_3_0)
end

var_0_0.ALFSkillDict = {
	[31130152] = true,
	[31130153] = true,
	[31130154] = true,
	[31130151] = true
}
var_0_0.CardAddEffect = "ui/viewres/fight/card_alf.prefab"

function var_0_0.onAfterAddUseCardOnContainer(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	if not arg_4_0.alfTimeLineCo then
		return
	end

	local var_4_0 = 0
	local var_4_1 = arg_4_1.actEffect
	local var_4_2 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if iter_4_1.effectType == FightEnum.EffectType.ADDUSECARD and var_0_0.ALFSkillDict[iter_4_1.effectNum1] then
			var_4_0 = var_4_0 + 1
			var_4_2 = iter_4_1.effectNum1
		end
	end

	local var_4_3

	if var_4_0 == 2 then
		var_4_3 = arg_4_0.alfTimeLineCo.timeline_2
	elseif var_4_0 == 3 then
		var_4_3 = arg_4_0.alfTimeLineCo.timeline_3
	elseif var_4_0 == 4 then
		var_4_3 = arg_4_0.alfTimeLineCo.timeline_4
	end

	if string.nilorempty(var_4_3) then
		return
	end

	arg_4_1.fromId = arg_4_0.entity.id
	arg_4_1.actId = var_4_2

	arg_4_0.entity.skill:playTimeline(var_4_3, arg_4_1)
end

function var_0_0.setCacheRecordSkillList(arg_5_0, arg_5_1)
	arg_5_0.cacheSkillList = arg_5_1
end

function var_0_0.getCacheSkillList(arg_6_0)
	return arg_6_0.cacheSkillList
end

return var_0_0
