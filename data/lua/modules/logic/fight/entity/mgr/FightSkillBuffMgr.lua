module("modules.logic.fight.entity.mgr.FightSkillBuffMgr", package.seeall)

local var_0_0 = class("FightSkillBuffMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0:_init()
end

function var_0_0._init(arg_2_0)
	arg_2_0._buffPlayDict = {}
	arg_2_0._buffEffectPlayDict = {}
end

function var_0_0.clearCompleteBuff(arg_3_0)
	arg_3_0:_init()
end

function var_0_0.playSkillBuff(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0:hasPlayBuff(arg_4_2) then
		FightWork2Work.New(FightWorkStepBuff, arg_4_1, arg_4_2):onStart()

		local var_4_0 = arg_4_2.effectType
		local var_4_1 = arg_4_2.buff

		arg_4_0._buffPlayDict[arg_4_2.clientId] = true

		local var_4_2 = arg_4_1.stepUid

		if var_4_2 and var_4_0 == FightEnum.EffectType.BUFFADD then
			local var_4_3 = lua_skill_buff.configDict[var_4_1.buffId]

			if var_4_3 and var_4_3.effect ~= "0" and not string.nilorempty(var_4_3.effect) then
				local var_4_4 = string.format(var_4_2 .. "-" .. var_4_1.entityId .. "-" .. var_4_3.effect)

				arg_4_0._buffEffectPlayDict[var_4_4] = true
			end
		end
	end
end

function var_0_0.hasPlayBuff(arg_5_0, arg_5_1)
	return arg_5_0._buffPlayDict[arg_5_1.clientId]
end

function var_0_0.hasPlayBuffEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = lua_skill_buff.configDict[arg_6_2.buffId]

	if arg_6_3 and var_6_0 and var_6_0.effect ~= "0" and not string.nilorempty(var_6_0.effect) then
		local var_6_1 = string.format(arg_6_3 .. "-" .. arg_6_1 .. "-" .. var_6_0.effect)

		return arg_6_0._buffEffectPlayDict[var_6_1]
	end

	return false
end

var_0_0.StackBuffFeatureList = {
	FightEnum.BuffType_DeadlyPoison
}

function var_0_0.buffIsStackerBuff(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return false
	end

	local var_7_0 = arg_7_1.id

	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(var_7_0) then
		local var_7_1 = lua_skill_bufftype.configDict[arg_7_1.typeId]
		local var_7_2 = FightStrUtil.instance:getSplitCache(var_7_1.includeTypes, "#")

		return true, var_7_2[1]
	end

	for iter_7_0, iter_7_1 in ipairs(var_0_0.StackBuffFeatureList) do
		if FightConfig.instance:hasBuffFeature(var_7_0, iter_7_1) then
			local var_7_3 = lua_skill_bufftype.configDict[arg_7_1.typeId]
			local var_7_4 = FightStrUtil.instance:getSplitCache(var_7_3.includeTypes, "#")

			return true, var_7_4[1]
		end
	end

	local var_7_5 = lua_skill_bufftype.configDict[arg_7_1.typeId]

	if var_7_5 then
		local var_7_6 = FightStrUtil.instance:getSplitCache(var_7_5.includeTypes, "#")[1]

		if var_7_6 == FightEnum.BuffIncludeTypes.Stacked or var_7_6 == FightEnum.BuffIncludeTypes.Stacked12 or var_7_6 == FightEnum.BuffIncludeTypes.Stacked15 or var_7_6 == FightEnum.BuffIncludeTypes.Stacked14 then
			return true, var_7_6
		end
	end
end

var_0_0.tempSignKeyDict = {}

function var_0_0.dealStackerBuff(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.tempSignKeyDict

	tabletool.clear(var_8_0)

	for iter_8_0 = #arg_8_1, 1, -1 do
		local var_8_1 = arg_8_1[iter_8_0]
		local var_8_2 = lua_skill_buff.configDict[var_8_1.buffId]

		if var_8_2 and arg_8_0:buffIsStackerBuff(var_8_2) then
			local var_8_3 = FightBuffHelper.getBuffMoSignKey(var_8_1)

			if not var_8_0[var_8_3] then
				var_8_0[var_8_3] = true
			else
				table.remove(arg_8_1, iter_8_0)
			end
		end
	end
end

function var_0_0.getStackedCount(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = lua_skill_buff.configDict[arg_9_2.buffId]

	if not arg_9_0:buffIsStackerBuff(var_9_0) then
		return 1
	end

	local var_9_1 = FightDataHelper.entityMgr:getById(arg_9_1)
	local var_9_2 = var_9_1 and var_9_1:getBuffDic()

	if var_9_2 then
		local var_9_3 = FightBuffHelper.getBuffMoSignKey(arg_9_2)
		local var_9_4 = 0

		for iter_9_0, iter_9_1 in pairs(var_9_2) do
			if var_9_3 == FightBuffHelper.getBuffMoSignKey(iter_9_1) then
				var_9_4 = var_9_4 + 1

				if iter_9_1.layer and iter_9_1.layer ~= 0 then
					var_9_4 = var_9_4 + iter_9_1.layer - 1
				end
			end
		end

		return var_9_4
	end

	return 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
