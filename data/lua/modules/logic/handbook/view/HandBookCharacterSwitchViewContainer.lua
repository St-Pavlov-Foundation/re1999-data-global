module("modules.logic.handbook.view.HandBookCharacterSwitchViewContainer", package.seeall)

slot0 = class("HandBookCharacterSwitchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.navigateHandleView = HandBookCharacterNavigateHandleView.New()

	table.insert(slot1, slot0.navigateHandleView)
	table.insert(slot1, HandBookCharacterSwitchView.New())
	table.insert(slot1, HandBookCharacterView.New())
	table.insert(slot1, HandBookCharacterSwitchViewEffect.New())
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

		slot0.navigateView:setOverrideClose(slot0.navigateHandleView.onCloseBtnClick, slot0.navigateHandleView)

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
