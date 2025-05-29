module("modules.logic.rouge.map.view.map.RougeMapLayerLineView", package.seeall)

local var_0_0 = class("RougeMapLayerLineView", BaseView)
local var_0_1 = 43
local var_0_2 = 0

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goLineContainer = gohelper.findChild(arg_1_0.viewGO, "#go_linecontainer")
	arg_1_0.goLineIconItem = gohelper.findChild(arg_1_0.viewGO, "#go_linecontainer/#go_lineitem")
	arg_1_0.goLine = gohelper.findChild(arg_1_0.viewGO, "#go_linecontainer/#go_line")
	arg_1_0.goStart = gohelper.findChild(arg_1_0.viewGO, "#go_linecontainer/#go_start")
	arg_1_0.goEnd = gohelper.findChild(arg_1_0.viewGO, "#go_linecontainer/#go_end")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0.goLineIconItem, false)
	gohelper.setActive(arg_4_0.goLine, false)

	arg_4_0.rectTrStart = arg_4_0.goStart:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrEnd = arg_4_0.goEnd:GetComponent(gohelper.Type_RectTransform)

	arg_4_0:hide()

	arg_4_0.lineItemList = {}

	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLayerChange, arg_4_0.onSelectLayerChange, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, arg_4_0.onPathSelectMapFocusDone, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_4_0.onChangeMapInfo, arg_4_0)
	arg_4_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_4_0.onUpdateMapInfo, arg_4_0)
end

function var_0_0.onChangeMapInfo(arg_5_0)
	if not RougeMapModel.instance:isPathSelect() then
		arg_5_0:hide()

		return
	end

	arg_5_0:initData()
end

function var_0_0.onUpdateMapInfo(arg_6_0)
	if not RougeMapModel.instance:isPathSelect() then
		arg_6_0:hide()

		return
	end

	arg_6_0:refreshLayer()
end

function var_0_0.onSelectLayerChange(arg_7_0, arg_7_1)
	arg_7_0.selectLayerId = arg_7_1

	arg_7_0:refreshLayerSelect()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:hide()

	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	arg_8_0:initData()
end

function var_0_0.initData(arg_9_0)
	arg_9_0.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	arg_9_0.nextLayerList = RougeMapModel.instance:getNextLayerList()
	arg_9_0.selectLayerId = RougeMapModel.instance:getSelectLayerId()
end

function var_0_0.onPathSelectMapFocusDone(arg_10_0)
	arg_10_0:show()
	arg_10_0:refreshLayer()
end

function var_0_0.refreshLayer(arg_11_0)
	local var_11_0, var_11_1 = RougeMapHelper.getPos(arg_11_0.pathSelectCo.startPos)

	recthelper.setAnchor(arg_11_0.rectTrStart, var_11_0, var_11_1)

	local var_11_2, var_11_3 = RougeMapHelper.getPos(arg_11_0.pathSelectCo.endPos)

	recthelper.setAnchor(arg_11_0.rectTrEnd, var_11_2, var_11_3)

	local var_11_4 = RougeDLCHelper.isUsingTargetDLC(RougeDLCEnum.DLCEnum.DLC_103)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.nextLayerList) do
		local var_11_5 = lua_rouge_layer.configDict[iter_11_1]
		local var_11_6 = arg_11_0.lineItemList[iter_11_0] or arg_11_0:createLineItem(var_11_5)

		gohelper.setActive(var_11_6.lineContainer, true)

		var_11_6.lineContainer.name = var_11_5.id

		var_11_6.simageLine:LoadImage(var_11_5.pathRes, arg_11_0.onLoadImageDone, var_11_6)

		local var_11_7 = var_11_5.name

		var_11_6.txtSelectLayerName.text = var_11_7
		var_11_6.txtUnSelectLayerName.text = var_11_7
		var_11_6.layerCo = var_11_5

		local var_11_8, var_11_9 = RougeMapHelper.getPos(var_11_5.pathPos)

		recthelper.setAnchor(var_11_6.rectLine, var_11_8, var_11_9)

		local var_11_10, var_11_11 = RougeMapHelper.getPos(var_11_5.iconPos)

		recthelper.setAnchor(var_11_6.rectLineIcon, var_11_10, var_11_11)

		local var_11_12 = var_11_6.layerCo.id == arg_11_0.selectLayerId

		var_11_6.animator:Play(var_11_12 and "select_open" or "unselect_open")
		ZProj.UGUIHelper.SetColorAlpha(var_11_6.imageLine, var_11_12 and 1 or 0.33)
		gohelper.setActive(var_11_6.goselectdlc3, var_11_4)
		gohelper.setActive(var_11_6.gounselectdlc3, var_11_4)
		recthelper.setAnchorY(var_11_6.goarrow.transform, var_11_4 and var_0_1 or var_0_2)

		if var_11_4 then
			local var_11_13 = RougeMapModel.instance:getLayerChoiceInfo(iter_11_1)
			local var_11_14 = var_11_13 and var_11_13:getMapRuleType()

			gohelper.setActive(var_11_6.goselectdlc3_normal, var_11_14 == RougeDLCEnum103.MapRuleType.Normal)
			gohelper.setActive(var_11_6.goselectdlc3_hard, var_11_14 == RougeDLCEnum103.MapRuleType.Hard)
			gohelper.setActive(var_11_6.gounselectdlc3_normal, var_11_14 == RougeDLCEnum103.MapRuleType.Normal)
			gohelper.setActive(var_11_6.gounselectdlc3_hard, var_11_14 == RougeDLCEnum103.MapRuleType.Hard)
		end
	end

	for iter_11_2 = #arg_11_0.nextLayerList + 1, #arg_11_0.lineItemList do
		gohelper.setActive(arg_11_0.lineItemList[iter_11_2].lineContainer, false)
	end
