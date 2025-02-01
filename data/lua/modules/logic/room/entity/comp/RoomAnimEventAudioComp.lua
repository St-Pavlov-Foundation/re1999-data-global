module("modules.logic.room.entity.comp.RoomAnimEventAudioComp", package.seeall)

slot0 = class("RoomAnimEventAudioComp", LuaCompBase)
slot0.AUDIO_MAX = 4

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0.__willDestroy = false
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._effectKey = RoomEnum.EffectKey.BuildingGOKey
	slot0._eventPrefix = "audio_"
	slot0._configName = "room_building"

	if slot0:getMO() and slot2.config and not string.nilorempty(slot2.config.audioExtendIds) then
		slot0._audioExtendIds = string.splitToNumber(slot2.config.audioExtendIds, "#")
	end
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

function slot0.setConfigName(slot0, slot1)
	slot0._configName = slot1
end

function slot0.setEffectKey(slot0, slot1)
	if slot0._effectKey ~= slot1 then
		slot0._effectKey = slot1

		slot0:_removeAnimEvent()
	end
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	slot0:removeEventListeners()
	slot0:_removeAnimEvent()
end

function slot0._onAnimEvent_1(slot0)
	slot0:_playAudio(1)
end

function slot0._onAnimEvent_2(slot0)
	slot0:_playAudio(2)
end

function slot0._onAnimEvent_3(slot0)
	slot0:_playAudio(3)
end

function slot0._onAnimEvent_4(slot0)
	slot0:_playAudio(4)
end

function slot0._playAudio(slot0, slot1)
	if slot0.__willDestroy or slot0._audioExtendIds == nil then
		return
	end

	if slot0._audioExtendIds[slot1] == nil then
		logNormal(string.format("RoomAnimEventAudioComp 请检\"%s\"表中\"audioExtendIds\"配置的音效数量不足。当前第%s个", slot0._configName, slot1))
	elseif slot2 ~= 0 then
		RoomHelper.audioExtendTrigger(slot2, slot0.go)
	end
end

function slot0._addAnimEvent(slot0)
	if slot0.__willDestroy then
		return
	end

	if slot0._animEventMonoList or not slot0.effect:isHasEffectGOByKey(slot0._effectKey) then
		return
	end

	if not slot0.effect:getComponentsByKey(slot0._effectKey, RoomEnum.ComponentName.AnimationEventWrap) then
		return
	end

	slot0._animEventMonoList = {}

	tabletool.addValues(slot0._animEventMonoList, slot1)

	for slot5, slot6 in ipairs(slot0._animEventMonoList) do
		for slot10 = 1, uv0.AUDIO_MAX do
			if slot0["_onAnimEvent_" .. slot10] then
				slot6:AddEventListener(slot0._eventPrefix .. slot10, slot12, slot0)
			else
				logError("RoomAnimEventAudioComp can not find function name is:" .. slot11)

				break
			end
		end
	end
end

function slot0._removeAnimEvent(slot0)
	if slot0._animEventMonoList then
		slot0._animEventMonoList = nil

		for slot5, slot6 in ipairs(slot0._animEventMonoList) do
			slot6:RemoveAllEventListener()
		end

		for slot5 in pairs(slot1) do
			rawset(slot1, slot5, nil)
		end
	end
end

function slot0.onEffectRebuild(slot0)
	if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) and not slot1:isSameResByKey(slot0._effectKey, slot0._effectRes) then
		slot0._effectRes = slot1:getEffectRes(slot0._effectKey)

		slot0:_removeAnimEvent()
		slot0:_addAnimEvent()
	end
end

function slot0.onEffectReturn(slot0, slot1, slot2)
	if slot0._effectKey == slot1 then
		slot0:_removeAnimEvent()
	end
end

return slot0
