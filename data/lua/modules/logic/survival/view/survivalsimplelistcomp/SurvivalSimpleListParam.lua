-- chunkname: @modules/logic/survival/view/survivalsimplelistcomp/SurvivalSimpleListParam.lua

module("modules.logic.survival.view.survivalsimplelistcomp.SurvivalSimpleListParam", package.seeall)

local SurvivalSimpleListParam = pureTable("SurvivalSimpleListParam")

function SurvivalSimpleListParam:ctor()
	self.cellClass = nil
	self.lineCount = 1
	self.cellWidth = 100
	self.cellHeight = 100
	self.cellSpaceH = 0
	self.cellSpaceV = 0
	self.startSpace = 0
	self.endSpace = 0
	self.sortMode = ScrollEnum.ScrollSortNone
	self.frameUpdateMs = 10
	self.minUpdateCountInFrame = 1
end

return SurvivalSimpleListParam
