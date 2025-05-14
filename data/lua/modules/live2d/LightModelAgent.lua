module("modules.live2d.LightModelAgent", package.seeall)

local var_0_0 = class("LightModelAgent", LuaCompBase)

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_0._isStory = arg_1_1

	return var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
end

function var_0_0.clear(arg_3_0)
	arg_3_0._curModel:doClear()
end

function var_0_0._getSpine(arg_4_0)
	if not arg_4_0._spine then
		arg_4_0._spine = LightSpine.Create(arg_4_0._go, arg_4_0._isStory)
	end

	return arg_4_0._spine
end

function var_0_0._getLive2d(arg_5_0)
	if not arg_5_0._live2d then
		arg_5_0._live2d = LightLive2d.Create(arg_5_0._go, arg_5_0._isStory)
	end

	return arg_5_0._live2d
end

function var_0_0.fadeIn(arg_6_0)
	local var_6_0 = arg_6_0:getSpineGo()

	arg_6_0._ppEffectMask = gohelper.onceAddComponent(var_6_0, PostProcessingMgr.PPEffectMaskType)
	arg_6_0._ppEffectMask.useLocalBloom = true
	arg_6_0._ppEffectMask.enabled = true
	arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, arg_6_0._onFadeInUpdate, arg_6_0._onFadeInFinish, arg_6_0, nil, EaseType.Linear)
end

