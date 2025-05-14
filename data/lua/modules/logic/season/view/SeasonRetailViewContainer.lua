module("modules.logic.season.view.SeasonRetailViewContainer", package.seeall)

local var_0_0 = class("SeasonRetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, SeasonRetailView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, 100, arg_2_0._closeCallback, arg_2_0._homeCallback, nil, arg_2_0)

	return {
		arg_2_0._navigateButtonView
	}
end

function var_0_0._closeCallback(arg_3_0)
	arg_3_0:closeThis()
end

function var_0_0._homeCallback(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.setVisibleInternal(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0:_setVisible(true)
		arg_5_0:playAnim(UIAnimationName.Open)
	elseif ViewMgr.instance:isOpen(ViewName.SeasonMainView) then
		arg_5_0:playAnim(UIAnimationName.Close)
	else
		arg_5_0:_setVisible(false)
	end
end

function var_0_0.playAnim(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0._anim and arg_6_0.viewGO then
		arg_6_0._anim = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_6_0._anim then
		if arg_6_2 and arg_6_3 then
			arg_6_0._anim:Play(arg_6_1, arg_6_2, arg_6_3)
		else
			arg_6_0._anim:Play(arg_6_1)
		end
	end
end

return var_0_0
