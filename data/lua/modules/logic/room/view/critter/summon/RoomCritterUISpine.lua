module("modules.logic.room.view.critter.summon.RoomCritterUISpine", package.seeall)

slot0 = class("RoomCritterUISpine", LuaCompBase)

function slot0.Create(slot0)
	slot1 = nil

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
end

function slot0._getSpine(slot0)
	if not slot0._spine then
		slot0._spine = GuiSpine.Create(slot0._go)
	end

	return slot0._spine
end

function slot0.resetTransform(slot0)
	if not slot0._spine then
		return
	end

	if gohelper.isNil(slot0._spine._spineGo) then
		return
	end

	recthelper.setAnchor(slot1.transform, 0, 0)
	transformhelper.setLocalScale(slot1.transform, 1, 1, 1)
end

function slot0.setResPath(slot0, slot1, slot2, slot3)
	slot0._curModel = slot0:_getSpine()

	slot0._curModel:setHeroId(slot1.id)
	slot0._curModel:showModel()
	slot0._curModel:setResPath(RoomResHelper.getCritterUIPath(slot1:getSkinId()), function ()
		uv0:resetTransform()

		if uv1 then
			uv1(uv2)
		end
	end, slot0, true)
end

function slot0.stopVoice(slot0)
	if slot0._spine then
		slot0._spine:stopVoice()
	end
end

function slot0.onDestroyView(slot0)
	if slot0._spine then
		slot0._spine:stopVoice()

		slot0._spine = nil
	end
end

return slot0
