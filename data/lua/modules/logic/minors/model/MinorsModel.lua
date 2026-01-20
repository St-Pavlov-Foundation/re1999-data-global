-- chunkname: @modules/logic/minors/model/MinorsModel.lua

module("modules.logic.minors.model.MinorsModel", package.seeall)

local MinorsModel = class("MinorsModel", ListScrollModel)

MinorsModel.instance = MinorsModel.New()

return MinorsModel
