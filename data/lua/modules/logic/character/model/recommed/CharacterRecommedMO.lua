module("modules.logic.character.model.recommed.CharacterRecommedMO", package.seeall)

local var_0_0 = pureTable("CharacterRecommedMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.heroId = arg_1_1.id
	arg_1_0.co = arg_1_1
	arg_1_0.teamRec = GameUtil.splitString2(arg_1_1.teamRec, true, "|", "#")
	arg_1_0.equipRec = string.splitToNumber(arg_1_1.equipRec, "|")
	arg_1_0.lvRec = GameUtil.splitString2(arg_1_1.lvRec, true, "|", "#")
	arg_1_0.resonanceRec = string.splitToNumber(arg_1_1.resonanceRec, "|")
end

function var_0_0.getHeroMo(arg_2_0)
	return (HeroModel.instance:getByHeroId(arg_2_0.heroId))
end

function var_0_0.getHeroConfig(arg_3_0)
	return HeroConfig.instance:getHeroCO(arg_3_0.heroId)
end

function var_0_0.getHeroSkinConfig(arg_4_0)
	local var_4_0 = arg_4_0:getHeroMo()
	local var_4_1 = arg_4_0:getHeroConfig()
	local var_4_2 = var_4_0 and var_4_0.skin or var_4_1.skinId

	return SkinConfig.instance:getSkinCo(var_4_2)
end

function var_0_0.isOwnHero(arg_5_0)
	local var_5_0 = arg_5_0:getHeroMo()

	if not var_5_0 then
		return
	end

	return var_5_0:isOwnHero()
end

function var_0_0.getHeroLevel(arg_6_0)
	local var_6_0 = arg_6_0:getHeroMo()

	if var_6_0 then
		return var_6_0.level
	end

	return (CharacterModel.instance:getMaxLevel(arg_6_0.heroId))
end

function var_0_0.getHeroRank(arg_7_0)
	local var_7_0 = arg_7_0:getHeroMo()

	if var_7_0 then
		return var_7_0.rank
	end

	return (CharacterModel.instance:getMaxRank(arg_7_0.heroId))
end

function var_0_0.isFavor(arg_8_0)
	local var_8_0 = arg_8_0:getHeroMo()

	if var_8_0 then
		return var_8_0.isFavor
	end
end

function var_0_0.getExSkillLevel(arg_9_0)
	local var_9_0 = arg_9_0:getHeroMo()

	if var_9_0 then
		return var_9_0.exSkillLevel
	end

	return (CharacterModel.instance:getMaxexskill(arg_9_0.heroId))
end

function var_0_0.getTalentLevel(arg_10_0)
	local var_10_0 = arg_10_0:getHeroMo()

	if var_10_0 then
		return var_10_0.talent
	end

	return #SkillConfig.instance:getherotalentsCo(arg_10_0.heroId)
end

function var_0_0.isShowTeam(arg_11_0)
	return arg_11_0.co.teamDisplay == 1 and not string.nilorempty(arg_11_0.co.teamRec)
end

function var_0_0.isShowEquip(arg_12_0)
	return arg_12_0.co.equipDisplay == 1 and not string.nilorempty(arg_12_0.co.equipRec)
end

function var_0_0.getNextDevelopMaterial(arg_13_0)
	local var_13_0 = arg_13_0:getHeroMo()
	local var_13_1 = arg_13_0:getHeroConfig()

	if not arg_13_0._developGoalsMOList then
		arg_13_0._developGoalsMOList = {}
	end

	local var_13_2 = var_13_0 and var_13_0.rank or 1
	local var_13_3 = var_13_0 and var_13_0.level or 1
	local var_13_4, var_13_5 = HeroConfig.instance:getShowLevel(var_13_3)
	local var_13_6 = arg_13_0:_getRecommedLvRec(var_13_4, var_13_5)

	if var_13_6 then
		local var_13_7 = var_13_6[1]
		local var_13_8 = {}

		for iter_13_0 = var_13_2 + 1, var_13_7 do
			local var_13_9 = SkillConfig.instance:getherorankCO(arg_13_0.heroId, iter_13_0)

			if var_13_9 and not string.nilorempty(var_13_9.consume) then
				arg_13_0:_addMaterials(var_13_9.consume, var_13_8)
			end
		end

		local var_13_10 = arg_13_0:_getRealLevel(var_13_7, var_13_6[2])
		local var_13_11 = arg_13_0:_getIgnoreLevel(var_13_0.heroId)

		for iter_13_1 = var_13_3 + 1, var_13_10 do
			if not LuaUtil.tableContains(var_13_11, iter_13_1) then
				local var_13_12 = SkillConfig.instance:getcosumeCO(iter_13_1, var_13_1.rare)

				arg_13_0:_addMaterials(var_13_12.cosume, var_13_8)
			end
		end

		local var_13_13 = arg_13_0:_convertMaterial(var_13_8)
		local var_13_14 = CharacterRecommedEnum.DevelopGoalsType.RankLevel
		local var_13_15 = arg_13_0._developGoalsMOList[var_13_14]

		if not var_13_15 then
			var_13_15 = CharacterDevelopGoalsMO.New()

			var_13_15:init(var_13_14, arg_13_0.heroId)

			arg_13_0._developGoalsMOList[var_13_14] = var_13_15
		end

		var_13_15:setItemList(var_13_13)

		local var_13_16
		local var_13_17

		if var_13_7 > 1 then
			local var_13_18 = luaLang("character_develop_goals_title_1")

			var_13_17 = "character_recommend_targeticon" .. 3 + var_13_7

			local var_13_19 = GameUtil.getRomanNums(var_13_7 - 1)

			var_13_16 = GameUtil.getSubPlaceholderLuaLangTwoParam(var_13_18, var_13_19, var_13_6[2])
		else
			local var_13_20 = luaLang("character_develop_goals_title_2")

			var_13_16 = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_20, var_13_6[2])
		end

		var_13_15:setTitleTxtAndIcon(var_13_16, var_13_17)
	else
		arg_13_0._developGoalsMOList[CharacterRecommedEnum.DevelopGoalsType.RankLevel] = nil
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) and var_13_2 >= CharacterEnum.TalentRank then
		local var_13_21 = arg_13_0:getTalentLevel()
		local var_13_22 = arg_13_0:_getRecommedTalentLvRec(var_13_21)

		if var_13_22 then
			local var_13_23 = {}

			for iter_13_2 = var_13_21 + 1, var_13_22 do
				local var_13_24 = SkillConfig.instance:gettalentCO(arg_13_0.heroId, iter_13_2)

				if var_13_24 then
					arg_13_0:_addMaterials(var_13_24.consume, var_13_23)
				end
			end

			local var_13_25 = arg_13_0:_convertMaterial(var_13_23)
			local var_13_26 = CharacterRecommedEnum.DevelopGoalsType.TalentLevel
			local var_13_27 = arg_13_0._developGoalsMOList[var_13_26]

			if not var_13_27 then
				var_13_27 = CharacterDevelopGoalsMO.New()

				var_13_27:init(var_13_26, arg_13_0.heroId)

				arg_13_0._developGoalsMOList[var_13_26] = var_13_27
			end

			var_13_27:setItemList(var_13_25)

			local var_13_28 = luaLang("character_develop_goals_title_3")
			local var_13_29 = GameUtil.getSubPlaceholderLuaLangOneParam(var_13_28, var_13_22)
			local var_13_30 = "character_recommend_targeticon3"

			var_13_27:setTitleTxtAndIcon(var_13_29, var_13_30)
		else
			arg_13_0._developGoalsMOList[CharacterRecommedEnum.DevelopGoalsType.TalentLevel] = nil
		end
	end

	return arg_13_0._developGoalsMOList
