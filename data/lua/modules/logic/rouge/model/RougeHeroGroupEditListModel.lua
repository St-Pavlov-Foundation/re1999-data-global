module("modules.logic.rouge.model.RougeHeroGroupEditListModel", package.seeall)

local var_0_0 = class("RougeHeroGroupEditListModel", ListScrollModel)

function var_0_0.setMoveHeroId(arg_1_0, arg_1_1)
	arg_1_0._moveHeroId = arg_1_1
end

function var_0_0.getMoveHeroIndex(arg_2_0)
	return arg_2_0._moveHeroIndex
end

function var_0_0.setHeroGroupEditType(arg_3_0, arg_3_1)
	arg_3_0._heroGroupEditType = arg_3_1
	arg_3_0._skipAssitType = arg_3_0._heroGroupEditType == RougeEnum.HeroGroupEditType.Init or arg_3_0._heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero
end

function var_0_0.setCapacityInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0._selectHeroCapacity = arg_4_1
	arg_4_0._curCapacity = arg_4_2
	arg_4_0._totalCapacity = arg_4_3
	arg_4_0._assistCapacity = arg_4_4 or 0
	arg_4_0._assistPos = arg_4_5
	arg_4_0._assistHeroId = arg_4_6
end

function var_0_0.getAssistHeroId(arg_5_0)
	return arg_5_0._assistHeroId
end

function var_0_0.getAssistCapacity(arg_6_0)
	return arg_6_0._assistCapacity
end

function var_0_0.getAssistPos(arg_7_0)
	return arg_7_0._assistPos
end

function var_0_0.getTotalCapacity(arg_8_0)
	return arg_8_0._totalCapacity
end

