module("modules.logic.character.view.CharacterTalentLevelUpViewContainer", package.seeall)

slot0 = class("CharacterTalentLevelUpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop"),
		CharacterTalentLevelUpView.New()
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
	elseif slot1 == 2 then
		return {
			CurrencyView.New({
				CurrencyEnum.CurrencyType.Gold
			})
		}
	end
end

function slot0.playOpenTransition(slot0)
	slot0:onPlayOpenTransitionFinish()
end

function slot0.playCloseTransition(slot0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_open)
	uv0.super.playCloseTransition(slot0, {
		anim = "charactertalentlevelup_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, slot0._head_close_ani1 or "2_1", slot0._head_close_ani1 and true or false, slot0._head_close_ani2 or "ani_2_1", true)
end

return slot0
