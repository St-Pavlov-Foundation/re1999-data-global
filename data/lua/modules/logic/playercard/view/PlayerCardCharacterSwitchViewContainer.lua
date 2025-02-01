module("modules.logic.playercard.view.PlayerCardCharacterSwitchViewContainer", package.seeall)

slot0 = class("PlayerCardCharacterSwitchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerCardCharacterSwitchView.New())
	table.insert(slot1, PlayerCardCharacterSwitchCharacterView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_characterswitchview/characterswitchview/right/mask/#scroll_card"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = PlayerCardCharacterSwitchItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 3
	slot2.cellWidth = 170
	slot2.cellHeight = 208
	slot2.cellSpaceH = 5
	slot2.cellSpaceV = 0
	slot2.startSpace = 5
	slot2.endSpace = 0
	slot0.scrollView = LuaListScrollView.New(PlayerCardCharacterSwitchListModel.instance, slot2)

	table.insert(slot1, slot0.scrollView)
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0.navigationView
	}
end

return slot0
