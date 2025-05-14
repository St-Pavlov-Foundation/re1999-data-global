module("modules.logic.guide.controller.action.impl.GuideActionPlayAnimator", package.seeall)

local var_0_0 = class("GuideActionPlayAnimator", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._animRoot = var_1_0[1]
	arg_1_0._controllerPath = var_1_0[2]
	arg_1_0._endAnim = var_1_0[3]
	arg_1_0._endAnimTime = tonumber(var_1_0[4])

	local var_1_1 = MultiAbLoader.New()

	arg_1_0._loader = var_1_1

	var_1_1:addPath(arg_1_0._controllerPath)
	var_1_1:startLoad(arg_1_0._loadedFinish, arg_1_0)
	arg_1_0:onDone(true)
end

function var_0_0._loadedFinish(arg_2_0, arg_2_1)
	local var_2_0 = gohelper.find(arg_2_0._animRoot)
	local var_2_1 = arg_2_0._loader:getFirstAssetItem():GetResource()
	local var_2_2 = gohelper.onceAddComponent(var_2_0, typeof(UnityEngine.Animator))

	if not var_2_2 then
		return
	end

	var_2_2.enabled = true
	var_2_2.runtimeAnimatorController = var_2_1
	arg_2_0._animator = var_2_2
end

function var_0_0._stopAnimator(arg_3_0)
	if arg_3_0._animator and gohelper.isNil(arg_3_0._animator) == false then
		arg_3_0._animator.runtimeAnimatorController = nil
		arg_3_0._animator.enabled = false
	end
end

function var_0_0.onDestroy(arg_4_0)
	var_0_0.super.onDestroy(arg_4_0)

	if arg_4_0._animator and arg_4_0._endAnim then
		arg_4_0._animator:Play(arg_4_0._endAnim)
	end

	if arg_4_0._animator and arg_4_0._endAnimTime then
		TaskDispatcher.runDelay(arg_4_0._stopAnimator, arg_4_0, arg_4_0._endAnimTime)
	end

	if arg_4_0._loader then
		arg_4_0._loader:dispose()
	end
end

return var_0_0
