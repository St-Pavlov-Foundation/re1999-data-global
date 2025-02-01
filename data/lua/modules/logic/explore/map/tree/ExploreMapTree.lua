module("modules.logic.explore.map.tree.ExploreMapTree", package.seeall)

slot0 = class("ExploreMapTree")

function slot0.ctor(slot0)
	slot0.root = nil
	slot0.checkMode = ExploreEnum.SceneCheckMode.Planes

	if SLFramework.FrameworkSettings.IsEditor then
		ZProj.ExploreHelper.InitDrawBound()
		TaskDispatcher.runRepeat(slot0.drawBound, slot0, 1e-05)
	end
end

function slot0.setup(slot0, slot1, slot2)
	slot0.root = ExploreMapTreeNode.New(slot1, slot2)
	slot0.camera = CameraMgr.instance:getMainCamera()
end

function slot0.triggerMove(slot0, slot1, slot2)
	if slot0.checkMode == ExploreEnum.SceneCheckMode.Planes then
		ZProj.ExploreHelper.RebuildFrustumPlanes(slot0.camera, 25, 0.01, slot0.camera.fieldOfView + 2, slot0.camera.aspect)
	end

	if slot0.checkMode ~= ExploreEnum.SceneCheckMode.Rage then
		slot1.z = 6
		slot1.w = 6
	end

	slot0.root:triggerMove(slot1, slot0.camera, slot0.checkMode, slot2)
end

function slot0.drawBound(slot0)
	ZProj.ExploreHelper.ResetBoundsList()
	slot0.root:drawBound()
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.drawBound, slot0)

	if slot0.root then
		slot0.root:onDestroy()

		slot0.root = nil
	end

	slot0.camera = nil
end

return slot0
