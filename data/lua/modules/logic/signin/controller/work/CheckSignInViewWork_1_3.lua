module("modules.logic.signin.controller.work.CheckSignInViewWork_1_3", package.seeall)

slot0 = class("CheckSignInViewWork_1_3", BaseWork)

function slot0.onStart(slot0)
	slot0._funcs = {}

	SignInController.instance:registerCallback(SignInEvent.OnSignInPopupFlowUpdate, slot0._onSignInPopupFlowUpdate, slot0)
end

function slot0._removeSingleEvent(slot0, slot1)
	if slot0._funcs[slot1] then
		SignInController.instance:unregisterCallback(slot1, slot2, slot0)

		slot0._funcs[slot1] = nil
	end

	if not next(slot0._funcs) then
		slot0:_startBlock()
		slot0:onDone(true)
	end
end

function slot0._onSignInPopupFlowUpdate(slot0, slot1)
	if slot1 == false then
		slot0:_clear()
		slot0:onDone(true)

		return
	end

	if slot1 == nil then
		logError("impossible ?!")

		return
	end

	if slot0._funcs[slot1] then
		return
	end

	slot2 = string.format("__internal_%s", slot1)

	slot0[slot2] = function ()
		uv0:_removeSingleEvent(uv1)
	end

	slot0._funcs[slot1] = slot0[slot2]

	SignInController.instance:registerCallback(slot1, slot0[slot2], slot0)
end

function slot0._clear(slot0)
	for slot4, slot5 in pairs(slot0._funcs) do
		SignInController.instance:unregisterCallback(slot4, slot5, slot0)
	end

	slot0._funcs = {}
end

function slot0.clearWork(slot0)
	if not slot0.isSuccess then
		slot0:_endBlock()
	end

	slot0:_clear()
	SignInController.instance:unregisterCallback(SignInEvent.OnSignInPopupFlowUpdate, slot0._onSignInPopupFlowUpdate, slot0)
end

function slot0._endBlock(slot0)
	if not slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function slot0._startBlock(slot0)
	if slot0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function slot0._isBlock(slot0)
	return UIBlockMgr.instance:isBlock() and true or false
end

return slot0
