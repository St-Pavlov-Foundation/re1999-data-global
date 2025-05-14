module("modules.logic.explore.controller.steps.ExploreShowAreaStep", package.seeall)

local var_0_0 = class("ExploreShowAreaStep", ExploreStepBase)

function var_0_0.onInit(arg_1_0)
	arg_1_0._unLockAreas = arg_1_0._data.showAreas

	if #arg_1_0._unLockAreas ~= 1 then
		if #arg_1_0._unLockAreas > 1 then
			logError("暂不支持多区域同时解锁")
		end

		return
	end

	arg_1_0.areaGo = ExploreController.instance:getMap():getContainRootByAreaId(arg_1_0._unLockAreas[1]).go
	arg_1_0._loader = MultiAbLoader.New()

	arg_1_0._loader:addPath(string.format("explore/camera_anim/%d_%d.controller", ExploreModel.instance:getMapId(), arg_1_0._unLockAreas[1]))
	arg_1_0._loader:startLoad(arg_1_0._loadedFinish, arg_1_0)
end

function var_0_0.onStart(arg_2_0)
	if #arg_2_0._unLockAreas ~= 1 then
		arg_2_0:onDone()

		return
	end

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.ShowArea)
	gohelper.setActive(arg_2_0.areaGo, false)

	ExploreModel.instance.unLockAreaIds[arg_2_0._unLockAreas[1]] = true

	ExploreController.instance:dispatchEvent(ExploreEvent.AreaShow)
end

function var_0_0._loadedFinish(arg_3_0)
	if not arg_3_0._data then
		return
	end

	gohelper.setActive(arg_3_0.areaGo, true)

	local var_3_0 = arg_3_0._loader:getFirstAssetItem():GetResource()

	arg_3_0._anim = gohelper.onceAddComponent(arg_3_0.areaGo, typeof(UnityEngine.Animator))
	arg_3_0._anim.runtimeAnimatorController = var_3_0

	local var_3_1 = arg_3_0._anim:GetCurrentAnimatorStateInfo(0)

	TaskDispatcher.runDelay(arg_3_0._onAnimDone, arg_3_0, var_3_1.length)
end

function var_0_0._onAnimDone(arg_4_0)
	arg_4_0:onDone()
end

function var_0_0.onDestory(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onAnimDone, arg_5_0)

	arg_5_0.areaGo = nil

	if arg_5_0._anim then
		gohelper.destroy(arg_5_0._anim)

		arg_5_0._anim = nil
	end

	if arg_5_0._loader then
		arg_5_0._loader:dispose()

		arg_5_0._loader = nil
	end

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.ShowArea)
	var_0_0.super.onDestory(arg_5_0)
end

return var_0_0
