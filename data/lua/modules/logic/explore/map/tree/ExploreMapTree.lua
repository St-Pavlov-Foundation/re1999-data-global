module("modules.logic.explore.map.tree.ExploreMapTree", package.seeall)

local var_0_0 = class("ExploreMapTree")

function var_0_0.ctor(arg_1_0)
	arg_1_0.root = nil
	arg_1_0.checkMode = ExploreEnum.SceneCheckMode.Planes

	if SLFramework.FrameworkSettings.IsEditor then
		ZProj.ExploreHelper.InitDrawBound()
		TaskDispatcher.runRepeat(arg_1_0.drawBound, arg_1_0, 1e-05)
	end
end

function var_0_0.setup(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.root = ExploreMapTreeNode.New(arg_2_1, arg_2_2)
	arg_2_0.camera = CameraMgr.instance:getMainCamera()
end

function var_0_0.triggerMove(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.checkMode == ExploreEnum.SceneCheckMode.Planes then
		local var_3_0 = arg_3_0.camera.fieldOfView + 2
		local var_3_1 = arg_3_0.camera.aspect
		local var_3_2 = 25
		local var_3_3 = 0.01

		ZProj.ExploreHelper.RebuildFrustumPlanes(arg_3_0.camera, var_3_2, var_3_3, var_3_0, var_3_1)
	end

	if arg_3_0.checkMode ~= ExploreEnum.SceneCheckMode.Rage then
		arg_3_1.z = 6
		arg_3_1.w = 6
	end

	arg_3_0.root:triggerMove(arg_3_1, arg_3_0.camera, arg_3_0.checkMode, arg_3_2)
end

function var_0_0.drawBound(arg_4_0)
	ZProj.ExploreHelper.ResetBoundsList()
	arg_4_0.root:drawBound()
end

function var_0_0.onDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.drawBound, arg_5_0)

	if arg_5_0.root then
		arg_5_0.root:onDestroy()

		arg_5_0.root = nil
	end

	arg_5_0.camera = nil
end

return var_0_0
