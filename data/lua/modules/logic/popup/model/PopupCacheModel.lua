-- chunkname: @modules/logic/popup/model/PopupCacheModel.lua

module("modules.logic.popup.model.PopupCacheModel", package.seeall)

local PopupCacheModel = class("PopupCacheModel", BaseModel)

function PopupCacheModel:onInit()
	self:clear()
	self:clearData()
end

function PopupCacheModel:reInit()
	self:clearData()
end

function PopupCacheModel:clearData()
	self._viewNameIgnoreGetProp = {}
end

function PopupCacheModel:recordCachePopupParam(param)
	self:addAtLast(param)
end

function PopupCacheModel:popNextPopupParam()
	local result = self:removeFirst()

	return result
end

function PopupCacheModel:setViewIgnoreGetPropView(viewName, isIgnore, getApproach)
	if isIgnore then
		self._viewNameIgnoreGetProp[viewName] = getApproach or true
	else
		self._viewNameIgnoreGetProp[viewName] = nil
	end
end

function PopupCacheModel:isIgnoreGetPropView(getApproach)
	for viewName, ignoreData in pairs(self._viewNameIgnoreGetProp) do
		local isOpen = ViewMgr.instance:isOpen(viewName)

		if isOpen then
			local ignoreType = type(ignoreData)

			if ignoreType == "boolean" or ignoreData == getApproach then
				return true
			end
		end
	end
end

PopupCacheModel.instance = PopupCacheModel.New()

return PopupCacheModel
