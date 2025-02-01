module("modules.logic.character.view.CharacterSwitchViewContainer", package.seeall)

slot0 = class("CharacterSwitchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterSwitchView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "right/mask/#scroll_card"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = CharacterSwitchItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 3
	slot2.cellWidth = 170
	slot2.cellHeight = 208
	slot2.cellSpaceH = 5
	slot2.cellSpaceV = 0
	slot2.startSpace = 5
	slot2.endSpace = 0
	slot0._characterScrollView = LuaListScrollView.New(CharacterSwitchListModel.instance, slot2)

	table.insert(slot1, slot0._characterScrollView)
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.getCharacterScrollView(slot0)
	return slot0._characterScrollView
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	}, 101)

	return {
		slot0.navigationView
	}
end

function slot0.on(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_OperaHouse)
end

return slot0
