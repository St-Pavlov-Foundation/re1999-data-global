module("modules.live2d.LightLive2d", package.seeall)

slot0 = class("LightLive2d", BaseLive2d)
slot1 = Live2D.Cubism.Rendering.CubismSortingMode

function slot0.Create(slot0, slot1)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
	slot2._isStory = slot1

	return slot2
end

function slot0._onResLoaded(slot0)
	slot0._recalcBounds = true
	slot0._sharedMaterials = nil
	slot0._cubismParameterModifider = nil

	uv0.super._onResLoaded(slot0)
	slot0:_initSkinUiEffect()
end

function slot0._clear(slot0)
	uv0.super._clear(slot0)

	slot0._sharedMaterials = nil
end

function slot0._initSkinUiEffect(slot0)
	slot0._uiEffectList = nil
	slot0._uiEffectConfig = nil

	for slot4, slot5 in ipairs(lua_skin_ui_effect.configList) do
		if string.find(slot0._resPath, slot5.id) then
			slot0._uiEffectConfig = slot5
			slot0._uiEffectList = string.split(slot5.effect, "|")

			break
		end
	end

	slot0:_fakeUIEffect()
end

function slot0._fakeUIEffect(slot0)
	slot1, slot2 = Live2dSpecialLogic.getFakeUIEffect(slot0._resPath)

	if not slot1 or not slot2 then
		return
	end

	slot0._uiEffectConfig = slot1
	slot0._uiEffectList = slot2
end

function slot0.processModelEffect(slot0)
	if slot0._uiEffectList and slot0._uiEffectConfig.changeVisible == 1 then
		for slot4, slot5 in ipairs(slot0._uiEffectList) do
			slot6 = gohelper.findChild(slot0._spineGo, slot5)

			gohelper.setActive(slot6.gameObject, false)
			gohelper.setActive(slot6.gameObject, true)
		end
	end
end

function slot0.setEffectVisible(slot0, slot1)
	if slot0._uiEffectList and slot0._uiEffectConfig.delayVisible == 1 then
		for slot5, slot6 in ipairs(slot0._uiEffectList) do
			gohelper.setActive(gohelper.findChild(slot0._spineGo, slot6), slot1)
		end
	end
end

function slot0.setEffectFrameVisible(slot0, slot1)
	slot0:showEverNodes(slot1)

	if slot0._uiEffectList and slot0._uiEffectConfig.frameVisible == 1 then
		for slot5, slot6 in ipairs(slot0._uiEffectList) do
			gohelper.setActive(gohelper.findChild(slot0._spineGo, slot6), slot1)
		end
	end
end

function slot0.addParameter(slot0, slot1, slot2, slot3)
	slot0._cubismParameterModifider = slot0._cubismParameterModifider or slot0._cubismController:GetCubismParameterModifier()

	return slot0._cubismParameterModifider:AddParameter(slot1, slot2, slot3)
end

function slot0.updateParameter(slot0, slot1, slot2)
	if not slot0._cubismParameterModifider then
		return
	end

	slot0._cubismParameterModifider:UpdateParameter(slot1, slot2)
end

function slot0.removeParameter(slot0, slot1)
	if not slot0._cubismParameterModifider then
		return
	end

	slot0._cubismParameterModifider:RemoveParameter(slot1)
end

function slot0.getBoundsMinMaxPos(slot0)
	if not slot0._recalcBounds then
		return slot0._boundsMin, slot0._boundsMax
	end

	slot0._recalcBounds = true
	slot0._boundsMin = nil
	slot0._boundsMax = nil

	for slot5 = 0, slot0._spineGo:GetComponentsInChildren(typeof(UnityEngine.Renderer)).Length - 1 do
		slot7 = slot1[slot5].bounds
		slot9 = slot7.max
		slot0._boundsMin = Vector3.Min(slot7.min, slot0._boundsMin or slot8)
		slot0._boundsMax = Vector3.Max(slot9, slot0._boundsMax or slot9)
	end

	return slot0._boundsMin, slot0._boundsMax
end

function slot0.setStencilRef(slot0, slot1)
	if gohelper.isNil(slot0._spineGo) then
		return
	end

	for slot6, slot7 in ipairs(slot0:getSharedMaterials()) do
		slot7:SetFloat(ShaderPropertyId.Stencil, slot1)
	end
end

function slot0.setStencilValues(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot0._spineGo) then
		return
	end

	for slot8, slot9 in ipairs(slot0:getSharedMaterials()) do
		slot9:SetFloat(ShaderPropertyId.Stencil, slot1)
		slot9:SetFloat(ShaderPropertyId.StencilComp, slot2)
		slot9:SetFloat(ShaderPropertyId.StencilOp, slot3)
	end
end

function slot0.changeRenderQueue(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getSharedMaterials()) do
		slot7.renderQueue = slot1
	end

	if not slot0._cubismController then
		return
	end

	if slot1 == -1 then
		slot0._cubismController:SetSortingMode(uv0.BackToFrontZ)
	else
		slot0._cubismController:SetSortingMode(uv0.BackToFrontOrder)
	end
end

function slot0.getSharedMaterials(slot0)
	if not slot0._sharedMaterials then
		slot0._sharedMaterials = {}

		for slot5 = 0, slot0._spineGo:GetComponentsInChildren(typeof(UnityEngine.Renderer)).Length - 1 do
			table.insert(slot0._sharedMaterials, slot1[slot5].sharedMaterial)
		end
	end

	return slot0._sharedMaterials
end

function slot0.clearSharedMaterials(slot0)
	slot0._sharedMaterials = nil
end

function slot0.setMainColor(slot0, slot1)
	if slot0._cubismController then
		slot0._cubismController:SetMainColor(slot1)
	end
end

function slot0.setLumFactor(slot0, slot1)
	if slot0._cubismController then
		slot0._cubismController:SetLumFactor(slot1)
	end
end

function slot0.setEmissionColor(slot0, slot1)
	if slot0._cubismController then
		slot0._cubismController:SetEmissionColor(slot1)
	end
end

return slot0
