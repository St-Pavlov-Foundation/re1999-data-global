module("modules.logic.handbook.model.HandbookStoryListModel", package.seeall)

local var_0_0 = class("HandbookStoryListModel", ListScrollModel)

function var_0_0.setStoryList(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.moList = {}

	local var_1_0 = 0

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		if iter_1_1.storyChapterId == arg_1_2 and HandbookModel.instance:isStoryGroupUnlock(iter_1_1.id) then
			var_1_0 = var_1_0 + 1

			local var_1_1 = HandbookStoryMO.New()

			var_1_1:init(iter_1_1.id, var_1_0)
			table.insert(arg_1_0.moList, var_1_1)
		end
	end

	arg_1_0:setList(arg_1_0.moList)
end

function var_0_0.getStoryList(arg_2_0)
	if GameUtil.getTabLen(arg_2_0.moList) > 0 then
		return arg_2_0.moList
	end

	return nil
end

function var_0_0.clearStoryList(arg_3_0)
	arg_3_0:setList({})
end

var_0_0.instance = var_0_0.New()

return var_0_0
