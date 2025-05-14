module("modules.logic.versionactivity2_1.lanshoupa.model.LanShouPaStoryListModel", package.seeall)

local var_0_0 = class("LanShouPaStoryListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Activity164Config.instance:getStoryList(arg_1_1, arg_1_2)
	local var_1_1 = {}

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_2 = LanShouPaStoryMO.New()

			var_1_2:init(iter_1_0, iter_1_1)
			table.insert(var_1_1, var_1_2)
		end
	end

	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
