module("modules.logic.fight.entity.pool.FightEffectWrap", package.seeall)

slot0 = class("FightEffectWrap", LuaCompBase)

function slot0.ctor(slot0)
	slot0.uniqueId = nil
	slot0.path = nil
	slot0.abPath = nil
	slot0.side = nil
	slot0.containerGO = nil
	slot0.containerTr = nil
	slot0.effectGO = nil
	slot0.hangPointGO = nil
	slot0._canDestroy = false
	slot0._layer = nil
	slot0._renderOrder = nil
	slot0._nonActiveKeyList = {}
	slot0._nonPosActiveKeyList = {}
	slot0.callback = nil
	slot0.callbackObj = nil
	slot0.dontPlay = nil
	slot0.cus_localPosX = nil
	slot0.cus_localPosY = nil
	slot0.cus_localPosZ = nil
end

function slot0.init(slot0, slot1)
	slot0.containerGO = slot1
	slot0.containerTr = slot1.transform
end

function slot0.play(slot0)
	if slot0.effectGO and not slot0.dontPlay then
		slot0:setActive(true)

		if slot0.effectGO:GetComponent(typeof(ZProj.EffectShakeComponent)) then
			slot3 = 1

			if FightModel.instance:getSpeed() > 1.4 then
				slot3 = 1 - 0.3 * (slot2 - 1.4) / 1.4
			end

			slot1:Play(CameraMgr.instance:getCameraShake(), slot2, slot3)
		end
	end
end

function slot0.setUniqueId(slot0, slot1)
	slot0.uniqueId = slot1
end

function slot0.setPath(slot0, slot1)
	slot0.path = slot1
	slot0.abPath = FightHelper.getEffectAbPath(slot1)
end

function slot0.setEffectGO(slot0, slot1)
	slot0.effectGO = slot1

	if slot0._effectScale then
		transformhelper.setLocalScale(slot0.effectGO.transform, slot0._effectScale, slot0._effectScale, slot0._effectScale)
	end

	if slot0._renderOrder then
		slot0:setRenderOrder(slot0._renderOrder, true)
	end

	slot0.cus_localPosX, slot0.cus_localPosY, slot0.cus_localPosZ = transformhelper.getLocalPos(slot0.effectGO.transform)

	if slot0._nonPosActiveKeyList and #slot0._nonPosActiveKeyList > 0 then
		slot0:playActiveByPos(false)
	end
end

function slot0.setLayer(slot0, slot1)
	slot0._layer = slot1

	gohelper.setLayer(slot0.effectGO, slot0._layer, true)
end

function slot0.setHangPointGO(slot0, slot1)
	if not gohelper.isNil(slot1) and not gohelper.isNil(slot0.containerGO) and slot0.hangPointGO ~= slot1 then
		slot0.hangPointGO = slot1

		slot0.containerGO.transform:SetParent(slot0.hangPointGO.transform, true)
		transformhelper.setLocalRotation(slot0.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(slot0.containerGO.transform, 1, 1, 1)
	end
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3)
	if slot0.containerTr then
		transformhelper.setLocalPos(slot0.containerTr, slot1, slot2, slot3)
		slot0:clearTrail()
	end
end

function slot0.setWorldPos(slot0, slot1, slot2, slot3)
	if slot0.containerTr then
		transformhelper.setPos(slot0.containerTr, slot1, slot2, slot3)
		slot0:clearTrail()
	end
end

function slot0.setCallback(slot0, slot1, slot2)
	slot0.callback = slot1
	slot0.callbackObj = slot2
end

function slot0.setActive(slot0, slot1, slot2)
	if slot0.containerGO then
		if slot1 then
			tabletool.removeValue(slot0._nonActiveKeyList, slot2 or "default")
			gohelper.setActive(slot0.containerGO, #slot0._nonActiveKeyList == 0)
		else
			if not tabletool.indexOf(slot0._nonActiveKeyList, slot2) then
				table.insert(slot0._nonActiveKeyList, slot2)
			end

			gohelper.setActive(slot0.containerGO, false)
		end
	else
		logError("Effect container is nil, setActive fail: " .. slot0.path)
	end
end

function slot0.setActiveByPos(slot0, slot1, slot2)
	if slot0.containerGO then
		if slot1 then
			tabletool.removeValue(slot0._nonPosActiveKeyList, slot2 or "default")
			slot0:playActiveByPos(#slot0._nonPosActiveKeyList == 0)
		else
			if not tabletool.indexOf(slot0._nonPosActiveKeyList, slot2) then
				table.insert(slot0._nonPosActiveKeyList, slot2)
			end

			slot0:playActiveByPos(false)
		end
	else
		logError("Effect container is nil, setActive fail: " .. slot0.path)
	end
end

function slot0.playActiveByPos(slot0, slot1)
	if slot0.effectGO and slot0.cus_localPosX then
		if slot1 then
			transformhelper.setLocalPos(slot0.effectGO.transform, slot0.cus_localPosX, slot0.cus_localPosY, slot0.cus_localPosZ)
		else
			transformhelper.setLocalPos(slot0.effectGO.transform, slot0.cus_localPosX + 20000, slot0.cus_localPosY + 20000, slot0.cus_localPosZ + 20000)
		end
	end
end

function slot0.onReturnPool(slot0)
	slot0._nonActiveKeyList = {}
	slot0._nonPosActiveKeyList = {}

	slot0:playActiveByPos(true)
end

function slot0.setRenderOrder(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._renderOrder = slot1

	if not slot2 and slot1 == slot0._renderOrder then
		return
	end

	if not gohelper.isNil(slot0.effectGO) and slot0.effectGO:GetComponent(typeof(ZProj.EffectOrderContainer)) then
		slot4:SetBaseOrder(slot1)
	end
end

function slot0.setTimeScale(slot0, slot1)
	if slot0.effectGO then
		gohelper.onceAddComponent(slot0.effectGO, typeof(ZProj.EffectTimeScale)):SetTimeScale(slot1)
	end
end

function slot0.clearTrail(slot0)
	if slot0.effectGO then
		gohelper.onceAddComponent(slot0.effectGO, typeof(ZProj.EffectTimeScale)):ClearTrail()
	end
end

function slot0.doCallback(slot0, slot1)
	if slot0.callback then
		if slot0.callbackObj then
			slot0.callback(slot0.callbackObj, slot0, slot1)
		else
			slot0:callback(slot1)
		end

		slot0.callback = nil
		slot0.callbackObj = nil
	end
end

function slot0.setEffectScale(slot0, slot1)
	slot0._effectScale = slot1

	if slot0.effectGO then
		transformhelper.setLocalScale(slot0.effectGO.transform, slot0._effectScale, slot0._effectScale, slot0._effectScale)
	end
end

function slot0.markCanDestroy(slot0)
	slot0._canDestroy = true
end

function slot0.onDestroy(slot0)
	if not slot0._canDestroy then
		logError("Effect destroy unexpected: " .. slot0.path)
	end

	slot0.containerGO = nil
	slot0.effectGO = nil
	slot0.hangPointGO = nil
	slot0.callback = nil
	slot0.callbackObj = nil
end

return slot0
