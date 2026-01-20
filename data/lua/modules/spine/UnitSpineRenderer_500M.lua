-- chunkname: @modules/spine/UnitSpineRenderer_500M.lua

module("modules.spine.UnitSpineRenderer_500M", package.seeall)

local UnitSpineRenderer_500M = class("UnitSpineRenderer_500M", LuaCompBase)

function UnitSpineRenderer_500M:ctor(entity)
	self._entity = entity
end

function UnitSpineRenderer_500M:init(go)
	self.go = go
end

function UnitSpineRenderer_500M:setSpine(unitSpine)
	if not self.centerSpineRender then
		self.centerSpineRender = MonoHelper.addLuaComOnceToGo(unitSpine.centerSpine:getSpineGO(), UnitSpineRenderer, self._entity)
	end

	self.centerSpineRender:setSpine(unitSpine.centerSpine)

	if not self.frontSpineRender then
		self.frontSpineRender = MonoHelper.addLuaComOnceToGo(unitSpine.frontSpine:getSpineGO(), UnitSpineRenderer, self._entity)
	end

	self.frontSpineRender:setSpine(unitSpine.frontSpine)

	if not self.behindSpineRender then
		self.behindSpineRender = MonoHelper.addLuaComOnceToGo(unitSpine.behindSpine:getSpineGO(), UnitSpineRenderer, self._entity)
	end

	self.behindSpineRender:setSpine(unitSpine.behindSpine)
end

function UnitSpineRenderer_500M:getReplaceMat()
	if self.centerSpineRender then
		return self.centerSpineRender:getReplaceMat()
	end
end

function UnitSpineRenderer_500M:getCloneOriginMat()
	if self.centerSpineRender then
		return self.centerSpineRender:getCloneOriginMat()
	end
end

function UnitSpineRenderer_500M:getSpineRenderMat()
	if self.centerSpineRender then
		return self.centerSpineRender:getSpineRenderMat()
	end
end

function UnitSpineRenderer_500M:_setReplaceMat(originMat, replaceMat)
	return
end

function UnitSpineRenderer_500M:replaceSpineMat(mat)
	if self.centerSpineRender then
		self.centerSpineRender:replaceSpineMat(mat)
	end
end

function UnitSpineRenderer_500M:resetSpineMat()
	if self.frontSpineRender then
		self.frontSpineRender:resetSpineMat()
	end
end

function UnitSpineRenderer_500M:setAlpha(alpha, duration)
	self:callFunc("setAlpha", alpha, duration)
end

function UnitSpineRenderer_500M:setColor(color)
	self:callFunc("setColor", color)
end

function UnitSpineRenderer_500M:_frameCallback(alpha)
	return
end

function UnitSpineRenderer_500M:_finishCallback()
	return
end

function UnitSpineRenderer_500M:_stopAlphaTween()
	return
end

function UnitSpineRenderer_500M:_setRendererEnabled(state)
	return
end

function UnitSpineRenderer_500M:onDestroy()
	return
end

function UnitSpineRenderer_500M:callFunc(funcName, ...)
	if self.frontSpineRender then
		local func = self.frontSpineRender[funcName]

		if func then
			func(self.frontSpineRender, ...)
		else
			logError("not found func int frontSpineRender : " .. tostring(funcName))
		end
	end

	if self.behindSpineRender then
		local func = self.behindSpineRender[funcName]

		if func then
			func(self.behindSpineRender, ...)
		else
			logError("not found func int behindSpineRender : " .. tostring(funcName))
		end
	end

	if self.centerSpineRender then
		local func = self.centerSpineRender[funcName]

		if func then
			return func(self.centerSpineRender, ...)
		else
			logError("not found func int centerSpineRender : " .. tostring(funcName))
		end
	end
end

return UnitSpineRenderer_500M
