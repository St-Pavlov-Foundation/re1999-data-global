-- chunkname: @modules/logic/backpack/controller/BackpackEvent.lua

module("modules.logic.backpack.controller.BackpackEvent", package.seeall)

local BackpackEvent = {}

BackpackEvent.SelectCategory = 1
BackpackEvent.UpdateItemList = 2
BackpackEvent.UsePowerPotionFinish = 3
BackpackEvent.SelectCategoryById = 4
BackpackEvent.UsePowerPotionListFinish = 5
BackpackEvent.BeforeUsePowerPotionList = 6
BackpackEvent.UseInsightItemFinished = 24001

return BackpackEvent
