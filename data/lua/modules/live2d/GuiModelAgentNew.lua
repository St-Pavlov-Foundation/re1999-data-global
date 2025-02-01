module("modules.live2d.GuiModelAgentNew", package.seeall)

slot0 = class("GuiModelAgentNew", LuaCompBase)
slot1 = "live2d/custom/live2d_camera_2.prefab"

function slot0.Create(slot0, slot1)
	slot2 = nil
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
	slot2._isStory = slot1

	return slot2
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
end

function slot0._getSpine(slot0)
	if not slot0._spine then
		slot0._spine = LightSpine.Create(slot0._go, slot0._isStory)
	end

	return slot0._spine
end

function slot0._getLive2d(slot0)
	if not slot0._live2d then
		slot0._live2d = GuiLive2d.Create(slot0._go, slot0._isStory)
	end

	slot0._live2d:cancelCamera()

	return slot0._live2d
end

function slot0.setSkinCfg(slot0, slot1, slot2, slot3)
	slot4 = slot0._curModel
	slot5 = slot0._isLive2D
	slot0.loadedCb = slot2
	slot0.loadedCbObj = slot3

	if string.nilorempty(slot1.live2d) then
		slot0._isLive2D = false
		slot0._curModel = slot0:_getSpine()

		gohelper.setActive(slot0._curModel._spineGo, true)
		slot0._curModel:setResPath(ResUrl.getLightSpine(slot1.verticalDrawing), slot0._loadResCb, slot0)
	else
		slot0._isLive2D = true
		slot0._curModel = slot0:_getLive2d()

		gohelper.setActive(slot0._curModel._spineGo, true)
		slot0._curModel:setResPath(ResUrl.getLightLive2d(slot1.live2d), slot0._loadResCb, slot0)
	end

	if slot4 and slot0._isLive2D ~= slot5 then
		gohelper.setActive(slot4._spineGo, false)
	end
end

function slot0.setResPath(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0._curModel
	slot6 = slot0._isLive2D
	slot0.loadedCb = slot3
	slot0.loadedCbObj = slot4

	if slot2 then
		slot0._isLive2D = true
		slot0._curModel = slot0:_getLive2d()

		gohelper.setActive(slot0._curModel._spineGo, true)
		slot0._curModel:setResPath(slot1, slot0._loadResCb, slot0)
	else
		slot0._isLive2D = false
		slot0._curModel = slot0:_getSpine()

		gohelper.setActive(slot0._curModel._spineGo, true)
		slot0._curModel:setResPath(slot1, slot0._loadResCb, slot0)
	end

	if slot5 and slot0._isLive2D ~= slot6 then
		gohelper.setActive(slot5._spineGo, false)
	end
end

function slot0.setVerticalDrawing(slot0, slot1, slot2, slot3)
	slot6 = nil
	slot7 = slot0._curModel
	slot8 = slot0._isLive2D

	if string.split(slot1, "/") and slot4[#slot4] then
		slot6 = SkinConfig.instance:getLive2dSkin(string.gsub(slot5, ".prefab", ""))
	end

	slot0.loadedCb = slot2
	slot0.loadedCbObj = slot3

	if not slot6 then
		slot0._isLive2D = false
		slot0._curModel = slot0:_getSpine()

		slot0._curModel:showModel()
		slot0._curModel:setResPath(slot1, slot0._loadResCb, slot0)
	else
		slot0._isLive2D = true
		slot0._curModel = slot0:_getLive2d()

		slot0._curModel:showModel()
		slot0._curModel:cancelCamera()
		slot0._curModel:setResPath(ResUrl.getLightLive2d(slot6), slot0._loadResCb, slot0)
	end

	if slot0._isLive2D ~= slot8 then
		slot7:hideModel()
	end
end

function slot0._loadResCb(slot0)
	slot2 = slot0._curModel:getSpineGo()
	slot3, slot4 = nil

	if slot0._isLive2D then
		slot2 = gohelper.findChild(slot1, "Drawables").transform:GetChild(0).gameObject
	end

	if gohelper.findChild(slot2, "roleeffect_for_ui") == nil then
		slot3 = gohelper.create2d(slot2, "roleeffect_for_ui")
	end

	gohelper.onceAddComponent(slot2, typeof(UrpCustom.PPEffectMask)).useLocalBloom = true

	gohelper.setActive(slot3, false)

	if slot0._curModel.setLocalScale then
		slot0._curModel:setLocalScale(1)
	else
		transformhelper.setLocalScale(slot1.transform, 1, 1, 1)
	end

	gohelper.onceAddComponent(slot3, typeof(ZProj.RoleEffectCtrl)).forUI = true

	gohelper.setActive(slot3, true)

	if slot0.loadedCb then
		slot0.loadedCb(slot0.loadedCbObj)
	end
end

function slot0.setModelVisible(slot0, slot1)
	if not slot0._curModel then
		return
	end

	gohelper.setActive(slot0._go, slot1)
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

function slot0.getSpineGo(slot0)
	if slot0._curModel then
		return slot0._curModel:getSpineGo()
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

function slot0.playVoice(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._curModel then
		slot0._curModel:playVoice(slot1, slot2, slot3, slot4, slot5)
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

return slot0
