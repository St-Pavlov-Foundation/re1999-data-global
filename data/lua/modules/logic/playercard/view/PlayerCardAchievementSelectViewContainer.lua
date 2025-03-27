module("modules.logic.playercard.view.PlayerCardAchievementSelectViewContainer", package.seeall)

slot0 = class("PlayerCardAchievementSelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._scrollView = LuaMixScrollView.New(PlayerCardAchievementSelectListModel.instance, slot0:getMixContentParam())

	return {
		PlayerCardAchievementSelectView.New(),
		TabViewGroup.New(1, "#go_btns"),
		slot0._scrollView
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0.navigateView:setOverrideClose(slot0.overrideCloseFunc, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.getMixContentParam(slot0)
	slot1 = MixScrollParam.New()
	slot1.scrollGOPath = "#go_container/#scroll_content"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = PlayerCardAchievementSelectItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.endSpace = 50

	return slot1
end

function slot0.overrideCloseFunc(slot0)
	PlayerCardAchievementSelectController.instance:popUpMessageBoxIfNeedSave(slot0.yesCallBackFunc, nil, slot0.closeThis, slot0, nil, slot0)
end

function slot0.yesCallBackFunc(slot0)
	PlayerCardAchievementSelectController.instance:resumeToOriginSelect()
	slot0:closeThis()
end

return slot0
