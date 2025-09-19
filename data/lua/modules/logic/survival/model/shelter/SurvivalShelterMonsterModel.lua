module("modules.logic.survival.model.shelter.SurvivalShelterMonsterModel", package.seeall)

local var_0_0 = class("SurvivalShelterMonsterModel", BaseModel)

function var_0_0.calBuffIsRepress(arg_1_0, arg_1_1)
	local var_1_0 = SurvivalShelterNpcMonsterListModel.instance:getSelectList()
	local var_1_1 = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_2 = var_1_0[iter_1_0]
		local var_1_3 = SurvivalConfig.instance:getNpcConfigTag(var_1_2)

		for iter_1_1 = 1, #var_1_3 do
			local var_1_4 = var_1_3[iter_1_1]

			if var_1_1[var_1_4] == nil then
				var_1_1[var_1_4] = true
			end
		end
	end

	local var_1_5 = SurvivalConfig.instance:getMonsterBuffConfigTag(arg_1_1)
	local var_1_6 = false

	if var_1_5 then
		var_1_6 = true

		for iter_1_2 = 1, #var_1_5 do
			if var_1_1[var_1_5[iter_1_2]] == nil then
				var_1_6 = false

				break
			end
		end
	end

	return var_1_6
end

function var_0_0.getMonsterSelectNpc(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = SurvivalShelterModel.instance:getWeekInfo().npcDict

	if var_2_1 then
		for iter_2_0, iter_2_1 in pairs(var_2_1) do
			if arg_2_0:isFilterNpc(iter_2_1.co) then
				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	if #var_2_0 > 1 then
		table.sort(var_2_0, SurvivalShelterNpcMo.sort)
	end

	return var_2_0
end

local var_0_1 = {}
local var_0_2

function var_0_0.calRecommendNum(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		return 0
	end

	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	if var_0_2 == nil or var_0_2 ~= var_3_0.fightId then
		local var_3_1 = var_3_0.schemes

		if var_0_1 then
			tabletool.clear(var_0_1)
		end

		for iter_3_0, iter_3_1 in pairs(var_3_1) do
			local var_3_2 = SurvivalConfig.instance:getMonsterBuffConfigTag(iter_3_0)

			for iter_3_2 = 1, #var_3_2 do
				var_0_1[#var_0_1 + 1] = var_3_2[iter_3_2]
			end
		end

		var_0_2 = var_3_0.fightId
	end

	local var_3_3 = SurvivalConfig.instance:getNpcConfigTag(arg_3_1)
	local var_3_4 = 0

	if var_3_3 then
		for iter_3_3 = 1, #var_3_3 do
			local var_3_5 = var_3_3[iter_3_3]

			for iter_3_4 = 1, #var_0_1 do
				if var_3_5 == var_0_1[iter_3_4] then
					var_3_4 = var_3_4 + 1

					break
				end
			end
		end
	end

	return var_3_4
end

function var_0_0.isNeedNpcTag(arg_4_0, arg_4_1)
	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight().schemes

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_1 = SurvivalConfig.instance:getMonsterBuffConfigTag(iter_4_0)

		for iter_4_2 = 1, #var_4_1 do
			if var_4_1[iter_4_2] == arg_4_1 then
				return true
			end
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
