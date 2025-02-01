module("modules.logic.room.entity.work.RoomAtmosphereEffectWork", package.seeall)

slot0 = class("RoomAtmosphereEffectWork", BaseWork)
slot1 = 0.3

function slot0.ctor(slot0, slot1, slot2)
	slot0._effectId = slot1
	slot0._effResPath = RoomConfig.instance:getRoomEffectPath(slot1)
	slot3 = nil

	if not GameResMgr.IsFromEditorDir then
		slot3 = FightHelper.getEffectAbPath(slot0._effResPath)
	end

	slot0._effGO = RoomGOPool.getInstance(slot0._effResPath, slot2, "effect_" .. slot1, slot3)
	slot0._playingId = nil
	slot0._tmpAudioId = nil

	gohelper.setActive(slot0._effGO, false)
end

function slot0.onStart(slot0)
	gohelper.setActive(slot0._effGO, false)
	gohelper.setActive(slot0._effGO, true)

	if RoomConfig.instance:getRoomEffectDuration(slot0._effectId) <= 0 then
		slot0:finish(true)
	else
		if RoomConfig.instance:getRoomEffectAudioId(slot0._effectId) and slot2 ~= 0 and not gohelper.isNil(slot0._effGO) then
			slot0._tmpAudioId = slot2

			TaskDispatcher.runDelay(slot0.delayPlayAudio, slot0, uv0)
		end

		TaskDispatcher.runDelay(slot0.finish, slot0, slot1)
	end
end

function slot0.delayPlayAudio(slot0)
	slot0._playingId = AudioMgr.instance:trigger(slot0._tmpAudioId, slot0._effGO)
	slot0._tmpAudioId = nil
end

function slot0.setAudioIsFade(slot0, slot1)
	if gohelper.isNil(slot0._effGO) then
		return
	end

	slot2 = AudioEnum.Room.set_firework_normal

	if slot1 then
		slot2 = AudioEnum.Room.set_firework_lower
	end

	AudioMgr.instance:trigger(slot2, slot0._effGO)
end

function slot0.finish(slot0, slot1)
	slot0:onDone(not slot1)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0.finish, slot0)
	TaskDispatcher.cancelTask(slot0.delayPlayAudio, slot0)

	if not gohelper.isNil(slot0._effGO) then
		gohelper.setActive(slot0._effGO, false)
		AudioMgr.instance:trigger(AudioEnum.Room.stop_home_activity_firework, slot0._effGO)
	elseif slot0._playingId then
		AudioMgr.instance:stopPlayingID(slot0._playingId)

		slot0._playingId = nil
	end
end

function slot0.onDestroy(slot0)
	slot0:clearWork()
	RoomGOPool.returnInstance(slot0._effResPath, slot0._effGO)

	slot0._effGO = nil
	slot0._effectId = nil
	slot0._effResPath = nil
	slot0._tmpAudioId = nil
end

return slot0
