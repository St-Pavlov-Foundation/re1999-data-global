module("modules.logic.playercard.view.PlayerCardAnimatorView", package.seeall)

local var_0_0 = class("PlayerCardAnimatorView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.goBottom = gohelper.findChild(arg_1_0.viewGO, "Bottom")
	arg_1_0.goBg = gohelper.findChild(arg_1_0.goBottom, "bg")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.CloseLayout, arg_2_0.onCloseLayout, arg_2_0)
	arg_2_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ShowTheme, arg_2_0.onShowTheme, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0.onOpenView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onShowTheme(arg_4_0)
	arg_4_0.animator:Play("switch1", 0, 0)

	arg_4_0._inThemeView = true

	gohelper.setActive(arg_4_0.goBottom, true)
end

function var_0_0.closeThemeView(arg_5_0)
	arg_5_0.animator:Play("switch2", 0, 0)

	arg_5_0._inThemeView = false

	gohelper.setActive(arg_5_0.goBottom, false)
end

function var_0_0.onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.PlayerCardLayoutView then
		arg_6_0.animator:Play("layout1", 0, 0)
	end
end

function var_0_0.onCloseLayout(arg_7_0)
	arg_7_0.animator:Play("layout2", 0, 0)
end

function var_0_0.isInThemeView(arg_8_0)
	return arg_8_0._inThemeView
end

function var_0_0.onClose(arg_9_0)
	return
end

return var_0_0
