module("modules.logic.room.entity.RoomMapTransportPathEntity", package.seeall)

slot0 = class("RoomMapTransportPathEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
end

function slot0.getTag(slot0)
	return SceneTag.Untagged
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.StaticContainerGOKey)
	slot0.goTrs = slot1.transform

	uv0.super.init(slot0, slot1)
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3)
	transformhelper.setLocalPos(slot0.goTrs, slot1, slot2, slot3)
end

function slot0.getMO(slot0)
	return nil
end

function slot0._refreshCanPlaceEffect(slot0)
	for slot11, slot12 in ipairs(RoomMapTransportPathModel.instance:getTempTransportPathMO():getHexPointList()) do
		slot13 = slot0:getEffectKeyById(slot11)

		if slot0:_isCanShowPlaceEffect() and slot0:_checkByXY(slot12.x, slot12.y, RoomMapBlockModel.instance) then
			if not slot0.entity.effect:isHasKey(slot13) then
				if nil == nil then
					slot3 = {}
				end

				slot14 = HexMath.hexToPosition(slot12, RoomBlockEnum.BlockSize)
				slot3[slot13] = {
					res = RoomScenePreloader.ResEffectD03,
					localPos = Vector3(slot14.x, -0.12, slot14.y)
				}
			end
		elseif slot5:getEffectRes(slot13) then
			if slot4 == nil then
				slot4 = {}
			end

			table.insert(slot4, slot13)
		end
	end

	if slot3 then
		slot5:addParams(slot3)
		slot5:refreshEffect()
	end

	if slot4 then
		slot0:removeParamsAndPlayAnimator(slot4, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

return slot0
