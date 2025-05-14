module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewContainer", package.seeall)

local var_0_0 = class("Activity1_3ChessMapViewContainer", BaseViewContainer)
local var_0_1 = "ChessMapViewColseBlockKey"
local var_0_2 = 0.8
local var_0_3 = 0.3

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0._mapViewScene = Activity1_3ChessMapScene.New()
	arg_1_0._mapView = Activity1_3ChessMapView.New()
	arg_1_0._viewAnim = Activity1_3ChessMapViewAnim.New()
	arg_1_0._viewAudio = Activity1_3ChessMapViewAudio.New()
	var_1_0[#var_1_0 + 1] = arg_1_0._mapViewScene
	var_1_0[#var_1_0 + 1] = arg_1_0._mapView
	var_1_0[#var_1_0 + 1] = arg_1_0._viewAnim
	var_1_0[#var_1_0 + 1] = arg_1_0._viewAudio
	var_1_0[#var_1_0 + 1] = TabViewGroup.New(1, "#go_BackBtns")

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		var_2_0:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0._overrideCloseFunc(arg_3_0)
	UIBlockMgr.instance:startBlock(var_0_1)
	arg_3_0._mapView:playViewAnimation(UIAnimationName.Close)
	TaskDispatcher.runDelay(arg_3_0._onDelayCloseView, arg_3_0, var_0_3)
end

function var_0_0._onDelayCloseView(arg_4_0)
	UIBlockMgr.instance:endBlock(var_0_1)
	arg_4_0._viewAnim:closeThis()
end

function var_0_0.onContainerInit(arg_5_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act304)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act304
	})
end

function var_0_0.switchStage(arg_6_0, arg_6_1)
	if arg_6_0._mapViewScene then
		arg_6_0._mapViewScene:switchStage(arg_6_1)
	end
end

function var_0_0.playPathAnim(arg_7_0)
	if arg_7_0._viewAnim then
		arg_7_0._viewAnim:playPathAnim()
	end
end

function var_0_0.showEnterSceneView(arg_8_0, arg_8_1)
	if arg_8_0._mapViewScene then
		arg_8_0._mapViewScene:playSceneEnterAni(arg_8_1)
	end
end

function var_0_0._setVisible(arg_9_0, arg_9_1)
	BaseViewContainer._setVisible(arg_9_0, arg_9_1)

	local var_9_0 = Activity1_3ChessController.instance:isReviewStory()

	if arg_9_0._mapViewScene then
		arg_9_0._mapViewScene:onSetVisible(arg_9_1)

		if not var_9_0 then
			arg_9_0._mapViewScene:setSceneActive(arg_9_1)
		end
	end

	if arg_9_0._mapView then
		arg_9_0._mapView:onSetVisible(arg_9_1, var_9_0)

		if not var_9_0 and arg_9_1 then
			arg_9_0._mapView:playViewAnimation(UIAnimationName.Open)
		end
	end
end

return var_0_0
