-- chunkname: @modules/logic/voyage/config/VoyageEnum.lua

module("modules.logic.voyage.config.VoyageEnum", package.seeall)

local VoyageEnum = _M

VoyageEnum.State = {
	Got = 2,
	Available = 1,
	None = 0
}

return VoyageEnum
