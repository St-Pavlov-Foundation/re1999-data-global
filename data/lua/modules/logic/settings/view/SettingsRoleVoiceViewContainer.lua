module("modules.logic.settings.view.SettingsRoleVoiceViewContainer", package.seeall)

slot0 = class("SettingsRoleVoiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._scrollParam = ListScrollParam.New()
	slot0._scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot0._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot0._scrollParam.prefabUrl = slot0._viewSetting.otherRes[1]
	slot0._scrollParam.cellClass = SettingsRoleVoiceListItem
	slot0._scrollParam.scrollDir = ScrollEnum.ScrollDirV
	slot0._scrollParam.lineCount = 6
	slot0._scrollParam.cellWidth = 250
	slot0._scrollParam.cellHeight = 555
	slot0._scrollParam.cellSpaceH = 18
	slot0._scrollParam.cellSpaceV = 10
	slot0._scrollParam.startSpace = 10
	slot0._scrollParam.frameUpdateMs = 100
	slot0._scrollParam.minUpdateCountInFrame = 100
	slot0._scrollParam.multiSelect = false

	for slot5 = 1, 12 do
	end

	slot0._cardScrollView = LuaListScrollViewWithAnimator.New(CharacterBackpackCardListModel.instance, slot0._scrollParam, {
		[slot5] = math.ceil((slot5 - 1) % 6) * 0.06
	})
	slot2 = {}
	slot0._mainSettingView = SettingsRoleVoiceView.New()
	slot0._filterView = SettingsRoleVoiceSearchFilterView.New()

	table.insert(slot2, slot0._mainSettingView)
	table.insert(slot2, slot0._filterView)
	table.insert(slot2, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot2, slot0._cardScrollView)

	return slot2
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonsView
		}
	end
end

function slot0.isBatchEditMode(slot0)
	return slot0._mainSettingView:isBatchEditMode()
end

function slot0.setBatchEditMode(slot0, slot1)
	slot0._scrollParam.multiSelect = slot1
end

function slot0.getCardScorllView(slot0)
	return slot0._cardScrollView
end

function slot0.clearSelectedItems(slot0)
	slot0._cardScrollView:setSelectList()
end

function slot0.selectedAllItems(slot0)
	slot0._cardScrollView:setSelectList(CharacterBackpackCardListModel.instance:getCharacterCardList())
end

return slot0
