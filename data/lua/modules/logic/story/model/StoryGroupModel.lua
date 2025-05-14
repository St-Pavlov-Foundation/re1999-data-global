module("modules.logic.story.model.StoryGroupModel", package.seeall)

local var_0_0 = class("StoryGroupModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._groupList = {}
end

function var_0_0.setGroupList(arg_2_0, arg_2_1)
	arg_2_0._groupList = {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in pairs(arg_2_1) do
			local var_2_0 = {}

			for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
				local var_2_1 = StoryGroupMo.New()

				var_2_1:init(iter_2_3)
				table.insert(var_2_0, var_2_1)
			end

			table.insert(arg_2_0._groupList, var_2_0)
		end
	end
end

function var_0_0.getGroupList(arg_3_0)
	return arg_3_0._groupList
end

function var_0_0.getGroupListById(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._groupList) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			if iter_4_3.id == arg_4_1 then
				return iter_4_1
			end
		end
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
