module("modules.logic.versionactivity1_3.va3chess.game.scene.Va3ChessStoryReviewScene", package.seeall)

slot0 = class("Va3ChessStoryReviewScene", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._viewAnimator = slot0.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
end

slot0.BLOCK_KEY = "Va3ChessGameSceneLoading"

function slot0.onDestroyView(slot0)
	slot0:_clearRes()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Va3ChessController.instance, Va3ChessEvent.StoryReviewSceneActvie, slot0.showScene, slot0)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0._onDelayClearRes, slot0)
end

function slot0.showScene(slot0, slot1, slot2)
	if slot1 then
		if slot0._sceneActive then
			slot0:_clearRes()
		end

		slot0._sceneActive = true
		slot0._mapPath = slot2

		slot0:createSceneRoot()
		slot0:loadRes()
	end
end

function slot0.resetOpenAnim(slot0)
	if slot0._viewAnimator then
		slot0._viewAnimator:Play(slot0._sceneActive and "switch" or "open", 0, 0)
	end

	slot0._sceneActive = false

	slot0:_clearRes()
end

function slot0._clearRes(slot0)
	slot0:releaseRes()
	slot0:disposeSceneRoot()
end

function slot0.loadRes(slot0)
	UIBlockMgr.instance:startBlock(uv0.BLOCK_KEY)

	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(slot0:getCurrentSceneUrl())
	slot0._loader:startLoad(slot0.loadResCompleted, slot0)
end

function slot0.getCurrentSceneUrl(slot0)
	if slot0._mapPath then
		return string.format(Va3ChessEnum.SceneResPath.SceneFormatPath, slot0._mapPath)
	else
		return Va3ChessEnum.SceneResPath.DefaultScene
	end
end

function slot0.loadResCompleted(slot0, slot1)
	if slot1:getAssetItem(slot0:getCurrentSceneUrl()) then
		slot0._sceneGo = gohelper.clone(slot2:GetResource(), slot0._sceneRoot, "scene")
		slot0._sceneEffect1 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/vx_click_quan")
		slot0._sceneEffect2 = gohelper.findChild(slot0._sceneGo, "Obj-Plant/all/diffuse/vx_click_eye")

		if slot0._sceneEffect1 and not gohelper.isNil(slot0._sceneEffect1) then
			gohelper.setActive(slot0._sceneEffect1, false)
			gohelper.setActive(slot0._sceneEffect2, false)
		end
	end

	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
end

function slot0.releaseRes(slot0)
	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

function slot0.createSceneRoot(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("StoryReviewScene")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, -10)

	slot0._sceneOffsetY = slot4

	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.disposeSceneRoot(slot0)
	if slot0._sceneRoot then
		gohelper.destroy(slot0._sceneRoot)

		slot0._sceneRoot = nil
	end

	slot0._sceneGo = nil
end

function slot0.playEnterAnim(slot0)
	if slot0._sceneAnim then
		slot0._sceneAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

return slot0
