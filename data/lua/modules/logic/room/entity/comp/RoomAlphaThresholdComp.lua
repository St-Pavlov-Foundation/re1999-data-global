module("modules.logic.room.entity.comp.RoomAlphaThresholdComp", package.seeall)

slot0 = class("RoomAlphaThresholdComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectKey = RoomEnum.EffectKey.BuildingGOKey
	slot0.__willDestroy = false
	slot0._tweenAlphaParams = {}
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.setEffectKey(slot0, slot1)
	slot0._effectKey = slot1
end

function slot0.tweenAlphaThreshold(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.__willDestroy then
		return
	end

	slot0._tweenAlphaParams.hasWaitRun = true
	slot0._tweenAlphaParams.form = slot1
	slot0._tweenAlphaParams.to = slot2
	slot0._tweenAlphaParams.duration = slot3
	slot0._finishCb = slot4
	slot0._finishCbObj = slot5
	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0:_runTweenAlpha()
end

function slot0._runTweenAlpha(slot0)
	if slot0._tweenAlphaParams.hasWaitRun then
		slot0._tweenAlphaParams.hasWaitRun = false

		slot0:_killTweenAlpha()

		if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) then
			slot0._tweenAlphaId = slot0._scene.tween:tweenFloat(0, 1, slot0._tweenAlphaParams.duration, slot0._frameAlphaCallback, slot0._finishAlphaTween, slot0, slot0._tweenAlphaParams)
		end
	end
end

function slot0._killTweenAlpha(slot0)
	if slot0._tweenAlphaId then
		if slot0._scene and slot0._scene.tween then
			slot0._scene.tween:killById(slot0._tweenAlphaId)
		end

		slot0._tweenAlphaId = nil
	end
end

function slot0._frameAlphaCallback(slot0, slot1, slot2)
	slot0.entity.effect:setMPB(slot0._effectKey, false, slot2.form + (slot2.to - slot2.form) * slot1 > 0.01, slot3)
end

function slot0._finishAlphaTween(slot0)
	if slot0.__willDestroy or not slot0._finishCb then
		return
	end

	slot0._tweenAlphaId = nil

	slot0._finishCb(slot0._finishCbObj)

	slot0._finishCb = nil
	slot0._finishCbObj = nil
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	slot0:_killTweenAlpha()

	slot0._finishCb = nil
	slot0._finishCbObj = nil
end

function slot0.onEffectReturn(slot0, slot1, slot2)
	if slot0._tweenAlphaId and slot1 == slot0._effectKey then
		slot0.entity.effect:setMPB(slot0._effectKey, false, false, 0)
	end
end

return slot0
