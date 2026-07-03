-- chunkname: @modules/logic/versionactivity3_6/enter/view/VersionActivity3_6EnterBgmView.lua

module("modules.logic.versionactivity3_6.enter.view.VersionActivity3_6EnterBgmView", package.seeall)

local VersionActivity3_6EnterBgmView = class("VersionActivity3_6EnterBgmView", VersionActivityFixedEnterBgmView)

function VersionActivity3_6EnterBgmView:initActHandle()
	if not self.actHandleDict then
		self.actHandleDict = {
			[BossRushConfig.instance:getActivityId()] = self._bossrushBgmHandle
		}
	end
end

return VersionActivity3_6EnterBgmView
