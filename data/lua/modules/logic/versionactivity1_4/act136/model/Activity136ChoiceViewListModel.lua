module("modules.logic.versionactivity1_4.act136.model.Activity136ChoiceViewListModel", package.seeall)

local var_0_0 = class("Activity136ChoiceViewListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

local function var_0_1(arg_3_0, arg_3_1)
	local var_3_0 = HeroModel.instance:getByHeroId(arg_3_0.id)
	local var_3_1 = HeroModel.instance:getByHeroId(arg_3_1.id)
	local var_3_2 = var_3_0 and true or false
	local var_3_3 = var_3_1 and true or false

	if var_3_2 ~= var_3_3 then
		return var_3_3
	end

	local var_3_4 = var_3_0 and var_3_0.exSkillLevel or -1
	local var_3_5 = var_3_1 and var_3_1.exSkillLevel or -1

	if var_3_4 ~= var_3_5 then
		return var_3_4 < var_3_5
	end

	return arg_3_0.id < arg_3_1.id
end

function var_0_0.setSelfSelectedCharacterList(arg_4_0)
	local var_4_0 = Activity136Model.instance:getCurActivity136Id()
	local var_4_1 = Activity136Config.instance:getSelfSelectCharacterIdList(var_4_0)
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_3 = {
			id = iter_4_1
		}

		table.insert(var_4_2, var_4_3)
	end

	table.sort(var_4_2, var_0_1)
	arg_4_0:setList(var_4_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
