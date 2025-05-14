module("modules.logic.versionactivity1_3.jialabona.model.JiaLaBoNaStoryListModel", package.seeall)

local var_0_0 = class("JiaLaBoNaStoryListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Activity120Config.instance:getEpisodeStoryList(arg_1_1, arg_1_2)
	local var_1_1 = {}
	local var_1_2 = 0

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_3 = JiaLaBoNaStoryMO.New()

			var_1_3:init(iter_1_0, iter_1_1)
			table.insert(var_1_1, var_1_3)
		end
	end

	arg_1_0:setList(var_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
