-- chunkname: @modules/logic/versionactivity220/model/Activity220Model.lua

module("modules.logic.versionactivity220.model.Activity220Model", package.seeall)

local Activity220Model = class("Activity220Model", BaseModel)

function Activity220Model:onInit()
	return
end

function Activity220Model:reInit()
	self:onInit()
end

Activity220Model.instance = Activity220Model.New()

return Activity220Model
