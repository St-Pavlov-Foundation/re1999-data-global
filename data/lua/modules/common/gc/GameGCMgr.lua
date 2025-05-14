module("modules.common.gc.GameGCMgr", package.seeall)

local var_0_0 = class("GameGCMgr")

function var_0_0.ctor(arg_1_0)
	LuaEventSystem.addEventMechanism(arg_1_0)

	arg_1_0.minInterval = 2
	arg_1_0.minAudioGcInterval = 2
end

function var_0_0.init(arg_2_0)
	arg_2_0:addGCEvent()
end

function var_0_0.addGCEvent(arg_3_0)
	arg_3_0:registerCallback(GameGCEvent.FullGC, arg_3_0._fullGC, arg_3_0)
	arg_3_0:registerCallback(GameGCEvent.DelayFullGC, arg_3_0._delayFullGC, arg_3_0)
	arg_3_0:registerCallback(GameGCEvent.ResGC, arg_3_0._resGC, arg_3_0)
	arg_3_0:registerCallback(GameGCEvent.CancelDelayFullGC, arg_3_0._cancelDelayFullGC, arg_3_0)
	arg_3_0:registerCallback(GameGCEvent.StoryGC, arg_3_0._storyGC, arg_3_0)
	arg_3_0:registerCallback(GameGCEvent.AudioGC, arg_3_0._audioGC, arg_3_0)
	arg_3_0:registerCallback(GameGCEvent.DelayAudioGC, arg_3_0._delayAudioGC, arg_3_0)
	arg_3_0:registerCallback(GameGCEvent.CancelDelayAudioGC, arg_3_0._cancelDelayAudioGC, arg_3_0)
end

function var_0_0._fullGC(arg_4_0, arg_4_1)
	if arg_4_0.lastCgTime and UnityEngine.Time.realtimeSinceStartup - arg_4_0.lastCgTime < arg_4_0.minInterval then
		logNormal("GameGCMgr._fullGC, interval less than " .. arg_4_0.minInterval .. "s, cancel this gc call !!")

		return
	end

	if arg_4_1 then
		logNormal("GameGCMgr FullGC Called By " .. arg_4_1.__cname)
	else
		logNormal("GameGCMgr FullGC !")
	end

	arg_4_0.lastCgTime = UnityEngine.Time.realtimeSinceStartup

	SLFramework.UnityHelper.LuaGC()
	arg_4_0:_resGC(arg_4_1)
	arg_4_0:dispatchEvent(GameGCEvent.OnFullGC)
end

function var_0_0._storyGC(arg_5_0, arg_5_1)
	if arg_5_1 then
		logNormal("GameGCMgr StoryGC Called By " .. arg_5_1.__cname)
	else
		logNormal("GameGCMgr StoryGC !")
	end

	SLFramework.UnityHelper.LuaGC()
	PostProcessingMgr.instance:ClearPPRenderRts()
	arg_5_0:_tryDispose()
	SLFramework.UnityHelper.ResGC()
end

function var_0_0._audioGC(arg_6_0, arg_6_1)
	if arg_6_0._audioLastGcTime and UnityEngine.Time.realtimeSinceStartup - arg_6_0._audioLastGcTime < arg_6_0.minAudioGcInterval then
		logNormal("GameGCMgr._audioGC, interval less than " .. arg_6_0.minAudioGcInterval .. "s, cancel this audio gc call !!")

		return
	end

	if arg_6_1 then
		logNormal("GameGCMgr AudioGC Called By " .. arg_6_1.__cname)
	else
		logNormal("GameGCMgr AudioGC !")
	end

	arg_6_0._audioLastGcTime = UnityEngine.Time.realtimeSinceStartup

	AudioMgr.instance:clearUnusedBanks()
end

function var_0_0._resGC(arg_7_0, arg_7_1)
	if arg_7_1 then
		logNormal("GameGCMgr ResGC Called By " .. arg_7_1.__cname)
	else
		logNormal("GameGCMgr ResGC !")
	end

	AudioMgr.instance:clearUnusedBanks()
	PostProcessingMgr.instance:ClearPPRenderRts()
	arg_7_0:_tryDispose()
	SLFramework.UnityHelper.ResGC()
end

function var_0_0._tryDispose(arg_8_0)
	logNormal("GameGCMgr TryDispose!")
	UISpriteSetMgr.instance:tryDispose()
	LuaMonoContainer.tryDispose()
	LuaNoUpdateMonoContainer.tryDispose()
end

function var_0_0._delayFullGC(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 then
		logNormal("GameGCMgr DelayFullGC In " .. arg_9_1 .. " Second By " .. arg_9_2.__cname)
	else
		logNormal("GameGCMgr DelayFullGC In " .. arg_9_1 .. " Second")
	end

	TaskDispatcher.cancelTask(arg_9_0._fullGC, arg_9_0)
	TaskDispatcher.runDelay(arg_9_0._fullGC, arg_9_0, arg_9_1)
end

function var_0_0._cancelDelayFullGC(arg_10_0)
	logNormal("GameGCMgr CancelDelayFullGC !")
	TaskDispatcher.cancelTask(arg_10_0._fullGC, arg_10_0)
end

function var_0_0._delayAudioGC(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 then
		logNormal("GameGCMgr._delayAudioGC In " .. arg_11_1 .. " Second By " .. arg_11_2.__cname)
	else
		logNormal("GameGCMgr._delayAudioGC In " .. arg_11_1 .. " Second")
	end

	TaskDispatcher.cancelTask(arg_11_0._audioGC, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0._audioGC, arg_11_0, arg_11_1)
end

function var_0_0._cancelDelayAudioGC(arg_12_0)
	logNormal("GameGCMgr._cancelDelayAudioGC !")
	TaskDispatcher.cancelTask(arg_12_0._audioGC, arg_12_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
