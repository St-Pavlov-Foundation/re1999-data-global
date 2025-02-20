module("modules.logic.scene.room.comp.RoomSceneTweenComp", package.seeall)

slot0 = class("RoomSceneTweenComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._initialized = false
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._tweenId = 0
	slot0._tweenParamDict = {}
	slot0._toDeleteTweenIdDict = {}

	TaskDispatcher.runRepeat(slot0._onUpdate, slot0, 0)

	slot0._initialized = true
end

function slot0.getTweenId(slot0)
	slot0._tweenId = slot0._tweenId + 1

	return slot0._tweenId
end

function slot0.tweenFloat(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot9 = slot0:getTweenId()
	slot0._tweenParamDict[slot9] = {
		time = 0,
		from = slot1,
		to = slot2,
		duration = slot3,
		frameCallback = slot4,
		finishCallback = slot5,
		target = slot6,
		object = slot7,
		ease = slot8
	}

	return slot9
end

function slot0.killById(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._toDeleteTweenIdDict[slot1] = true
end

function slot0._onUpdate(slot0)
	if not slot0._tweenParamDict or not slot0._initialized then
		return
	end

	for slot4, slot5 in pairs(slot0._tweenParamDict) do
		if not slot0._toDeleteTweenIdDict[slot4] then
			slot5.time = slot5.time + Time.deltaTime

			if slot5.duration < slot5.time then
				slot0._toDeleteTweenIdDict[slot4] = true

				if slot5.finishCallback then
					if slot5.target then
						slot5.finishCallback(slot5.target, slot5.object)
					else
						slot5.finishCallback(slot5.object)
					end
				end
			elseif slot5.frameCallback then
				if slot5.target then
					slot5.frameCallback(slot5.target, slot0:getFloat(slot5.from, slot5.to, slot5.duration, slot5.time, slot5.ease), slot5.object)
				else
					slot5.frameCallback(slot6, slot5.object)
				end
			end
		end
	end

	slot1 = false

	for slot5, slot6 in pairs(slot0._toDeleteTweenIdDict) do
		slot0._tweenParamDict[slot5] = nil
		slot1 = true
	end

	if slot1 then
		slot0._toDeleteTweenIdDict = {}
	end
end

function slot0.getFloat(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot4 < 0 then
		return slot1
	elseif slot3 < slot4 then
		return slot2
	end

	if slot5 then
		return LuaTween.tween(slot4, slot1, slot2 - slot1, slot3, slot5)
	else
		slot6 = slot4 / slot3

		return slot1 * (1 - slot6) + slot2 * slot6
	end
end

function slot0.onSceneClose(slot0)
	slot0._initialized = false

	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)

	slot0._tweenId = 0
	slot0._tweenParamDict = {}
	slot0._toDeleteTweenIdDict = {}
	slot0._initialized = false
end

return slot0
