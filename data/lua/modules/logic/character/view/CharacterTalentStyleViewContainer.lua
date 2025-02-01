module("modules.logic.character.view.CharacterTalentStyleViewContainer", package.seeall)

slot0 = class("CharacterTalentStyleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "go_style/#scroll_style"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "go_style/#item_style"
	slot1.cellClass = CharacterTalentStyleItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 212
	slot1.cellHeight = 212
	slot1.cellSpaceV = -45
	slot0._view = CharacterTalentStyleView.New()

	return {
		LuaListScrollView.New(TalentStyleListModel.instance, slot1),
		slot0._view,
		TabViewGroup.New(1, "#go_leftbtns"),
		TabViewGroup.New(2, "#go_rightbtns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TalentStyleViewHelp)

		slot2:setOverrideClose(slot0.overrideCloseFunc, slot0)

		return {
			slot2
		}
	elseif slot1 == 2 then
		slot3 = CurrencyView.New({
			CurrencyEnum.CurrencyType.Gold
		})
		slot3.foreHideBtn = true

		return {
			slot3
		}
	end
end

function slot0.overrideCloseFunc(slot0)
	if slot0._view then
		slot0._view:playCloseAnim()
	else
		slot0:closeThis()
	end
end

return slot0
