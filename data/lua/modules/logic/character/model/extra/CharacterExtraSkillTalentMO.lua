module("modules.logic.character.model.extra.CharacterExtraSkillTalentMO", package.seeall)

local var_0_0 = class("CharacterExtraSkillTalentMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0:_initRankTalentSkillPoint()
end

function var_0_0.isUnlockSystem(arg_2_0)
	if arg_2_0._unlockSystemRank then
		return arg_2_0.heroMo.rank >= arg_2_0._unlockSystemRank
	end
end

function var_0_0.refreshMo(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.heroMo = arg_3_2

	arg_3_0:initConfig()

	arg_3_0._extra = {}

	if not string.nilorempty(arg_3_1) then
		local var_3_0 = GameUtil.splitString2(arg_3_1, false, "|", "#")

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if not string.nilorempty(iter_3_1[1]) then
				local var_3_1 = tonumber(iter_3_1[1])

				if not string.nilorempty(iter_3_1[2]) then
					local var_3_2 = string.splitToNumber(iter_3_1[2], ",")

					arg_3_0._extra[var_3_1] = var_3_2
				end
			end
		end
	end

	arg_3_0:refreshStatus()
end

function var_0_0._initRankTalentSkillPoint(arg_4_0)
	arg_4_0._rankTalentSkillPoint = {}

	local var_4_0 = lua_fight_const.configDict[CharacterExtraEnum.UnlockTalentPointCountConst]
	local var_4_1 = GameUtil.splitString2(var_4_0.value, true)

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		arg_4_0._rankTalentSkillPoint[iter_4_1[1]] = iter_4_1[2]

		if arg_4_0._unlockSystemRank then
			arg_4_0._unlockSystemRank = math.min(arg_4_0._unlockSystemRank, iter_4_1[1])
		else
			arg_4_0._unlockSystemRank = iter_4_1[1]
		end
	end
end

function var_0_0.isNotLight(arg_5_0)
	return not LuaUtil.tableNotEmpty(arg_5_0._extra)
end

function var_0_0.getExtraCount(arg_6_0)
	return arg_6_0._extra and tabletool.len(arg_6_0._extra) or 0
end

function var_0_0.getSubExtra(arg_7_0)
	return arg_7_0._extra
end

function var_0_0.getMainFieldMo(arg_8_0)
	if arg_8_0:isNotLight() then
		return
	end

	local var_8_0 = arg_8_0.heroMo.exSkillLevel
	local var_8_1 = tabletool.len(arg_8_0._extra)

	for iter_8_0, iter_8_1 in pairs(arg_8_0._extra) do
		if iter_8_1 and #iter_8_1 > 0 and (var_8_1 == 1 or #iter_8_1 == 3) then
			table.sort(iter_8_1, function(arg_9_0, arg_9_1)
				return arg_9_1 < arg_9_0
			end)

			for iter_8_2, iter_8_3 in ipairs(iter_8_1) do
				local var_8_2 = arg_8_0:getMoById(iter_8_0, iter_8_3)
				local var_8_3 = var_8_2:getFieldDesc(var_8_0)

				if not string.nilorempty(var_8_3) then
					return var_8_2
				end
			end
		end
	end
end

function var_0_0._checkIsAllLight(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getTreeMosBySub(arg_10_1)

	for iter_10_0, iter_10_1 in ipairs(var_10_0:getTreeMoList()) do
		if not LuaUtil.tableContains(arg_10_2, iter_10_1.id) then
			return false
		end
	end

	return true
end

function var_0_0.showReddot(arg_11_0)
	if not arg_11_0.heroMo or not arg_11_0.heroMo:isOwnHero() then
		return
	end

	return arg_11_0:getTalentpoint() > 0
end

function var_0_0.refreshStatus(arg_12_0)
	local var_12_0 = arg_12_0:getTalentpoint()
	local var_12_1 = {}
	local var_12_2 = 0

	if arg_12_0._extra then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._extra) do
			local var_12_3 = iter_12_1 and tabletool.len(iter_12_1) or 0

			var_12_1[iter_12_0] = var_12_3
			var_12_2 = var_12_2 + var_12_3
		end
	end

	for iter_12_2 = 1, CharacterExtraEnum.TalentSkillSubCount do
		local var_12_4 = arg_12_0:getTreeMosBySub(iter_12_2):getTreeMoList()
		local var_12_5 = var_12_1[iter_12_2] or 0

		for iter_12_3, iter_12_4 in ipairs(var_12_4) do
			local var_12_6 = iter_12_3 - var_12_5
			local var_12_7 = CharacterExtraEnum.SkillTreeNodeStatus.Lock

			if var_12_2 == 0 then
				var_12_7 = CharacterExtraEnum.SkillTreeNodeStatus.Normal
			elseif var_12_5 > 0 then
				if iter_12_3 <= var_12_5 then
					var_12_7 = CharacterExtraEnum.SkillTreeNodeStatus.Light
				elseif var_12_6 <= var_12_0 then
					var_12_7 = CharacterExtraEnum.SkillTreeNodeStatus.Normal
				end
			elseif var_12_2 >= CharacterExtraEnum.TalentSkillTreeNodeCount and var_12_6 <= var_12_0 then
				var_12_7 = CharacterExtraEnum.SkillTreeNodeStatus.Normal
			end

			iter_12_4:setStatus(var_12_7)
		end
	end
end

function var_0_0.initConfig(arg_13_0)
	if arg_13_0._treeMoList then
		return
	end

	local var_13_0 = CharacterExtraConfig.instance:getSkillTalentCos()

	if not var_13_0 then
		return
	end

	arg_13_0._treeMoList = {}

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_1 = CharacterSkillTalentTreeMO.New()

		var_13_1:initMo(iter_13_0, iter_13_1)

		arg_13_0._treeMoList[iter_13_0] = var_13_1
	end
end

function var_0_0.getTreeMosBySub(arg_14_0, arg_14_1)
	return arg_14_0._treeMoList and arg_14_0._treeMoList[arg_14_1]
end

function var_0_0.getTreeNodeMoBySubLevel(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._treeMoList[arg_15_1]

	if var_15_0 then
		return var_15_0:getNodeMoByLevel(arg_15_2)
	end
end

function var_0_0.getMoById(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._treeMoList[arg_16_1]

	if var_16_0 then
		return var_16_0:getMoById(arg_16_2)
	end
end

function var_0_0.getLightOrCancelNodes(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0:getTreeNodeMoBySubLevel(arg_17_1, arg_17_2)
	local var_17_1 = arg_17_0._treeMoList[arg_17_1]:getTreeMoList()
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		if var_17_0:isLight() then
			if var_17_0.level <= iter_17_1.level and iter_17_1:isLight() then
				table.insert(var_17_2, iter_17_1)
			end
		elseif var_17_0.level >= iter_17_1.level and not iter_17_1:isLight() then
			table.insert(var_17_2, iter_17_1)
		end
	end

	return var_17_2
end

function var_0_0.getRankTalentSkillPoint(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0 = arg_18_1, 1, -1 do
		if arg_18_0._rankTalentSkillPoint[iter_18_0] then
			var_18_0 = var_18_0 + arg_18_0._rankTalentSkillPoint[iter_18_0]
		end
	end

	return var_18_0
end

function var_0_0.getTalentSkillPointByRank(arg_19_0, arg_19_1)
	return arg_19_0._rankTalentSkillPoint[arg_19_1] or 0
end

function var_0_0.getTalentpoint(arg_20_0)
	local var_20_0 = arg_20_0:getRankTalentSkillPoint(arg_20_0.heroMo.rank) or 0
	local var_20_1 = 0

	for iter_20_0, iter_20_1 in pairs(arg_20_0._extra) do
		for iter_20_2, iter_20_3 in pairs(iter_20_1) do
			var_20_1 = var_20_1 + 1
		end
	end

	return var_20_0 - var_20_1
end

function var_0_0.isNullTalentPonit(arg_21_0)
	return arg_21_0:getTalentpoint() == 0
end

function var_0_0.getUnlockSystemRank(arg_22_0)
	return arg_22_0._unlockSystemRank
end

function var_0_0.getUnlockRankStr(arg_23_0, arg_23_1)
	local var_23_0 = {}

	if not arg_23_0._unlockSystemRank then
		return
	end

	if arg_23_0._unlockSystemRank == arg_23_1 then
		local var_23_1 = luaLang("character_rankup_unlock_system")
		local var_23_2 = GameUtil.getSubPlaceholderLuaLangOneParam(var_23_1, luaLang("character_rankup_system_1"))

		table.insert(var_23_0, var_23_2)
	end

	local var_23_3 = arg_23_0:getTalentSkillPointByRank(arg_23_1 - 1)

	if var_23_3 and var_23_3 > 0 then
		local var_23_4 = luaLang("character_rankup_talentskilltree_add_point")
		local var_23_5 = GameUtil.getSubPlaceholderLuaLangOneParam(var_23_4, var_23_3)

		table.insert(var_23_0, var_23_5)
	end

	return var_23_0
end

function var_0_0.getSmallSubIconPath(arg_24_0, arg_24_1)
	return (string.format("characterskilltalent_job_0%s_small", arg_24_1))
end

function var_0_0.getWhiteSubIconPath(arg_25_0, arg_25_1)
	return (string.format("charactertalent_job_0%s", arg_25_1))
end

function var_0_0.getSubIconPath(arg_26_0, arg_26_1)
	local var_26_0 = "characterskilltalent_job_0%s_%s"
	local var_26_1 = arg_26_0:getTreeLightCount(arg_26_1)
	local var_26_2 = 1
	local var_26_3 = var_26_1 == 1 and 2 or var_26_1 == 0 and 1 or var_26_1

	return string.format(var_26_0, arg_26_1, var_26_3)
end

function var_0_0.getTreeLightCount(arg_27_0, arg_27_1)
	if not arg_27_0._extra then
		return 0
	end

	local var_27_0 = tabletool.len(arg_27_0._extra)
	local var_27_1 = arg_27_0._extra[arg_27_1]

	if var_27_1 and #var_27_1 > 0 and (var_27_0 == 1 or #var_27_1 == 3) then
		return #var_27_1
	end

	return 0
end

function var_0_0.getLightNodeAdditionalDesc(arg_28_0, arg_28_1)
	local var_28_0 = ""

	if not arg_28_0._extra then
		return var_28_0
	end

	for iter_28_0, iter_28_1 in pairs(arg_28_0._extra) do
		local var_28_1 = arg_28_0:getTreeMosBySub(iter_28_0)

		var_28_0 = var_28_0 .. var_28_1:getLightNodeAdditionalDesc(arg_28_1)
	end

	return var_28_0
end

function var_0_0.getReplaceSkills(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0:_getAllLightReplaceSkill()

	if var_29_0 then
		for iter_29_0, iter_29_1 in pairs(arg_29_1) do
			for iter_29_2, iter_29_3 in ipairs(var_29_0) do
				local var_29_1 = iter_29_3[1]
				local var_29_2 = iter_29_3[2]

				if arg_29_1[iter_29_0] == var_29_1 then
					arg_29_1[iter_29_0] = var_29_2
				end
			end
		end
	end

	return arg_29_1
end

function var_0_0._getAllLightReplaceSkill(arg_30_0)
	local var_30_0 = {}

	if not arg_30_0.heroMo then
		return var_30_0
	end

	if not arg_30_0._extra then
		return var_30_0
	end

	local var_30_1 = arg_30_0.heroMo.exSkillLevel
	local var_30_2 = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_0._extra) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1) do
			local var_30_3 = arg_30_0:getMoById(iter_30_0, iter_30_3)
			local var_30_4 = var_30_3 and var_30_3:getReplaceSkill(var_30_1)
			local var_30_5 = {
				id = iter_30_3,
				skills = var_30_4
			}

			table.insert(var_30_2, var_30_5)
		end
	end

	table.sort(var_30_2, function(arg_31_0, arg_31_1)
		return arg_31_0.id < arg_31_1.id
	end)

	for iter_30_4, iter_30_5 in ipairs(var_30_2) do
		tabletool.addValues(var_30_0, iter_30_5.skills)
	end

	return var_30_0
end

return var_0_0
