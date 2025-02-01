module("modules.logic.playercard.view.PlayerCardViewContainer", package.seeall)

slot0 = class("PlayerCardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerCardCharacterView.New())
	table.insert(slot1, PlayerCardView.New())
	table.insert(slot1, PlayerCardThemeView.New())

	slot0.animatorView = PlayerCardAnimatorView.New()

	table.insert(slot1, slot0.animatorView)
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
	slot2.scrollGOPath = "Bottom/#scroll_theme"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "Bottom/#scroll_theme/viewport/Content/#go_themeitem"
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
	if slot0.animatorView:isInThemeView() then
		slot0.animatorView:closeThemeView()

		return
	end

	slot0:closeThis()
end

return slot0
