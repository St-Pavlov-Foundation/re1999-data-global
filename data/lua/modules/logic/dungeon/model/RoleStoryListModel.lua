module("modules.logic.dungeon.model.RoleStoryListModel", package.seeall)

local var_0_0 = class("RoleStoryListModel", ListScrollModel)

function var_0_0.markUnlockOrder(arg_1_0)
	arg_1_0.unlockOrderDict = {}

	local var_1_0 = RoleStoryConfig.instance:getStoryList()
	local var_1_1 = {}

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_2 = RoleStoryModel.instance:getMoById(iter_1_1.id)

			if var_1_2:isResidentTime() then
				arg_1_0.unlockOrderDict[iter_1_1.id] = var_1_2.hasUnlock and 1 or 0
			end
		end
	end
end

function var_0_0.refreshList(arg_2_0)
	if #arg_2_0._scrollViews == 0 then
		return
	end

	local var_2_0 = RoleStoryConfig.instance:getStoryList()
	local var_2_1 = {}

	if var_2_0 then
		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			local var_2_2 = RoleStoryModel.instance:getMoById(iter_2_1.id)

			if var_2_2:isResidentTime() then
				var_2_2.unlockOrder = arg_2_0.unlockOrderDict[iter_2_1.id] or 0

				table.insert(var_2_1, var_2_2)
			end
		end
	end

	table.sort(var_2_1, SortUtil.tableKeyUpper({
		"getUnlockOrder",
		"unlockOrder",
		"hasRewardUnget",
		"getRewardOrder",
		"order"
	}))
	arg_2_0:setList(var_2_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
