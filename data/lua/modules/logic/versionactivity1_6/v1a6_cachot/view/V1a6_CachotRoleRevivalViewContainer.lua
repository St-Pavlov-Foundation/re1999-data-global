module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalViewContainer", package.seeall)

slot0 = class("V1a6_CachotRoleRevivalViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		V1a6_CachotRoleRevivalView.New(),
		LuaListScrollView.New(V1a6_CachotRoleRevivalPrepareListModel.instance, slot0:_getPrepareListParam())
	}
end

function slot0._getPrepareListParam(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_tipswindow/scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[2]
	slot1.cellClass = V1a6_CachotRoleRevivalPrepareItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 4
	slot1.cellWidth = 624
	slot1.cellHeight = 192
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.endSpace = 0
	slot1.minUpdateCountInFrame = 100

	return slot1
end

return slot0
