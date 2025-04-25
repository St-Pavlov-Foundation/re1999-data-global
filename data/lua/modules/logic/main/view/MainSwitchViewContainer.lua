module("modules.logic.main.view.MainSwitchViewContainer", package.seeall)

slot0 = class("MainSwitchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MainSwitchView.New())
	table.insert(slot1, TabViewGroupFit.New(1, "#go_container"))
	table.insert(slot1, TabViewGroup.New(2, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 2 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end

	if slot1 == 1 then
		slot2 = {}

		slot0:_addCharacterSwitch(slot2)
		slot0:_addSceneSwitch(slot2)

		return slot2
	end
end

function slot0._addCharacterSwitch(slot0, slot1)
	slot2 = {}

	table.insert(slot2, CharacterSwitchView.New())

	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = "right/mask/#scroll_card"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot3.prefabUrl = slot0._viewSetting.tabRes[1][1][2]
	slot3.cellClass = CharacterSwitchItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.lineCount = 3
	slot3.cellWidth = 170
	slot3.cellHeight = 208
	slot3.cellSpaceH = 5
	slot3.cellSpaceV = 0
	slot3.startSpace = 5
	slot3.endSpace = 0
	slot0._characterScrollView = LuaListScrollView.New(CharacterSwitchListModel.instance, slot3)

	table.insert(slot2, slot0._characterScrollView)

	slot1[MainEnum.SwitchType.Character] = MultiView.New(slot2)
end

function slot0.getCharacterScrollView(slot0)
	return slot0._characterScrollView
end

function slot0._addSceneSwitch(slot0, slot1)
	slot2 = {}

	table.insert(slot2, MainSceneSwitchDisplayView.New())
	table.insert(slot2, MainSceneSwitchView.New())

	slot3 = MixScrollParam.New()
	slot3.scrollGOPath = "right/mask/#scroll_card"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot3.prefabUrl = slot0._viewSetting.tabRes[1][2][2]
	slot3.cellClass = MainSceneSwitchItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.lineCount = 1

	table.insert(slot2, LuaMixScrollView.New(MainSceneSwitchListModel.instance, slot3))

	slot1[MainEnum.SwitchType.Scene] = MultiView.New(slot2)
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 1, slot1)
end

return slot0
