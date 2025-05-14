module("modules.logic.voyage.view.VoyagePopupRewardViewContainer", package.seeall)

local var_0_0 = class("VoyagePopupRewardViewContainer", BaseViewContainer)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.BeforeOpenView, arg_1_0._beforeOpenView, arg_1_0)
end

function var_0_0.buildViews(arg_2_0)
	return {
		VoyagePopupRewardView.New()
	}
end

function var_0_0._beforeOpenView(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == ViewName.VoyagePopupRewardView and arg_3_2 and arg_3_2.openFromGuide then
		-- block empty
	end
end

return var_0_0
