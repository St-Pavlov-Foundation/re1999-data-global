module("modules.logic.versionactivity2_4.pinball.controller.PinballEntityMgr", package.seeall)

slot0 = class("PinballEntityMgr")

function slot0.ctor(slot0)
	slot0._entitys = {}
	slot0._item = nil
	slot0._topItem = nil
	slot0._numItem = nil
	slot0._layers = {}
	slot0.uniqueId = 0
	slot0._curMarblesNum = 0
	slot0._totalNum = 0
end

function slot0.addEntity(slot0, slot1, slot2)
	slot0.uniqueId = slot0.uniqueId + 1
	slot3 = PinballEnum.UnitTypeToName[slot1] or ""
	slot6 = nil
	slot6 = (not PinballEnum.UnitTypeToLayer[slot1] or not slot0._layers[slot5] or gohelper.clone(slot0._item, slot0._layers[slot5], slot3)) and gohelper.cloneInPlace((PinballHelper.isMarblesType(slot1) or slot1 == PinballEnum.UnitType.CommonEffect) and slot0._topItem or slot0._item, slot3)

	gohelper.setActive(slot6, true)

	slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot6, _G[string.format("Pinball%sEntity", slot3)] or PinballColliderEntity)
	slot7.id = slot0.uniqueId
	slot7.unitType = slot1

	slot7:initByCo(slot2)
	slot7:loadRes()

	if slot7:isMarblesType() then
		slot0._curMarblesNum = slot0._curMarblesNum + 1
	end

	slot7:tick(0)

	slot0._entitys[slot0.uniqueId] = slot7

	return slot7
end

function slot0.addNumShow(slot0, slot1, slot2, slot3)
	slot0._totalNum = slot0._totalNum + slot1
	slot4 = gohelper.cloneInPlace(slot0._numItem)

	gohelper.setActive(slot4, true)

	slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot4, PinballNumShowEntity)

	slot5:setType(slot0._totalNum)
	slot5:setPos(slot2, slot3)
end

function slot0.removeEntity(slot0, slot1)
	if slot0._entitys[slot1] then
		slot0._entitys[slot1]:markDead()
	end
end

function slot0.getEntity(slot0, slot1)
	return slot0._entitys[slot1]
end

function slot0.getAllEntity(slot0)
	return slot0._entitys
end

function slot0.beginTick(slot0)
	TaskDispatcher.runRepeat(slot0.frameTick, slot0, 0, -1)
end

function slot0.pauseTick(slot0)
	TaskDispatcher.cancelTask(slot0.frameTick, slot0)
end

function slot0.setRoot(slot0, slot1, slot2, slot3, slot4)
	slot0._item = slot1
	slot0._topItem = slot2
	slot0._numItem = slot3
	slot0._layers = slot4
end

function slot0.frameTick(slot0)
	if isDebugBuild and PinballModel.instance._gmkey then
		slot0:checkGMKey()
	end

	slot1 = 3

	for slot6 = 1, slot1 do
		slot0:_tickDt(Mathf.Clamp(UnityEngine.Time.deltaTime, 0.01, 0.1) / slot1)
	end
end

function slot0._tickDt(slot0, slot1)
	for slot5, slot6 in pairs(slot0._entitys) do
		slot6:tick(slot1)
	end

	for slot5, slot6 in pairs(slot0._entitys) do
		if slot6:isCheckHit() then
			for slot10 = #slot6.curHitEntityIdList, 1, -1 do
				if not slot0._entitys[slot6.curHitEntityIdList[slot10]] or not PinballHelper.getHitInfo(slot6, slot12) then
					if slot12 then
						slot12:onHitExit(slot6.id)
						tabletool.removeValue(slot12.curHitEntityIdList, slot6.id)
					end

					slot6:onHitExit(slot11)
					table.remove(slot6.curHitEntityIdList, slot10)
				end
			end

			for slot10, slot11 in pairs(slot0._entitys) do
				if slot6 ~= slot11 and slot11:canHit() and not tabletool.indexOf(slot6.curHitEntityIdList, slot11.id) then
					slot12, slot13, slot14 = PinballHelper.getHitInfo(slot6, slot11)

					if slot12 then
						table.insert(slot6.curHitEntityIdList, slot11.id)
						table.insert(slot11.curHitEntityIdList, slot6.id)

						if slot6.unitType <= slot11.unitType then
							slot6:onHitEnter(slot11.id, slot12, slot13, slot14)
							slot11:onHitEnter(slot6.id, slot12, slot13, -slot14)

							break
						end

						slot11:onHitEnter(slot6.id, slot12, slot13, -slot14)
						slot6:onHitEnter(slot11.id, slot12, slot13, slot14)

						break
					end
				end
			end
		end
	end

	slot2 = false

	for slot6, slot7 in pairs(slot0._entitys) do
		if slot7.isDead then
			if slot7.curHitEntityIdList then
				for slot11, slot12 in pairs(slot7.curHitEntityIdList) do
					if slot0._entitys[slot12] then
						slot13:onHitExit(slot7.id)
						tabletool.removeValue(slot13.curHitEntityIdList, slot7.id)
						slot7:onHitExit(slot13.id)
					end
				end

				slot7.curHitEntityIdList = {}
			end

			if slot7:isMarblesType() then
				slot0._curMarblesNum = slot0._curMarblesNum - 1
				slot2 = true
			end

			slot0._entitys[slot6]:dispose()

			slot0._entitys[slot6] = nil
		end
	end

	if slot2 and slot0._curMarblesNum == 0 then
		slot0._totalNum = 0

		PinballController.instance:dispatchEvent(PinballEvent.MarblesDead)
	end
end

function slot0.checkGMKey(slot0)
	slot1 = nil

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha1) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad1) then
		slot1 = 1
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha2) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad2) then
		slot1 = 2
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha3) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad3) then
		slot1 = 3
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha4) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad4) then
		slot1 = 4
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha5) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad5) then
		slot1 = 5
	elseif UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Alpha0) or UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Keypad0) then
		for slot5, slot6 in pairs(slot0._entitys) do
			slot6.vx = 0
			slot6.vy = 0
		end
	end

	if slot1 then
		slot2 = ViewMgr.instance:getContainer(ViewName.PinballGameView)._views[2]
		slot3 = slot2._curBagDict
		slot3[slot1] = slot3[slot1] + 1

		slot2:_refreshBagAndSaveData()
	end
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0.frameTick, slot0)

	for slot4, slot5 in pairs(slot0._entitys) do
		slot5:dispose()
	end

	slot0._entitys = {}
	slot0._item = nil
	slot0._topItem = nil
	slot0._numItem = nil
	slot0._layers = nil
	slot0._curMarblesNum = 0
end

slot0.instance = slot0.New()

return slot0
