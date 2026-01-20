-- chunkname: @modules/logic/gift/controller/GiftController.lua

module("modules.logic.gift.controller.GiftController", package.seeall)

local GiftController = class("GiftController", BaseController)

function GiftController:onInit()
	return
end

function GiftController:onInitFinish()
	return
end

function GiftController:addConstEvents()
	return
end

function GiftController:reInit()
	return
end

function GiftController:openGiftMultipleChoiceView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.GiftMultipleChoiceView, param, isImmediate)
end

function GiftController:openOptionalGiftMultipleChoiceView(param, isImmediate)
	ViewMgr.instance:openView(ViewName.OptionalGiftMultipleChoiceView, param, isImmediate)
end

function GiftController:openGiftInsightHeroChoiceView(param)
	ViewMgr.instance:openView(ViewName.GiftInsightHeroChoiceView, param)
end

GiftController.instance = GiftController.New()

return GiftController
