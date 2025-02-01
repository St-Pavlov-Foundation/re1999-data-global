module("modules.common.res.AssetLoadCbMO", package.seeall)

slot0 = class("AssetLoadCbMO")

function slot0.ctor(slot0, slot1, slot2)
	slot0._loadedCb = slot1
	slot0._loadedObj = slot2
end

function slot0.call(slot0, ...)
	slot0._loadedCb(slot0._loadedObj, ...)
end

return slot0
