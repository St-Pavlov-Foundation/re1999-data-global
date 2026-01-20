-- chunkname: @modules/logic/voyage/controller/VoyageController.lua

module("modules.logic.voyage.controller.VoyageController", package.seeall)

local VoyageController = class("VoyageController", BaseController)

function VoyageController:onInit()
	self:reInit()
end

function VoyageController:reInit()
	self._model = VoyageModel.instance
end

function VoyageController:addConstEvents()
	return
end

function VoyageController:_onReceiveAct1001GetInfoReply(msg)
	self._model:onReceiveAct1001GetInfoReply(msg)
	self:dispatchEvent(VoyageEvent.OnReceiveAct1001GetInfoReply)
end

function VoyageController:_onReceiveAct1001UpdatePush(msg)
	self._model:onReceiveAct1001UpdatePush(msg)
	self:dispatchEvent(VoyageEvent.OnReceiveAct1001UpdatePush)
end

function VoyageController:jump()
	if self._model:hasAnyRewardAvailable() then
		MailController.instance:open()
	else
		local param = {
			chapterId = 101
		}

		DungeonController.instance:enterDungeonView(true)
		DungeonController.instance:openDungeonChapterView(param)
	end
end

VoyageController.instance = VoyageController.New()

return VoyageController
