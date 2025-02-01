module("modules.common.touch.TouchEventMgrHepler", package.seeall)

slot0 = class("TouchEventMgrHepler")
slot1 = ZProj.TouchEventMgr
slot2 = {}

function slot0.getTouchEventMgr(slot0)
	slot1 = uv0.Get(slot0)

	if SDKNativeUtil.isGamePad() and tabletool.indexOf(uv1, slot1) == nil then
		table.insert(uv1, slot1)
		slot1:SetDestroyCb(uv2._remove, nil)
	end

	return slot1
end

function slot0.getAllMgrs()
	return uv0
end

function slot0.remove(slot0)
	if not gohelper.isNil(slot0) then
		slot0:ClearAllCallback()
		uv0._remove(slot0)
	end
end

function slot0._remove(slot0)
	tabletool.removeValue(uv0, slot0)
end

return slot0
