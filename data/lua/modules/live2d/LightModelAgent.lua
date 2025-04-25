module("modules.live2d.LightModelAgent", package.seeall)

slot0 = class("LightModelAgent", LuaCompBase)

function slot0.Create(slot0, slot1)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
	slot2._isStory = slot1

	return slot2
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
end

function slot0.clear(slot0)
	slot0._curModel:doClear()
end

function slot0._getSpine(slot0)
	if not slot0._spine then
		slot0._spine = LightSpine.Create(slot0._go, slot0._isStory)
	end

	return slot0._spine
end

function slot0._getLive2d(slot0)
	if not slot0._live2d then
		slot0._live2d = LightLive2d.Create(slot0._go, slot0._isStory)
	end

	return slot0._live2d
end

function slot0.fadeIn(slot0)
	slot0._ppEffectMask = gohelper.onceAddComponent(slot0:getSpineGo(), PostProcessingMgr.PPEffectMaskType)
	slot0._ppEffectMask.useLocalBloom = true
	slot0._ppEffectMask.enabled = true
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, slot0._onFadeInUpdate, slot0._onFadeInFinish, slot0, nil, EaseType.Linear)
end

function slot0._onFadeInUpdate(slot0, slot1)
	if gohelper.isNil(slot0:getSpineGo()) then
		if slot0._tweenId then
			ZProj.TweenHelper.KillById(slot0._tweenId)

			slot0._tweenId = nil
		end

		return
	end

	slot3 = Vector4(0, 0, slot1, 0)

	if not slot0._isLive2D then
		for slot9 = 0, slot0._curModel:getRenderer().materials.Length - 1 do
			slot10 = slot4[slot9]

			slot10:EnableKeyword("USE_INVISIBLE")
			slot0._ppEffectMask:SetPassEnable(slot10, "useInvisible", true)
			slot10:SetVector("_InvisibleOffset", slot3)
		end

		return
	end

	for slot8 = 0, slot2:GetComponentsInChildren(typeof(UnityEngine.Renderer)).Length - 1 do
		if not gohelper.isNil(slot4[slot8]) and not gohelper.isNil(slot9.sharedMaterial) then
			slot10:EnableKeyword("USE_INVISIBLE")
			slot0._ppEffectMask:SetPassEnable(slot10, "useInvisible", true)
			slot10:SetVector("_InvisibleOffset", slot3)
		end
	end
end

function slot0._onFadeInFinish(slot0)
	if gohelper.isNil(slot0:getSpineGo()) then
		return
	end

	slot0._ppEffectMask.enabled = false

	if not slot0._isLive2D then
		slot0._curModel:getRenderer().materials = slot0._curModel:getSharedMats()

		return
	end

	for slot6 = 0, slot1:GetComponentsInChildren(typeof(UnityEngine.Renderer)).Length - 1 do
		if not gohelper.isNil(slot2[slot6]) and not gohelper.isNil(slot7.sharedMaterial) then
			slot8:DisableKeyword("USE_INVISIBLE")
			slot0._ppEffectMask:SetPassEnable(slot8, "useInvisible", false)
		end
	end

	slot0._curModel:clearSharedMaterials()
end

function slot0.setResPath(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot1.live2d) then
		slot0._isLive2D = false
		slot0._curModel = slot0:_getSpine()

		slot0._curModel:setHeroId(slot1.characterId)
		slot0._curModel:setSkinId(slot1.id)
		slot0._curModel:setResPath(ResUrl.getLightSpine(slot1.verticalDrawing), slot2, slot3)
	else
		slot0._isLive2D = true
		slot0._curModel = slot0:_getLive2d()

		slot0._curModel:setHeroId(slot1.characterId)
		slot0._curModel:setSkinId(slot1.id)
		slot0._curModel:setResPath(ResUrl.getLightLive2d(slot1.live2d), slot2, slot3)
	end
end

function slot0.setInMainView(slot0)
	if not slot0._isLive2D then
		slot0._curModel:setInMainView()
	end
end

function slot0.setMainColor(slot0, slot1)
	slot0._curModel:setMainColor(slot1)
end

function slot0.setLumFactor(slot0, slot1)
	slot0._curModel:setLumFactor(slot1)
end

function slot0.setEmissionColor(slot0, slot1)
	if slot0._isLive2D then
		slot0._curModel:setEmissionColor(slot1)
	end
end

function slot0.processModelEffect(slot0)
	if slot0._isLive2D then
		slot0._curModel:processModelEffect()
	end
end

function slot0.setEffectVisible(slot0, slot1)
	if slot0._isLive2D then
		slot0._curModel:setEffectVisible(slot1)
	end
end

function slot0.setLayer(slot0, slot1)
	if slot0._isLive2D then
		gohelper.setLayer(slot0._curModel:getSpineGo(), slot1, true)
	end
end

function slot0.setEffectFrameVisible(slot0, slot1)
	if slot0._isLive2D then
		slot0._curModel:setEffectFrameVisible(slot1)
	end
end

function slot0.addParameter(slot0, slot1, slot2, slot3)
	if slot0._isLive2D then
		return slot0._curModel:addParameter(slot1, slot2, slot3)
	end
end

function slot0.updateParameter(slot0, slot1, slot2)
	if slot0._isLive2D then
		slot0._curModel:updateParameter(slot1, slot2)
	end
end

function slot0.removeParameter(slot0, slot1)
	if slot0._isLive2D then
		slot0._curModel:removeParameter(slot1)
	end
end

function slot0.getSpineGo(slot0)
	return slot0._curModel:getSpineGo()
end

function slot0.getRenderer(slot0)
	return slot0._curModel:getRenderer()
end

function slot0.changeRenderQueue(slot0, slot1)
	slot0._curModel:changeRenderQueue(slot1)
end

function slot0.setStencilRef(slot0, slot1)
	slot0._curModel:setStencilRef(slot1)
end

function slot0.setStencilValues(slot0, slot1, slot2, slot3)
	slot0._curModel:setStencilValues(slot1, slot2, slot3)
end

function slot0.isPlayingVoice(slot0)
	return slot0._curModel:isPlayingVoice()
end

function slot0.getPlayVoiceStartTime(slot0)
	return slot0._curModel:getPlayVoiceStartTime()
end

function slot0.getBoundsMinMaxPos(slot0)
	return slot0._curModel:getBoundsMinMaxPos()
end

function slot0.playVoice(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._curModel:playVoice(slot1, slot2, slot3, slot4, slot5)
end

function slot0.stopVoice(slot0)
	if not slot0._curModel then
		return
	end

	slot0._curModel:stopVoice()
end

function slot0.play(slot0, slot1, slot2)
	if not slot0._curModel then
		return
	end

	slot0._curModel:play(slot1, slot2)
end

function slot0.doDestroy(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0:stopVoice()
	slot0:onDestroy()
	slot0:clear()
end

return slot0
