module("modules.live2d.controller.Live2dMaskController", package.seeall)

slot0 = class("Live2dMaskController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._goList = {}
end

function slot0.addConstEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinsh, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onOpenViewFinsh(slot0)
	slot0:_checkMask()
end

function slot0._onCloseViewFinish(slot0)
	slot0:_checkMask()
end

function slot0.addLive2dGo(slot0, slot1)
	if not slot1 then
		return
	end

	if gohelper.isNil(slot1) then
		return
	end

	slot0._goList[slot1] = true

	slot0:_checkMask()
end

function slot0.removeLive2dGo(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._goList[slot1] = nil

	slot0:_checkMask()
end

function slot0._checkMask(slot0)
	RenderPipelineSetting.SetCubisMaskCommandBufferLateUpdateEnable(slot0:_needMask())
end

function slot0._needMask(slot0)
	for slot4, slot5 in pairs(slot0._goList) do
		if not gohelper.isNil(slot4) then
			return true
		else
			rawset(slot0._goList, slot4, nil)
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
