module("modules.logic.gm.controller.VisualInteractiveAreaMgr", package.seeall)

local var_0_0 = class("VisualInteractiveAreaMgr")

var_0_0.maskItemPath = "ui/viewres/gm/visualmaskitem.prefab"
var_0_0.LoadStatus = {
	Loaded = 3,
	LoadFail = 4,
	Loading = 2,
	None = 1
}
var_0_0.needCheckComponentList = {
	SLFramework.UGUI.ButtonWrap,
	SLFramework.UGUI.UIClickListener
}
var_0_0.CloneMaskGoName = "cloneMaskItem"
var_0_0.MaxStackLevel = 50

function var_0_0.init(arg_1_0)
	arg_1_0:loadMaskItem()
	arg_1_0:createPool()

	arg_1_0.viewName2MaskGoListDict = {}
end

function var_0_0.loadMaskItem(arg_2_0)
	arg_2_0.loadStatus = var_0_0.LoadStatus.Loading

	loadAbAsset(var_0_0.maskItemPath, true, arg_2_0._onLoadCallback, arg_2_0)
end

function var_0_0._onLoadCallback(arg_3_0, arg_3_1)
	if arg_3_1.IsLoadSuccess then
		arg_3_0.assetItem = arg_3_1

		arg_3_0.assetItem:Retain()

		arg_3_0.maskItemGo = gohelper.clone(arg_3_0.assetItem:GetResource(var_0_0.maskItemPath), ViewMgr.instance:getUIRoot())

		gohelper.setActive(arg_3_0.maskItemGo, false)

		arg_3_0.loadStatus = var_0_0.LoadStatus.Loaded

		if arg_3_0.needDelayShowMask then
			arg_3_0:showAllViewMaskGo()
		end
	else
		arg_3_0.maskItemGo = nil
		arg_3_0.loadStatus = var_0_0.LoadStatus.LoadFail

		logError("load fail ...")
	end
end

function var_0_0.createPool(arg_4_0)
	arg_4_0.maskGoPool = {}
	arg_4_0.poolGO = gohelper.create2d(ViewMgr.instance:getUIRoot(), "maskPool")
	arg_4_0.poolTr = arg_4_0.poolGO.transform

	gohelper.setActive(arg_4_0.poolGO, false)
end

function var_0_0.beforeStart(arg_5_0)
	arg_5_0.listSourceFunc = LuaListScrollView.onUpdateFinish

	function LuaListScrollView.onUpdateFinish(arg_6_0)
		arg_5_0.listSourceFunc(arg_6_0)
		arg_5_0:showMaskGoByGo(arg_6_0._csListScroll.gameObject, arg_6_0.viewName)
	end

	arg_5_0.tableViewSourceFunc = TabViewGroup._finishCallback

	function TabViewGroup._finishCallback(arg_7_0, arg_7_1)
		arg_5_0.tableViewSourceFunc(arg_7_0, arg_7_1)
		arg_5_0:showMaskGoByGo(arg_7_0.viewGO, arg_7_0.viewName)
	end
end

function var_0_0.beforeStop(arg_8_0)
	LuaListScrollView.onUpdateFinish = arg_8_0.listSourceFunc
	TabViewGroup._finishCallback = arg_8_0.tableViewSourceFunc
end

function var_0_0.start(arg_9_0)
	arg_9_0:beforeStart()

	if arg_9_0.loadStatus ~= var_0_0.LoadStatus.Loaded then
		arg_9_0.needDelayShowMask = true
	else
		arg_9_0:showAllViewMaskGo()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_9_0.onOpenView, arg_9_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_9_0.onCloseView, arg_9_0)
end

function var_0_0.stop(arg_10_0)
	arg_10_0:beforeStop()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_10_0.onOpenView, arg_10_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_10_0.onCloseView, arg_10_0)

	local var_10_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		arg_10_0:recycleMaskGoByViewName(iter_10_1)
	end
end

function var_0_0.onOpenView(arg_11_0, arg_11_1)
	arg_11_0:showMaskGoByViewName(arg_11_1)
end

function var_0_0.onCloseView(arg_12_0, arg_12_1)
	arg_12_0:recycleMaskGoByViewName(arg_12_1)
end

function var_0_0.showAllViewMaskGo(arg_13_0)
	local var_13_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if not arg_13_0.viewName2MaskGoListDict[iter_13_1] then
			arg_13_0:showMaskGoByViewName(iter_13_1)
		end
	end
