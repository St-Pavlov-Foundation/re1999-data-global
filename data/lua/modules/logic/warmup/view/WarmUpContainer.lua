-- chunkname: @modules/logic/warmup/view/WarmUpContainer.lua

module("modules.logic.warmup.view.WarmUpContainer", package.seeall)

local WarmUpContainer = class("WarmUpContainer", Activity125WarmUpViewBaseContainer)
local StateEpisode = {
	Done = 1999,
	None = 0
}
local kResNameFormat = "warmup_shiban0%s"

function WarmUpContainer:getImgResUrl(i)
	local resName = string.format(kResNameFormat, i)

	return ResUrl.getWarmUpSingleBg(resName)
end

function WarmUpContainer:buildViews()
	self._warmUp = WarmUp.New()
	self._warmUpLeftView = WarmUpLeftView.New()

	return {
		self._warmUp,
		self._warmUpLeftView
	}
end

function WarmUpContainer:onContainerInit()
	self._needWaitCount = 0
	self.__isWaitingPlayHasGetAnim = false

	WarmUpContainer.super.onContainerInit(self)

	self._tweenSwitchContext = {
		lastEpisode = false,
		curEpisodeId = false
	}
end

function WarmUpContainer:onContainerOpen()
	self._warmUp:setBlock_scroll(false)
	WarmUpContainer.super.onContainerOpen(self)

	if self._needWaitCount > 0 then
		self:tryTweenDesc()
	end
end

function WarmUpContainer:onContainerClose()
	UIBlockMgrExtend.setNeedCircleMv(true)
	WarmUpContainer.super.onContainerClose(self)
end

function WarmUpContainer:onContainerDestroy()
	self:setCurSelectEpisodeIdSlient(nil)

	self._needWaitCount = 0
	self._isPlaying = false

	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	WarmUpContainer.super:onContainerDestroy()
end

function WarmUpContainer:onContainerCloseFinish()
	self:_play_stop_UI_Bus()
end

function WarmUpContainer:onDataUpdateFirst()
	self._warmUp:onDataUpdateFirst()
	self._warmUpLeftView:onDataUpdateFirst()
end

function WarmUpContainer:onDataUpdate()
	self._warmUp:onDataUpdate()
	self._warmUpLeftView:onDataUpdate()
end

function WarmUpContainer:onDataUpdateDoneFirst()
	self:tryTweenDesc()
end

function WarmUpContainer:onSwitchEpisode()
	self.__isWaitingPlayHasGetAnim = false

	self:_play_stop_UI_Bus()
	self._warmUp:setBlock_scroll(false)
	self._warmUp:onSwitchEpisode()
	self._warmUpLeftView:onSwitchEpisode()
end

function WarmUpContainer:onUpdateActivity()
	if self._isPlaying then
		self:setLocalIsPlayCur()
		self._warmUp:onUpdateActivity()

		self._isPlaying = false
	end
end

function WarmUpContainer:episode2Index(episodeId)
	return self._warmUp:episode2Index(episodeId)
end

function WarmUpContainer:switchTabWithAnim(lastEpisode, curEpisodeId)
	if self._tweenSwitchContext.lastEpisode then
		return
	end

	if not curEpisodeId then
		self._tweenSwitchContext.lastEpisode = false
		self._tweenSwitchContext.curEpisodeId = false

		return
	end

	self._isPlaying = false
	self._tweenSwitchContext.lastEpisode = lastEpisode
	self._tweenSwitchContext.curEpisodeId = curEpisodeId

	self._warmUp:tweenSwitch(function()
		self._tweenSwitchContext.lastEpisode = false
	end)
end

function WarmUpContainer:switchTabNoAnim(lastEpisode, curEpisodeId)
	curEpisodeId = curEpisodeId or self._tweenSwitchContext.curEpisodeId
	self._tweenSwitchContext.lastEpisode = false
	self._tweenSwitchContext.curEpisodeId = false

	self:setCurSelectEpisodeIdSlient(curEpisodeId)
	Activity125Controller.instance:dispatchEvent(Activity125Event.SwitchEpisode)
end

function WarmUpContainer:sendFinishAct125EpisodeRequest(...)
	self.__isWaitingPlayHasGetAnim = true

	WarmUpContainer.super.sendFinishAct125EpisodeRequest(self, ...)
end

function WarmUpContainer:onCloseViewFinish(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self._warmUp:playRewardItemsHasGetAnim()

	self.__isWaitingPlayHasGetAnim = false
end

function WarmUpContainer:isWaitingPlayHasGetAnim()
	return self.__isWaitingPlayHasGetAnim
end

function WarmUpContainer:tryTweenDesc()
	self._needWaitCount = 0

	local isRecevied, localIsPlay = self:getRLOCCur()

	if isRecevied then
		return
	end

	if localIsPlay then
		return
	end

	if not self:checkIsDone() then
		return
	end

	self:setLocalIsPlayCurByUser()
	self:openDesc()
end

function WarmUpContainer:checkIsDone(episodeId)
	local isRecevied = self:getRLOCCur()

	if isRecevied then
		return true
	end

	episodeId = episodeId or self:getCurSelectedEpisode()

	return self:getState(episodeId) == StateEpisode.Done
end

function WarmUpContainer:openDesc()
	self._warmUp:setBlock_scroll(true)
	self:addNeedWaitCount()
	self._warmUp:openDesc(function()
		self._isPlaying = false

		self:onAnimDone()
		self._warmUp:setBlock_scroll(false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	end)
end

function WarmUpContainer:setNeedWaitCount(needWaitCount)
	self._needWaitCount = needWaitCount or 1
end

function WarmUpContainer:addNeedWaitCount()
	self:setNeedWaitCount(self._needWaitCount and self._needWaitCount + 1 or 1)
end

function WarmUpContainer:onAnimDone()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount > 0 then
		return
	end

	self:setLocalIsPlayCur()
	self._warmUp:_refresh()
end

local kEpisode = "Act125Episode|"

function WarmUpContainer:_getPrefsKey(episodeId)
	return self:getPrefsKeyPrefix() .. kEpisode .. tostring(episodeId)
end

function WarmUpContainer:saveState(episodeId, value)
	local key = self:_getPrefsKey(episodeId)

	self:saveInt(key, value or StateEpisode.None)
end

function WarmUpContainer:getState(episodeId, defaultValue)
	local key = self:_getPrefsKey(episodeId)

	return self:getInt(key, defaultValue or StateEpisode.None)
end

function WarmUpContainer:saveStateDone(episodeId, isDone)
	self:saveState(episodeId, isDone and StateEpisode.Done or StateEpisode.None)

	if isDone then
		self:onAnimDone()
	end
end

function WarmUpContainer:setLocalIsPlayCurByUser()
	self._isPlaying = true
end

function WarmUpContainer:_play_stop_UI_Bus()
	if not self._isPlaying then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
	end
end

return WarmUpContainer
