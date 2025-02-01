module("modules.logic.skin.view.SkinOffsetAdjustViewContainer", package.seeall)

slot0 = class("SkinOffsetAdjustViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.skinOffsetAdjustView = SkinOffsetAdjustView.New()

	table.insert(slot1, slot0.skinOffsetAdjustView)

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_container/component/#go_skincontainer/#scroll_skin"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = SkinOffsetSkinItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 512
	slot2.cellHeight = 40
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 2
	slot2.startSpace = 8

	table.insert(slot1, LuaListScrollView.New(SkinOffsetSkinListModel.instance, slot2))

	return slot1
end

return slot0
