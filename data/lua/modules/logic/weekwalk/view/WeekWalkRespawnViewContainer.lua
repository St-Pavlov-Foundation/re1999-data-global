module("modules.logic.weekwalk.view.WeekWalkRespawnViewContainer", package.seeall)

slot0 = class("WeekWalkRespawnViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = HeroGroupEditItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 290
	slot1.cellHeight = 550
	slot1.cellSpaceH = 48
	slot1.cellSpaceV = 30
	slot1.startSpace = 25

	return {
		LuaListScrollView.New(WeekWalkRespawnModel.instance, slot1),
		WeekWalkRespawnView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return slot0
