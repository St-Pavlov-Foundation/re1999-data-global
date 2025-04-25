module("modules.logic.video.adjust.AvProUGUIPlayer_adjust", package.seeall)

slot0 = class("AvProUGUIPlayer_adjust")

function slot0.Play(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._cb = slot4
	slot0._cbObj = slot5

	TaskDispatcher.runDelay(slot0._finishedPlaying, slot0, 2)
end

function slot0._finishedPlaying(slot0)
	if slot0._cb then
		slot0._cb(slot0._cbObj, "", AvProEnum.PlayerStatus.FinishedPlaying, 0)
	end
end

function slot0.AddDisplayUGUI(slot0)
end

function slot0.SetEventListener(slot0)
end

function slot0.LoadMedia(slot0)
end

function slot0.Stop(slot0)
end

function slot0.Clear(slot0)
	slot0._cb = nil
	slot0._cbObj = nil

	TaskDispatcher.cancelTask(slot0._finishedPlaying)
end

function slot0.IsPlaying(slot0)
	return false
end

function slot0.CanPlay(slot0)
	return false
end

function slot0.Rewind(slot0)
end

slot0.instance = slot0.New()

return slot0
