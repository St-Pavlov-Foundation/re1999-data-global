-- chunkname: @modules/logic/necrologiststory/view/control/NecrologistStoryControlMagic.lua

module("modules.logic.necrologiststory.view.control.NecrologistStoryControlMagic", package.seeall)

local NecrologistStoryControlMagic = class("NecrologistStoryControlMagic", NecrologistStoryControlMgrItem)

function NecrologistStoryControlMagic:onPlayControl()
	self:getControlItem(NecrologistStoryMagicItem)
end

return NecrologistStoryControlMagic
