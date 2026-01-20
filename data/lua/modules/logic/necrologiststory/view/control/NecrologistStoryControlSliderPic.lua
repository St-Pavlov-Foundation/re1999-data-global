-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlSliderPic.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlSliderPic", package.seeall)

local NecrologistStoryControlSliderPic = class("NecrologistStoryControlSliderPic", NecrologistStoryControlMgrItem)

function NecrologistStoryControlSliderPic:onPlayControl()
	self:getControlItem(NecrologistStorySliderPictureItem)
end

return NecrologistStoryControlSliderPic
