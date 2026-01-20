-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlDragPic.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlDragPic", package.seeall)

local NecrologistStoryControlDragPic = class("NecrologistStoryControlDragPic", NecrologistStoryControlMgrItem)

function NecrologistStoryControlDragPic:onPlayControl()
	self:getControlItem(NecrologistStoryDragPictureItem)
end

return NecrologistStoryControlDragPic
