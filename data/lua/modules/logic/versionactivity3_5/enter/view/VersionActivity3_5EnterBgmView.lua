-- chunkname: @modules/logic/versionactivity3_5/enter/view/VersionActivity3_5EnterBgmView.lua

module("modules.logic.versionactivity3_5.enter.view.VersionActivity3_5EnterBgmView", package.seeall)

local VersionActivity3_5EnterBgmView = class("VersionActivity3_5EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity3_5EnterBgmView:initActHandle()
	if not self.actHandleDict then
		self.actHandleDict = {
			[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle,
			[VersionActivity3_5Enum.ActivityId.AutoChess] = self._autochessBgmHandle
		}
	end
end

function VersionActivity3_5EnterBgmView:_autochessBgmHandle(actId)
	self.playingActId = actId

	local bgmId = ActivityConfig.instance:getActivityEnterViewBgm(actId)

	self.bgmId = bgmId

	local bgmLayer = VersionActivityFixedHelper.getVersionActivityAudioBgmLayer()

	AudioBgmManager.instance:setSwitchData(bgmLayer, "autochess", "prepare")
	AudioBgmManager.instance:modifyBgmAudioId(bgmLayer, bgmId)
end

return VersionActivity3_5EnterBgmView
