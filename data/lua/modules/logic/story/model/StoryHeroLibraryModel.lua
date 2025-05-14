module("modules.logic.story.model.StoryHeroLibraryModel", package.seeall)

local var_0_0 = class("StoryHeroLibraryModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._herolibrary = {}
end

function var_0_0.setStoryHeroLibraryList(arg_2_0, arg_2_1)
	arg_2_0._herolibrary = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = StoryHeroLibraryMo.New()

		var_2_0:init(iter_2_1, iter_2_0)
		table.insert(arg_2_0._herolibrary, var_2_0)
	end

	arg_2_0:setList(arg_2_0._herolibrary)
end

function var_0_0.getStoryHeroLibraryList(arg_3_0)
	return arg_3_0._herolibrary
end

function var_0_0.getStoryLibraryHeroByIndex(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._herolibrary) do
		if iter_4_1.index == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
