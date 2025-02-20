module("modules.logic.explore.controller.ExploreMapTriggerController", package.seeall)

slot0 = class("ExploreMapTriggerController", BaseController)

function slot0.onInit(slot0)
	slot0.triggerHandleDic = {
		[ExploreEnum.TriggerEvent.Award] = ExploreTriggerAward,
		[ExploreEnum.TriggerEvent.Story] = ExploreTriggerStory,
		[ExploreEnum.TriggerEvent.ChangeCamera] = ExploreTriggerCameraCO,
		[ExploreEnum.TriggerEvent.ChangeElevator] = ExploreTriggerElevator,
		[ExploreEnum.TriggerEvent.MoveCamera] = ExploreTriggerMoveCamera,
		[ExploreEnum.TriggerEvent.Guide] = ExploreTriggerGuide,
		[ExploreEnum.TriggerEvent.Rotate] = ExploreTriggerRotate,
		[ExploreEnum.TriggerEvent.Dialogue] = ExploreTriggerDialogue,
		[ExploreEnum.TriggerEvent.ItemUnit] = ExploreTriggerItem,
		[ExploreEnum.TriggerEvent.Spike] = ExploreTriggerSpike,
		[ExploreEnum.TriggerEvent.OpenArchiveView] = ExploreTriggerOpenArchiveView,
		[ExploreEnum.TriggerEvent.Audio] = ExploreTriggerPlayAudio,
		[ExploreEnum.TriggerEvent.BubbleDialogue] = ExploreTriggerBubbleDialogue,
		[ExploreEnum.TriggerEvent.HeroPlayAnim] = ExploreTriggerHeroPlayAnim
	}
	slot0._triggerflowPool = LuaObjPool.New(5, function ()
		return BaseExploreSequence.New()
	end, function (slot0)
		slot0:dispose()
	end, function ()
	end)
	slot0._usingTriggerflowDic = {}
	slot0._triggerHandlePoolDic = {}
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	ExploreController.instance:registerCallback(ExploreEvent.TryTriggerUnit, slot0._tryTriggerUnit, slot0)
	ExploreController.instance:registerCallback(ExploreEvent.TryCancelTriggerUnit, slot0._tryCancelTriggerUnit, slot0)
end

function slot0.reInit(slot0)
	slot0._triggerflowPool:dispose()
end

function slot0.getFlow(slot0, slot1)
	if slot0._usingTriggerflowDic[slot1] == nil then
		slot2 = slot0._triggerflowPool:getObject()
	end

	slot0._usingTriggerflowDic[slot1] = slot2

	return slot2
end

function slot0.releaseFlow(slot0, slot1)
	slot0._triggerflowPool:putObject(slot0._usingTriggerflowDic[slot1])

	slot0._usingTriggerflowDic[slot1] = nil
end

function slot0.getTriggerHandle(slot0, slot1)
	if slot0.triggerHandleDic[slot1] then
		if slot0._triggerHandlePoolDic[slot1] == nil then
			slot0._triggerHandlePoolDic[slot1] = LuaObjPool.New(5, function ()
				return uv0.triggerHandleDic[uv1].New()
			end, function (slot0)
				slot0:clearWork()
			end, function ()
			end)
		end

		return slot2:getObject()
	end
end

function slot0.registerMap(slot0, slot1)
	slot0._map = slot1
end

function slot0.unRegisterMap(slot0, slot1)
	if slot0._map == slot1 then
		slot0._map = nil
	end
end

function slot0.getMap(slot0)
	return slot0._map
end

function slot0._tryCancelTriggerUnit(slot0, slot1)
	if not slot0._map:isInitDone() then
		return
	end

	if slot0._map:getUnit(slot1) then
		slot2:cancelTrigger()
	end
end

function slot0._tryTriggerUnit(slot0, slot1, slot2)
	if not slot0._map:isInitDone() then
		return
	end

	if slot0._map:getUnit(slot1) then
		if not slot2 and ExploreModel.instance:getCarryUnit() and (not isTypeOf(slot3, ExplorePipeEntranceUnit) or slot3.mo:getColor() ~= ExploreEnum.PipeColor.None) then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantTrigger)

			return
		end

		if slot3.mo.isCanMove and not slot3.mo:isInteractFinishState() then
			table.insert({}, ExploreInteractOptionMO.New(luaLang("explore_op_move"), slot0._beginMoveUnit, slot0, slot3))
		end

		if not slot3.mo:isInteractEnabled() and slot3:getFixItemId() then
			table.insert(slot5, ExploreInteractOptionMO.New(luaLang("explore_op_fix"), slot0._beginFixUnit, slot0, slot3))
		end

		if slot3:canTrigger() then
			table.insert(slot5, ExploreInteractOptionMO.New(luaLang("explore_op_interact"), slot0._beginTriggerUnit, slot0, slot3, slot2))
		end

		if #slot5 == 1 then
			slot5[1].optionCallBack(slot5[1].optionCallObj, slot5[1].unit, slot5[1].isClient)
		elseif slot6 > 1 then
			ViewMgr.instance:openView(ViewName.ExploreInteractOptionView, slot5)
		end
	end
end

function slot0._beginMoveUnit(slot0, slot1)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetMoveUnit, slot1)
end

