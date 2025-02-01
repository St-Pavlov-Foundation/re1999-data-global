module("modules.logic.character.view.CharacterTalentLevelUpResultViewContainer", package.seeall)

slot0 = class("CharacterTalentLevelUpResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		CharacterTalentLevelUpResultView.New(),
		TabViewGroup.New(1, "#go_lefttop")
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

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

function slot0.playCloseTransition(slot0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_success_close)
	uv0.super.playCloseTransition(slot0, {
		anim = "charactertalentlevelupresult_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentLevelUpViewInAni)
end

return slot0
