module("modules.logic.gm.view.GMToolViewContainer", package.seeall)

slot0 = class("GMToolViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "addItem/scroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "addItem/scroll/item"
	slot1.cellClass = GMAddItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 794
	slot1.cellHeight = 100
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "gmcommand/img/scroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "gmcommand/img/scroll/item"
	slot2.cellClass = GMCommandItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 950
	slot2.cellHeight = 100
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 5

	return {
		GMToolView.New(),
		GMToolView2.New(),
		GMAddItemView.New(),
		GMCommandView.New(),
		GMToolFightView.New(),
		GMAudioTool.New(),
		GMRougeTool.New(),
		LuaListScrollView.New(GMAddItemModel.instance, slot1),
		LuaListScrollView.New(GMCommandModel.instance, slot2),
		GMSubViewOldView.New(),
		GMSubViewCommon.New(),
		GMSubViewNewFightView.New(),
		GMSubViewBattle.New(),
		GMSubViewAudio.New(),
		GMSubViewGuide.New(),
		GMSubViewActivity.New(),
		GMSubViewRole.New(),
		GMSubViewCode.New(),
		GMSubViewRouge.New(),
		GMSubViewResource.New(),
		GMSubViewProfiler.New(),
		GMSubViewRoom.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0.addSubViewToggle(slot0, slot1)
	slot0.toggleList = slot0.toggleList or slot0:getUserDataTb_()

	table.insert(slot0.toggleList, slot1)
end

function slot0.selectToggle(slot0, slot1)
	if slot0.toggleList then
		for slot5, slot6 in ipairs(slot0.toggleList) do
			if slot6 == slot1 then
				PlayerPrefsHelper.setNumber("GMLastSelectIndexKey", slot5)
			end
		end
	end
end

function slot0.onContainerOpenFinish(slot0)
	if slot0.toggleList and slot0.toggleList[PlayerPrefsHelper.getNumber("GMLastSelectIndexKey", 1)] then
		slot2.isOn = true
	end
end

return slot0
