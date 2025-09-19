module("modules.logic.survival.model.SurvivalHeroGroupQuickEditListModel", package.seeall)

local var_0_0 = class("SurvivalHeroGroupQuickEditListModel", HeroGroupQuickEditListModel)

function var_0_0.copyQuickEditCardList(arg_1_0)
	local var_1_0
	local var_1_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_1_2 = var_1_1.inSurvival
	local var_1_3

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		var_1_0 = {}
	elseif var_1_2 then
		var_1_3 = SurvivalMapModel.instance:getSceneMo().teamInfo
		var_1_0 = {}

		for iter_1_0 in pairs(var_1_3.heroUids) do
			table.insert(var_1_0, (var_1_3:getHeroMo(iter_1_0)))
		end
	else
		var_1_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()
	end

	local var_1_4 = {}
	local var_1_5 = {}

	arg_1_0._inTeamHeroUidMap = {}
	arg_1_0._inTeamHeroUidList = {}
	arg_1_0._originalHeroUidList = {}
	arg_1_0._selectUid = nil

	local var_1_6 = HeroSingleGroupModel.instance:getList()

	for iter_1_1, iter_1_2 in ipairs(var_1_6) do
		local var_1_7 = iter_1_2.heroUid

		if tonumber(var_1_7) > 0 and not var_1_5[var_1_7] then
			if var_1_2 then
				table.insert(var_1_4, (var_1_3:getHeroMo(var_1_7)))
			else
				table.insert(var_1_4, HeroModel.instance:getById(var_1_7))
			end

			arg_1_0._inTeamHeroUidMap[var_1_7] = 1
			var_1_5[var_1_7] = true
		elseif HeroSingleGroupModel.instance:getByIndex(iter_1_1).trial then
			table.insert(var_1_4, HeroGroupTrialModel.instance:getById(var_1_7))

			arg_1_0._inTeamHeroUidMap[var_1_7] = 1
			var_1_5[var_1_7] = true
		end

		table.insert(arg_1_0._inTeamHeroUidList, var_1_7)
		table.insert(arg_1_0._originalHeroUidList, var_1_7)
	end

	local var_1_8 = HeroGroupTrialModel.instance:getFilterList()

	for iter_1_3, iter_1_4 in ipairs(var_1_8) do
		if not var_1_5[iter_1_4.uid] then
			table.insert(var_1_4, iter_1_4)
		end
	end

	local var_1_9 = {}

	for iter_1_5, iter_1_6 in ipairs(var_1_0) do
		if not var_1_5[iter_1_6.uid] then
			var_1_5[iter_1_6.uid] = true

			if var_1_1:getHeroMo(iter_1_6.heroId).health <= 0 or SurvivalHeroGroupEditListModel.instance:getSelectByIndex(iter_1_6.heroId) ~= nil then
				table.insert(var_1_9, iter_1_6)
			else
				table.insert(var_1_4, iter_1_6)
			end
		end
	end

	tabletool.addValues(var_1_4, var_1_9)
	arg_1_0:setList(var_1_4)
end

function var_0_0.isTeamFull(arg_2_0)
	local var_2_0 = HeroGroupModel.instance:getBattleRoleNum() or 0

	for iter_2_0 = 1, math.min(var_2_0, #arg_2_0._inTeamHeroUidList) do
		if arg_2_0._inTeamHeroUidList[iter_2_0] == "0" then
			return false
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
