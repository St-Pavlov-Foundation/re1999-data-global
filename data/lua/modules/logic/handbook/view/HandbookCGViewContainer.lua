module("modules.logic.handbook.view.HandbookCGViewContainer", package.seeall)

slot0 = class("HandbookCGViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "#scroll_cg"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = HandbookCGItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot0._csScrollView = LuaMixScrollView.New(HandbookCGTripleListModel.instance, slot2)

	table.insert(slot1, HandbookCGView.New())
	table.insert(slot1, slot0._csScrollView)
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.getCsScroll(slot0)
	return slot0._csScrollView
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_screenplay_photo_close)
	slot0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.play_ui_screenplay_photo_close)
end

return slot0