end

function var_0_0.showMaskGoByViewName(arg_14_0, arg_14_1)
	local var_14_0 = ViewMgr.instance:getContainer(arg_14_1)

	arg_14_0:showMaskGoByGo(var_14_0.viewGO, arg_14_1)
end

function var_0_0.showMaskGoByGo(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_4 = arg_15_4 or 1

	if arg_15_4 > var_0_0.MaxStackLevel then
		logError("stack overflow ...")

		return
	end

	if not arg_15_1 or not arg_15_1.transform then
		logError("go not be null")

		return
	end

	if not arg_15_0.viewName2MaskGoListDict[arg_15_2] then
		arg_15_0.viewName2MaskGoListDict[arg_15_2] = {}
	end

	arg_15_0.currentViewNameMaskList = arg_15_0.viewName2MaskGoListDict[arg_15_2]

	arg_15_0:addMaskGo(arg_15_1, arg_15_3)

	arg_15_3 = arg_15_3 or arg_15_0:checkNeedAddMask(arg_15_1, arg_15_3)

	local var_15_0 = arg_15_1.transform

	for iter_15_0 = 1, var_15_0.childCount do
		arg_15_0:showMaskGoByGo(var_15_0:GetChild(iter_15_0 - 1).gameObject, arg_15_2, arg_15_3, arg_15_4 + 1)
	end
end

function var_0_0.addMaskGo(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0:checkNeedAddMask(arg_16_1, arg_16_2) then
		local var_16_0 = arg_16_0:addMaskItemGo(arg_16_1)

		if var_16_0 then
			table.insert(arg_16_0.currentViewNameMaskList, var_16_0)
		end
	end
end

function var_0_0.checkNeedAddMask(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 then
		local var_17_0 = arg_17_1:GetComponent(gohelper.Type_Graphic)

		if var_17_0 and var_17_0.raycastTarget then
			return true
		else
			return false
		end
	end

	for iter_17_0, iter_17_1 in ipairs(var_0_0.needCheckComponentList) do
		if arg_17_1:GetComponent(typeof(iter_17_1)) then
			return true
		end
	end

	return false
end

function var_0_0.addMaskItemGo(arg_18_0, arg_18_1)
	if gohelper.findChild(arg_18_1, var_0_0.CloneMaskGoName) then
		return nil
	end

	local var_18_0 = table.remove(arg_18_0.maskGoPool) or gohelper.clone(arg_18_0.maskItemGo, arg_18_1, var_0_0.CloneMaskGoName)

	var_18_0.transform:SetParent(arg_18_1.transform)

	var_18_0.transform.offsetMax = Vector2.zero
	var_18_0.transform.offsetMin = Vector2.zero

	transformhelper.setLocalRotation(var_18_0.transform, 0, 0, 0)
	transformhelper.setLocalScale(var_18_0.transform, 1, 1, 1)

	local var_18_1 = gohelper.findChildText(var_18_0, "txt_size")

	if var_18_1 then
		var_18_1.text = string.format("%.1f%s%.1f", recthelper.getWidth(var_18_0.transform), luaLang("multiple"), recthelper.getHeight(var_18_0.transform))
	end

	gohelper.setActive(var_18_0, true)

	return var_18_0
end

function var_0_0.recycleMaskGoByViewName(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.viewName2MaskGoListDict[arg_19_1]

	if var_19_0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			if not gohelper.isNil(iter_19_1) then
				iter_19_1.transform:SetParent(arg_19_0.poolTr)
				table.insert(arg_19_0.maskGoPool, iter_19_1)
			end
		end

		arg_19_0.viewName2MaskGoListDict[arg_19_1] = nil
	end
end

function var_0_0.dispose(arg_20_0)
	if arg_20_0.loadStatus == var_0_0.LoadStatus.Loading then
		removeAssetLoadCb(var_0_0.maskItemPath, arg_20_0._onLoadCallback, arg_20_0)
	end

	if arg_20_0.assetItem then
		arg_20_0.assetItem:Release()
	end

	arg_20_0:stop()

	arg_20_0.maskGoPool = nil

	gohelper.destroy(arg_20_0.maskItemGo)
	gohelper.destroy(arg_20_0.poolGO)
end

return var_0_0
