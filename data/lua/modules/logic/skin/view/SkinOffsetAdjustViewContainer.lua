module("modules.logic.skin.view.SkinOffsetAdjustViewContainer", package.seeall)

local var_0_0 = class("SkinOffsetAdjustViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.skinOffsetAdjustView = SkinOffsetAdjustView.New()

	table.insert(var_1_0, arg_1_0.skinOffsetAdjustView)

	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "#go_container/component/#go_skincontainer/#scroll_skin"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = SkinOffsetSkinItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 512
	var_1_1.cellHeight = 40
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 2
	var_1_1.startSpace = 8

	table.insert(var_1_0, LuaListScrollView.New(SkinOffsetSkinListModel.instance, var_1_1))

	return var_1_0
end

return var_0_0
