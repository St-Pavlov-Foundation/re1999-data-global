module("modules.logic.story.view.StoryLogViewContainer", package.seeall)

local var_0_0 = class("StoryLogViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_log"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = StoryLogItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV

	table.insert(var_1_0, LuaMixScrollView.New(StoryLogListModel.instance, var_1_1))
	table.insert(var_1_0, StoryLogView.New())

	return var_1_0
end

return var_0_0
