module("modules.logic.handbook.view.HandbookViewContainer", package.seeall)

slot0 = class("HandbookViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, HandbookView.New())
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

function slot0.onContainerOpenFinish(slot0)
	slot0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
	slot0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return slot0
