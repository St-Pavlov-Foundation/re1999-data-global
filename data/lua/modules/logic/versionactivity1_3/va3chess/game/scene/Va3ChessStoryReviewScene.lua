module("modules.logic.versionactivity1_3.va3chess.game.scene.Va3ChessStoryReviewScene", package.seeall)

local var_0_0 = class("Va3ChessStoryReviewScene", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
end

var_0_0.BLOCK_KEY = "Va3ChessGameSceneLoading"

function var_0_0.onDestroyView(arg_2_0)
	arg_2_0:_clearRes()
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:addEventCb(Va3ChessController.instance, Va3ChessEvent.StoryReviewSceneActvie, arg_3_0.showScene, arg_3_0)
end

function var_0_0.onClose(arg_4_0)
	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_4_0._onDelayClearRes, arg_4_0)
end

function var_0_0.showScene(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 then
		if arg_5_0._sceneActive then
			arg_5_0:_clearRes()
		end

		arg_5_0._sceneActive = true
		arg_5_0._mapPath = arg_5_2

		arg_5_0:createSceneRoot()
		arg_5_0:loadRes()
	end
end

function var_0_0.resetOpenAnim(arg_6_0)
	if arg_6_0._viewAnimator then
		arg_6_0._viewAnimator:Play(arg_6_0._sceneActive and "switch" or "open", 0, 0)
	end

	arg_6_0._sceneActive = false

	arg_6_0:_clearRes()
end

function var_0_0._clearRes(arg_7_0)
	arg_7_0:releaseRes()
	arg_7_0:disposeSceneRoot()
end

function var_0_0.loadRes(arg_8_0)
	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_KEY)

	arg_8_0._loader = MultiAbLoader.New()

	arg_8_0._loader:addPath(arg_8_0:getCurrentSceneUrl())
	arg_8_0._loader:startLoad(arg_8_0.loadResCompleted, arg_8_0)
end

function var_0_0.getCurrentSceneUrl(arg_9_0)
	if arg_9_0._mapPath then
		return string.format(Va3ChessEnum.SceneResPath.SceneFormatPath, arg_9_0._mapPath)
	else
		return Va3ChessEnum.SceneResPath.DefaultScene
	end
end

function var_0_0.loadResCompleted(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getAssetItem(arg_10_0:getCurrentSceneUrl())

	if var_10_0 then
		arg_10_0._sceneGo = gohelper.clone(var_10_0:GetResource(), arg_10_0._sceneRoot, "scene")
		arg_10_0._sceneEffect1 = gohelper.findChild(arg_10_0._sceneGo, "Obj-Plant/all/diffuse/vx_click_quan")
		arg_10_0._sceneEffect2 = gohelper.findChild(arg_10_0._sceneGo, "Obj-Plant/all/diffuse/vx_click_eye")

		if arg_10_0._sceneEffect1 and not gohelper.isNil(arg_10_0._sceneEffect1) then
			gohelper.setActive(arg_10_0._sceneEffect1, false)
			gohelper.setActive(arg_10_0._sceneEffect2, false)
		end
	end

	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
end

function var_0_0.releaseRes(arg_11_0)
	if arg_11_0._loader then
		arg_11_0._loader:dispose()

		arg_11_0._loader = nil
	end
end

function var_0_0.createSceneRoot(arg_12_0)
	local var_12_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_12_1 = CameraMgr.instance:getSceneRoot()

	arg_12_0._sceneRoot = UnityEngine.GameObject.New("StoryReviewScene")

	local var_12_2, var_12_3, var_12_4 = transformhelper.getLocalPos(var_12_0)

	transformhelper.setLocalPos(arg_12_0._sceneRoot.transform, 0, var_12_3, -10)

	arg_12_0._sceneOffsetY = var_12_3

	gohelper.addChild(var_12_1, arg_12_0._sceneRoot)
end

function var_0_0.disposeSceneRoot(arg_13_0)
	if arg_13_0._sceneRoot then
		gohelper.destroy(arg_13_0._sceneRoot)

		arg_13_0._sceneRoot = nil
	end

	arg_13_0._sceneGo = nil
end

function var_0_0.playEnterAnim(arg_14_0)
	if arg_14_0._sceneAnim then
		arg_14_0._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

return var_0_0
