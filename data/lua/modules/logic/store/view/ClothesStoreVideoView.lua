-- chunkname: @modules/logic/store/view/ClothesStoreVideoView.lua

module("modules.logic.store.view.ClothesStoreVideoView", package.seeall)

local ClothesStoreVideoView = class("ClothesStoreVideoView", BaseView)

function ClothesStoreVideoView:onInitView()
	self._videoRoot = gohelper.findChild(self.viewGO, "#go_has/character/bg/video/videoRoot")
	self._videoGO = gohelper.findChild(self._videoRoot, "#go_video")
	self.viewCanvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
end

function ClothesStoreVideoView:addEvents()
	self:addEventCb(StoreController.instance, StoreEvent.OnPlaySkinVideo, self._onPlaySkinVideo, self)
	self:addEventCb(StoreController.instance, StoreEvent.OnCheckHideSkinVideo, self._onCheckHideSkillVideo, self)
end

function ClothesStoreVideoView:removeEvents()
	self:removeEventCb(StoreController.instance, StoreEvent.OnPlaySkinVideo, self._onPlaySkinVideo, self)
	self:removeEventCb(StoreController.instance, StoreEvent.OnCheckHideSkinVideo, self._onCheckHideSkillVideo, self)
end

function ClothesStoreVideoView:_onPlaySkinVideo(goodsMo)
	self:playSkinVideo(goodsMo)
end

function ClothesStoreVideoView:_onCheckHideSkillVideo(goodsId)
	if goodsId ~= self._curPlayGoodsId and self._curPlayGoodsId ~= nil then
		self:_playMovieFinish()
	end
end

function ClothesStoreVideoView:onOpen()
	return
end

function ClothesStoreVideoView:playSkinVideo(goodsMo)
	self._curPlayGoodsId = nil

	if not goodsMo then
		self:_stopMovie()

		return
	end

	local product = goodsMo.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]
	local skinViewCfg = lua_character_limited.configDict[skinId]

	if not skinViewCfg or VersionValidator.instance:isInReviewing() then
		return
	end

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end

	self._hasPlayFinish = false

	NavigateMgr.instance:addEscape(self.viewName, self._onEscBtnClick, self)

	self._videoAudioId = skinViewCfg.audio
	self._stopAudioId = skinViewCfg.stopAudio
	self._stopBgm = self._videoAudioId > 0
	self._videoPath = string.nilorempty(skinViewCfg.entranceMv) and "" or skinViewCfg.entranceMv
	self._mvTime = skinViewCfg.mvtime

	if self._stopBgm then
		self:_stopMainBgm()
		TaskDispatcher.runDelay(self._stopMainBgm, self, 0.5)
	end

	gohelper.setActive(self._videoRoot, true)

	if not string.nilorempty(self._videoPath) then
		if not self._videoPlayer then
			self._videoPlayer, self._videoPlayerGO = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._videoGO)

			local uiVideoAdapter = MonoHelper.addNoUpdateLuaComOnceToGo(self._videoPlayerGO, FullScreenVideoAdapter)

			self._videoPlayerGO = nil
		end

		self._curPlayGoodsId = goodsMo.goodsId

		self._videoPlayer:play(self._videoPath, false, self._videoStatusUpdate, self)

		if self._mvTime and self._mvTime > 0 then
			TaskDispatcher.runDelay(self._timeout, self, self._mvTime)
		end
	else
		TaskDispatcher.runDelay(self._hideVideoGo, self, 1)
	end
end

function ClothesStoreVideoView:onClose()
	self:_stopMovie()
end

function ClothesStoreVideoView:_onEscBtnClick()
	return
end

function ClothesStoreVideoView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.FinishedPlaying then
		TaskDispatcher.cancelTask(self._timeout, self)
		self:_playMovieFinish()
	end

	if status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.StartedSeeking then
		if self._videoAudioId > 0 then
			AudioMgr.instance:trigger(self._videoAudioId)
		end

		self.viewCanvasGroup.alpha = 1
	end
end

function ClothesStoreVideoView:_timeout()
	self:_stopMovie()
end

function ClothesStoreVideoView:_stopMovie()
	NavigateMgr.instance:removeEscape(self.viewName)
	self:_hideVideoGo()

	if self._videoPlayer then
		self._videoPlayer:stop()

		self._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(self._timeout, self)

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end

	self:_playMainBgm()
end

function ClothesStoreVideoView:_playMovieFinish()
	self._hasPlayFinish = true
	self._curPlayGoodsId = nil

	self:_hideVideoGo()
	NavigateMgr.instance:removeEscape(self.viewName)

	if self._stopAudioId and self._stopAudioId > 0 then
		AudioMgr.instance:trigger(self._stopAudioId)
	end

	self:_playMainBgm()
	ViewMgr.instance:closeView(ViewName.StoreSkinDefaultShowView)
end

function ClothesStoreVideoView:_playMainBgm()
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
	end
end

function ClothesStoreVideoView:_stopMainBgm()
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
	end
end

function ClothesStoreVideoView:_hideVideoGo()
	gohelper.setActive(self._videoRoot, false)
end

return ClothesStoreVideoView
