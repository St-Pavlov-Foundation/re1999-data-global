module("modules.logic.playercard.view.PlayerCardBaseInfoViewContainer", package.seeall)

slot0 = class("PlayerCardBaseInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerCardBaseInfoView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_base"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#scroll_base/Viewport/Content/#go_baseInfoitem"
	slot2.cellClass = PlayerCardBaseInfoItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 528
	slot2.cellHeight = 112
	slot2.cellSpaceV = 19
	slot0._scrollView = LuaListScrollView.New(PlayerCardBaseInfoModel.instance, slot2)

	table.insert(slot1, slot0._scrollView)
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
	slot0:checkCloseFunc()
end

function slot0.checkCloseFunc(slot0)
	if not PlayerCardBaseInfoModel.instance:checkDiff() then
		GameFacade.showMessageBox(MessageBoxIdDefine.PlayerCardSelectTips, MsgBoxEnum.BoxType.Yes_No, uv0.yesCallback, uv0.cancel)
	else
		slot0:closeFunc()
	end
end

function slot0.yesCallback()
	PlayerCardBaseInfoModel.instance:confirmData()
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

function slot0.cancel()
	PlayerCardBaseInfoModel.instance:reselectData()
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

function slot0.closeFunc(slot0)
	ViewMgr.instance:closeView(ViewName.PlayerCardBaseInfoView, nil, true)
end

return slot0
