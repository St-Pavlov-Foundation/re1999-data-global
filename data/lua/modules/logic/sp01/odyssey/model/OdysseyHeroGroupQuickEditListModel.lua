module("modules.logic.sp01.odyssey.model.OdysseyHeroGroupQuickEditListModel", package.seeall)

local var_0_0 = class("OdysseyHeroGroupQuickEditListModel", HeroGroupQuickEditListModel)

function var_0_0.copyQuickEditCardList(arg_1_0)
	local var_1_0

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		var_1_0 = {}
	else
		var_1_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()
	end

	local var_1_1 = {}
	local var_1_2 = {}

	arg_1_0._inTeamHeroUidMap = {}
	arg_1_0._inTeamHeroUidList = {}
	arg_1_0._originalHeroUidList = {}
	arg_1_0._selectUid = nil

	local var_1_3 = HeroSingleGroupModel.instance:getList()

	for iter_1_0, iter_1_1 in ipairs(var_1_3) do
		local var_1_4 = OdysseyHeroGroupModel.instance:isPositionOpen(iter_1_0)
		local var_1_5 = iter_1_1.heroUid

		if tonumber(var_1_5) > 0 and not var_1_2[var_1_5] then
			table.insert(var_1_1, HeroModel.instance:getById(var_1_5))

			if var_1_4 then
				arg_1_0._inTeamHeroUidMap[var_1_5] = 1
			end

			var_1_2[var_1_5] = true
		elseif HeroSingleGroupModel.instance:getByIndex(iter_1_0).trial then
			table.insert(var_1_1, HeroGroupTrialModel.instance:getById(var_1_5))

			if var_1_4 then
				arg_1_0._inTeamHeroUidMap[var_1_5] = 1
			end

			var_1_2[var_1_5] = true
		end

		if var_1_4 then
			table.insert(arg_1_0._inTeamHeroUidList, var_1_5)
			table.insert(arg_1_0._originalHeroUidList, var_1_5)
		end
	end

	local var_1_6 = HeroGroupTrialModel.instance:getFilterList()

	for iter_1_2, iter_1_3 in ipairs(var_1_6) do
		if not var_1_2[iter_1_3.uid] then
			table.insert(var_1_1, iter_1_3)
		end
	end

	local var_1_7 = arg_1_0.isTowerBattle
	local var_1_8 = arg_1_0.isWeekWalk_2
	local var_1_9 = {}

	if var_1_7 then
		for iter_1_4 = #var_1_1, 1, -1 do
			if TowerModel.instance:isHeroBan(var_1_1[iter_1_4].heroId) then
				table.insert(var_1_9, var_1_1[iter_1_4])
				table.remove(var_1_1, iter_1_4)
			end
		end
	end

	for iter_1_5, iter_1_6 in ipairs(var_1_0) do
		if not var_1_2[iter_1_6.uid] then
			var_1_2[iter_1_6.uid] = true

			if arg_1_0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(iter_1_6.heroId) > 0 then
					table.insert(var_1_9, iter_1_6)
				else
					table.insert(var_1_1, iter_1_6)
				end
			elseif var_1_8 then
				if WeekWalk_2Model.instance:getCurMapHeroCd(iter_1_6.heroId) > 0 then
					table.insert(var_1_9, iter_1_6)
				else
					table.insert(var_1_1, iter_1_6)
				end
			elseif var_1_7 then
				if TowerModel.instance:isHeroBan(iter_1_6.heroId) then
					table.insert(var_1_9, iter_1_6)
				else
					table.insert(var_1_1, iter_1_6)
				end
			else
				table.insert(var_1_1, iter_1_6)
			end
		end
	end

	if arg_1_0.adventure or var_1_7 or var_1_8 then
		tabletool.addValues(var_1_1, var_1_9)
	end

	arg_1_0:setList(var_1_1)
end

local var_0_1 = var_0_0.New()

return var_0_0
