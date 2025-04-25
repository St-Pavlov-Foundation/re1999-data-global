module("modules.logic.lifecircle.view.LifeCircleRewardViewContainer", package.seeall)

slot0 = class("LifeCircleRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_Reward/#scroll_Reward"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = CommonPropListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 270
	slot1.cellHeight = 250
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 30
	slot1.startSpace = 0
	slot1.endSpace = 56

	return {
		LuaListScrollView.New(CommonPropListModel.instance, slot1),
		LifeCircleRewardView.New()
	}
end

return slot0
