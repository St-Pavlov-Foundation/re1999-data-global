module("modules.logic.achievement.view.AchievementSelectViewContainer", package.seeall)

slot0 = class("AchievementSelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._scrollView = LuaMixScrollView.New(AchievementSelectListModel.instance, slot0:getMixContentParam())

	return {
		AchievementSelectView.New(),
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
	slot1.cellClass = AchievementSelectItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.endSpace = 50

	return slot1
end

function slot0.overrideCloseFunc(slot0)
	AchievementSelectController.instance:popUpMessageBoxIfNeedSave(slot0.yesCallBackFunc, nil, slot0.closeThis, slot0, nil, slot0)
end

function slot0.yesCallBackFunc(slot0)
	AchievementSelectController.instance:resumeToOriginSelect()
	slot0:closeThis()
end

return slot0
