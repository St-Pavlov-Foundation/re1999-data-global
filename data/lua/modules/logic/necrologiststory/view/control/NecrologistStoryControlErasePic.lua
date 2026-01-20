-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlErasePic.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlErasePic", package.seeall)

local NecrologistStoryControlErasePic = class("NecrologistStoryControlErasePic", NecrologistStoryControlMgrItem)

function NecrologistStoryControlErasePic:onPlayControl()
	self:getControlItem(NecrologistStoryErasePictureItem)
end

return NecrologistStoryControlErasePic
