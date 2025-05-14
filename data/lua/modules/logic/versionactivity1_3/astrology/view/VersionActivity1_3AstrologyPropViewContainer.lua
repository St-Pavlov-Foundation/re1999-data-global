module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPropViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologyPropViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_item"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = CommonPropListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 5
	var_1_1.cellWidth = 270
	var_1_1.cellHeight = 250
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 50
	var_1_1.startSpace = 35
	var_1_1.endSpace = 56

	table.insert(var_1_0, LuaListScrollView.New(CommonPropListModel.instance, var_1_1))
	table.insert(var_1_0, VersionActivity1_3AstrologyPropView.New())

	return var_1_0
end

return var_0_0
