module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaMainViewContainer", package.seeall)

local var_0_0 = class("TianShiNaNaMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._mapViewScene = TianShiNaNaMainScene.New()

	return {
		arg_1_0._mapViewScene,
		TianShiNaNaMainView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			var_2_0
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity2_2Enum.ActivityId.TianShiNaNa)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity2_2Enum.ActivityId.TianShiNaNa
	})
end

function var_0_0.setVisibleInternal(arg_4_0, arg_4_1)
	arg_4_0._mapViewScene:setSceneVisible(arg_4_1)
	var_0_0.super.setVisibleInternal(arg_4_0, arg_4_1)
end

return var_0_0
