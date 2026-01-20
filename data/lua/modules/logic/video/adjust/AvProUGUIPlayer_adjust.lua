-- chunkname: @modules/logic/video/adjust/AvProUGUIPlayer_adjust.lua

module("modules.logic.video.adjust.AvProUGUIPlayer_adjust", package.seeall)

local AvProUGUIPlayer_adjust = class("AvProUGUIPlayer_adjust")

function AvProUGUIPlayer_adjust:Play(displayCom, filePath, isLoop, luaCb, luaCbObj)
	self._cb = luaCb
	self._cbObj = luaCbObj

	TaskDispatcher.runDelay(self._finishedPlaying, self, 2)
end

function AvProUGUIPlayer_adjust:_finishedPlaying()
	if self._cb then
		self._cb(self._cbObj, "", AvProEnum.PlayerStatus.FinishedPlaying, 0)
	end
end

function AvProUGUIPlayer_adjust:AddDisplayUGUI()
	return
end

function AvProUGUIPlayer_adjust:SetEventListener()
	return
end

function AvProUGUIPlayer_adjust:LoadMedia()
	return
end

function AvProUGUIPlayer_adjust:Stop()
	return
end

function AvProUGUIPlayer_adjust:Clear()
	self._cb = nil
	self._cbObj = nil

	TaskDispatcher.cancelTask(self._finishedPlaying)
end

function AvProUGUIPlayer_adjust:IsPlaying()
	return false
end

function AvProUGUIPlayer_adjust:CanPlay()
	return false
end

function AvProUGUIPlayer_adjust:Rewind()
	return
end

AvProUGUIPlayer_adjust.instance = AvProUGUIPlayer_adjust.New()

return AvProUGUIPlayer_adjust