end

function var_0_0.refreshLayerSelect(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.lineItemList) do
		local var_12_0 = iter_12_1.layerCo.id == arg_12_0.selectLayerId

		iter_12_1.animator:Play(var_12_0 and "select" or "unselect")
		ZProj.UGUIHelper.SetColorAlpha(iter_12_1.imageLine, var_12_0 and 1 or 0.33)
	end
end

function var_0_0.createLineItem(arg_13_0)
	local var_13_0 = arg_13_0:getUserDataTb_()
	local var_13_1 = gohelper.create2d(arg_13_0.goLineContainer)
	local var_13_2 = gohelper.clone(arg_13_0.goLine, var_13_1, "line")
	local var_13_3 = gohelper.clone(arg_13_0.goLineIconItem, var_13_1, "lineIcon")

	gohelper.setActive(var_13_2, true)
	gohelper.setActive(var_13_3, true)

	var_13_0.lineContainer = var_13_1
	var_13_0.rectLine = var_13_2:GetComponent(gohelper.Type_RectTransform)
	var_13_0.rectLineIcon = var_13_3:GetComponent(gohelper.Type_RectTransform)
	var_13_0.simageLine = SLFramework.UGUI.SingleImage.Get(var_13_2)
	var_13_0.imageLine = var_13_2:GetComponent(gohelper.Type_Image)
	var_13_0.iconSelect = gohelper.findChild(var_13_3, "select")
	var_13_0.txtSelectLayerName = gohelper.findChildText(var_13_3, "select/#txt_line")
	var_13_0.iconUnSelect = gohelper.findChild(var_13_3, "unselect")
	var_13_0.txtUnSelectLayerName = gohelper.findChildText(var_13_3, "unselect/#txt_line")
	var_13_0.animator = var_13_3:GetComponent(gohelper.Type_Animator)
	var_13_0.goselectdlc3 = gohelper.findChild(var_13_3, "select/#go_dlc3")
	var_13_0.goselectdlc3_normal = gohelper.findChild(var_13_3, "select/#go_dlc3/normal")
	var_13_0.goselectdlc3_hard = gohelper.findChild(var_13_3, "select/#go_dlc3/hard")
	var_13_0.gounselectdlc3 = gohelper.findChild(var_13_3, "unselect/#go_dlc3")
	var_13_0.gounselectdlc3_normal = gohelper.findChild(var_13_3, "unselect/#go_dlc3/normal")
	var_13_0.gounselectdlc3_hard = gohelper.findChild(var_13_3, "unselect/#go_dlc3/hard")
	var_13_0.goarrow = gohelper.findChild(var_13_3, "select/arrow")
	var_13_0.click = gohelper.getClickWithDefaultAudio(var_13_3)

	var_13_0.click:AddClickListener(arg_13_0.onClickLine, arg_13_0, var_13_0)
	gohelper.setActive(var_13_0.iconSelect, true)
	gohelper.setActive(var_13_0.iconUnSelect, true)
	table.insert(arg_13_0.lineItemList, var_13_0)

	return var_13_0
end

function var_0_0.onClickLine(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.layerCo.id

	RougeMapModel.instance:updateSelectLayerId(var_14_0)
end

function var_0_0.onLoadImageDone(arg_15_0)
	arg_15_0.imageLine:SetNativeSize()
end

function var_0_0.show(arg_16_0)
	gohelper.setActive(arg_16_0.goLineContainer, true)
end

function var_0_0.hide(arg_17_0)
	gohelper.setActive(arg_17_0.goLineContainer, false)
end

function var_0_0.onDestroyView(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.lineItemList) do
		iter_18_1.simageLine:UnLoadImage()
		iter_18_1.click:RemoveClickListener()
	end

	arg_18_0.lineItemList = nil
end

return var_0_0
