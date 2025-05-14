module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroGroupEditListModel", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupEditListModel", ListScrollModel)

function var_0_0.setMoveHeroId(arg_1_0, arg_1_1)
	arg_1_0._moveHeroId = arg_1_1
end

function var_0_0.getMoveHeroIndex(arg_2_0)
	return arg_2_0._moveHeroIndex
end

function var_0_0.setHeroGroupEditType(arg_3_0, arg_3_1)
	arg_3_0._heroGroupEditType = arg_3_1
end

function var_0_0.getHeroGroupEditType(arg_4_0)
	return arg_4_0._heroGroupEditType
end

function var_0_0.setSeatLevel(arg_5_0, arg_5_1)
	arg_5_0._seatLevel = arg_5_1
end

function var_0_0.getSeatLevel(arg_6_0)
	return arg_6_0._seatLevel
end

function var_0_0.copyCharacterCardList(arg_7_0, arg_7_1)
	local var_7_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()

	if arg_7_0._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Fight then
		local var_7_1 = V1a6_CachotModel.instance:getTeamInfo()
		local var_7_2 = var_7_1:getAllHeroIdsMap()
		local var_7_3 = {}
		local var_7_4 = {}

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if var_7_2[iter_7_1.heroId] then
				if var_7_1:getHeroHp(iter_7_1.heroId).life > 0 then
					table.insert(var_7_3, iter_7_1)
				else
					table.insert(var_7_4, iter_7_1)
				end
			end
		end

		tabletool.addValues(var_7_3, var_7_4)

		var_7_0 = var_7_3
	end

	local var_7_5 = {}
	local var_7_6 = {}

	arg_7_0._inTeamHeroUids = {}

	local var_7_7 = 1
	local var_7_8 = 1
	local var_7_9 = V1a6_CachotHeroSingleGroupModel.instance:getList()

	for iter_7_2, iter_7_3 in ipairs(var_7_9) do
		if iter_7_3.trial or not iter_7_3.aid and tonumber(iter_7_3.heroUid) > 0 and not var_7_6[iter_7_3.heroUid] then
			if iter_7_3.trial then
				table.insert(var_7_5, HeroGroupTrialModel.instance:getById(iter_7_3.heroUid))
			else
				table.insert(var_7_5, HeroModel.instance:getById(iter_7_3.heroUid))
			end

			if arg_7_0.specialHero == iter_7_3.heroUid then
				arg_7_0._inTeamHeroUids[iter_7_3.heroUid] = 2
				var_7_7 = var_7_8
			else
				arg_7_0._inTeamHeroUids[iter_7_3.heroUid] = 1
				var_7_8 = var_7_8 + 1
			end

			var_7_6[iter_7_3.heroUid] = true
		end
	end

	for iter_7_4, iter_7_5 in ipairs(var_7_5) do
		if arg_7_0._moveHeroId and iter_7_5.heroId == arg_7_0._moveHeroId then
			arg_7_0._moveHeroId = nil
			arg_7_0._moveHeroIndex = iter_7_4

			break
		end
	end

	local var_7_10 = #var_7_5
	local var_7_11 = {}

	for iter_7_6, iter_7_7 in ipairs(var_7_0) do
		if not var_7_6[iter_7_7.uid] then
			var_7_6[iter_7_7.uid] = true

			if arg_7_0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(iter_7_7.heroId) > 0 then
					table.insert(var_7_11, iter_7_7)
				else
					table.insert(var_7_5, iter_7_7)
				end
			elseif arg_7_0._moveHeroId and iter_7_7.heroId == arg_7_0._moveHeroId then
				arg_7_0._moveHeroId = nil
				arg_7_0._moveHeroIndex = var_7_10 + 1

				table.insert(var_7_5, arg_7_0._moveHeroIndex, iter_7_7)
			elseif arg_7_0._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
				table.insert(var_7_5, #var_7_5 - var_7_10 + 1, iter_7_7)
			else
				table.insert(var_7_5, iter_7_7)
			end
		end
	end

	if arg_7_0.adventure then
		tabletool.addValues(var_7_5, var_7_11)
	end

	arg_7_0:setList(var_7_5)

	if arg_7_0._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event and #V1a6_CachotModel.instance:getRogueInfo().teamInfo:getFightHeros() == #var_7_5 then
		var_7_7 = 0
	end

	if arg_7_1 and #var_7_5 > 0 and var_7_7 > 0 and #arg_7_0._scrollViews > 0 then
		for iter_7_8, iter_7_9 in ipairs(arg_7_0._scrollViews) do
			iter_7_9:selectCell(var_7_7, true)
		end

		if var_7_5[var_7_7] then
			return var_7_5[var_7_7]
		end
	end
end

function var_0_0.isRepeatHero(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._inTeamHeroUids then
		return false
	end

	for iter_8_0 in pairs(arg_8_0._inTeamHeroUids) do
		local var_8_0 = arg_8_0:getById(iter_8_0)

		if var_8_0.heroId == arg_8_1 and arg_8_2 ~= var_8_0.uid then
			return true
		end
	end

	return false
end

function var_0_0.isTrialLimit(arg_9_0)
	if not arg_9_0._inTeamHeroUids then
		return false
	end

	local var_9_0 = 0

	for iter_9_0 in pairs(arg_9_0._inTeamHeroUids) do
		if arg_9_0:getById(iter_9_0):isTrial() then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0 >= HeroGroupTrialModel.instance:getLimitNum()
end

function var_0_0.cancelAllSelected(arg_10_0)
	if arg_10_0._scrollViews then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._scrollViews) do
			local var_10_0 = iter_10_1:getFirstSelect()
			local var_10_1 = arg_10_0:getIndex(var_10_0)

			iter_10_1:selectCell(var_10_1, false)
		end
	end
end

function var_0_0.isInTeamHero(arg_11_0, arg_11_1)
	return arg_11_0._inTeamHeroUids and arg_11_0._inTeamHeroUids[arg_11_1]
end

function var_0_0.setParam(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0.specialHero = arg_12_1
	arg_12_0.adventure = arg_12_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
