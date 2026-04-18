-- chunkname: @modules/logic/summon/comp/SummonSpineComp.lua

module("modules.logic.summon.comp.SummonSpineComp", package.seeall)

local SummonSpineComp = class("SummonSpineComp", LuaCompBase)

function SummonSpineComp.Create(gameObj)
	local ret = MonoHelper.addNoUpdateLuaComOnceToGo(gameObj, SummonSpineComp)

	return ret
end

function SummonSpineComp:init(go)
	self._go = go
end

function SummonSpineComp:setConfig(config, hideGameObj)
	if not config or string.nilorempty(config.spinePrefab) then
		gohelper.setActive(self._go, false)

		return
	end

	gohelper.setActive(self._go, true)

	if not self._spine then
		self._spine = GuiSpine.Create(self._go, false)
	end

	self._hideGameObj = hideGameObj

	self._spine:setResPath(config.spinePrefab, self._spineLoadFinish, self)
end

function SummonSpineComp:_spineLoadFinish()
	gohelper.setActive(self._hideGameObj, false)
end

function SummonSpineComp:onDestroy()
	if self._spine then
		self._spine:onDestroy()
	end
end

return SummonSpineComp
