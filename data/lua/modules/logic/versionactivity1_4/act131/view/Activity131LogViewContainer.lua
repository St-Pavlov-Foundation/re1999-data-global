module("modules.logic.versionactivity1_4.act131.view.Activity131LogViewContainer", package.seeall)

local var_0_0 = class("Activity131LogViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_log"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = Activity131LogItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV

	table.insert(var_1_0, LuaMixScrollView.New(Activity131LogListModel.instance, var_1_1))
	table.insert(var_1_0, Activity131LogView.New())

	return var_1_0
end

return var_0_0