function slot0._beginFixUnit(slot0, slot1)
	if not ExploreBackpackModel.instance:getItem(slot1:getFixItemId()) then
		ToastController.instance:showToast(ExploreConstValue.Toast.NoItem)

		return
	end

	slot3 = ExploreController.instance:getMap():getHero()

	slot3:onCheckDir(slot3.nodePos, slot1.nodePos)
	slot3:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Fix, true, true)
	slot3.uiComp:addUI(ExploreRoleFixView):setFixUnit(slot1)
	ExploreRpc.instance:sendExploreUseItemRequest(slot2.id, 0, 0, slot1.id)

	slot5, slot6, slot7, slot8 = ExploreConfig.instance:getUnitEffectConfig(slot1:getResPath(), "fix")

	ExploreHelper.triggerAudio(slot7, slot8, slot1.go)
end

function slot0._beginTriggerUnit(slot0, slot1, slot2)
	slot4 = slot1:tryTrigger()

	if slot1:getUnitType() ~= ExploreEnum.ItemType.Bonus then
		slot5 = ExploreController.instance:getMap():getHero()

		if not slot2 and ExploreHelper.getDistance(slot5.nodePos, slot1.nodePos) == 1 then
			slot5:onCheckDir(slot5.nodePos, slot1.nodePos)
		end

		if slot4 then
			slot6 = ExploreAnimEnum.RoleAnimStatus.Interact

			if slot3 == ExploreEnum.ItemType.StoneTable or isTypeOf(slot1, ExploreItemUnit) then
				slot6 = ExploreAnimEnum.RoleAnimStatus.CreateUnit
			end

			slot5:setHeroStatus(slot6, true, true)
		end
	end
end

function slot0.triggerUnit(slot0, slot1, slot2)
	if slot0._map:isInitDone() == false then
		return
	end

	slot0:getFlow(slot1.id):buildFlow()

	slot5 = true

	if slot1:getUnitType() == ExploreEnum.ItemType.BonusScene then
		slot7 = ExploreTriggerBonusScene.New()

		slot7:setParam(nil, slot1, 0, slot2)
		slot4:addWork(slot7)
	end

	slot11 = slot1

	for slot10, slot11 in ipairs(slot1.getExploreUnitMO(slot11).triggerEffects) do
		if slot0:getTriggerHandle(slot11[1]) then
			slot13:setParam(slot11[2], slot1, slot10, slot2)

			if slot12 == ExploreEnum.TriggerEvent.Dialogue then
				if slot5 then
					slot5 = false
				else
					slot13.isNoFirstDialog = true
				end
			end

			slot4:addWork(slot13)
		end
	end

	if not ExploreEnum.ServerTriggerType[slot6] and slot1.mo.triggerByClick or slot1:getUnitType() == ExploreEnum.ItemType.Reset then
		slot7 = ExploreTriggerNormal.New()

		slot7:setParam(nil, slot1, 0, slot2)
		slot4:addWork(slot7)
	end

	slot4:start(function (slot0)
		if slot0 then
			uv0:triggerDone(uv1)
		end
	end)
end

function slot0.triggerDone(slot0, slot1)
	slot0:releaseFlow(slot1)
	slot0:doDoneTrigger(slot1)
end

function slot0.setDonePerformance(slot0, slot1)
	slot6 = slot1

	for slot5, slot6 in ipairs(slot1.getExploreUnitMO(slot6).doneEffects) do
		if slot0:getTriggerHandle(slot6[1]) then
			slot7:setParam(slot6[2], slot1)
			slot7:onStart()
		else
			logError("Explore triggerHandle not find:", slot1.id, slot6[1])
		end
	end
end

function slot0.doDoneTrigger(slot0, slot1)
	if not slot0._map then
		return
	end

	if not slot0._map:getUnit(slot1, true) then
		return
	end

	slot2:getExploreUnitMO().hasInteract = true

	slot0:getFlow(slot1):buildFlow()

	slot8 = slot2

	for slot7, slot8 in ipairs(slot2.getExploreUnitMO(slot8).doneEffects) do
		if slot0:getTriggerHandle(slot8[1]) then
			slot9:setParam(slot8[2], slot2)
			slot3:addWork(slot9)
		end
	end

	slot3:start(function ()
		uv0:onTriggerDone()
		uv1:releaseFlow(uv2)
	end)
end

function slot0.triggerEvent(slot0, slot1, slot2)
	if slot0:getTriggerHandle(slot1) then
		slot3:handle(slot2)
	end
end

function slot0.cancelTriggerEvent(slot0, slot1, slot2, slot3)
	if slot0:getTriggerHandle(slot1) then
		slot4:setParam(slot2, slot3)
		slot4:cancel(slot2)
	end
end

function slot0.cancelTrigger(slot0, slot1, slot2)
	if slot0._map:isInitDone() == false then
		return
	end

	slot0:getFlow(slot1.id):buildFlow()

	slot9 = slot1

	for slot8, slot9 in ipairs(slot1.getExploreUnitMO(slot9).triggerEffects) do
		if slot0:getTriggerHandle(slot9[1]) then
			slot10:setParam(slot9[2], slot1, slot8, slot2, true)
			slot4:addWork(slot10)
		end
	end

	slot4:start(function (slot0)
		uv0:releaseFlow(uv1)
		uv2:onTriggerDone()
	end)
end

slot0.instance = slot0.New()

return slot0
