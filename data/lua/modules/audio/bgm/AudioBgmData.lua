module("modules.audio.bgm.AudioBgmData", package.seeall)

slot0 = class("AudioBgmData")

function slot0.ctor(slot0)
	slot0.layer = nil

	slot0:clear()
end

function slot0.clear(slot0)
	slot0.playId = 0
	slot0.stopId = 0
	slot0.pauseId = nil
	slot0.resumeId = nil
	slot0.switchGroup = nil
	slot0.switchState = nil
end

function slot0.setSwitch(slot0)
	if slot0.switchGroup and slot0.switchState then
		AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(slot0.switchGroup), AudioMgr.instance:getIdFromString(slot0.switchState))
	end
end

return slot0
