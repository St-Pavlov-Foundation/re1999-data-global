module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotMainViewContainer", package.seeall)

local var_0_0 = class("V1a6_CachotMainViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0._guideDragTip = V1a6_CachotGuideDragTip.New()

	return {
		V1a6_CachotMainView.New(),
		V1a6_CachotPlayCtrlView.New(),
		arg_1_0._guideDragTip,
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		true,
		false
	})

	var_2_0:setOverrideClose(arg_2_0._onCloseClick, arg_2_0)
	var_2_0:setOverrideHome(arg_2_0._onHomeClick, arg_2_0)
	var_2_0:setCloseCheck(arg_2_0._navCloseCheck, arg_2_0)

	return {
		var_2_0
	}
end

function var_0_0._navCloseCheck(arg_3_0)
	return not (arg_3_0._guideDragTip and arg_3_0._guideDragTip:isShowDragTip())
end

function var_0_0._onCloseClick(arg_4_0)
	MainController.instance:enterMainScene()
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.VersionActivity1_6EnterView)
		VersionActivity1_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, V1a6_CachotEnum.ActivityId)
	end)
end

function var_0_0._onHomeClick(arg_6_0)
	MainController.instance:enterMainScene()
end

return var_0_0
