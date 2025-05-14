module("modules.logic.prototest.view.ProtoTestViewContainer", package.seeall)

local var_0_0 = class("ProtoTestViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "Panel_testcase/protolist"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "Panel_testcase/protolist/Viewport/item"
	var_1_1.cellClass = ProtoTestCaseItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV

	table.insert(var_1_0, LuaMixScrollView.New(ProtoTestCaseModel.instance, var_1_1))

	local var_1_2 = ListScrollParam.New()

	var_1_2.scrollGOPath = "Panel_storage/testcaserepo"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_2.prefabUrl = "Panel_storage/testcaserepo/Viewport/repo"
	var_1_2.cellClass = ProtoTestFileItem
	var_1_2.scrollDir = ScrollEnum.ScrollDirV
	var_1_2.lineCount = 1
	var_1_2.cellWidth = 520
	var_1_2.cellHeight = 85
	var_1_2.cellSpaceH = 0
	var_1_2.cellSpaceV = 0

	table.insert(var_1_0, LuaListScrollView.New(ProtoTestFileModel.instance, var_1_2))

	local var_1_3 = ListScrollParam.New()

	var_1_3.scrollGOPath = "Panel_testcase/Panel_new/bg/scroll"
	var_1_3.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_3.prefabUrl = "Panel_testcase/Panel_new/bg/scroll/Viewport/item"
	var_1_3.cellClass = ProtoReqListItem
	var_1_3.scrollDir = ScrollEnum.ScrollDirV
	var_1_3.lineCount = 1
	var_1_3.cellWidth = 350
	var_1_3.cellHeight = 60
	var_1_3.cellSpaceH = 0
	var_1_3.cellSpaceV = 0

	table.insert(var_1_0, LuaListScrollView.New(ProtoReqListModel.instance, var_1_3))
	table.insert(var_1_0, ProtoTestView.New())
	table.insert(var_1_0, ProtoTestCaseView.New())
	table.insert(var_1_0, ProtoTestFileView.New())
	table.insert(var_1_0, ProtoTestReqView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	ViewMgr.instance:closeView(arg_2_0.viewName)
end

return var_0_0
