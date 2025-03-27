module("modules.logic.playercard.view.NewPlayerCardViewContainer", package.seeall)

slot0 = class("NewPlayerCardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.playercardview = NewPlayerCardView.New()

	table.insert(slot1, slot0.playercardview)
	table.insert(slot1, PlayerCardAchievement.New())
	table.insert(slot1, PlayerCardThemeView.New())
	table.insert(slot1, PlayerCardPlayerInfo.New())
	slot0:buildThemeScrollView(slot1)
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0.navigateView:setOverrideClose(slot0._overrideClose, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.buildThemeScrollView(slot0, slot1)
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "bottom/#scroll_theme"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "bottom/#scroll_theme/viewport/Content/#go_themeitem"
	slot2.cellClass = PlayerCardThemeItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 404
	slot2.cellHeight = 172
	slot2.cellSpaceH = 16
	slot2.cellSpaceV = 0
	slot2.startSpace = 4
	slot2.endSpace = 0
	slot0.scrollView = LuaListScrollView.New(PlayerCardThemeListModel.instance, slot2)

	table.insert(slot1, slot0.scrollView)
end

function slot0._overrideClose(slot0)
	if not PlayerCardModel.instance:getIsOpenSkinView() then
		slot0:closeThis()
	else
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseBottomView)
	end
end

return slot0
