module("modules.live2d.GuiModelAgent", package.seeall)

local var_0_0 = class("GuiModelAgent", LuaCompBase)

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_1._isStory = arg_1_1

	return var_1_1
end

function var_0_0.showDragEffect(arg_2_0, arg_2_1)
	if not arg_2_0._dragEffectGoList then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._dragEffectGoList) do
		gohelper.setActive(iter_2_1, arg_2_1)
	end
end

function var_0_0.initSkinDragEffect(arg_3_0, arg_3_1)
	arg_3_0._dragEffectGoList = arg_3_0._dragEffectGoList or {}

	tabletool.clear(arg_3_0._dragEffectGoList)

	local var_3_0 = lua_skin_fullscreen_effect.configDict[arg_3_1]

	if not var_3_0 then
		return
	end

	local var_3_1 = arg_3_0:getSpineGo()
	local var_3_2 = string.split(var_3_0.effectList, "|")

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		local var_3_3 = gohelper.findChild(var_3_1, iter_3_1)

		if var_3_3 then
			table.insert(arg_3_0._dragEffectGoList, var_3_3)
		end
	end
end

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0._go = arg_4_1
end

function var_0_0.setUIMask(arg_5_0, arg_5_1)
	if arg_5_0:isLive2D() then
		local var_5_0 = arg_5_0:_getLive2d()

		if var_5_0:isCancelCamera() then
			var_5_0:setUIMaskKeyword(arg_5_1)
		else
			var_5_0:setImageUIMask(arg_5_1)
		end
	elseif arg_5_0:isSpine() then
		arg_5_0:_getSpine():setImageUIMask(arg_5_1)
	end
end

function var_0_0.useRT(arg_6_0)
	if arg_6_0:isSpine() then
		arg_6_0:_getSpine():useRT()
	end
end

