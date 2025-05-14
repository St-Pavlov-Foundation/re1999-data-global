module("modules.logic.rouge.view.RougeCollectionChessViewContainer", package.seeall)

local var_0_0 = class("RougeCollectionChessViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._poolComp = RougeCollectionChessPoolComp.New()

	return {
		TabViewGroup.New(1, "#go_left/#go_btns"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		arg_1_0._poolComp,
		RougeCollectionEffectActiveComp.New(),
		RougeCollectionEffectTriggerComp.New(),
		RougeCollectionChessView.New(),
		RougeCollectionChessSlotComp.New(),
		RougeCollectionChessBagComp.New(),
		RougeCollectionChessInteractComp.New(),
		RougeCollectionChessPlaceComp.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		arg_2_0._navigateButtonView:setHelpId(HelpEnum.HelpId.RougeCollectionChessViewHelp)

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

function var_0_0.getRougePoolComp(arg_3_0)
	return arg_3_0._poolComp
end

return var_0_0
