module("modules.logic.ressplit.work.ResSplitRoleStoryWork", package.seeall)

local var_0_0 = class("ResSplitRoleStoryWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = ResSplitConfig.instance:getAppIncludeConfig()
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		if iter_1_1.heroStoryIds then
			for iter_1_2, iter_1_3 in pairs(iter_1_1.heroStoryIds) do
				local var_1_2 = RoleStoryConfig.instance:getStoryById(iter_1_3)

				ResSplitModel.instance:addIncludeChapter(var_1_2.chapterId)
			end
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
