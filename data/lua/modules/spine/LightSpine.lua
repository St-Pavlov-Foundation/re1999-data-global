module("modules.spine.LightSpine", package.seeall)

local var_0_0 = class("LightSpine", BaseSpine)

var_0_0.TypeSkeletonAnimation = typeof(Spine.Unity.SkeletonAnimation)
var_0_0.TypeSpineAnimationEvent = typeof(ZProj.SpineAnimationEvent)

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_0._isStory = arg_1_1

	return var_1_0
end

function var_0_0._onResLoaded(arg_2_0)
	arg_2_0._sharedMaterials = nil
	arg_2_0._retryGetSharedMats = 0

	var_0_0.super._onResLoaded(arg_2_0)
end

function var_0_0.getBoundsMinMaxPos(arg_3_0)
	local var_3_0 = arg_3_0:getRenderer().bounds

	return var_3_0.min, var_3_0.max
end

function var_0_0.initSkeletonComponent(arg_4_0)
	arg_4_0._skeletonComponent = arg_4_0._spineGo:GetComponent(var_0_0.TypeSkeletonAnimation)

	arg_4_0._skeletonComponent:Initialize(false)

	arg_4_0._skeletonComponent.freeze = arg_4_0._bFreeze
	arg_4_0._animationEvent = var_0_0.TypeSpineAnimationEvent
	arg_4_0._mountroot = gohelper.findChild(arg_4_0._spineGo, "mountroot")
end

function var_0_0.changeRenderQueue(arg_5_0, arg_5_1)
	return
end

function var_0_0.setStencilRef(arg_6_0, arg_6_1)
	if gohelper.isNil(arg_6_0._spineGo) then
		return
	end

	local var_6_0 = arg_6_0:getSharedMats()
	local var_6_1 = var_6_0.Length

	for iter_6_0 = 0, var_6_1 - 1 do
		var_6_0[iter_6_0]:SetFloat(ShaderPropertyId.Stencil, arg_6_1)
	end

	if arg_6_0._mountroot then
		gohelper.setActive(arg_6_0._mountroot, arg_6_1 == 0)
	end
end

function var_0_0.setStencilValues(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if gohelper.isNil(arg_7_0._spineGo) then
		return
	end

	local var_7_0 = arg_7_0:getSharedMats()
	local var_7_1 = var_7_0.Length

	for iter_7_0 = 0, var_7_1 - 1 do
		local var_7_2 = var_7_0[iter_7_0]

		var_7_2:SetFloat(ShaderPropertyId.Stencil, arg_7_1)
		var_7_2:SetFloat(ShaderPropertyId.StencilComp, arg_7_2)
		var_7_2:SetFloat(ShaderPropertyId.StencilOp, arg_7_3)
	end
end

function var_0_0.getSharedMats(arg_8_0)
	if not arg_8_0._sharedMaterials then
		arg_8_0._sharedMaterials = arg_8_0:getRenderer().sharedMaterials
	elseif arg_8_0._retryGetSharedMats and arg_8_0._retryGetSharedMats <= 6 then
		arg_8_0._retryGetSharedMats = arg_8_0._retryGetSharedMats + 1
		arg_8_0._sharedMaterials = arg_8_0:getRenderer().sharedMaterials

		if arg_8_0._sharedMaterials.Length > 1 then
			arg_8_0._retryGetSharedMats = nil
		end
	end

	return arg_8_0._sharedMaterials
end

function var_0_0.setMainColor(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getSharedMats()
	local var_9_1 = var_9_0.Length

	for iter_9_0 = 0, var_9_1 - 1 do
		local var_9_2 = var_9_0[iter_9_0]

		MaterialUtil.setMainColor(var_9_2, arg_9_1)
	end
end

function var_0_0.setLumFactor(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getSharedMats()
	local var_10_1 = var_10_0.Length

	for iter_10_0 = 0, var_10_1 - 1 do
		var_10_0[iter_10_0]:SetFloat(ShaderPropertyId.LumFactor, arg_10_1)
	end
end

return var_0_0
