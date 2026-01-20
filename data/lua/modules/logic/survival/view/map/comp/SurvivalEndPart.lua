-- chunkname: @modules/logic/survival/view/map/comp/SurvivalEndPart.lua

module("modules.logic.survival.view.map.comp.SurvivalEndPart", package.seeall)

local SurvivalEndPart = class("SurvivalEndPart", LuaCompBase)

function SurvivalEndPart:ctor(param)
	self.view = param.view
end

function SurvivalEndPart:init(go)
	self.go = go
	self.goDefaultBg = gohelper.findChild(go, "#simage_FullBG")
	self.txtDefaultTime = gohelper.findChildTextMesh(self.goDefaultBg, "image_LimitTimeBG/#txt_LimitTime")
	self.goEndBg = gohelper.findChild(go, "#simage_FullBG2")
	self.txtEndTime = gohelper.findChildTextMesh(self.goEndBg, "image_LimitTimeBG/#txt_LimitTime")
	self.goSpecialBg = gohelper.findChild(self.goEndBg, "#go_babieta")
end

function SurvivalEndPart:refreshView()
	local isFail = self:isFailEnd()

	gohelper.setActive(self.goDefaultBg, isFail)
	gohelper.setActive(self.goEndBg, not isFail)

	if not isFail then
		self.view._txtLimitTime = self.txtEndTime

		local isSpecial = self:isSpecialEnd()

		gohelper.setActive(self.goSpecialBg, isSpecial)
	else
		self.view._txtLimitTime = self.txtDefaultTime
	end
end

function SurvivalEndPart:isFailEnd()
	local endConfig = self:getEndConfig()

	return not endConfig or endConfig.type == 1
end

function SurvivalEndPart:isSpecialEnd()
	local endConfig = self:getEndConfig()

	return endConfig and endConfig.type == 3
end

function SurvivalEndPart:getEndConfig()
	local outSideInfo = SurvivalModel.instance:getOutSideInfo()
	local endId = outSideInfo and outSideInfo:getEndId() or 0
	local endConfig = lua_survival_end.configDict[endId]

	return endConfig
end

function SurvivalEndPart:onDestroy()
	return
end

return SurvivalEndPart
