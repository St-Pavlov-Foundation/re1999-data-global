module("modules.audio.AudioParam", package.seeall)

slot0 = class("AudioParam")

function slot0.ctor(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	slot0.loopNum = nil
	slot0.fadeInTime = nil
	slot0.fadeOutTime = nil
	slot0.volume = nil
	slot0.callback = nil
	slot0.callbackTarget = nil
end

return slot0
