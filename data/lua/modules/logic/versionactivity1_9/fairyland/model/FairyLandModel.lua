module("modules.logic.versionactivity1_9.fairyland.model.FairyLandModel", package.seeall)

slot0 = class("FairyLandModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.stairIndex = 1
	slot0.passPuzzleDict = {}
	slot0.dialogDict = {}
	slot0.finishElementDict = {}
	slot0.hasInfo = false
end

function slot0.onGetFairylandInfoReply(slot0, slot1)
	slot0:clear()
	slot0:updateInfo(slot1.info)
end

function slot0.onResolvePuzzleReply(slot0, slot1)
	slot0:updateInfo(slot1.info)
end

function slot0.onRecordDialogReply(slot0, slot1)
	slot0:updateInfo(slot1.info)
end

function slot0.onRecordElementReply(slot0, slot1)
	slot0:updateInfo(slot1.info)
end

function slot0.updateInfo(slot0, slot1)
	slot0.hasInfo = true
	slot0.passPuzzleDict = {}
	slot0.dialogDict = {}
	slot0.finishElementDict = {}

	if not slot1 then
		return
	end

	for slot5 = 1, #slot1.passPuzzleId do
		slot0.passPuzzleDict[slot1.passPuzzleId[slot5]] = true
	end

	for slot5 = 1, #slot1.dialogId do
		slot0.dialogDict[slot1.dialogId[slot5]] = true
	end

	for slot5 = 1, #slot1.finishElementId do
		slot0.finishElementDict[slot1.finishElementId[slot5]] = true
	end
end

function slot0.setFinishDialog(slot0, slot1)
	if not slot0.dialogDict then
		return
	end

	slot0.dialogDict[slot1] = true
end

function slot0.setPos(slot0, slot1, slot2)
	slot0.stairIndex = slot1

	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetStairPos, slot2)
end

function slot0.getStairPos(slot0)
	return slot0.stairIndex or 1
end

function slot0.caleCurStairPos(slot0)
	slot1 = 0

	for slot6 = #FairyLandConfig.instance:getElements(), 1, -1 do
		if FairyLandEnum.ConfigType2ElementType[slot2[slot6].type] ~= FairyLandEnum.ElementType.NPC and slot0:isFinishElement(slot7.id) then
			slot1 = tonumber(slot7.pos)

			break
		end
	end

	return slot1
end

function slot0.isFinishElement(slot0, slot1)
	return slot0.finishElementDict[slot1]
end

function slot0.isPassPuzzle(slot0, slot1)
	return slot0.passPuzzleDict[slot1]
end

function slot0.isFinishDialog(slot0, slot1)
	return slot1 == 0 or slot0.dialogDict[slot1]
end

function slot0.getCurPuzzle(slot0)
	for slot5, slot6 in ipairs(FairyLandConfig.instance:getElements()) do
		if FairyLandEnum.ConfigType2ElementType[slot6.type] == FairyLandEnum.ElementType.NPC then
			for slot12, slot13 in ipairs(string.splitToNumber(slot6.puzzleId, "#")) do
				if not slot0:isPuzzleAllStepFinish(FairyLandConfig.instance:getFairlyLandPuzzleConfig(slot13).id) and (slot14.beforeTalkId == 0 or slot0:isFinishDialog(slot14.beforeTalkId)) and slot0:isPuzzleAllStepFinish(slot13 - 1) then
					return slot14.id
				end
			end
		end
	end

	return 0
end

function slot0.getLatestFinishedPuzzle(slot0)
	for slot5, slot6 in ipairs(FairyLandConfig.instance:getElements()) do
		if FairyLandEnum.ConfigType2ElementType[slot6.type] == FairyLandEnum.ElementType.NPC then
			for slot12, slot13 in ipairs(string.splitToNumber(slot6.puzzleId, "#")) do
				if slot0:isPuzzleAllStepFinish(FairyLandConfig.instance:getFairlyLandPuzzleConfig(slot13).id) then
					return slot14.id
				end
			end
		end
	end

	return 0
end

function slot0.isPuzzleAllStepFinish(slot0, slot1)
	if not FairyLandConfig.instance:getFairlyLandPuzzleConfig(slot1) then
		return true
	end

	return slot0:isFinishDialog(slot2.beforeTalkId) and slot0:isFinishDialog(slot2.successTalkId) and slot0:isFinishDialog(slot2.storyTalkId) and slot0:isPassPuzzle(slot1)
end

function slot0.getDialogElement(slot0, slot1)
	if ViewMgr.instance:getContainer(ViewName.FairyLandView) then
		return slot2:getElement(slot1)
	end
end

function slot0.isFinishFairyLand(slot0)
	for slot5 = #FairyLandConfig.instance:getElements(), 1, -1 do
		if not slot0:isFinishElement(slot1[slot5].id) then
			return false
		end
	end

	return true
end

slot0.instance = slot0.New()

return slot0
