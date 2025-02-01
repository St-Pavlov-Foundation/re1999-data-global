module("modules.logic.character.view.CharacterDataViewContainer", package.seeall)

slot0 = class("CharacterDataViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, CharacterDataView.New())
	table.insert(slot1, TabViewGroup.New(1, "topleft"))
	table.insert(slot1, TabViewGroup.New(2, "content"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigationView
		}
	elseif slot1 == 2 then
		slot2 = ListScrollParam.New()
		slot2.scrollGOPath = "content/#scroll_vioce"
		slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot2.prefabUrl = slot0._viewSetting.otherRes[1]
		slot2.cellClass = CharacterVoiceItem
		slot2.scrollDir = ScrollEnum.ScrollDirV
		slot2.lineCount = 1
		slot2.cellWidth = 693.3164
		slot2.cellHeight = 90
		slot2.cellSpaceH = 0
		slot2.cellSpaceV = 2
		slot2.startSpace = 0
		slot2.endSpace = 0

		return {
			CharacterDataTitleView.New(),
			MultiView.New({
				CharacterDataVoiceView.New(),
				LuaListScrollView.New(CharacterVoiceModel.instance, slot2)
			}),
			CharacterDataItemView.New(),
			CharacterDataCultureView.New()
		}
	end
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.UI_role_introduce_close)
end

return slot0
