module("modules.logic.playercard.view.PlayerCardCharacterSwitchViewContainer", package.seeall)

slot0 = class("PlayerCardCharacterSwitchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerCardCharacterSwitchView.New())

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

function slot0._overrideClose(slot0)
	if not PlayerCardModel.instance:checkHeroDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, uv0.yesCallback, uv0.cancel)
	else
		slot0:closeFunc()
	end
end

function slot0.cancel()
	slot1, slot2, slot3, slot4 = PlayerCardModel.instance:getCardInfo():getMainHero()

	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshSwitchView, {
		heroId = slot1,
		skinId = slot2
	})
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

function slot0.yesCallback()
	slot0, slot1 = PlayerCardModel.instance:getSelectHero()

	PlayerCardCharacterSwitchListModel.instance:changeMainHero(slot0, slot1)
end

function slot0.closeFunc(slot0)
	ViewMgr.instance:closeView(ViewName.PlayerCardCharacterSwitchView, nil, true)
end

return slot0
