-- chunkname: @modules/logic/activity/view/VersionSummonFull_Part2.lua

module("modules.logic.activity.view.VersionSummonFull_Part2", package.seeall)

local VersionSummonFull_Part2 = class("VersionSummonFull_Part2", VersionSummonFull)

function VersionSummonFull_Part2:_editableInitView()
	self._simageRole:LoadImage(ResUrl.getVersionSummonSingleBg("versionsummon_rolefull_2"))
	self._simageTitle:LoadImage(ResUrl.getVersionSummonSingleBgLang("versionsummon_txt_2"))

	self._txtTips.text = luaLang("versionsummon_txt_tips2")
end

return VersionSummonFull_Part2
