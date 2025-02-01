module("modules.logic.equip.view.EquipTeamViewContainer", package.seeall)

slot0 = class("EquipTeamViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_equipcontainer/#scroll_equip"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = EquipTeamItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 3
	slot1.cellWidth = 200
	slot1.cellHeight = 210
	slot1.cellSpaceH = 28
	slot1.cellSpaceV = 10
	slot1.startSpace = 13

	return {
		EquipTeamView.New(),
		TabViewGroup.New(1, "#go_btns"),
		LuaListScrollView.New(EquipTeamListModel.instance, slot1)
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil, slot0._overrideClose)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0._overrideClose(slot0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnCloseEquipTeamShowView)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.UI_Rolesclose)
end

return slot0
