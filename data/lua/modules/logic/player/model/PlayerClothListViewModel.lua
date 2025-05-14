module("modules.logic.player.model.PlayerClothListViewModel", package.seeall)

local var_0_0 = class("PlayerClothListViewModel", ListScrollModel)

function var_0_0.setGroupModel(arg_1_0, arg_1_1)
	arg_1_0._groupModel = arg_1_1
end

function var_0_0.getGroupModel(arg_2_0)
	return arg_2_0._groupModel
end

function var_0_0.update(arg_3_0)
	local var_3_0 = PlayerClothModel.instance:getList()
	local var_3_1 = {}
	local var_3_2 = PlayerClothModel.instance:getSpEpisodeClothID()

	if var_3_2 then
		table.insert(var_3_1, PlayerClothModel.instance:getById(var_3_2))
	else
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if PlayerClothModel.instance:hasCloth(iter_3_1.id) then
				table.insert(var_3_1, iter_3_1)
			end
		end
	end

	arg_3_0:setList(var_3_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
