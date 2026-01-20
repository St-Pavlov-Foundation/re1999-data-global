-- chunkname: @modules/logic/rouge/define/RougeBaseDLCViewComp.lua

module("modules.logic.rouge.define.RougeBaseDLCViewComp", package.seeall)

local RougeBaseDLCViewComp = class("RougeBaseDLCViewComp", BaseViewExtended)

function RougeBaseDLCViewComp:_updateVersion()
	local season = self:getSeason()
	local versions = self:getVersions()

	self:killAllChildView()

	for _, version in pairs(versions or {}) do
		local clsName = string.format("%s_%s_%s", self.viewName, season, version)
		local cls = _G[clsName]

		if cls then
			local subViewGO = cls.AssetUrl or self.viewGO
			local goParent = gohelper.findChild(self.viewGO, cls.ParentObjPath or "") or self.viewGO

			self:openSubView(cls, subViewGO, goParent, self.viewParam)
		end
	end
end

function RougeBaseDLCViewComp:onOpen()
	self:addEventCb(RougeDLCController.instance, RougeEvent.UpdateRougeVersion, self._updateVersion, self)
	self:_updateVersion()
end

function RougeBaseDLCViewComp:getSeason()
	return RougeOutsideModel.instance:season()
end

function RougeBaseDLCViewComp:getVersions()
	local gameRecordInfo = RougeOutsideModel.instance:getRougeGameRecord()
	local versions = gameRecordInfo and gameRecordInfo:getVersionIds()

	return versions
end

return RougeBaseDLCViewComp
