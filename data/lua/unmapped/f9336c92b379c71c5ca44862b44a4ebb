module("projbooter.audio.BootAudioMgr", package.seeall)

slot0 = class("BootAudioMgr")

function slot0.ctor(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0.csharpInst = ZProj.AudioManager.Instance

	slot0.csharpInst:BootInit(slot1, slot2)
end

function slot0._onInited(slot0)
	logNormal("BootAudioMgr._onInited -----------")
end

function slot0.dispose(slot0)
	slot0.csharpInst:BootDispose()
end

function slot0.trigger(slot0, slot1, slot2)
	slot0.csharpInst:TriggerEvent(slot1, slot2)
end

slot0.instance = slot0.New()

return slot0
