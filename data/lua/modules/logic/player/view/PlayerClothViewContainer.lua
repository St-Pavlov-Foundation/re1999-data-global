module("modules.logic.player.view.PlayerClothViewContainer", package.seeall)

slot0 = class("PlayerClothViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_skills"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#scroll_skills/Viewport/#go_skillitem"
	slot1.cellClass = PlayerClothItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 300
	slot1.cellHeight = 155
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = -4.34
	slot1.startSpace = 10
	slot0._clothListView = LuaListScrollView.New(PlayerClothListViewModel.instance, slot1)

	return {
		PlayerClothView.New(),
		slot0._clothListView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		false,
		not (slot0.viewParam and slot0.viewParam.isTip)
	}, HelpEnum.HelpId.PlayCloth)

	return {
		slot0.navigateView
	}
end

function slot0.onContainerInit(slot0)
	PlayerClothListViewModel.instance:update()
	PlayerController.instance:registerCallback(PlayerEvent.SelectCloth, slot0._onSelectCloth, slot0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, slot0.navigateView.showHelpBtnIcon, slot0.navigateView)
end

function slot0.onContainerDestroy(slot0)
	PlayerController.instance:unregisterCallback(PlayerEvent.SelectCloth, slot0._onSelectCloth, slot0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, slot0.navigateView.showHelpBtnIcon, slot0.navigateView)
end

function slot0.onContainerOpen(slot0)
	PlayerClothListViewModel.instance:update()
end

function slot0._onSelectCloth(slot0, slot1)
	if PlayerClothListViewModel.instance:getById(slot1) and PlayerClothListViewModel.instance:getIndex(slot2) then
		slot0._index = slot3

		slot0._clothListView:selectCell(slot3, true)
	end
end

return slot0
