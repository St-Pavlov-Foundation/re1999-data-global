module("modules.logic.signin.view.SignInViewContainer", package.seeall)

slot0 = class("SignInViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "rightContent/monthdetail/scroll_item"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = SignInListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 7
	slot2.cellWidth = 110
	slot2.cellHeight = 144
	slot2.cellSpaceH = 8.3
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot2.endSpace = 0
	slot2.minUpdateCountInFrame = 100

	table.insert(slot1, LuaListScrollView.New(SignInListModel.instance, slot2))
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))
	table.insert(slot1, SignInView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			false,
			false,
			false
		})

		slot2:setOverrideClose(slot0.overrideOnCloseClick, slot0)

		return {
			slot2
		}
	end
end

function slot0.overrideOnCloseClick(slot0)
	SignInController.instance:dispatchEvent(SignInEvent.CloseSignInView)
end

return slot0
