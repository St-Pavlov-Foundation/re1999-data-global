module("modules.logic.meilanni.controller.MeilanniAnimationController", package.seeall)

slot0 = class("MeilanniAnimationController", BaseController)
slot0.historyLayer = 1
slot0.excludeRulesLayer = 2
slot0.epilogueLayer = 3
slot0.changeMapLayer = 4
slot0.changeWeatherLayer = 5
slot0.showElementsLayer = 6
slot0.prefaceLayer = 7
slot0.enemyLayer = 8
slot0.endLayer = 9
slot0.maxLayer = 9

function slot0.onInit(slot0)
	slot0._isPlaying = nil
	slot0._isPlayingDialogItemList = nil
	slot0._delayCallList = {}
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0._isPlaying = nil
	slot0._isPlayingDialogItemList = nil
	slot0._delayCallList = {}
end

function slot0.startDialogListAnim(slot0)
	slot0._isPlayingDialogItemList = true
end

function slot0.endDialogListAnim(slot0)
	slot0._isPlayingDialogItemList = nil
end

function slot0.isPlayingDialogListAnim(slot0)
	return slot0._isPlayingDialogItemList
end

function slot0.addDelayCall(slot0, slot1, slot2, slot3, slot4, slot5)
	if not slot0._isPlaying then
		slot1(slot2, slot3)

		return
	end

	slot7 = slot0._delayCallList[slot5] or {}
	slot0._delayCallList[slot5] = slot7

	table.insert(slot7, {
		slot1,
		slot2,
		slot3,
		slot4
	})
end

function slot0.startAnimation(slot0)
	slot0._isPlaying = true

	TaskDispatcher.runRepeat(slot0._frame, slot0, 0)
	slot0:dispatchEvent(MeilanniEvent.dialogListAnimChange, slot0._isPlaying)
end

function slot0._frame(slot0)
	if slot0._isPlayingDialogItemList or ViewMgr.instance:isOpen(ViewName.MeilanniBossInfoView) then
		return
	end

	if not slot0:_getFirstCall() then
		return
	end

	if not slot1._startTime then
		slot1._startTime = Time.realtimeSinceStartup

		return
	end

	if (slot1[4] or 0) <= Time.realtimeSinceStartup - slot1._startTime then
		slot1 = slot0:_getFirstCall(true)

		slot1[1](slot1[2], slot1[3])
	end
end

function slot0._getFirstCall(slot0, slot1)
	for slot5 = 1, uv0.maxLayer do
		if slot0._delayCallList[slot5] and #slot6 > 0 then
			if slot1 then
				return table.remove(slot6, 1)
			else
				return slot6[1]
			end
		end
	end

	return nil
end

function slot0.endAnimation(slot0, slot1)
	slot0:addDelayCall(slot0._endAnimation, slot0, nil, , slot1)
end

function slot0._endAnimation(slot0)
	slot0._isPlaying = false

	TaskDispatcher.cancelTask(slot0._frame, slot0)
	slot0:dispatchEvent(MeilanniEvent.dialogListAnimChange, slot0._isPlaying)
end

function slot0.isPlaying(slot0)
	return slot0._isPlaying
end

function slot0.close(slot0)
	TaskDispatcher.cancelTask(slot0._frame, slot0)
	slot0:reInit()
end

slot0.instance = slot0.New()

return slot0
