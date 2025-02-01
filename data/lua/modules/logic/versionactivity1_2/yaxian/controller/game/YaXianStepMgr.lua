module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianStepMgr", package.seeall)

slot0 = class("YaXianStepMgr")
slot0.StepClzMap = {
	[YaXianGameEnum.GameStepType.GameFinish] = YaXianStepGameFinish,
	[YaXianGameEnum.GameStepType.Move] = YaXianStepMove,
	[YaXianGameEnum.GameStepType.NextRound] = YaXianStepNextRound,
	[YaXianGameEnum.GameStepType.CallEvent] = YaXianStepCallEvent,
	[YaXianGameEnum.GameStepType.CreateObject] = YaXianStepCreateObject,
	[YaXianGameEnum.GameStepType.DeleteObject] = YaXianStepDeleteObject,
	[YaXianGameEnum.GameStepType.PickUp] = YaXianStepPickUpItem,
	[YaXianGameEnum.GameStepType.InteractFinish] = YaXianStepInteractFinish,
	[YaXianGameEnum.GameStepType.UpdateObjectData] = YaXianStepUpdateObjectData
}

function slot0.ctor(slot0)
	slot0._stepList = nil
	slot0._stepPool = nil
	slot0._curStep = nil
end

function slot0.insertStepList(slot0, slot1)
	slot0:beforeBuildStep(slot1)

	for slot5, slot6 in ipairs(slot0.stepDataList) do
		slot0:insertStep(slot6, slot5)
	end
end

function slot0.beforeBuildStep(slot0, slot1)
	slot0.stepDataList = {}
	slot2, slot3 = nil

	for slot7, slot8 in ipairs(slot1) do
		if cjson.decode(slot8.param).stepType ~= YaXianGameEnum.GameStepType.Move then
			if slot3 then
				table.insert(slot0.stepDataList, slot3)

				slot3 = nil
			end

			table.insert(slot0.stepDataList, slot2)
		else
			if slot3 and slot3.id ~= slot2.id then
				table.insert(slot0.stepDataList, slot3)
			end

			slot3 = slot2
		end
	end

	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot0.stepDataList) do
		if slot10.stepType == YaXianGameEnum.GameStepType.DeleteObject and slot10.reason == YaXianGameEnum.DeleteInteractReason.AssassinateKill then
			table.insert(slot4, slot9)
		end

		if slot10.stepType == YaXianGameEnum.GameStepType.Move then
			table.insert(slot5, slot9)
		end
	end

	for slot9, slot10 in ipairs(slot4) do
		slot11 = nil

		for slot15 = #slot5, 1, -1 do
			if slot5[slot15] < slot10 then
				slot11 = slot5[slot15]

				break
			end
		end

		if slot0:getStepData(slot11) then
			slot3.assassinateSourceStep = true
			slot3.deleteStepIndex = slot10
		else
			logError("not found step data, index : " .. slot10)
		end
	end
end

function slot0.getStepData(slot0, slot1)
	return slot0.stepDataList and slot0.stepDataList[slot1]
end

function slot0.insertStep(slot0, slot1, slot2)
	if slot0:buildStep(slot1, slot2) then
		slot0._stepList = slot0._stepList or {}

		table.insert(slot0._stepList, slot3)
	end

	if slot0._curStep == nil then
		slot0:nextStep()
	end
end

function slot0.buildStep(slot0, slot1, slot2)
	slot3 = nil

	if slot0._stepPool and slot0._stepPool[slot1.stepType] and #slot4 > 0 then
		slot3 = slot4[#slot4]
		slot4[#slot4] = nil
	else
		slot3 = uv0.StepClzMap[slot1.stepType].New()
	end

	slot3:init(slot1, slot2)

	return slot3
end

function slot0.nextStep(slot0)
	if slot0._curStep then
		slot0:putPool(slot0._curStep)

		slot0._curStep = nil
	end

	if slot0._stepList and #slot0._stepList > 0 then
		slot0._curStep = slot0._stepList[1]

		table.remove(slot0._stepList, 1)
		slot0._curStep:start()
	end
end

function slot0.putPool(slot0, slot1)
	if not slot1 then
		return
	end

	slot1:dispose()

	slot0._stepPool = slot0._stepPool or {}
	slot2 = slot0._stepPool[slot1.stepType] or {}

	table.insert(slot2, slot1)

	slot0._stepPool[slot1.stepType] = slot2
end

function slot0.disposeAllStep(slot0)
	if slot0._curStep then
		slot0:putPool(slot0._curStep)

		slot0._curStep = nil
	end

	if slot0._stepList then
		for slot4, slot5 in pairs(slot0._stepList) do
			slot0:putPool(slot5)
		end

		slot0._stepList = nil
	end
end

function slot0.removeAll(slot0)
	slot0:disposeAllStep()
end

function slot0.dispose(slot0)
	slot0._stepPool = nil
end

function slot0.log(slot0, slot1)
	logError(string.format("data : %s, index : %s", cjson.encode(slot1.originData), slot1.index))
end

return slot0