function var_0_0.canAddCapacity(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._curCapacity or not arg_9_0._totalCapacity then
		return false
	end

	return arg_9_0:calcTotalCapacity(arg_9_1, arg_9_2) <= arg_9_0._totalCapacity
end

function var_0_0.calcTotalCapacity(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = 0
	local var_10_1 = RougeHeroSingleGroupModel.instance:getList()
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		local var_10_3 = iter_10_1:getHeroMO()

		if var_10_3 == arg_10_2 then
			var_10_3 = nil
		end

		if iter_10_0 == arg_10_1 then
			var_10_3 = arg_10_2
		end

		if iter_10_0 > RougeEnum.FightTeamNormalHeroNum and not arg_10_0._skipAssitType and not var_10_2[iter_10_0 - RougeEnum.FightTeamNormalHeroNum] then
			var_10_3 = nil
		end

		var_10_2[iter_10_0] = var_10_3
	end

	for iter_10_2, iter_10_3 in pairs(var_10_2) do
		var_10_0 = var_10_0 + RougeController.instance:getRoleStyleCapacity(iter_10_3, iter_10_2 > RougeEnum.FightTeamNormalHeroNum and not arg_10_0._skipAssitType)
	end

	return var_10_0 + arg_10_0._assistCapacity
end

function var_0_0.getHeroGroupEditType(arg_11_0)
	return arg_11_0._heroGroupEditType
end

function var_0_0.getTeamNoSortedList(arg_12_0)
	local var_12_0 = RougeModel.instance:getTeamInfo().heroLifeMap
	local var_12_1 = {}
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		local var_12_3 = HeroModel.instance:getByHeroId(iter_12_1.heroId)

		table.insert(var_12_1, var_12_3)
	end

	return var_12_1
end

function var_0_0.getTeamList(arg_13_0, arg_13_1)
	local var_13_0 = RougeModel.instance:getTeamInfo().heroLifeMap
	local var_13_1 = {}
	local var_13_2 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_3 = var_13_0[iter_13_1.heroId]

		if var_13_3 then
			local var_13_4 = HeroModel.instance:getByHeroId(var_13_3.heroId)

			if var_13_3.life > 0 then
				table.insert(var_13_1, var_13_4)
			else
				table.insert(var_13_2, var_13_4)
			end
		end
	end

	tabletool.addValues(var_13_1, var_13_2)

	return var_13_1
end

function var_0_0.getSelectHeroList(arg_14_0, arg_14_1)
	local var_14_0 = RougeModel.instance:getTeamInfo().heroLifeMap
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		if not var_14_0[iter_14_1.heroId] then
			table.insert(var_14_1, iter_14_1)
		end
	end

	return var_14_1
end

function var_0_0.copyCharacterCardList(arg_15_0, arg_15_1)
	local var_15_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()

	if arg_15_0._heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or arg_15_0._heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit then
		var_15_0 = arg_15_0:getTeamList(var_15_0)
	elseif arg_15_0._heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		var_15_0 = arg_15_0:getSelectHeroList(var_15_0)
	end

	local var_15_1 = {}
	local var_15_2 = {}

	arg_15_0._inTeamHeroUids = {}
	arg_15_0._heroTeamPosIndex = {}

	local var_15_3 = 1
	local var_15_4 = 1
	local var_15_5 = RougeHeroSingleGroupModel.instance:getList()

	for iter_15_0, iter_15_1 in ipairs(var_15_5) do
		if iter_15_1.trial or not iter_15_1.aid and tonumber(iter_15_1.heroUid) > 0 and not var_15_2[iter_15_1.heroUid] then
			if iter_15_1.trial then
				table.insert(var_15_1, HeroGroupTrialModel.instance:getById(iter_15_1.heroUid))
			else
				table.insert(var_15_1, HeroModel.instance:getById(iter_15_1.heroUid))
			end

			if arg_15_0.specialHero == iter_15_1.heroUid then
				arg_15_0._inTeamHeroUids[iter_15_1.heroUid] = 2
				var_15_3 = var_15_4
			else
				arg_15_0._inTeamHeroUids[iter_15_1.heroUid] = 1
				var_15_4 = var_15_4 + 1
			end

			var_15_2[iter_15_1.heroUid] = true
			arg_15_0._heroTeamPosIndex[iter_15_1.heroUid] = iter_15_0
		end
	end

	for iter_15_2, iter_15_3 in ipairs(var_15_1) do
		if arg_15_0._moveHeroId and iter_15_3.heroId == arg_15_0._moveHeroId then
			arg_15_0._moveHeroId = nil
			arg_15_0._moveHeroIndex = iter_15_2

			break
		end
	end

	local var_15_6 = #var_15_1
	local var_15_7 = {}

	for iter_15_4, iter_15_5 in ipairs(var_15_0) do
		if not var_15_2[iter_15_5.uid] then
			var_15_2[iter_15_5.uid] = true

			if arg_15_0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(iter_15_5.heroId) > 0 then
					table.insert(var_15_7, iter_15_5)
				else
					table.insert(var_15_1, iter_15_5)
				end
			elseif arg_15_0._moveHeroId and iter_15_5.heroId == arg_15_0._moveHeroId then
				arg_15_0._moveHeroId = nil
				arg_15_0._moveHeroIndex = var_15_6 + 1

				table.insert(var_15_1, arg_15_0._moveHeroIndex, iter_15_5)
			elseif iter_15_5.heroId ~= arg_15_0._assistHeroId then
				table.insert(var_15_1, iter_15_5)
			end
		end
	end

	if arg_15_0.adventure then
		tabletool.addValues(var_15_1, var_15_7)
	end

	arg_15_0:setList(var_15_1)

	if (arg_15_0._heroGroupEditType == RougeEnum.HeroGroupEditType.Init or arg_15_0._heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit or arg_15_0._heroGroupEditType == RougeEnum.HeroGroupEditType.Fight) and (arg_15_0._selectHeroCapacity or 0) <= 0 then
		var_15_3 = 0
	end

	if arg_15_1 and #var_15_1 > 0 and var_15_3 > 0 and #arg_15_0._scrollViews > 0 then
		for iter_15_6, iter_15_7 in ipairs(arg_15_0._scrollViews) do
			iter_15_7:selectCell(var_15_3, true)
		end

		if var_15_1[var_15_3] then
			return var_15_1[var_15_3]
		end
	end
end

function var_0_0.isRepeatHero(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0._inTeamHeroUids then
		return false
	end

	for iter_16_0 in pairs(arg_16_0._inTeamHeroUids) do
		local var_16_0 = arg_16_0:getById(iter_16_0)

		if var_16_0.heroId == arg_16_1 and arg_16_2 ~= var_16_0.uid then
			return true
		end
	end

	return false
end

function var_0_0.isTrialLimit(arg_17_0)
	if not arg_17_0._inTeamHeroUids then
		return false
	end

	local var_17_0 = 0

	for iter_17_0 in pairs(arg_17_0._inTeamHeroUids) do
		if arg_17_0:getById(iter_17_0):isTrial() then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0 >= HeroGroupTrialModel.instance:getLimitNum()
end

function var_0_0.cancelAllSelected(arg_18_0)
	if arg_18_0._scrollViews then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._scrollViews) do
			local var_18_0 = iter_18_1:getFirstSelect()
			local var_18_1 = arg_18_0:getIndex(var_18_0)

			iter_18_1:selectCell(var_18_1, false)
		end
	end
end

function var_0_0.isInTeamHero(arg_19_0, arg_19_1)
	return arg_19_0._inTeamHeroUids and arg_19_0._inTeamHeroUids[arg_19_1]
end

function var_0_0.getTeamPosIndex(arg_20_0, arg_20_1)
	return arg_20_0._heroTeamPosIndex[arg_20_1]
end

function var_0_0.setParam(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.specialHero = arg_21_1
	arg_21_0.adventure = arg_21_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
