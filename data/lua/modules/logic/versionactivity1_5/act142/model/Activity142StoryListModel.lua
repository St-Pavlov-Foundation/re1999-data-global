module("modules.logic.versionactivity1_5.act142.model.Activity142StoryListModel", package.seeall)

local var_0_0 = class("Activity142StoryListModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}
	local var_1_1 = Activity142Config.instance:getEpisodeStoryList(arg_1_1, arg_1_2)

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		local var_1_2 = {
			index = iter_1_0,
			storyId = iter_1_1.id
		}

		table.insert(var_1_0, var_1_2)
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