end

function var_0_0.getDevelopGoalsMO(arg_14_0, arg_14_1)
	return arg_14_0:getNextDevelopMaterial()[arg_14_1]
end

function var_0_0._convertMaterial(arg_15_0, arg_15_1)
	local var_15_0 = {}

	if not arg_15_1 then
		return
	end

	for iter_15_0, iter_15_1 in pairs(arg_15_1) do
		for iter_15_2, iter_15_3 in pairs(iter_15_1) do
			table.insert(var_15_0, {
				materilType = iter_15_0,
				materilId = iter_15_2,
				quantity = iter_15_3
			})
		end
	end

	return var_15_0
end

function var_0_0._getRealLevel(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = SkillConfig.instance:getherorankCO(arg_16_0.heroId, arg_16_1)

	if not var_16_0 then
		return CharacterModel.instance:getMaxLevel(arg_16_0.heroId)
	end

	local var_16_1 = string.split(var_16_0.requirement, "|")

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		local var_16_2 = string.splitToNumber(iter_16_1, "#")

		if var_16_2[1] == 1 then
			return var_16_2[2] + arg_16_2, var_16_2[2]
		end
	end

	return arg_16_2
end

function var_0_0._getIgnoreLevel(arg_17_0, arg_17_1)
	if not arg_17_0._ignoreLevels then
		arg_17_0._ignoreLevels = {}
	end

	local var_17_0 = arg_17_0._ignoreLevels[arg_17_1]

	if not var_17_0 then
		var_17_0 = {}

		local var_17_1 = SkillConfig.instance:getheroranksCO(arg_17_0.heroId)

		for iter_17_0, iter_17_1 in pairs(var_17_1) do
			local var_17_2 = string.split(iter_17_1.requirement, "|")

			for iter_17_2, iter_17_3 in pairs(var_17_2) do
				local var_17_3 = string.splitToNumber(iter_17_3, "#")

				if var_17_3[1] == 1 then
					table.insert(var_17_0, var_17_3[2] + 1)
				end
			end
		end

		arg_17_0._ignoreLevels[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0._addMaterials(arg_18_0, arg_18_1, arg_18_2)
	if string.nilorempty(arg_18_1) then
		return
	end

	local var_18_0 = GameUtil.splitString2(arg_18_1, true, "|", "#")

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_1 = arg_18_2[iter_18_1[1]]

		if not arg_18_2[iter_18_1[1]] then
			var_18_1 = {}
		end

		local var_18_2 = var_18_1[iter_18_1[2]]

		if var_18_2 then
			var_18_1[iter_18_1[2]] = var_18_2 + iter_18_1[3]
		else
			var_18_1[iter_18_1[2]] = iter_18_1[3]
		end

		arg_18_2[iter_18_1[1]] = var_18_1
	end
end

function var_0_0._getRecommedLvRec(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.lvRec) do
		if iter_19_1[1] == arg_19_2 and arg_19_1 < iter_19_1[2] or arg_19_2 < iter_19_1[1] then
			return iter_19_1
		end
	end
end

function var_0_0._getRecommedTalentLvRec(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.resonanceRec) do
		if arg_20_1 < iter_20_1 then
			return iter_20_1
		end
	end
end

return var_0_0
