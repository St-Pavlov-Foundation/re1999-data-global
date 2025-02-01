module("modules.common.gc.GameGCMgr", package.seeall)

slot0 = class("GameGCMgr")

function slot0.ctor(slot0)
	LuaEventSystem.addEventMechanism(slot0)

	slot0.minInterval = 2
	slot0.minAudioGcInterval = 2
end

function slot0.init(slot0)
	slot0:addGCEvent()
end

function slot0.addGCEvent(slot0)
	slot0:registerCallback(GameGCEvent.FullGC, slot0._fullGC, slot0)
	slot0:registerCallback(GameGCEvent.DelayFullGC, slot0._delayFullGC, slot0)
	slot0:registerCallback(GameGCEvent.ResGC, slot0._resGC, slot0)
	slot0:registerCallback(GameGCEvent.CancelDelayFullGC, slot0._cancelDelayFullGC, slot0)
	slot0:registerCallback(GameGCEvent.StoryGC, slot0._storyGC, slot0)
	slot0:registerCallback(GameGCEvent.AudioGC, slot0._audioGC, slot0)
	slot0:registerCallback(GameGCEvent.DelayAudioGC, slot0._delayAudioGC, slot0)
	slot0:registerCallback(GameGCEvent.CancelDelayAudioGC, slot0._cancelDelayAudioGC, slot0)
end

function slot0._fullGC(slot0, slot1)
	if slot0.lastCgTime and UnityEngine.Time.realtimeSinceStartup - slot0.lastCgTime < slot0.minInterval then
		logNormal("GameGCMgr._fullGC, interval less than " .. slot0.minInterval .. "s, cancel this gc call !!")

		return
	end

	if slot1 then
		logNormal("GameGCMgr FullGC Called By " .. slot1.__cname)
	else
		logNormal("GameGCMgr FullGC !")
	end

	slot0.lastCgTime = UnityEngine.Time.realtimeSinceStartup

	SLFramework.UnityHelper.LuaGC()
	slot0:_resGC(slot1)
	slot0:dispatchEvent(GameGCEvent.OnFullGC)
end

function slot0._storyGC(slot0, slot1)
	if slot1 then
		logNormal("GameGCMgr StoryGC Called By " .. slot1.__cname)
	else
		logNormal("GameGCMgr StoryGC !")
	end

	SLFramework.UnityHelper.LuaGC()
	PostProcessingMgr.instance:ClearPPRenderRts()
	slot0:_tryDispose()
	SLFramework.UnityHelper.ResGC()
end

function slot0._audioGC(slot0, slot1)
	if slot0._audioLastGcTime and UnityEngine.Time.realtimeSinceStartup - slot0._audioLastGcTime < slot0.minAudioGcInterval then
		logNormal("GameGCMgr._audioGC, interval less than " .. slot0.minAudioGcInterval .. "s, cancel this audio gc call !!")

		return
	end

	if slot1 then
		logNormal("GameGCMgr AudioGC Called By " .. slot1.__cname)
	else
		logNormal("GameGCMgr AudioGC !")
	end

	slot0._audioLastGcTime = UnityEngine.Time.realtimeSinceStartup

	AudioMgr.instance:clearUnusedBanks()
end

function slot0._resGC(slot0, slot1)
	if slot1 then
		logNormal("GameGCMgr ResGC Called By " .. slot1.__cname)
	else
		logNormal("GameGCMgr ResGC !")
	end

	AudioMgr.instance:clearUnusedBanks()
	PostProcessingMgr.instance:ClearPPRenderRts()
	slot0:_tryDispose()
	SLFramework.UnityHelper.ResGC()
end

function slot0._tryDispose(slot0)
	logNormal("GameGCMgr TryDispose!")
	UISpriteSetMgr.instance:tryDispose()
	LuaMonoContainer.tryDispose()
	LuaNoUpdateMonoContainer.tryDispose()
end

function slot0._delayFullGC(slot0, slot1, slot2)
	if slot2 then
		logNormal("GameGCMgr DelayFullGC In " .. slot1 .. " Second By " .. slot2.__cname)
	else
		logNormal("GameGCMgr DelayFullGC In " .. slot1 .. " Second")
	end

	TaskDispatcher.cancelTask(slot0._fullGC, slot0)
	TaskDispatcher.runDelay(slot0._fullGC, slot0, slot1)
end

function slot0._cancelDelayFullGC(slot0)
	logNormal("GameGCMgr CancelDelayFullGC !")
	TaskDispatcher.cancelTask(slot0._fullGC, slot0)
end

function slot0._delayAudioGC(slot0, slot1, slot2)
	if slot2 then
		logNormal("GameGCMgr._delayAudioGC In " .. slot1 .. " Second By " .. slot2.__cname)
	else
		logNormal("GameGCMgr._delayAudioGC In " .. slot1 .. " Second")
	end

	TaskDispatcher.cancelTask(slot0._audioGC, slot0)
	TaskDispatcher.runDelay(slot0._audioGC, slot0, slot1)
end

function slot0._cancelDelayAudioGC(slot0)
	logNormal("GameGCMgr._cancelDelayAudioGC !")
	TaskDispatcher.cancelTask(slot0._audioGC, slot0)
end

slot0.instance = slot0.New()

return slot0
