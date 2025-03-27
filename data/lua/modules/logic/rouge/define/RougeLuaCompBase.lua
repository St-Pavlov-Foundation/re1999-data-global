module("modules.logic.rouge.define.RougeLuaCompBase", package.seeall)

slot0 = class("RougeLuaCompBase", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0:__onInit()
	uv0.super.init(slot0, slot1)
	slot0:initDLCs(slot1)
end

function slot0.initDLCs(slot0, slot1)
	slot0._parentGo = slot1

	slot0:_collectAllClsAndLoadRes()
end

function slot0.onUpdateDLC(slot0, ...)
end

function slot0.tickUpdateDLCs(slot0, ...)
	if not slot0._dlcComps or not slot0._resLoadDone then
		slot0.params = {
			...
		}

		return
	end

	for slot4, slot5 in ipairs(slot0._dlcComps) do
		slot5:onUpdateDLC(...)
	end
end

function slot0._collectAllClsAndLoadRes(slot0)
	slot0._clsList = slot0:getUserDataTb_()
	slot1 = {}

	for slot8, slot9 in ipairs(RougeModel.instance:getVersion() or {}) do
		slot11 = _G[string.format("%s_%s_%s", slot0.__cname, RougeOutsideModel.instance:season(), slot9)]

		table.insert(slot0._clsList, slot11)
		slot0:_collectNeedLoadRes(slot11, slot1, {})
	end

	slot0:_loadAllNeedRes(slot1)
end

function slot0._collectNeedLoadRes(slot0, slot1, slot2, slot3)
	if slot1 and slot1.AssetUrl then
		slot3[slot4] = true

		table.insert(slot2, slot4)
	end
end

function slot0._loadAllNeedRes(slot0, slot1)
	slot0._resLoadDone = false

	if not slot1 or #slot1 <= 0 then
		slot0:_resLoadDoneCallBack()

		return
	end

	slot0._abLoader = slot0._abLoader or MultiAbLoader.New()

	slot0._abLoader:setPathList(slot1)
	slot0._abLoader:startLoad(slot0._resLoadDoneCallBack, slot0)
end

function slot0._resLoadDoneCallBack(slot0)
	slot0._dlcComps = slot0:getUserDataTb_()
	slot1 = nil

	if slot0.params then
		slot1 = unpack(slot0.params)
	end

	for slot5, slot6 in ipairs(slot0._clsList) do
		if slot0:_createGo(slot6.ParentObjPath, slot6.AssetUrl, slot6.ResInitPosition) then
			slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot7, slot6, slot0)

			slot8:onUpdateDLC(slot1)
			table.insert(slot0._dlcComps, slot8)
		end
	end

	slot0._resLoadDone = true
end

function slot0._createGo(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot1) or string.nilorempty(slot2) or not slot0._abLoader then
		return
	end

	if not (slot0._abLoader:getAssetItem(slot2) and slot4:GetResource(slot2)) then
		logError("无法找到指定资源 :" .. slot2)

		return
	end

	if gohelper.isNil(gohelper.findChild(slot0._parentGo, slot1)) then
		logError("无法找到指定肉鸽DLC界面挂点:" .. tostring(slot1))

		return
	end

	slot7 = gohelper.clone(slot5, slot6)

	if slot3 then
		recthelper.setAnchor(slot7.transform, slot3.x or 0, slot3.y or 0)
	end

	return slot7
end

function slot0.onDestroy(slot0)
	if slot0._abLoader then
		slot0._abLoader:dispose()

		slot0._abLoader = nil
	end

	uv0.super.onDestroy(slot0)
	slot0:__onDispose()
end

return slot0
