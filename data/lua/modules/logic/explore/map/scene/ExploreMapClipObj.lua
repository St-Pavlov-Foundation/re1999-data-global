module("modules.logic.explore.map.scene.ExploreMapClipObj", package.seeall)

local var_0_0 = class("ExploreMapClipObj", UserDataDispose)
local var_0_1 = UnityEngine.Shader.PropertyToID("_OcclusionThreshold")
local var_0_2 = 0.7
local var_0_3 = 0.6

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._trans = arg_1_1
	arg_1_0._renderers = arg_1_1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)
	arg_1_0._isClip = false
	arg_1_0._isNowClip = false
	arg_1_0._nowClipValue = nil
end

function var_0_0.markClip(arg_2_0, arg_2_1)
	arg_2_0._isClip = arg_2_1
end

function var_0_0.checkNow(arg_3_0)
	if arg_3_0._isClip ~= arg_3_0._isNowClip then
		arg_3_0._isNowClip = arg_3_0._isClip

		if arg_3_0._isClip then
			arg_3_0:beginClip()
		else
			arg_3_0:endClip()
		end
	end
end

function var_0_0.beginClip(arg_4_0)
	if not arg_4_0._shareMats then
		arg_4_0._shareMats = arg_4_0:getUserDataTb_()
		arg_4_0._matInsts = arg_4_0:getUserDataTb_()

		for iter_4_0 = 0, arg_4_0._renderers.Length - 1 do
			arg_4_0._shareMats[iter_4_0] = arg_4_0._renderers[iter_4_0].sharedMaterial
			arg_4_0._matInsts[iter_4_0] = arg_4_0._renderers[iter_4_0].material

			arg_4_0._matInsts[iter_4_0]:EnableKeyword("_OCCLUSION_CLIP")
			arg_4_0._matInsts[iter_4_0]:SetFloat(var_0_1, 0)
		end
	end

	for iter_4_1 = 0, arg_4_0._renderers.Length - 1 do
		local var_4_0 = arg_4_0._renderers[iter_4_1]

		if not tolua.isnull(var_4_0) then
			var_4_0.material = arg_4_0._matInsts[iter_4_1]
		end
	end

	if arg_4_0._tweenId then
		ZProj.TweenHelper.KillById(arg_4_0._tweenId)
	end

	arg_4_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_4_0._nowClipValue or 0, var_0_2, var_0_3, arg_4_0.onTween, arg_4_0.onTweenEnd, arg_4_0, nil, EaseType.Linear)
end

function var_0_0.onTween(arg_5_0, arg_5_1)
	arg_5_0._nowClipValue = arg_5_1

	for iter_5_0 = 0, #arg_5_0._matInsts do
		arg_5_0._matInsts[iter_5_0]:SetFloat(var_0_1, arg_5_1)
	end
end

function var_0_0.onTweenEnd(arg_6_0)
	arg_6_0._tweenId = nil

	if not arg_6_0._isNowClip then
		for iter_6_0 = 0, arg_6_0._renderers.Length - 1 do
			local var_6_0 = arg_6_0._renderers[iter_6_0]

			if not tolua.isnull(var_6_0) then
				var_6_0.material = arg_6_0._shareMats[iter_6_0]
			end
		end
	end
end

function var_0_0.endClip(arg_7_0)
	if arg_7_0._tweenId then
		ZProj.TweenHelper.KillById(arg_7_0._tweenId)
	end

	arg_7_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_7_0._nowClipValue or var_0_2, 0, var_0_3, arg_7_0.onTween, arg_7_0.onTweenEnd, arg_7_0, nil, EaseType.Linear)
end

function var_0_0.clear(arg_8_0)
	if arg_8_0._tweenId then
		ZProj.TweenHelper.KillById(arg_8_0._tweenId)

		arg_8_0._tweenId = nil
	end

	arg_8_0._trans = nil
	arg_8_0._renderers = nil
	arg_8_0._mats = nil
	arg_8_0._isClip = false
	arg_8_0._isNowClip = false

	arg_8_0:__onDispose()
end

return var_0_0