function var_0_0.setImgPos(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0:isSpine() then
		arg_7_0:_getSpine():setImgPos(arg_7_1, arg_7_2)
	end
end

function var_0_0.setImgSize(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0:isSpine() then
		arg_8_0:_getSpine():setImgSize(arg_8_1, arg_8_2)
	end
end

function var_0_0.setAlphaBg(arg_9_0, arg_9_1)
	if arg_9_0:isLive2D() then
		arg_9_0:setSceneTexture(arg_9_1)
	elseif arg_9_0:isSpine() then
		local var_9_0 = arg_9_0:getSkeletonGraphic()

		if var_9_0 then
			var_9_0.materialForRendering:SetTexture("_SceneMask", arg_9_1)
		end
	end
end

function var_0_0._getSpine(arg_10_0)
	if not arg_10_0._spine then
		arg_10_0._spine = GuiSpine.Create(arg_10_0._go, arg_10_0._isStory)
	end

	return arg_10_0._spine
end

function var_0_0._getLive2d(arg_11_0)
	if not arg_11_0._live2d then
		arg_11_0._live2d = GuiLive2d.Create(arg_11_0._go, arg_11_0._isStory)
	end

	return arg_11_0._live2d
end

function var_0_0.openBloomView(arg_12_0, arg_12_1)
	arg_12_0._openBloomView = arg_12_1
end

function var_0_0.setResPath(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_0._curModel
	local var_13_1 = arg_13_0._isLive2D

	if string.nilorempty(arg_13_1.live2d) then
		arg_13_0._isLive2D = false
		arg_13_0._curModel = arg_13_0:_getSpine()

		arg_13_0._curModel:setHeroId(arg_13_1.characterId)
		arg_13_0._curModel:setSkinId(arg_13_1.id)
		arg_13_0._curModel:showModel()
		arg_13_0._curModel:setResPath(ResUrl.getRolesPrefabStory(arg_13_1.verticalDrawing), arg_13_2, arg_13_3)
	else
		arg_13_0._isLive2D = true
		arg_13_0._curModel = arg_13_0:_getLive2d()

		arg_13_0._curModel:setHeroId(arg_13_1.characterId)
		arg_13_0._curModel:setSkinId(arg_13_1.id)
		arg_13_0._curModel:openBloomView(arg_13_0._openBloomView)
		arg_13_0._curModel:showModel()
		arg_13_0._curModel:setCameraSize(arg_13_4 or arg_13_1.cameraSize)
		arg_13_0._curModel:setResPath(ResUrl.getLightLive2d(arg_13_1.live2d), arg_13_2, arg_13_3)
	end

	if var_13_0 and arg_13_0._isLive2D ~= var_13_1 then
		var_13_0:hideModel()
	end
end

function var_0_0.setLive2dCameraLoadedCallback(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:_getLive2d()

	if var_14_0 then
		var_14_0:setCameraLoadedCallback(arg_14_1, arg_14_2)
	end
end

function var_0_0.setVerticalDrawing(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = string.split(arg_15_1, "/")
	local var_15_1 = var_15_0 and var_15_0[#var_15_0]
	local var_15_2
	local var_15_3 = arg_15_0._curModel
	local var_15_4 = arg_15_0._isLive2D

	if var_15_1 then
		local var_15_5 = string.gsub(var_15_1, ".prefab", "")

		var_15_2 = SkinConfig.instance:getLive2dSkin(var_15_5)
	end

	if not var_15_2 then
		arg_15_0._isLive2D = false
		arg_15_0._curModel = arg_15_0:_getSpine()

		arg_15_0._curModel:showModel()
		arg_15_0._curModel:setResPath(arg_15_1, arg_15_2, arg_15_3)
	else
		arg_15_0._isLive2D = true
		arg_15_0._curModel = arg_15_0:_getLive2d()

		arg_15_0._curModel:showModel()
		arg_15_0._curModel:cancelCamera()
		arg_15_0._curModel:setResPath(ResUrl.getLightLive2d(var_15_2), arg_15_2, arg_15_3)
	end

	if arg_15_0._isLive2D ~= var_15_4 then
		var_15_3:hideModel()
	end
end

function var_0_0.setModelVisible(arg_16_0, arg_16_1)
	if not arg_16_0._curModel then
		return
	end

	gohelper.setActive(arg_16_0._go, arg_16_1)

	if arg_16_1 then
		if arg_16_0._curModel.showModel then
			arg_16_0._curModel:showModel()
		end
	elseif arg_16_0._curModel.hideModel then
		arg_16_0._curModel:hideModel()
	end
end

function var_0_0.setLayer(arg_17_0, arg_17_1)
	if arg_17_0:isLive2D() then
		local var_17_0 = arg_17_0._curModel:getSpineGo()

		gohelper.setLayer(var_17_0, arg_17_1, true)
	end
end

function var_0_0.setAllLayer(arg_18_0, arg_18_1)
	if arg_18_0:isLive2D() then
		arg_18_0:setLayer(arg_18_1)
		arg_18_0._curModel:setCameraLayer(arg_18_1)
	end
end

function var_0_0.processModelEffect(arg_19_0)
	if arg_19_0:isLive2D() then
		arg_19_0._curModel:processModelEffect()
	end
end

function var_0_0.hideModelEffect(arg_20_0)
	if arg_20_0:isLive2D() then
		arg_20_0._curModel:hideModelEffect()
	end
end

function var_0_0.showModelEffect(arg_21_0)
	if arg_21_0:isLive2D() then
		arg_21_0._curModel:showModelEffect()
	end
end

function var_0_0.getSpineGo(arg_22_0)
	if arg_22_0._curModel then
		return arg_22_0._curModel:getSpineGo()
	end
end

function var_0_0.getSkeletonGraphic(arg_23_0)
	if arg_23_0._curModel and arg_23_0._curModel.getSkeletonGraphic then
		return arg_23_0._curModel:getSkeletonGraphic()
	end
end

function var_0_0.setSortingOrder(arg_24_0, arg_24_1)
	if arg_24_0._curModel and arg_24_0._curModel.setSortingOrder then
		return arg_24_0._curModel:setSortingOrder(arg_24_1)
	end
end

function var_0_0.setAlpha(arg_25_0, arg_25_1)
	if arg_25_0._curModel and arg_25_0:isLive2D() then
		arg_25_0._curModel:setAlpha(arg_25_1)
	end
end

function var_0_0.enableSceneAlpha(arg_26_0)
	if arg_26_0._curModel and arg_26_0:isLive2D() then
		arg_26_0._curModel:enableSceneAlpha()
	end
end

function var_0_0.disableSceneAlpha(arg_27_0)
	if arg_27_0._curModel and arg_27_0:isLive2D() then
		arg_27_0._curModel:disableSceneAlpha()
	end
end

function var_0_0.setSceneTexture(arg_28_0, arg_28_1)
	if arg_28_0._curModel and arg_28_0:isLive2D() then
		arg_28_0._curModel:setSceneTexture(arg_28_1)
	end
end

function var_0_0.isLive2D(arg_29_0)
	return arg_29_0._isLive2D == true
end

function var_0_0.isSpine(arg_30_0)
	return arg_30_0._isLive2D ~= true
end

function var_0_0.getSpineVoice(arg_31_0)
	if arg_31_0._curModel then
		return arg_31_0._curModel:getSpineVoice()
	end
end

function var_0_0.isPlayingVoice(arg_32_0)
	if arg_32_0._curModel then
		return arg_32_0._curModel:isPlayingVoice()
	end
end

function var_0_0.getPlayVoiceStartTime(arg_33_0)
	if arg_33_0._curModel then
		return arg_33_0._curModel:getPlayVoiceStartTime()
	end
end

function var_0_0.playVoice(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5, arg_34_6)
	if arg_34_0._curModel then
		arg_34_0._curModel:playVoice(arg_34_1, arg_34_2, arg_34_3, arg_34_4, arg_34_5, arg_34_6)
	end
end

function var_0_0.stopVoice(arg_35_0)
	if arg_35_0._curModel then
		arg_35_0._curModel:stopVoice()
	end
end

function var_0_0.setSwitch(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_0._curModel then
		arg_36_0._curModel:setSwitch(arg_36_1, arg_36_2)
	end
end

function var_0_0.onDestroy(arg_37_0)
	if arg_37_0._dragEffectGoList then
		tabletool.clear(arg_37_0._dragEffectGoList)
	end
end

return var_0_0
