module("modules.logic.versionactivity2_7.act191.config.Activity191Config", package.seeall)

local var_0_0 = class("Activity191Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity191_const",
		"activity191_init_build",
		"activity191_node",
		"activity191_badge",
		"activity191_stage",
		"activity191_role",
		"activity191_collection",
		"activity191_template",
		"activity191_relation",
		"activity191_assist_boss",
		"activity191_enhance",
		"activity191_shop",
		"activity191_event",
		"activity191_fight_event",
		"activity191_match_rank",
		"activity191_pvp_match",
		"activity191_rank",
		"activity191_effect",
		"activity191_item",
		"activity191_ex_level",
		"activity191_eff_desc",
		"activity191_relation_select",
		"activity191_summon"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity191_role" then
		arg_3_0._roleConfig = arg_3_2
	end
end

function var_0_0.getRoleCoByNativeId(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = Activity191Model.instance:getCurActId()

	for iter_4_0, iter_4_1 in ipairs(lua_activity191_role.configList) do
		if iter_4_1.activityId == var_4_0 and iter_4_1.roleId == arg_4_1 and iter_4_1.star == arg_4_2 then
			return iter_4_1
		end
	end

	if not arg_4_3 then
		logError(string.format("找不到角色配置 : 活动ID %s 角色ID %s 角色星级 %s", var_4_0, arg_4_1, arg_4_2))
	end
end

function var_0_0.getRoleCo(arg_5_0, arg_5_1)
	arg_5_1 = tonumber(arg_5_1)

	local var_5_0 = arg_5_0._roleConfig.configDict[arg_5_1]

	if not var_5_0 then
		logError(string.format("找不到角色配置 ： 玩法角色ID %s", arg_5_1))
	end

	return var_5_0
end

function var_0_0.getShowRoleCoList(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._roleConfig.configList) do
		if iter_6_1.activityId == arg_6_1 and iter_6_1.star == 1 then
			var_6_0[#var_6_0 + 1] = iter_6_1
		end
	end

	table.sort(var_6_0, Activity191Helper.sortRoleCo)

	return var_6_0
end

function var_0_0.getCollectionCo(arg_7_0, arg_7_1)
	local var_7_0 = lua_activity191_collection.configDict[arg_7_1]

	if not var_7_0 then
		logError(string.format("找不到造物配置 ： 造物ID %s", arg_7_1))
	end

	return var_7_0
end

function var_0_0.getEnhanceCo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(lua_activity191_enhance.configList) do
		if iter_8_1.activityId == arg_8_1 and iter_8_1.id == arg_8_2 then
			var_8_0 = iter_8_1

			break
		end
	end

	if not var_8_0 then
		logError(string.format("找不到强化配置 ： 强化ID %s", arg_8_2))
	end

	return var_8_0
end

function var_0_0.getRelationCoList(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = Activity191Model.instance:getCurActId()

	for iter_9_0, iter_9_1 in ipairs(lua_activity191_relation.configList) do
		if iter_9_1.activityId == var_9_1 and iter_9_1.tag == arg_9_1 then
			var_9_0[iter_9_1.level] = iter_9_1
		end
	end

	if next(var_9_0) then
		return var_9_0
	else
		logError(string.format("找不到羁绊配置 ： 羁绊ID %s", arg_9_1))
	end
end

function var_0_0.getRelationCo(arg_10_0, arg_10_1, arg_10_2)
	arg_10_2 = arg_10_2 or 0

	local var_10_0 = arg_10_0:getRelationCoList(arg_10_1)

	if var_10_0 and var_10_0[arg_10_2] then
		return var_10_0[arg_10_2]
	else
		logError(string.format("找不到羁绊配置 ： 羁绊ID %s   羁绊等级 %s", arg_10_1, arg_10_2))
	end
end

function var_0_0.getRelationMaxCo(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getRelationCoList(arg_11_1)

	return var_11_0[#var_11_0]
end

function var_0_0.getHeroPassiveSkillIdList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getRoleCo(arg_12_1)

	if string.nilorempty(var_12_0.passiveSkill) then
		local var_12_1 = {}
		local var_12_2 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(var_12_0.roleId, var_12_0.exLevel)

		for iter_12_0, iter_12_1 in pairs(var_12_2) do
			var_12_1[iter_12_0] = iter_12_1.skillPassive
		end

		return var_12_1
	else
		return string.splitToNumber(var_12_0.passiveSkill, "|")
	end
end

function var_0_0.getHeroSkillIdDic(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getRoleCo(arg_13_1)

	if string.nilorempty(var_13_0.activeSkill1) then
		local var_13_1 = var_13_0.roleId
		local var_13_2 = math.min(var_13_0.exLevel, CharacterEnum.MaxSkillExLevel)

		if arg_13_2 then
			local var_13_3 = SkillConfig.instance:getHeroBaseSkillIdDict(var_13_1)

			if var_13_2 < 1 then
				return var_13_3
			end

			local var_13_4

			for iter_13_0 = 1, var_13_2 do
				local var_13_5 = arg_13_0:getHeroLevelExSkillCo(arg_13_1, iter_13_0)

				if not string.nilorempty(var_13_5.skillGroup1) then
					var_13_3[1] = string.splitToNumber(var_13_5.skillGroup1, "|")[1]
				end

				if not string.nilorempty(var_13_5.skillGroup2) then
					var_13_3[2] = string.splitToNumber(var_13_5.skillGroup2, "|")[1]
				end

				if var_13_5.skillEx ~= 0 then
					var_13_3[3] = var_13_5.skillEx
				end
			end

			return var_13_3
		else
			local var_13_6 = SkillConfig.instance:getHeroAllSkillIdDict(var_13_1)

			if var_13_2 < 1 then
				return var_13_6
			end

			local var_13_7

			for iter_13_1 = 1, var_13_2 do
				local var_13_8 = arg_13_0:getHeroLevelExSkillCo(arg_13_1, iter_13_1)

				if not string.nilorempty(var_13_8.skillGroup1) then
					var_13_6[1] = string.splitToNumber(var_13_8.skillGroup1, "|")
				end

				if not string.nilorempty(var_13_8.skillGroup2) then
					var_13_6[2] = string.splitToNumber(var_13_8.skillGroup2, "|")
				end

				if var_13_8.skillEx ~= 0 then
					var_13_6[3] = {
						var_13_8.skillEx
					}
				end
			end

			return var_13_6
		end
	else
		local var_13_9 = {}
		local var_13_10 = string.splitToNumber(var_13_0.activeSkill1, "#")
		local var_13_11 = GameUtil.splitString2(var_13_0.activeSkill2, true, ",", "#")[1]

		if arg_13_2 then
			var_13_9[1] = var_13_10[1]
			var_13_9[2] = var_13_11[1]
			var_13_9[3] = var_13_0.uniqueSkill
		else
			var_13_9[1] = var_13_10
			var_13_9[2] = var_13_11
			var_13_9[3] = {
				var_13_0.uniqueSkill
			}
		end

		return var_13_9
	end
end

function var_0_0.getHeroLevelExSkillCo(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getRoleCo(arg_14_1)

	if var_14_0.type == Activity191Enum.CharacterType.Hero then
		return SkillConfig.instance:getherolevelexskillCO(var_14_0.roleId, arg_14_2)
	else
		local var_14_1 = lua_activity191_ex_level.configDict[var_14_0.roleId]

		if not var_14_1 then
			logError(string.format("ex skill not found heroid : %s `s config ", var_14_0.roleId))

			return nil
		end

		if var_14_1[arg_14_2] == nil then
			logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", var_14_0.roleId, arg_14_2))
		end

		return var_14_1[arg_14_2]
	end
end

function var_0_0.getExSkillDesc(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == nil then
		return ""
	end

	local var_15_0 = arg_15_1.desc

	if LangSettings.instance:isEn() then
		var_15_0 = SkillConfig.replaceHeroName(var_15_0, arg_15_2)
	end

	local var_15_1, var_15_2, var_15_3 = string.find(var_15_0, "▩(%d)%%s")

	if not var_15_3 then
		logError("not fount skillIndex in desc : " .. var_15_0)

		return var_15_0
	end

	local var_15_4 = tonumber(var_15_3)
	local var_15_5

	if var_15_4 == 0 then
		var_15_5 = arg_15_0:getHeroPassiveSkillIdList(arg_15_2)[1]
	else
		var_15_5 = arg_15_0:getHeroSkillIdDic(arg_15_2, true)[var_15_4]
	end

	if not var_15_5 then
		logError("not fount skillId, skillIndex : " .. var_15_4)

		return var_15_0
	end

	return var_15_0, lua_skill.configDict[var_15_5].name, var_15_4
end

function var_0_0.getFetterHeroList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = lua_activity191_role.configList

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		if iter_16_1.activityId == arg_16_2 and iter_16_1.star == 1 then
			local var_16_2 = string.split(iter_16_1.tag, "#")

			if tabletool.indexOf(var_16_2, arg_16_1) then
				local var_16_3 = {
					inBag = 1,
					transfer = 0,
					config = iter_16_1
				}

				var_16_0[#var_16_0 + 1] = var_16_3
			end
		end
	end

	table.sort(var_16_0, Activity191Helper.sortFetterHeroList)

	return var_16_0
end

function var_0_0.getEffDescCoByName(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(lua_activity191_eff_desc.configList) do
		if iter_17_1.name == arg_17_1 then
			return iter_17_1
		end
	end

	logError("not fount skillId, skillIndex : " .. arg_17_1)
end

var_0_0.AttrIdToFieldName = {
	[CharacterEnum.AttrId.Attack] = "attack",
	[CharacterEnum.AttrId.Defense] = "defense",
	[CharacterEnum.AttrId.Technic] = "technic",
	[CharacterEnum.AttrId.Hp] = "life",
	[CharacterEnum.AttrId.Mdefense] = "mdefense"
}

function var_0_0.getBossCfgListByTag(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(lua_activity191_assist_boss.configList) do
		if iter_18_1.relation == arg_18_1 then
			var_18_0[#var_18_0 + 1] = iter_18_1
		end
	end

	table.sort(var_18_0, function(arg_19_0, arg_19_1)
		return arg_19_0.bossId > arg_19_1.bossId
	end)

	return var_18_0
end

function var_0_0.getSummonCfg(arg_20_0, arg_20_1)
	local var_20_0 = lua_activity191_summon.configDict[arg_20_1]

	if var_20_0 then
		return var_20_0
	else
		logError(string.format("斗蛐蛐召唤物表 id : %s 找不到对应配置", arg_20_1))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
