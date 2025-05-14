module("modules.logic.dungeon.model.DungeonMainStoryModel", package.seeall)

local var_0_0 = class("DungeonMainStoryModel")

function var_0_0.setChapterList(arg_1_0, arg_1_1)
	arg_1_0._list = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_0 = DungeonConfig.instance:getChapterDivideSectionId(iter_1_1.id)
		local var_1_1 = arg_1_0._list[var_1_0] or {}

		table.insert(var_1_1, iter_1_1)

		arg_1_0._list[var_1_0] = var_1_1
	end
end

function var_0_0.getChapterList(arg_2_0, arg_2_1)
	return arg_2_1 and arg_2_0._list[arg_2_1]
end

function var_0_0.setSectionSelected(arg_3_0, arg_3_1)
	arg_3_0._selectedSectionId = arg_3_1
end

function var_0_0.getSelectedSectionId(arg_4_0)
	return arg_4_0._selectedSectionId
end

function var_0_0.sectionIsSelected(arg_5_0, arg_5_1)
	return arg_5_0._selectedSectionId == arg_5_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
