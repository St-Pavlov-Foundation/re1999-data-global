module("modules.logic.explore.map.heroanimflow.ExploreHeroResetFlow", package.seeall)

local var_0_0 = class("ExploreHeroResetFlow")

function var_0_0.begin(arg_1_0, arg_1_1)
	arg_1_0.sourceUnitId = arg_1_1
	arg_1_0._isReset = true

	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreHeroResetFlow")
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0.onOpenViewFinish, arg_1_0)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
end

function var_0_0.onOpenViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)

	local var_2_0 = ExploreController.instance:getMap()
	local var_2_1 = var_2_0:getHero()
	local var_2_2 = var_2_0:getUnit(arg_2_0.sourceUnitId)

	if var_2_2 then
		var_2_2:tryTrigger()

		var_2_1.dir = var_2_2.mo.targetDir

		var_2_1:setRotate(0, var_2_2.mo.targetDir, 0)
		var_2_1:setTilemapPos({
			x = var_2_2.mo.targetX,
			y = var_2_2.mo.targetY
		})
	end

	arg_2_0.sourceUnitId = nil

	TaskDispatcher.runDelay(arg_2_0._delayLoadObj, arg_2_0, 0.1)
end

function var_0_0._delayLoadObj(arg_3_0)
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, arg_3_0.onSceneObjLoaded, arg_3_0)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function var_0_0.onSceneObjLoaded(arg_4_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_4_0.onSceneObjLoaded, arg_4_0)
	arg_4_0:checkMsgRecv()
end

function var_0_0.checkMsgRecv(arg_5_0)
	if not ExploreModel.instance:isHeroInControl(ExploreEnum.HeroLock.BeginInteract) then
		ExploreController.instance:registerCallback(ExploreEvent.UnitInteractEnd, arg_5_0.onBlackEnd, arg_5_0)
	else
		arg_5_0:onBlackEnd()
	end
end

function var_0_0.onBlackEnd(arg_6_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitInteractEnd, arg_6_0.onBlackEnd, arg_6_0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroResetFlow")
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)
	ExploreController.instance:getMapPipe():initColors(true)

	arg_6_0._isReset = false
end

function var_0_0.isReseting(arg_7_0)
	return arg_7_0._isReset
end

function var_0_0.clear(arg_8_0)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreHeroResetFlow")
	TaskDispatcher.cancelTask(arg_8_0._delayLoadObj, arg_8_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.UnitInteractEnd, arg_8_0.onBlackEnd, arg_8_0)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, arg_8_0.onSceneObjLoaded, arg_8_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_8_0.onOpenViewFinish, arg_8_0)

	arg_8_0._isReset = false

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.HeroAnim)
end

var_0_0.instance = var_0_0.New()

return var_0_0
