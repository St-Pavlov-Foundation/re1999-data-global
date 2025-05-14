module("modules.logic.story.model.StoryBgEffectTransModel", package.seeall)

local var_0_0 = class("StoryBgEffectTransModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._transList = {}
end

function var_0_0.setStoryBgEffectTransList(arg_2_0, arg_2_1)
	arg_2_0._transList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = StoryBgEffectTransMo.New()

		var_2_0:init(iter_2_1, iter_2_0)
		table.insert(arg_2_0._transList, var_2_0)
	end
end

function var_0_0.getStoryBgEffectTransList(arg_3_0)
	return arg_3_0._transList
end

function var_0_0.getStoryBgEffectTransByType(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._transList) do
		if iter_4_1.type == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