function var_0_0._onFadeInUpdate(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getSpineGo()

	if gohelper.isNil(var_7_0) then
		if arg_7_0._tweenId then
			ZProj.TweenHelper.KillById(arg_7_0._tweenId)

			arg_7_0._tweenId = nil
		end

		return
	end

	local var_7_1 = Vector4(0, 0, arg_7_1, 0)

	if not arg_7_0._isLive2D then
		local var_7_2 = arg_7_0._curModel:getRenderer().materials
		local var_7_3 = var_7_2.Length

		for iter_7_0 = 0, var_7_3 - 1 do
			local var_7_4 = var_7_2[iter_7_0]

			var_7_4:EnableKeyword("USE_INVISIBLE")
			arg_7_0._ppEffectMask:SetPassEnable(var_7_4, "useInvisible", true)
			var_7_4:SetVector("_InvisibleOffset", var_7_1)
		end

		return
	end

	local var_7_5 = var_7_0:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_7_1 = 0, var_7_5.Length - 1 do
		local var_7_6 = var_7_5[iter_7_1]

		if not gohelper.isNil(var_7_6) then
			local var_7_7 = var_7_6.sharedMaterial

			if not gohelper.isNil(var_7_7) then
				var_7_7:EnableKeyword("USE_INVISIBLE")
				arg_7_0._ppEffectMask:SetPassEnable(var_7_7, "useInvisible", true)
				var_7_7:SetVector("_InvisibleOffset", var_7_1)
			end
		end
	end
end

function var_0_0._onFadeInFinish(arg_8_0)
	local var_8_0 = arg_8_0:getSpineGo()

	if gohelper.isNil(var_8_0) then
		return
	end

	arg_8_0._ppEffectMask.enabled = false

	if not arg_8_0._isLive2D then
		arg_8_0._curModel:getRenderer().materials = arg_8_0._curModel:getSharedMats()

		return
	end

	local var_8_1 = var_8_0:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_8_0 = 0, var_8_1.Length - 1 do
		local var_8_2 = var_8_1[iter_8_0]

		if not gohelper.isNil(var_8_2) then
			local var_8_3 = var_8_2.sharedMaterial

			if not gohelper.isNil(var_8_3) then
				var_8_3:DisableKeyword("USE_INVISIBLE")
				arg_8_0._ppEffectMask:SetPassEnable(var_8_3, "useInvisible", false)
			end
		end
	end

	arg_8_0._curModel:clearSharedMaterials()
end

function var_0_0.setResPath(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if string.nilorempty(arg_9_1.live2d) then
		arg_9_0._isLive2D = false
		arg_9_0._curModel = arg_9_0:_getSpine()

		arg_9_0._curModel:setHeroId(arg_9_1.characterId)
		arg_9_0._curModel:setSkinId(arg_9_1.id)
		arg_9_0._curModel:setResPath(ResUrl.getLightSpine(arg_9_1.verticalDrawing), arg_9_2, arg_9_3)
	else
		arg_9_0._isLive2D = true
		arg_9_0._curModel = arg_9_0:_getLive2d()

		arg_9_0._curModel:setHeroId(arg_9_1.characterId)
		arg_9_0._curModel:setSkinId(arg_9_1.id)
		arg_9_0._curModel:setResPath(ResUrl.getLightLive2d(arg_9_1.live2d), arg_9_2, arg_9_3)
	end
end

function var_0_0.setInMainView(arg_10_0)
	if not arg_10_0._isLive2D then
		arg_10_0._curModel:setInMainView()
	end
end

function var_0_0.setMainColor(arg_11_0, arg_11_1)
	arg_11_0._curModel:setMainColor(arg_11_1)
end

function var_0_0.setLumFactor(arg_12_0, arg_12_1)
	arg_12_0._curModel:setLumFactor(arg_12_1)
end

function var_0_0.setEmissionColor(arg_13_0, arg_13_1)
	if arg_13_0._isLive2D then
		arg_13_0._curModel:setEmissionColor(arg_13_1)
	end
end

function var_0_0.processModelEffect(arg_14_0)
	if arg_14_0._isLive2D then
		arg_14_0._curModel:processModelEffect()
	end
end

function var_0_0.setEffectVisible(arg_15_0, arg_15_1)
	if arg_15_0._isLive2D then
		arg_15_0._curModel:setEffectVisible(arg_15_1)
	end
end

function var_0_0.setLayer(arg_16_0, arg_16_1)
	if arg_16_0._isLive2D then
		local var_16_0 = arg_16_0._curModel:getSpineGo()

		gohelper.setLayer(var_16_0, arg_16_1, true)
	end
end

function var_0_0.setEffectFrameVisible(arg_17_0, arg_17_1)
	if arg_17_0._isLive2D then
		arg_17_0._curModel:setEffectFrameVisible(arg_17_1)
	end
end

function var_0_0.addParameter(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_0._isLive2D then
		return arg_18_0._curModel:addParameter(arg_18_1, arg_18_2, arg_18_3)
	end
end

function var_0_0.updateParameter(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0._isLive2D then
		arg_19_0._curModel:updateParameter(arg_19_1, arg_19_2)
	end
end

function var_0_0.removeParameter(arg_20_0, arg_20_1)
	if arg_20_0._isLive2D then
		arg_20_0._curModel:removeParameter(arg_20_1)
	end
end

function var_0_0.getSpineGo(arg_21_0)
	return arg_21_0._curModel:getSpineGo()
end

function var_0_0.getRenderer(arg_22_0)
	return arg_22_0._curModel:getRenderer()
end

function var_0_0.changeRenderQueue(arg_23_0, arg_23_1)
	arg_23_0._curModel:changeRenderQueue(arg_23_1)
end

function var_0_0.setStencilRef(arg_24_0, arg_24_1)
	arg_24_0._curModel:setStencilRef(arg_24_1)
end

function var_0_0.setStencilValues(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0._curModel:setStencilValues(arg_25_1, arg_25_2, arg_25_3)
end

function var_0_0.isPlayingVoice(arg_26_0)
	return arg_26_0._curModel:isPlayingVoice()
end

function var_0_0.getPlayVoiceStartTime(arg_27_0)
	return arg_27_0._curModel:getPlayVoiceStartTime()
end

function var_0_0.getBoundsMinMaxPos(arg_28_0)
	return arg_28_0._curModel:getBoundsMinMaxPos()
end

function var_0_0.playVoice(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	arg_29_0._curModel:playVoice(arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
end

function var_0_0.stopVoice(arg_30_0)
	if not arg_30_0._curModel then
		return
	end

	arg_30_0._curModel:stopVoice()
end

function var_0_0.play(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_0._curModel then
		return
	end

	arg_31_0._curModel:play(arg_31_1, arg_31_2)
end

function var_0_0.doDestroy(arg_32_0)
	if arg_32_0._tweenId then
		ZProj.TweenHelper.KillById(arg_32_0._tweenId)

		arg_32_0._tweenId = nil
	end

	arg_32_0:stopVoice()
	arg_32_0:onDestroy()
	arg_32_0:clear()
end

return var_0_0
