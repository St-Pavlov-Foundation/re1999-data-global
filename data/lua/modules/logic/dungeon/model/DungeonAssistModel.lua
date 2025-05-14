module("modules.logic.dungeon.model.DungeonAssistModel", package.seeall)

local var_0_0 = class("DungeonAssistModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getAssistList(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}

	if not arg_3_1 or not arg_3_0._assistTypeDict then
		return var_3_0
	end

	local var_3_1 = arg_3_0._assistTypeDict[arg_3_1] or {}

	if arg_3_2 then
		var_3_0 = var_3_1[arg_3_2] or {}
	else
		for iter_3_0, iter_3_1 in pairs(var_3_1) do
			tabletool.addValues(var_3_0, iter_3_1)
		end
	end

	return var_3_0
end

function var_0_0.setAssistHeroCareersByServerData(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_1 or not arg_4_2 then
		return
	end

	if not arg_4_0._assistTypeDict then
		arg_4_0._assistTypeDict = {}
	end

	local var_4_0 = {}

	arg_4_0._assistTypeDict[arg_4_1] = var_4_0

	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		local var_4_1 = iter_4_1.career
		local var_4_2 = {}

		var_4_0[var_4_1] = var_4_2

		local var_4_3 = {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1.assistHeroInfos) do
			local var_4_4 = iter_4_3.heroUid

			if not var_4_3[var_4_4] then
				local var_4_5 = DungeonAssistHeroMO.New()

				if var_4_5:init(arg_4_1, iter_4_3) then
					var_4_2[#var_4_2 + 1] = var_4_5
				end

				var_4_3[var_4_4] = true
			end
		end
	end
end

function var_0_0.clear(arg_5_0)
	arg_5_0._assistTypeDict = {}

	var_0_0.super.clear(arg_5_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
