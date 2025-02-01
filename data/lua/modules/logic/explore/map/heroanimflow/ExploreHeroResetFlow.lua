module("modules.logic.explore.map.heroanimflow.ExploreHeroResetFlow", package.seeall)

slot0 = class("ExploreHeroResetFlow")

function slot0.begin(slot0, slot1)
	slot0.sourceUnitId = slot1
	slot0._isReset = true

	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroResetFlow")
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

	slot2 = ExploreController.instance:getMap()
	slot3 = slot2:getHero()

	if slot2:getUnit(slot0.sourceUnitId) then
		slot4:tryTrigger()

		slot3.dir = slot4.mo.targetDir

		slot3:setRotate(0, slot4.mo.targetDir, 0)
		slot3:setTilemapPos({
			x = slot4.mo.targetX,
			y = slot4.mo.targetY
		})
	end

	slot0.sourceUnitId = nil

	TaskDispatcher.runDelay(slot0._delayLoadObj, slot0, 0.1)
end

function slot0._delayLoadObj(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onSceneObjLoaded, slot0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function slot0.onSceneObjLoaded(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onSceneObjLoaded, slot0)
	slot0:checkMsgRecv()
end

function slot0.checkMsgRecv(slot0)
	if not ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.BeginInteract) then
		ExploreController.instance:registerCallback(ExploreEvent.UnitInteractEnd, slot0.onBlackEnd, slot0)
	else
		slot0:onBlackEnd()
	end
end

function slot0.onBlackEnd(slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitInteractEnd, slot0.onBlackEnd, slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroResetFlow")
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)
	ExploreController.instance:getMapPipe():initColors(true)

	slot0._isReset = false
end

function slot0.isReseting(slot0)
	return slot0._isReset
end

function slot0.clear(slot0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroResetFlow")
	TaskDispatcher.cancelTask(slot0._delayLoadObj, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitInteractEnd, slot0.onBlackEnd, slot0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, slot0.onSceneObjLoaded, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)

	slot0._isReset = false

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)
end

slot0.instance = slot0.New()

return slot0
