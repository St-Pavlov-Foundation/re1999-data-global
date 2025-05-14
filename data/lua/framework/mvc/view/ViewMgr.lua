module("framework.mvc.view.ViewMgr", package.seeall)

local var_0_0 = class("ViewMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._viewSettings = nil
	arg_1_0._viewContainerDict = {}
	arg_1_0._openViewNameList = {}
	arg_1_0._openViewNameSet = {}
	arg_1_0._uiCanvas = nil
	arg_1_0._uiRoot = nil
	arg_1_0._topUICanvas = nil
	arg_1_0._topUIRoot = nil
	arg_1_0._uiLayerDict = {}

	LuaEventSystem.addEventMechanism(arg_1_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._viewSettings = arg_2_1

	ViewModalMaskMgr.instance:init()
	ViewFullScreenMgr.instance:init()
	ViewDestroyMgr.instance:init()
end

function var_0_0.openTabView(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	arg_3_2 = arg_3_2 or {}
	arg_3_2.defaultTabIds = {
		arg_3_4,
		arg_3_5,
		arg_3_6
	}

	arg_3_0:openView(arg_3_1, arg_3_2, arg_3_3)
end

function var_0_0.openView(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == nil or arg_4_1 == "" then
		logError("viewName is empty")

		return
	end

	local var_4_0 = arg_4_0:getContainer(arg_4_1)

	if arg_4_0._openViewNameSet[arg_4_1] and var_4_0 then
		tabletool.removeValue(arg_4_0._openViewNameList, arg_4_1)
		table.insert(arg_4_0._openViewNameList, arg_4_1)
		gohelper.setAsLastSibling(var_4_0.viewGO)
		var_4_0:onUpdateParamInternal(arg_4_2)
		var_0_0.instance:dispatchEvent(ViewEvent.ReOpenWhileOpen, arg_4_1, arg_4_2)

		return
	end

	local var_4_1 = arg_4_0:_createContainer(arg_4_1)

	arg_4_0._viewContainerDict[arg_4_1] = var_4_1

	table.insert(arg_4_0._openViewNameList, arg_4_1)

	arg_4_0._openViewNameSet[arg_4_1] = true

	var_4_1:openInternal(arg_4_2, arg_4_3)
end

function var_0_0.closeView(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_1 or not arg_5_0._openViewNameSet[arg_5_1] then
		return
	end

	arg_5_0._openViewNameSet[arg_5_1] = nil

	tabletool.removeValue(arg_5_0._openViewNameList, arg_5_1)

	local var_5_0 = arg_5_0:getContainer(arg_5_1)

	var_5_0:setCloseType(arg_5_3 and BaseViewContainer.CloseTypeManual or nil)
	var_5_0:closeInternal(arg_5_2)
end

function var_0_0.destroyView(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getContainer(arg_6_1)

	if var_6_0 then
		if var_6_0:isOpen() then
			var_6_0:closeInternal(true)
		end

		var_6_0:destroyView()
		var_6_0:__onDispose()

		arg_6_0._viewContainerDict[arg_6_1] = nil

		if arg_6_0:isFull(arg_6_1) then
			var_0_0.instance:dispatchEvent(ViewEvent.DestroyFullViewFinish, arg_6_1)
		elseif arg_6_0:isModal(arg_6_1) then
			var_0_0.instance:dispatchEvent(ViewEvent.DestroyModalViewFinish, arg_6_1)
		end

		var_0_0.instance:dispatchEvent(ViewEvent.DestroyViewFinish, arg_6_1)
	end
end

function var_0_0.isOpen(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getContainer(arg_7_1)

	return var_7_0 and var_7_0:isOpen()
end

function var_0_0.isOpening(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getContainer(arg_8_1)

	return var_8_0 and var_8_0:isOpening()
end

function var_0_0.isOpenFinish(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getContainer(arg_9_1)

	return var_9_0 and var_9_0:isOpenFinish()
end

function var_0_0.closeAllModalViews(arg_10_0, arg_10_1)
	local var_10_0

	for iter_10_0 = #arg_10_0._openViewNameList, 1, -1 do
		local var_10_1 = arg_10_0._openViewNameList[iter_10_0]

		if (not arg_10_1 or not tabletool.indexOf(arg_10_1, var_10_1)) and arg_10_0:isModal(var_10_1) then
			var_10_0 = var_10_0 or {}

			table.insert(var_10_0, var_10_1)
		end
	end

	if var_10_0 then
		for iter_10_1 = 1, #var_10_0 do
			arg_10_0:closeView(var_10_0[iter_10_1], true)
		end
	end
end

function var_0_0.closeAllPopupViews(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	for iter_11_0 = #arg_11_0._openViewNameList, 1, -1 do
		local var_11_1 = arg_11_0._openViewNameList[iter_11_0]
		local var_11_2 = arg_11_0:getSetting(var_11_1)

		if (not arg_11_1 or not tabletool.indexOf(arg_11_1, var_11_1)) and (var_11_2.layer == UILayerName.PopUpTop or var_11_2.layer == UILayerName.PopUp) then
			var_11_0 = var_11_0 or {}

			table.insert(var_11_0, var_11_1)
		end
	end

	if var_11_0 then
		local var_11_3 = #var_11_0

		for iter_11_1 = 1, var_11_3 do
			arg_11_0:closeView(var_11_0[iter_11_1], true, iter_11_1 == var_11_3 and arg_11_2)
		end
	end
end

function var_0_0.closeAllViews(arg_12_0, arg_12_1)
	local var_12_0

	for iter_12_0 = #arg_12_0._openViewNameList, 1, -1 do
		local var_12_1 = arg_12_0._openViewNameList[iter_12_0]

		if not arg_12_1 or not tabletool.indexOf(arg_12_1, var_12_1) then
			var_12_0 = var_12_0 or {}

			table.insert(var_12_0, var_12_1)
		end
	end

	if var_12_0 then
		for iter_12_1 = 1, #var_12_0 do
			arg_12_0:closeView(var_12_0[iter_12_1], true)
		end
	end
end

function var_0_0.IsPopUpViewOpen(arg_13_0)
	for iter_13_0 = #arg_13_0._openViewNameList, 1, -1 do
		local var_13_0 = arg_13_0._openViewNameList[iter_13_0]
		local var_13_1 = arg_13_0:getSetting(var_13_0)

		if var_13_1.layer == UILayerName.PopUpTop or var_13_1.layer == UILayerName.PopUp or var_13_1.layer == UILayerName.Guide then
			return true
		end
	end

	return false
end

function var_0_0.getSetting(arg_14_0, arg_14_1)
	return arg_14_0._viewSettings[arg_14_1]
end

function var_0_0.getOpenViewNameList(arg_15_0)
	return arg_15_0._openViewNameList
end

function var_0_0.hasOpenFullView(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._openViewNameList) do
		if arg_16_0:isFull(iter_16_1) then
			return true
		end
	end

	return false
end

function var_0_0.isNormal(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._viewSettings[arg_17_1]

	return var_17_0 and var_17_0.viewType == ViewType.Normal
end

function var_0_0.isModal(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._viewSettings[arg_18_1]

	return var_18_0 and var_18_0.viewType == ViewType.Modal
end

function var_0_0.isFull(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._viewSettings[arg_19_1]

	return var_19_0 and var_19_0.viewType == ViewType.Full
end

function var_0_0.getUIRoot(arg_20_0)
	if not arg_20_0._uiRoot then
		arg_20_0._uiRoot = gohelper.find("UIRoot")
	end

	return arg_20_0._uiRoot
end

function var_0_0.getTopUIRoot(arg_21_0)
	if not arg_21_0._topUIRoot then
		arg_21_0._topUIRoot = gohelper.find("UIRoot")
	end

	return arg_21_0._topUIRoot
end

function var_0_0.getUICanvas(arg_22_0)
	if not arg_22_0._uiCanvas then
		arg_22_0._uiCanvas = arg_22_0:getUIRoot():GetComponent("Canvas")
	end

	return arg_22_0._uiCanvas
end

function var_0_0.getTopUICanvas(arg_23_0)
	if not arg_23_0._topUICanvas then
		arg_23_0._topUICanvas = arg_23_0:getTopUIRoot():GetComponent("Canvas")
	end

	return arg_23_0._topUICanvas
end

function var_0_0.getUILayer(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._uiLayerDict[arg_24_1]

	if not var_24_0 then
		if arg_24_1 == UILayerName.IDCanvasPopUp then
			var_24_0 = gohelper.find(arg_24_1)
		else
			local var_24_1 = arg_24_0:getUIRoot()

			var_24_0 = gohelper.findChild(arg_24_0:getUIRoot(), arg_24_1)
			var_24_0 = var_24_0 or gohelper.findChild(arg_24_0:getTopUIRoot(), arg_24_1)
		end

		if var_24_0 then
			arg_24_0._uiLayerDict[arg_24_1] = var_24_0
		end
	end

	return var_24_0
end

function var_0_0.getContainer(arg_25_0, arg_25_1)
	return arg_25_0._viewContainerDict[arg_25_1]
end

function var_0_0._createContainer(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._viewContainerDict[arg_26_1]

	if not var_26_0 then
		local var_26_1 = arg_26_0:getSetting(arg_26_1)

		if var_26_1 == nil then
			logError("view setting is nil " .. arg_26_1)
		end

		local var_26_2 = getModulePath(var_26_1.container)

		if var_26_2 then
			var_26_0 = addGlobalModule(var_26_2).New()

			var_26_0:__onInit()
			var_26_0:setSetting(arg_26_1, var_26_1)
		else
			logError("ViewContainer class path not exist: " .. arg_26_1)
		end
	end

	return var_26_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
