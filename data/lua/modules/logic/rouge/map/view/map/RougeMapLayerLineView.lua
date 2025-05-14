module("modules.logic.rouge.map.view.map.RougeMapLayerLineView", package.seeall)

local var_0_0 = class("RougeMapLayerLineView", BaseView)

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
end

function var_0_0.onChangeMapInfo(arg_5_0)
	if not RougeMapModel.instance:isPathSelect() then
		arg_5_0:hide()

		return
	end

	arg_5_0:initData()
end

function var_0_0.onSelectLayerChange(arg_6_0, arg_6_1)
	arg_6_0.selectLayerId = arg_6_1

	arg_6_0:refreshLayerSelect()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:hide()

	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	arg_7_0:initData()
end

function var_0_0.initData(arg_8_0)
	arg_8_0.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	arg_8_0.nextLayerList = RougeMapModel.instance:getNextLayerList()
	arg_8_0.selectLayerId = RougeMapModel.instance:getSelectLayerId()
end

function var_0_0.onPathSelectMapFocusDone(arg_9_0)
	arg_9_0:show()
	arg_9_0:refreshLayer()
end

function var_0_0.refreshLayer(arg_10_0)
	local var_10_0, var_10_1 = RougeMapHelper.getPos(arg_10_0.pathSelectCo.startPos)

	recthelper.setAnchor(arg_10_0.rectTrStart, var_10_0, var_10_1)

	local var_10_2, var_10_3 = RougeMapHelper.getPos(arg_10_0.pathSelectCo.endPos)

	recthelper.setAnchor(arg_10_0.rectTrEnd, var_10_2, var_10_3)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.nextLayerList) do
		local var_10_4 = lua_rouge_layer.configDict[iter_10_1]
		local var_10_5 = arg_10_0.lineItemList[iter_10_0] or arg_10_0:createLineItem(var_10_4)

		gohelper.setActive(var_10_5.lineContainer, true)

		var_10_5.lineContainer.name = var_10_4.id

		var_10_5.simageLine:LoadImage(var_10_4.pathRes, arg_10_0.onLoadImageDone, var_10_5)

		local var_10_6 = var_10_4.name

		var_10_5.txtSelectLayerName.text = var_10_6
		var_10_5.txtUnSelectLayerName.text = var_10_6
		var_10_5.layerCo = var_10_4

		local var_10_7, var_10_8 = RougeMapHelper.getPos(var_10_4.pathPos)

		recthelper.setAnchor(var_10_5.rectLine, var_10_7, var_10_8)

		local var_10_9, var_10_10 = RougeMapHelper.getPos(var_10_4.iconPos)

		recthelper.setAnchor(var_10_5.rectLineIcon, var_10_9, var_10_10)

		local var_10_11 = var_10_5.layerCo.id == arg_10_0.selectLayerId

		var_10_5.animator:Play(var_10_11 and "select_open" or "unselect_open")
		ZProj.UGUIHelper.SetColorAlpha(var_10_5.imageLine, var_10_11 and 1 or 0.33)
	end

	for iter_10_2 = #arg_10_0.nextLayerList + 1, #arg_10_0.lineItemList do
		gohelper.setActive(arg_10_0.lineItemList[iter_10_2].lineContainer, false)
	end
end

function var_0_0.refreshLayerSelect(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0.lineItemList) do
		local var_11_0 = iter_11_1.layerCo.id == arg_11_0.selectLayerId

		iter_11_1.animator:Play(var_11_0 and "select" or "unselect")
		ZProj.UGUIHelper.SetColorAlpha(iter_11_1.imageLine, var_11_0 and 1 or 0.33)
	end
end

function var_0_0.createLineItem(arg_12_0)
	local var_12_0 = arg_12_0:getUserDataTb_()
	local var_12_1 = gohelper.create2d(arg_12_0.goLineContainer)
	local var_12_2 = gohelper.clone(arg_12_0.goLine, var_12_1, "line")
	local var_12_3 = gohelper.clone(arg_12_0.goLineIconItem, var_12_1, "lineIcon")

	gohelper.setActive(var_12_2, true)
	gohelper.setActive(var_12_3, true)

	var_12_0.lineContainer = var_12_1
	var_12_0.rectLine = var_12_2:GetComponent(gohelper.Type_RectTransform)
	var_12_0.rectLineIcon = var_12_3:GetComponent(gohelper.Type_RectTransform)
	var_12_0.simageLine = SLFramework.UGUI.SingleImage.Get(var_12_2)
	var_12_0.imageLine = var_12_2:GetComponent(gohelper.Type_Image)
	var_12_0.iconSelect = gohelper.findChild(var_12_3, "select")
	var_12_0.txtSelectLayerName = gohelper.findChildText(var_12_3, "select/#txt_line")
	var_12_0.iconUnSelect = gohelper.findChild(var_12_3, "unselect")
	var_12_0.txtUnSelectLayerName = gohelper.findChildText(var_12_3, "unselect/#txt_line")
	var_12_0.animator = var_12_3:GetComponent(gohelper.Type_Animator)
	var_12_0.click = gohelper.getClickWithDefaultAudio(var_12_3)

	var_12_0.click:AddClickListener(arg_12_0.onClickLine, arg_12_0, var_12_0)
	gohelper.setActive(var_12_0.iconSelect, true)
	gohelper.setActive(var_12_0.iconUnSelect, true)
	table.insert(arg_12_0.lineItemList, var_12_0)

	return var_12_0
end

function var_0_0.onClickLine(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.layerCo.id

	RougeMapModel.instance:updateSelectLayerId(var_13_0)
end

function var_0_0.onLoadImageDone(arg_14_0)
	arg_14_0.imageLine:SetNativeSize()
end

function var_0_0.show(arg_15_0)
	gohelper.setActive(arg_15_0.goLineContainer, true)
end

function var_0_0.hide(arg_16_0)
	gohelper.setActive(arg_16_0.goLineContainer, false)
end

function var_0_0.onDestroyView(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.lineItemList) do
		iter_17_1.simageLine:UnLoadImage()
		iter_17_1.click:RemoveClickListener()
	end

	arg_17_0.lineItemList = nil
end

return var_0_0
