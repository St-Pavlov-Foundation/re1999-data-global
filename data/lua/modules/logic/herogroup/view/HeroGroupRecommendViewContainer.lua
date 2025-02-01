module("modules.logic.herogroup.view.HeroGroupRecommendViewContainer", package.seeall)

slot0 = class("HeroGroupRecommendViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_character"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = HeroGroupRecommendCharacterItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 482
	slot1.cellHeight = 172
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 7.19
	slot1.startSpace = 0
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_group"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[2]
	slot2.cellClass = HeroGroupRecommendGroupItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1362
	slot2.cellHeight = 172
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 7.19
	slot2.startSpace = 0
	slot3 = {
		[slot8] = (slot8 - 1) * 0.06
	}
	slot4 = nil

	for slot8 = 1, 5 do
	end

	return {
		HeroGroupRecommendView.New(),
		LuaListScrollViewWithAnimator.New(HeroGroupRecommendCharacterListModel.instance, slot1, slot3),
		LuaListScrollViewWithAnimator.New(HeroGroupRecommendGroupListModel.instance, slot2, slot3),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return slot0
