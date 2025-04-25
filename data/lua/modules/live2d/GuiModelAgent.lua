module("modules.live2d.GuiModelAgent", package.seeall)

slot0 = class("GuiModelAgent", LuaCompBase)

function slot0.Create(slot0, slot1)
	slot2 = nil
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
	slot2._isStory = slot1

	return slot2
end

function slot0.showDragEffect(slot0, slot1)
	if not slot0._dragEffectGoList then
		return
	end

	for slot5, slot6 in ipairs(slot0._dragEffectGoList) do
		gohelper.setActive(slot6, slot1)
	end
end

function slot0.initSkinDragEffect(slot0, slot1)
	slot0._dragEffectGoList = slot0._dragEffectGoList or {}

	tabletool.clear(slot0._dragEffectGoList)

	if not lua_skin_fullscreen_effect.configDict[slot1] then
		return
	end

	for slot8, slot9 in ipairs(string.split(slot2.effectList, "|")) do
		if gohelper.findChild(slot0:getSpineGo(), slot9) then
			table.insert(slot0._dragEffectGoList, slot10)
		end
	end
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
end

function slot0.setUIMask(slot0, slot1)
	if slot0:isLive2D() then
		if slot0:_getLive2d():isCancelCamera() then
			slot2:setUIMaskKeyword(slot1)
		else
			slot2:setImageUIMask(slot1)
		end
	elseif slot0:isSpine() then
		slot0:_getSpine():setImageUIMask(slot1)
	end
end

function slot0.useRT(slot0)
	if slot0:isSpine() then
		slot0:_getSpine():useRT()
	end
end

function slot0.setImgPos(slot0, slot1, slot2)
	if slot0:isSpine() then
		slot0:_getSpine():setImgPos(slot1, slot2)
	end
end

function slot0.setImgSize(slot0, slot1, slot2)
	if slot0:isSpine() then
		slot0:_getSpine():setImgSize(slot1, slot2)
	end
end

function slot0.setAlphaBg(slot0, slot1)
	if slot0:isLive2D() then
		slot0:setSceneTexture(slot1)
	elseif slot0:isSpine() and slot0:getSkeletonGraphic() then
		slot2.materialForRendering:SetTexture("_SceneMask", slot1)
	end
end

function slot0._getSpine(slot0)
	if not slot0._spine then
		slot0._spine = GuiSpine.Create(slot0._go, slot0._isStory)
	end

	return slot0._spine
end

function slot0._getLive2d(slot0)
	if not slot0._live2d then
		slot0._live2d = GuiLive2d.Create(slot0._go, slot0._isStory)
	end

	return slot0._live2d
end

function slot0.openBloomView(slot0, slot1)
	slot0._openBloomView = slot1
end

