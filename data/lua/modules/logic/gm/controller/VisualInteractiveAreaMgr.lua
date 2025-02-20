module("modules.logic.gm.controller.VisualInteractiveAreaMgr", package.seeall)

slot0 = class("VisualInteractiveAreaMgr")
slot0.maskItemPath = "ui/viewres/gm/visualmaskitem.prefab"
slot0.LoadStatus = {
	Loaded = 3,
	LoadFail = 4,
	Loading = 2,
	None = 1
}
slot0.needCheckComponentList = {
	SLFramework.UGUI.ButtonWrap,
	SLFramework.UGUI.UIClickListener
}
slot0.CloneMaskGoName = "cloneMaskItem"
slot0.MaxStackLevel = 50

function slot0.init(slot0)
	slot0:loadMaskItem()
	slot0:createPool()

	slot0.viewName2MaskGoListDict = {}
end

function slot0.loadMaskItem(slot0)
	slot0.loadStatus = uv0.LoadStatus.Loading

	loadAbAsset(uv0.maskItemPath, true, slot0._onLoadCallback, slot0)
end

function slot0._onLoadCallback(slot0, slot1)
	if slot1.IsLoadSuccess then
		slot0.assetItem = slot1

		slot0.assetItem:Retain()

		slot0.maskItemGo = gohelper.clone(slot0.assetItem:GetResource(uv0.maskItemPath), ViewMgr.instance:getUIRoot())

		gohelper.setActive(slot0.maskItemGo, false)

		slot0.loadStatus = uv0.LoadStatus.Loaded

		if slot0.needDelayShowMask then
			slot0:showAllViewMaskGo()
		end
	else
		slot0.maskItemGo = nil
		slot0.loadStatus = uv0.LoadStatus.LoadFail

		logError("load fail ...")
	end
end

function slot0.createPool(slot0)
	slot0.maskGoPool = {}
	slot0.poolGO = gohelper.create2d(ViewMgr.instance:getUIRoot(), "maskPool")
	slot0.poolTr = slot0.poolGO.transform

	gohelper.setActive(slot0.poolGO, false)
end

function slot0.beforeStart(slot0)
	slot0.listSourceFunc = LuaListScrollView.onUpdateFinish

	function LuaListScrollView.onUpdateFinish(slot0)
		uv0.listSourceFunc(slot0)
		uv0:showMaskGoByGo(slot0._csListScroll.gameObject, slot0.viewName)
	end

	slot0.tableViewSourceFunc = TabViewGroup._finishCallback

	function TabViewGroup._finishCallback(slot0, slot1)
		uv0.tableViewSourceFunc(slot0, slot1)
		uv0:showMaskGoByGo(slot0.viewGO, slot0.viewName)
	end
end

function slot0.beforeStop(slot0)
	LuaListScrollView.onUpdateFinish = slot0.listSourceFunc
	TabViewGroup._finishCallback = slot0.tableViewSourceFunc
end

function slot0.start(slot0)
	slot0:beforeStart()

	if slot0.loadStatus ~= uv0.LoadStatus.Loaded then
		slot0.needDelayShowMask = true
	else
		slot0:showAllViewMaskGo()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.stop(slot0)
	slot0:beforeStop()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.onOpenView, slot0)

	slot5 = slot0.onCloseView
	slot6 = slot0

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot5, slot6)

	for slot5, slot6 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		slot0:recycleMaskGoByViewName(slot6)
	end
end

function slot0.onOpenView(slot0, slot1)
	slot0:showMaskGoByViewName(slot1)
end

function slot0.onCloseView(slot0, slot1)
	slot0:recycleMaskGoByViewName(slot1)
end

function slot0.showAllViewMaskGo(slot0)
	for slot5, slot6 in ipairs(ViewMgr.instance:getOpenViewNameList()) do
		if not slot0.viewName2MaskGoListDict[slot6] then
			slot0:showMaskGoByViewName(slot6)
		end
	end
end

function slot0.showMaskGoByViewName(slot0, slot1)
	slot0:showMaskGoByGo(ViewMgr.instance:getContainer(slot1).viewGO, slot1)
end

function slot0.showMaskGoByGo(slot0, slot1, slot2, slot3, slot4)
	if uv0.MaxStackLevel < (slot4 or 1) then
		logError("stack overflow ...")

		return
	end

	if not slot1 or not slot1.transform then
		logError("go not be null")

		return
	end

	if not slot0.viewName2MaskGoListDict[slot2] then
		slot0.viewName2MaskGoListDict[slot2] = {}
	end

	slot0.currentViewNameMaskList = slot0.viewName2MaskGoListDict[slot2]

	slot0:addMaskGo(slot1, slot3)

	for slot9 = 1, slot1.transform.childCount do
		slot0:showMaskGoByGo(slot5:GetChild(slot9 - 1).gameObject, slot2, slot3 or slot0:checkNeedAddMask(slot1, slot3), slot4 + 1)
	end
end

function slot0.addMaskGo(slot0, slot1, slot2)
	if slot0:checkNeedAddMask(slot1, slot2) and slot0:addMaskItemGo(slot1) then
		table.insert(slot0.currentViewNameMaskList, slot3)
	end
end

function slot0.checkNeedAddMask(slot0, slot1, slot2)
	if slot2 then
		if slot1:GetComponent(gohelper.Type_Graphic) and slot3.raycastTarget then
			return true
		else
			return false
		end
	end

	for slot6, slot7 in ipairs(uv0.needCheckComponentList) do
		if slot1:GetComponent(typeof(slot7)) then
			return true
		end
	end

	return false
end

function slot0.addMaskItemGo(slot0, slot1)
	if gohelper.findChild(slot1, uv0.CloneMaskGoName) then
		return nil
	end

	slot2 = table.remove(slot0.maskGoPool) or gohelper.clone(slot0.maskItemGo, slot1, uv0.CloneMaskGoName)

	slot2.transform:SetParent(slot1.transform)

	slot2.transform.offsetMax = Vector2.zero
	slot2.transform.offsetMin = Vector2.zero

	transformhelper.setLocalRotation(slot2.transform, 0, 0, 0)
	transformhelper.setLocalScale(slot2.transform, 1, 1, 1)

	if gohelper.findChildText(slot2, "txt_size") then
		slot3.text = string.format("%.1f%s%.1f", recthelper.getWidth(slot2.transform), luaLang("multiple"), recthelper.getHeight(slot2.transform))
	end

	gohelper.setActive(slot2, true)

	return slot2
end

function slot0.recycleMaskGoByViewName(slot0, slot1)
	if slot0.viewName2MaskGoListDict[slot1] then
		for slot6, slot7 in ipairs(slot2) do
			if not gohelper.isNil(slot7) then
				slot7.transform:SetParent(slot0.poolTr)
				table.insert(slot0.maskGoPool, slot7)
			end
		end

		slot0.viewName2MaskGoListDict[slot1] = nil
	end
end

function slot0.dispose(slot0)
	if slot0.loadStatus == uv0.LoadStatus.Loading then
		removeAssetLoadCb(uv0.maskItemPath, slot0._onLoadCallback, slot0)
	end

	if slot0.assetItem then
		slot0.assetItem:Release()
	end

	slot0:stop()

	slot0.maskGoPool = nil

	gohelper.destroy(slot0.maskItemGo)
	gohelper.destroy(slot0.poolGO)
end

return slot0
