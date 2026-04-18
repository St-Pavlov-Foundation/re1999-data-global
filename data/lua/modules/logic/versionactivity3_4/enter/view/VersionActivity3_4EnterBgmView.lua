-- chunkname: @modules/logic/versionactivity3_4/enter/view/VersionActivity3_4EnterBgmView.lua

module("modules.logic.versionactivity3_4.enter.view.VersionActivity3_4EnterBgmView", package.seeall)

local VersionActivity3_4EnterBgmView = class("VersionActivity3_4EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity3_4EnterBgmView:initActHandle()
	if not self.actHandleDict then
		self.actHandleDict = {
			[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle,
			[ChgController.instance:actId()] = self._chgBgmHandle
		}
	end
end

return VersionActivity3_4EnterBgmView
