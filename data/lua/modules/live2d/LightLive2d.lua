module("modules.live2d.LightLive2d", package.seeall)

local var_0_0 = class("LightLive2d", BaseLive2d)
local var_0_1 = Live2D.Cubism.Rendering.CubismSortingMode

function var_0_0.Create(arg_1_0, arg_1_1)
	local var_1_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0, var_0_0)

	var_1_0._isStory = arg_1_1

	return var_1_0
end

function var_0_0._onResLoaded(arg_2_0)
	arg_2_0._recalcBounds = true
	arg_2_0._sharedMaterials = nil
	arg_2_0._cubismParameterModifider = nil

	var_0_0.super._onResLoaded(arg_2_0)
	arg_2_0:_initSkinUiEffect()
end

function var_0_0._clear(arg_3_0)
	var_0_0.super._clear(arg_3_0)

	arg_3_0._sharedMaterials = nil
end

function var_0_0._initSkinUiEffect(arg_4_0)
	arg_4_0._uiEffectList = nil
	arg_4_0._uiEffectConfig = nil

	for iter_4_0, iter_4_1 in ipairs(lua_skin_ui_effect.configList) do
		if string.find(arg_4_0._resPath, iter_4_1.id) then
			arg_4_0._uiEffectConfig = iter_4_1
			arg_4_0._uiEffectList = string.split(iter_4_1.effect, "|")

			break
		end
	end

	arg_4_0:_fakeUIEffect()
end

function var_0_0._fakeUIEffect(arg_5_0)
	local var_5_0, var_5_1 = Live2dSpecialLogic.getFakeUIEffect(arg_5_0._resPath)

	if not var_5_0 or not var_5_1 then
		return
	end

	arg_5_0._uiEffectConfig = var_5_0
	arg_5_0._uiEffectList = var_5_1
end

function var_0_0.processModelEffect(arg_6_0)
	if arg_6_0._uiEffectList and arg_6_0._uiEffectConfig.changeVisible == 1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._uiEffectList) do
			local var_6_0 = gohelper.findChild(arg_6_0._spineGo, iter_6_1)

			gohelper.setActive(var_6_0.gameObject, false)
			gohelper.setActive(var_6_0.gameObject, true)
		end
	end
end

function var_0_0.setEffectVisible(arg_7_0, arg_7_1)
	if arg_7_0._uiEffectList and arg_7_0._uiEffectConfig.delayVisible == 1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._uiEffectList) do
			local var_7_0 = gohelper.findChild(arg_7_0._spineGo, iter_7_1)

			gohelper.setActive(var_7_0, arg_7_1)
		end
	end
end

function var_0_0.setEffectFrameVisible(arg_8_0, arg_8_1)
	arg_8_0:showEverNodes(arg_8_1)

	if arg_8_0._uiEffectList and arg_8_0._uiEffectConfig.frameVisible == 1 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._uiEffectList) do
			local var_8_0 = gohelper.findChild(arg_8_0._spineGo, iter_8_1)

			gohelper.setActive(var_8_0, arg_8_1)
		end
	end
end

function var_0_0.addParameter(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0._cubismParameterModifider = arg_9_0._cubismParameterModifider or arg_9_0._cubismController:GetCubismParameterModifier()

	return arg_9_0._cubismParameterModifider:AddParameter(arg_9_1, arg_9_2, arg_9_3)
end

function var_0_0.updateParameter(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._cubismParameterModifider then
		return
	end

	arg_10_0._cubismParameterModifider:UpdateParameter(arg_10_1, arg_10_2)
end

function var_0_0.removeParameter(arg_11_0, arg_11_1)
	if not arg_11_0._cubismParameterModifider then
		return
	end

	arg_11_0._cubismParameterModifider:RemoveParameter(arg_11_1)
end

function var_0_0.getBoundsMinMaxPos(arg_12_0)
	if not arg_12_0._recalcBounds then
		return arg_12_0._boundsMin, arg_12_0._boundsMax
	end

	arg_12_0._recalcBounds = true
	arg_12_0._boundsMin = nil
	arg_12_0._boundsMax = nil

	local var_12_0 = arg_12_0._spineGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_12_0 = 0, var_12_0.Length - 1 do
		local var_12_1 = var_12_0[iter_12_0].bounds
		local var_12_2 = var_12_1.min
		local var_12_3 = var_12_1.max

		arg_12_0._boundsMin = Vector3.Min(var_12_2, arg_12_0._boundsMin or var_12_2)
		arg_12_0._boundsMax = Vector3.Max(var_12_3, arg_12_0._boundsMax or var_12_3)
	end

	return arg_12_0._boundsMin, arg_12_0._boundsMax
end

function var_0_0.setStencilRef(arg_13_0, arg_13_1)
	if gohelper.isNil(arg_13_0._spineGo) then
		return
	end

	local var_13_0 = arg_13_0:getSharedMaterials()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		iter_13_1:SetFloat(ShaderPropertyId.Stencil, arg_13_1)
	end
end

function var_0_0.setStencilValues(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if gohelper.isNil(arg_14_0._spineGo) then
		return
	end

	local var_14_0 = arg_14_0:getSharedMaterials()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		iter_14_1:SetFloat(ShaderPropertyId.Stencil, arg_14_1)
		iter_14_1:SetFloat(ShaderPropertyId.StencilComp, arg_14_2)
		iter_14_1:SetFloat(ShaderPropertyId.StencilOp, arg_14_3)
	end
end

function var_0_0.changeRenderQueue(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getSharedMaterials()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		iter_15_1.renderQueue = arg_15_1
	end

	if not arg_15_0._cubismController then
		return
	end

	if arg_15_1 == -1 then
		arg_15_0._cubismController:SetSortingMode(var_0_1.BackToFrontZ)
	else
		arg_15_0._cubismController:SetSortingMode(var_0_1.BackToFrontOrder)
	end
end

function var_0_0.getSharedMaterials(arg_16_0)
	if not arg_16_0._sharedMaterials then
		arg_16_0._sharedMaterials = {}

		local var_16_0 = arg_16_0._spineGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for iter_16_0 = 0, var_16_0.Length - 1 do
			local var_16_1 = var_16_0[iter_16_0].sharedMaterial

			table.insert(arg_16_0._sharedMaterials, var_16_1)
		end
	end

	return arg_16_0._sharedMaterials
end

function var_0_0.clearSharedMaterials(arg_17_0)
	arg_17_0._sharedMaterials = nil
end

function var_0_0.setMainColor(arg_18_0, arg_18_1)
	if arg_18_0._cubismController then
		arg_18_0._cubismController:SetMainColor(arg_18_1)
	end
end

function var_0_0.setLumFactor(arg_19_0, arg_19_1)
	if arg_19_0._cubismController then
		arg_19_0._cubismController:SetLumFactor(arg_19_1)
	end
end

function var_0_0.setEmissionColor(arg_20_0, arg_20_1)
	if arg_20_0._cubismController then
		arg_20_0._cubismController:SetEmissionColor(arg_20_1)
	end
end

return var_0_0
