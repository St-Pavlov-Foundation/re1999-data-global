module("modules.logic.bgmswitch.view.BGMSwitchViewContainer", package.seeall)

slot0 = class("BGMSwitchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BGMSwitchMechineView.New(),
		BGMSwitchMusicView.New(),
		BGMSwitchEggView.New(),
		TabViewGroup.New(1, "#go_btns"),
		BGMSwitchView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0.navigationView:setHelpId(HelpEnum.HelpId.BgmView)

		return {
			slot0.navigationView
		}
	end
end

return slot0
