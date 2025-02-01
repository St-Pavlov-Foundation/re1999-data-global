module("modules.logic.character.view.CharacterTalentChessViewContainer", package.seeall)

slot0 = class("CharacterTalentChessViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.chess_view = CharacterTalentChessView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		slot0.chess_view
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Talent)

		return {
			slot0._navigateButtonView
		}
	end
end

function slot0.onContainerInit(slot0)
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, slot0._navigateButtonView.showHelpBtnIcon, slot0._navigateButtonView)
end

function slot0.onContainerDestroy(slot0)
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, slot0._navigateButtonView.showHelpBtnIcon, slot0._navigateButtonView)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_checkpoint_click)
end

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

function slot0.playCloseTransition(slot0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_close)
	uv0.super.playCloseTransition(slot0, {
		anim = "charactertalentchess_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "3_1", false, "ani_3_1", true)
	slot0.chess_view:playChessIconOutAni()
end

return slot0
