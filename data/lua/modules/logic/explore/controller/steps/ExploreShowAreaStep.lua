module("modules.logic.explore.controller.steps.ExploreShowAreaStep", package.seeall)

slot0 = class("ExploreShowAreaStep", ExploreStepBase)

function slot0.onInit(slot0)
	slot0._unLockAreas = slot0._data.showAreas

	if #slot0._unLockAreas ~= 1 then
		if #slot0._unLockAreas > 1 then
			logError("暂不支持多区域同时解锁")
		end

		return
	end

	slot0.areaGo = ExploreController.instance:getMap():getContainRootByAreaId(slot0._unLockAreas[1]).go
	slot0._loader = MultiAbLoader.New()

	slot0._loader:addPath(string.format("explore/camera_anim/%d_%d.controller", ExploreModel.instance:getMapId(), slot0._unLockAreas[1]))
	slot0._loader:startLoad(slot0._loadedFinish, slot0)
end

function slot0.onStart(slot0)
	if #slot0._unLockAreas ~= 1 then
		slot0:onDone()

		return
	end

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.ShowArea)
	gohelper.setActive(slot0.areaGo, false)

	ExploreModel.instance.unLockAreaIds[slot0._unLockAreas[1]] = true

	ExploreController.instance:dispatchEvent(ExploreEvent.AreaShow)
end

function slot0._loadedFinish(slot0)
	if not slot0._data then
		return
	end

	gohelper.setActive(slot0.areaGo, true)

	slot0._anim = gohelper.onceAddComponent(slot0.areaGo, typeof(UnityEngine.Animator))
	slot0._anim.runtimeAnimatorController = slot0._loader:getFirstAssetItem():GetResource()

	TaskDispatcher.runDelay(slot0._onAnimDone, slot0, slot0._anim:GetCurrentAnimatorStateInfo(0).length)
end

function slot0._onAnimDone(slot0)
	slot0:onDone()
end

function slot0.onDestory(slot0)
	TaskDispatcher.cancelTask(slot0._onAnimDone, slot0)

	slot0.areaGo = nil

	if slot0._anim then
		gohelper.destroy(slot0._anim)

		slot0._anim = nil
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.ShowArea)
	uv0.super.onDestory(slot0)
end

return slot0
