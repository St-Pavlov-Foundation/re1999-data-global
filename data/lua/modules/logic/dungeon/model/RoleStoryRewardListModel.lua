module("modules.logic.dungeon.model.RoleStoryRewardListModel", package.seeall)

local var_0_0 = class("RoleStoryRewardListModel", ListScrollModel)

function var_0_0.refreshList(arg_1_0)
	local var_1_0 = RoleStoryModel.instance:getCurActStoryId()
	local var_1_1 = {}

	if var_1_0 then
		local var_1_2 = RoleStoryConfig.instance:getRewardList(var_1_0) or {}

		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			table.insert(var_1_1, {
				index = iter_1_0,
				config = iter_1_1
			})
		end
	end

	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
