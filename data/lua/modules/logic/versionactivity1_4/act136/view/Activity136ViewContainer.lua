-- chunkname: @modules/logic/versionactivity1_4/act136/view/Activity136ViewContainer.lua

module("modules.logic.versionactivity1_4.act136.view.Activity136ViewContainer", package.seeall)

local Activity136ViewContainer = class("Activity136ViewContainer", BaseViewContainer)

function Activity136ViewContainer:buildViews()
	local views = {
		Activity136View.New()
	}

	return views
end

function Activity136ViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Activity136ViewContainer
