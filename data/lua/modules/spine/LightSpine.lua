module("modules.spine.LightSpine", package.seeall)

slot0 = class("LightSpine", BaseSpine)
slot0.TypeSkeletonAnimation = typeof(Spine.Unity.SkeletonAnimation)
slot0.TypeSpineAnimationEvent = typeof(ZProj.SpineAnimationEvent)

function slot0.Create(slot0, slot1)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
	slot2._isStory = slot1

	return slot2
end

function slot0._onResLoaded(slot0)
	slot0._sharedMaterials = nil
	slot0._retryGetSharedMats = 0

	uv0.super._onResLoaded(slot0)
end

function slot0.getBoundsMinMaxPos(slot0)
	slot2 = slot0:getRenderer().bounds

	return slot2.min, slot2.max
end

function slot0.initSkeletonComponent(slot0)
	slot0._skeletonComponent = slot0._spineGo:GetComponent(uv0.TypeSkeletonAnimation)

	slot0._skeletonComponent:Initialize(false)

	slot0._skeletonComponent.freeze = slot0._bFreeze
	slot0._animationEvent = uv0.TypeSpineAnimationEvent
	slot0._mountroot = gohelper.findChild(slot0._spineGo, "mountroot")
end

function slot0.changeRenderQueue(slot0, slot1)
end

function slot0.setStencilRef(slot0, slot1)
	if gohelper.isNil(slot0._spineGo) then
		return
	end

	for slot7 = 0, slot0:getSharedMats().Length - 1 do
		slot2[slot7]:SetFloat(ShaderPropertyId.Stencil, slot1)
	end

	if slot0._mountroot then
		gohelper.setActive(slot0._mountroot, slot1 == 0)
	end
end

function slot0.setStencilValues(slot0, slot1, slot2, slot3)
	if gohelper.isNil(slot0._spineGo) then
		return
	end

	for slot9 = 0, slot0:getSharedMats().Length - 1 do
		slot10 = slot4[slot9]

		slot10:SetFloat(ShaderPropertyId.Stencil, slot1)
		slot10:SetFloat(ShaderPropertyId.StencilComp, slot2)
		slot10:SetFloat(ShaderPropertyId.StencilOp, slot3)
	end
end

function slot0.getSharedMats(slot0)
	if not slot0._sharedMaterials then
		slot0._sharedMaterials = slot0:getRenderer().sharedMaterials
	elseif slot0._retryGetSharedMats and slot0._retryGetSharedMats <= 6 then
		slot0._retryGetSharedMats = slot0._retryGetSharedMats + 1
		slot0._sharedMaterials = slot0:getRenderer().sharedMaterials

		if slot0._sharedMaterials.Length > 1 then
			slot0._retryGetSharedMats = nil
		end
	end

	return slot0._sharedMaterials
end

function slot0.setMainColor(slot0, slot1)
	for slot7 = 0, slot0:getSharedMats().Length - 1 do
		MaterialUtil.setMainColor(slot2[slot7], slot1)
	end
end

function slot0.setLumFactor(slot0, slot1)
	for slot7 = 0, slot0:getSharedMats().Length - 1 do
		slot2[slot7]:SetFloat(ShaderPropertyId.LumFactor, slot1)
	end
end

return slot0
