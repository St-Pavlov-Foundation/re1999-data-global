module("modules.logic.prototest.view.ProtoTestViewContainer", package.seeall)

slot0 = class("ProtoTestViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "Panel_testcase/protolist"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "Panel_testcase/protolist/Viewport/item"
	slot2.cellClass = ProtoTestCaseItem
	slot2.scrollDir = ScrollEnum.ScrollDirV

	table.insert(slot1, LuaMixScrollView.New(ProtoTestCaseModel.instance, slot2))

	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = "Panel_storage/testcaserepo"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromView
	slot3.prefabUrl = "Panel_storage/testcaserepo/Viewport/repo"
	slot3.cellClass = ProtoTestFileItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.lineCount = 1
	slot3.cellWidth = 520
	slot3.cellHeight = 85
	slot3.cellSpaceH = 0
	slot3.cellSpaceV = 0

	table.insert(slot1, LuaListScrollView.New(ProtoTestFileModel.instance, slot3))

	slot4 = ListScrollParam.New()
	slot4.scrollGOPath = "Panel_testcase/Panel_new/bg/scroll"
	slot4.prefabType = ScrollEnum.ScrollPrefabFromView
	slot4.prefabUrl = "Panel_testcase/Panel_new/bg/scroll/Viewport/item"
	slot4.cellClass = ProtoReqListItem
	slot4.scrollDir = ScrollEnum.ScrollDirV
	slot4.lineCount = 1
	slot4.cellWidth = 350
	slot4.cellHeight = 60
	slot4.cellSpaceH = 0
	slot4.cellSpaceV = 0

	table.insert(slot1, LuaListScrollView.New(ProtoReqListModel.instance, slot4))
	table.insert(slot1, ProtoTestView.New())
	table.insert(slot1, ProtoTestCaseView.New())
	table.insert(slot1, ProtoTestFileView.New())
	table.insert(slot1, ProtoTestReqView.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

return slot0