function slot0.setResPath(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0._curModel
	slot6 = slot0._isLive2D

	if string.nilorempty(slot1.live2d) then
		slot0._isLive2D = false
		slot0._curModel = slot0:_getSpine()

		slot0._curModel:setHeroId(slot1.characterId)
		slot0._curModel:setSkinId(slot1.id)
		slot0._curModel:showModel()
		slot0._curModel:setResPath(ResUrl.getRolesPrefabStory(slot1.verticalDrawing), slot2, slot3)
	else
		slot0._isLive2D = true
		slot0._curModel = slot0:_getLive2d()

		slot0._curModel:setHeroId(slot1.characterId)
		slot0._curModel:setSkinId(slot1.id)
		slot0._curModel:openBloomView(slot0._openBloomView)
		slot0._curModel:showModel()
		slot0._curModel:setCameraSize(slot4 or slot1.cameraSize)
		slot0._curModel:setResPath(ResUrl.getLightLive2d(slot1.live2d), slot2, slot3)
	end

	if slot5 and slot0._isLive2D ~= slot6 then
		slot5:hideModel()
	end
end

function slot0.setLive2dCameraLoadedCallback(slot0, slot1, slot2)
	if slot0:_getLive2d() then
		slot3:setCameraLoadedCallback(slot1, slot2)
	end
end

function slot0.setVerticalDrawing(slot0, slot1, slot2, slot3)
	slot6 = nil
	slot7 = slot0._curModel
	slot8 = slot0._isLive2D

	if string.split(slot1, "/") and slot4[#slot4] then
		slot6 = SkinConfig.instance:getLive2dSkin(string.gsub(slot5, ".prefab", ""))
	end

	if not slot6 then
		slot0._isLive2D = false
		slot0._curModel = slot0:_getSpine()

		slot0._curModel:showModel()
		slot0._curModel:setResPath(slot1, slot2, slot3)
	else
		slot0._isLive2D = true
		slot0._curModel = slot0:_getLive2d()

		slot0._curModel:showModel()
		slot0._curModel:cancelCamera()
		slot0._curModel:setResPath(ResUrl.getLightLive2d(slot6), slot2, slot3)
	end

	if slot0._isLive2D ~= slot8 then
		slot7:hideModel()
	end
end

function slot0.setModelVisible(slot0, slot1)
	if not slot0._curModel then
		return
	end

	gohelper.setActive(slot0._go, slot1)

	if slot1 then
		if slot0._curModel.showModel then
			slot0._curModel:showModel()
		end
	elseif slot0._curModel.hideModel then
		slot0._curModel:hideModel()
	end
end

function slot0.setLayer(slot0, slot1)
	if slot0:isLive2D() then
		gohelper.setLayer(slot0._curModel:getSpineGo(), slot1, true)
	end
end

function slot0.setAllLayer(slot0, slot1)
	if slot0:isLive2D() then
		slot0:setLayer(slot1)
		slot0._curModel:setCameraLayer(slot1)
	end
end

function slot0.processModelEffect(slot0)
	if slot0:isLive2D() then
		slot0._curModel:processModelEffect()
	end
end

function slot0.hideModelEffect(slot0)
	if slot0:isLive2D() then
		slot0._curModel:hideModelEffect()
	end
end

function slot0.showModelEffect(slot0)
	if slot0:isLive2D() then
		slot0._curModel:showModelEffect()
	end
end

function slot0.getSpineGo(slot0)
	if slot0._curModel then
		return slot0._curModel:getSpineGo()
	end
end

function slot0.getSkeletonGraphic(slot0)
	if slot0._curModel and slot0._curModel.getSkeletonGraphic then
		return slot0._curModel:getSkeletonGraphic()
	end
end

function slot0.setSortingOrder(slot0, slot1)
	if slot0._curModel and slot0._curModel.setSortingOrder then
		return slot0._curModel:setSortingOrder(slot1)
	end
end

function slot0.setAlpha(slot0, slot1)
	if slot0._curModel and slot0:isLive2D() then
		slot0._curModel:setAlpha(slot1)
	end
end

function slot0.enableSceneAlpha(slot0)
	if slot0._curModel and slot0:isLive2D() then
		slot0._curModel:enableSceneAlpha()
	end
end

function slot0.disableSceneAlpha(slot0)
	if slot0._curModel and slot0:isLive2D() then
		slot0._curModel:disableSceneAlpha()
	end
end

function slot0.setSceneTexture(slot0, slot1)
	if slot0._curModel and slot0:isLive2D() then
		slot0._curModel:setSceneTexture(slot1)
	end
end

function slot0.isLive2D(slot0)
	return slot0._isLive2D == true
end

function slot0.isSpine(slot0)
	return slot0._isLive2D ~= true
end

function slot0.getSpineVoice(slot0)
	if slot0._curModel then
		return slot0._curModel:getSpineVoice()
	end
end

function slot0.isPlayingVoice(slot0)
	if slot0._curModel then
		return slot0._curModel:isPlayingVoice()
	end
end

function slot0.getPlayVoiceStartTime(slot0)
	if slot0._curModel then
		return slot0._curModel:getPlayVoiceStartTime()
	end
end

function slot0.playVoice(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot0._curModel then
		slot0._curModel:playVoice(slot1, slot2, slot3, slot4, slot5, slot6)
	end
end

function slot0.stopVoice(slot0)
	if slot0._curModel then
		slot0._curModel:stopVoice()
	end
end

function slot0.setSwitch(slot0, slot1, slot2)
	if slot0._curModel then
		slot0._curModel:setSwitch(slot1, slot2)
	end
end

function slot0.onDestroy(slot0)
	if slot0._dragEffectGoList then
		tabletool.clear(slot0._dragEffectGoList)
	end
end

return slot0
