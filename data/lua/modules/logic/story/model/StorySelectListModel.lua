module("modules.logic.story.model.StorySelectListModel", package.seeall)

local var_0_0 = class("StorySelectListModel", ListScrollModel)

function var_0_0.setSelectList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_1 = StorySelectMo.New()

		var_1_1:init(iter_1_1)
		table.insert(var_1_0, var_1_1)
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
