module("modules.logic.character.view.CharacterExSkillViewContainer", package.seeall)

slot0 = class("CharacterExSkillViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterExSkillView.New(),
		TabViewGroup.New(1, "#go_btn"),
		CommonRainEffectView.New("bg/#go_glowcontainer")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigateView
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
	slot0.navigateView:resetHomeBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
end

function slot0.hideHomeBtn(slot0)
	slot0.navigateView:setParam({
		true,
		false,
		false
	})
end

return slot0
