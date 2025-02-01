module("modules.logic.character.view.CharacterTalentViewContainer", package.seeall)

slot0 = class("CharacterTalentViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.talent_view = CharacterTalentView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		slot0.talent_view
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
	slot0._navigateButtonView:resetOnCloseViewAudio(AudioEnum.Talent.play_ui_resonate_close)
end

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

function slot0.playCloseTransition(slot0)
	uv0.super.playCloseTransition(slot0, {
		anim = "charactertalentup_out"
	})

	if gohelper.findChildComponent(slot0.viewGO, "commen/rentouxiang/ani/tou/tou", typeof(UnityEngine.Animator)) then
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "commen/rentouxiang/ani/tou/tou_in"), false)

		slot1.enabled = true

		gohelper.setActive(slot1.gameObject, true)
		slot1:Play("0")
	end

	gohelper.findChildComponent(slot0.viewGO, "commen/rentouxiang/ani", typeof(UnityEngine.Animator)):Play("ani_0")
	gohelper.findChildComponent(slot0.viewGO, "#btn_chessboard", typeof(UnityEngine.Animator)):Play("chessboard_out")
	slot0.talent_view:playChessIconOutAni()
end

return slot0
