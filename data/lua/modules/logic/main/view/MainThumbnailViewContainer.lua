module("modules.logic.main.view.MainThumbnailViewContainer", package.seeall)

local var_0_0 = class("MainThumbnailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._heroView = MainThumbnailHeroView.New()

	return {
		MainThumbnailView.New(),
		arg_1_0._heroView,
		MainThumbnailRecommendView.New(),
		MainThumbnailBtnView.New(),
		MainThumbnailBgmView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	arg_2_0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	}, 101)

	return {
		arg_2_0.navigationView
	}
end

function var_0_0.getThumbnailNav(arg_3_0)
	return arg_3_0.navigationView
end

function var_0_0.playCloseTransition(arg_4_0)
	var_0_0.super.playCloseTransition(arg_4_0, {
		duration = 1
	})
end

function var_0_0.getLightSpineGo(arg_5_0)
	return arg_5_0._heroView:getLightSpineGo()
end

return var_0_0
