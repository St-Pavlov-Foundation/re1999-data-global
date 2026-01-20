-- chunkname: @modules/logic/versionactivity2_6/enter/view/VersionActivity2_6EnterBgmView.lua

module("modules.logic.versionactivity2_6.enter.view.VersionActivity2_6EnterBgmView", package.seeall)

local VersionActivity2_6EnterBgmView = class("VersionActivity2_6EnterBgmView", BaseView)

function VersionActivity2_6EnterBgmView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_6EnterBgmView:addEvents()
	self:addEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity2_6EnterBgmView:removeEvents()
	self:removeEventCb(VersionActivityBaseController.instance, VersionActivityEnterViewEvent.SelectActId, self.onSelectActId, self, LuaEventSystem.Low)
end

function VersionActivity2_6EnterBgmView:_editableInitView()
	self:initActHandle()
end

function VersionActivity2_6EnterBgmView:initActHandle()
	if not self.actHandleDict then
		self.actHandleDict = {}
	end
end

function VersionActivity2_6EnterBgmView:onOpen()
	local activitySettingList = self.viewParam.activitySettingList or {}
	local defaultIndex = VersionActivityEnterHelper.getTabIndex(activitySettingList, self.viewParam.jumpActId)
	local actSetting = activitySettingList[defaultIndex]
	local actId = VersionActivityEnterHelper.getActId(actSetting)

	self._isFirstOpenMainAct = actId == VersionActivity2_6Enum.ActivityId.Dungeon

	self:modifyBgm(actId)

	self._isFirstOpenMainAct = false
end

function VersionActivity2_6EnterBgmView:onSelectActId(actId)
	self:modifyBgm(actId)
end

function VersionActivity2_6EnterBgmView:modifyBgm(actId)
	self._isMainAct = actId == VersionActivity2_6Enum.ActivityId.Dungeon

	local delayTime = 0

	if self._isMainAct then
		AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.VersionActivity2_6Main, 0, AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)

		self.playingActId = nil
		self.bgmId = nil

		if self._isFirstOpenMainAct then
			self._isFirstOpenMainAct = false
			delayTime = 3.5

			AudioMgr.instance:trigger(AudioEnum2_6.VersionActivity2_6Enter.play_ui_jinye_open)
		else
			delayTime = 1

			AudioMgr.instance:trigger(AudioEnum2_6.VersionActivity2_6Enter.play_ui_jinye_unfold)
		end
	end

	self._actId = actId

	TaskDispatcher.cancelTask(self._doModifyBgm, self)
	TaskDispatcher.runDelay(self._doModifyBgm, self, delayTime)
end

function VersionActivity2_6EnterBgmView:_doModifyBgm()
	local modifyFunc = self.actHandleDict[self._actId] or self.defaultBgmHandle

	modifyFunc(self, self._actId)
end

function VersionActivity2_6EnterBgmView:defaultBgmHandle(actId)
	if self.playingActId == actId then
		return
	end

	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	if bgmId == 0 then
		logError("actId : " .. tostring(actId) .. " 没有配置背景音乐")

		bgmId = AudioEnum.Bgm.Act2_0DungeonBgm
	end

	if not self._isMainAct and bgmId == self.bgmId then
		return
	end

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_6Main)
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_6Main, bgmId)
end

function VersionActivity2_6EnterBgmView:onClose()
	TaskDispatcher.cancelTask(self._doModifyBgm, self)
end

function VersionActivity2_6EnterBgmView:_reactivityBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	AudioBgmManager.instance:setSwitchData(AudioBgmEnum.Layer.VersionActivity2_6Main, "music_vocal_filter", "original")
	AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.VersionActivity2_6Main, bgmId)
end

return VersionActivity2_6EnterBgmView
