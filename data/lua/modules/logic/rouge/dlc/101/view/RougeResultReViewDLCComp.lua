-- chunkname: @modules/logic/rouge/dlc/101/view/RougeResultReViewDLCComp.lua

module("modules.logic.rouge.dlc.101.view.RougeResultReViewDLCComp", package.seeall)

local RougeResultReViewDLCComp = class("RougeResultReViewDLCComp", RougeBaseDLCViewComp)

function RougeResultReViewDLCComp:getSeason()
	local reviewInfo = self.viewParam and self.viewParam.reviewInfo

	return reviewInfo and reviewInfo.season
end

function RougeResultReViewDLCComp:getVersions()
	local reviewInfo = self.viewParam and self.viewParam.reviewInfo

	return reviewInfo and reviewInfo:getVersions()
end

return RougeResultReViewDLCComp
