module("modules.logic.prototest.view.ProtoModifyViewContainer", package.seeall)

local var_0_0 = class("ProtoModifyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "paramlistpanel/paramscroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "paramlistpanel/paramscroll/Viewport/item"
	var_1_1.cellClass = ProtoModifyListItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 667
	var_1_1.cellHeight = 75
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0

	table.insert(var_1_0, LuaListScrollView.New(ProtoModifyModel.instance, var_1_1))
	table.insert(var_1_0, ProtoModifyView.New())

	return var_1_0
end

return var_0_0
