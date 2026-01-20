-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlClickPic.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlClickPic", package.seeall)

local NecrologistStoryControlClickPic = class("NecrologistStoryControlClickPic", NecrologistStoryControlMgrItem)

function NecrologistStoryControlClickPic:onPlayControl()
	self:getControlItem(NecrologistStoryClickPictureItem)
end

return NecrologistStoryControlClickPic
