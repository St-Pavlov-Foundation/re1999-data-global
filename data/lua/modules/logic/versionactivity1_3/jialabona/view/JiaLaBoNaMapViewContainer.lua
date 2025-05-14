module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewContainer", package.seeall)

local var_0_0 = class("JiaLaBoNaMapViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mapViewScene = JiaLaBoNaMapScene.New()
	arg_1_0._viewAnim = JiaLaBoNaMapViewAnim.New()

	table.insert(var_1_0, arg_1_0._mapViewScene)
	table.insert(var_1_0, JiaLaBoNaMapView.New())
	table.insert(var_1_0, arg_1_0._viewAnim)
	table.insert(var_1_0, JiaLaBoNaMapViewAudio.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_BackBtns"))

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	arg_2_0:closeThis()
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_3_0._navigateButtonsView:setOverrideClose(arg_3_0._overrideCloseFunc, arg_3_0)

		return {
			arg_3_0._navigateButtonsView
		}
	end
end

var_0_0.UI_COLSE_BLOCK_KEY = "JiaLaBoNaMapViewContainer_COLSE_BLOCK_KEY"

function var_0_0._overrideCloseFunc(arg_4_0)
	UIBlockMgr.instance:startBlock(var_0_0.UI_COLSE_BLOCK_KEY)
	arg_4_0._viewAnim:playViewAnimator(UIAnimationName.Close)
	TaskDispatcher.runDelay(arg_4_0._onDelayCloseView, arg_4_0, JiaLaBoNaEnum.AnimatorTime.MapViewClose)
end

function var_0_0._onDelayCloseView(arg_5_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_COLSE_BLOCK_KEY)
	arg_5_0._viewAnim:closeThis()
end

function var_0_0.switchPage(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._mapViewScene then
		arg_6_0._mapViewScene:switchPage(arg_6_1)

		if not string.nilorempty(arg_6_2) then
			arg_6_0._mapViewScene:playSceneAnim(arg_6_2)
		end
	end
end

function var_0_0.refreshInteract(arg_7_0, arg_7_1)
	if arg_7_0._mapViewScene then
		arg_7_0._mapViewScene:refreshInteract(arg_7_1)
	end
end

function var_0_0._setVisible(arg_8_0, arg_8_1)
	var_0_0.super._setVisible(arg_8_0, arg_8_1)

	if arg_8_0._mapViewScene then
		local var_8_0 = ViewMgr.instance:isOpen(ViewName.JiaLaBoNaStoryView)

		if not var_8_0 or arg_8_1 then
			arg_8_0._mapViewScene:setSceneActive(arg_8_1)
		end

		if arg_8_0._lastMapViewSceneVisible ~= arg_8_1 then
			arg_8_0._lastMapViewSceneVisible = arg_8_1

			if arg_8_1 and not var_8_0 then
				arg_8_0._mapViewScene:playSceneAnim(UIAnimationName.Open)
				arg_8_0._viewAnim:playViewAnimator(UIAnimationName.Open)
			end
		end
	end
end

function var_0_0.switchScene(arg_9_0, arg_9_1)
	if arg_9_0._viewAnim then
		arg_9_0._viewAnim:switchScene(arg_9_1)
	end
end

function var_0_0.playPathAnim(arg_10_0)
	if arg_10_0._viewAnim then
		arg_10_0._viewAnim:playPathAnim()
	end
end

function var_0_0.refreshPathPoin(arg_11_0)
	if arg_11_0._viewAnim then
		arg_11_0._viewAnim:refreshPathPoin()
	end
end

function var_0_0.onContainerInit(arg_12_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act306)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act306
	})
end

return var_0_0
