module("modules.logic.guide.controller.GuidePriorityController", package.seeall)

slot0 = class("GuidePriorityController", BaseController)

function slot0.onInit(slot0)
	slot0._guideIdList = {}
	slot0._guideObjDict = {}
end

function slot0.reInit(slot0)
	slot0._guideIdList = {}
	slot0._guideObjDict = {}

	TaskDispatcher.cancelTask(slot0._onFrame, slot0)
end

function slot0.add(slot0, slot1, slot2, slot3, slot4)
	slot0._guideObjDict[slot1] = {
		guideId = slot1,
		callback = slot2,
		callbackObj = slot3,
		time = Time.time + (slot4 and slot4 > 0 and slot4 or 0.01)
	}

	if not tabletool.indexOf(slot0._guideIdList, slot1) then
		table.insert(slot0._guideIdList, slot1)
	end

	for slot11, slot12 in pairs(slot0._guideObjDict) do
		if slot5 < slot12.time - slot6 then
			slot7 = slot12.time - slot6
		end
	end

	TaskDispatcher.cancelTask(slot0._onTimeEnd, slot0)
	TaskDispatcher.runDelay(slot0._onTimeEnd, slot0, slot7)
end

function slot0.remove(slot0, slot1)
	slot0._guideObjDict[slot1] = nil

	tabletool.removeValue(slot0._guideIdList, slot1)
end

function slot0._onTimeEnd(slot0)
	if #slot0._guideIdList == 0 then
		return
	end

	slot0._guideIdList = {}
	slot0._guideObjDict = {}

	if slot0._guideObjDict[GuideConfig.instance:getHighestPriorityGuideId(slot0._guideIdList)] then
		slot4.callback(slot4.callbackObj)
	end
end

slot0.instance = slot0.New()

return slot0
