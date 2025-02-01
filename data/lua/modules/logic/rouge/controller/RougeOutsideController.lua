module("modules.logic.rouge.controller.RougeOutsideController", package.seeall)

slot0 = class("RougeOutsideController", BaseController)

function slot0.onInit(slot0)
	slot0._model = RougeOutsideModel.instance
end

function slot0.addConstEvents(slot0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, slot0._onGetOpenInfoSuccess, slot0)
end

function slot0._onGetOpenInfoSuccess(slot0)
	if OpenModel.instance:isFunctionUnlock(slot0._model:config():openUnlockId()) then
		return
	end

	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0._onNewFuncUnlock, slot0)
end

function slot0.checkOutSideStageInfo(slot0)
end

function slot0._onNewFuncUnlock(slot0, slot1)
	slot4 = false

	for slot8, slot9 in ipairs(slot1) do
		if slot9 == slot0._model:config():openUnlockId() then
			slot4 = true

			break
		end
	end

	if not slot4 then
		return
	end

	slot0._model:setIsNewUnlockDifficulty(1, true)
end

function slot0.isOpen(slot0)
	return slot0._model:isUnlock()
end

slot0.instance = slot0.New()

return slot0
