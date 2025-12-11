module("modules.logic.gm.view.yeshumei.GMYeShuMeiView", package.seeall)

local var_0_0 = class("GMYeShuMeiView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnroot/#btn_add")
	arg_1_0._btnaddline = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnroot/#btn_addline")
	arg_1_0._btnload = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnroot/#btn_load")
	arg_1_0._btnsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnroot/#btn_save")
	arg_1_0._nodeRoot = gohelper.findChild(arg_1_0.viewGO, "noderoot")
	arg_1_0._gonode = gohelper.findChild(arg_1_0.viewGO, "noderoot/#go_node")
	arg_1_0._lineRoot = gohelper.findChild(arg_1_0.viewGO, "lineroot")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "lineroot/#go_line")
	arg_1_0._orderRoot = gohelper.findChild(arg_1_0.viewGO, "btnroot/orderroot")
	arg_1_0._goorder = gohelper.findChild(arg_1_0.viewGO, "btnroot/orderroot/orderitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._inpActId = gohelper.findChildInputField(arg_1_0.viewGO, "btnroot/input/Input_actId")
	arg_1_0._inpLineOrder = gohelper.findChildInputField(arg_1_0.viewGO, "btnroot/orderinput/Input_order")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnload:AddClickListener(arg_2_0._btnloadOnClick, arg_2_0)
	arg_2_0._btnsave:AddClickListener(arg_2_0._btnsaveOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnaddline:AddClickListener(arg_2_0._btnaddlineOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnload:RemoveClickListener()
	arg_3_0._btnsave:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnaddline:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnaddOnClick(arg_5_0)
	if not arg_5_0._curLevelData then
		return
	end

	local var_5_0
	local var_5_1 = GMYeShuMeiModel.instance:addPoint()

	if not var_5_1 then
		return
	end

	if arg_5_0.pointItems == nil then
		arg_5_0.pointItems = arg_5_0:getUserDataTb_()
	end

	local var_5_2 = arg_5_0:createPoint(var_5_1.id)

	if var_5_2 and var_5_1 then
		var_5_2.comp:updateInfo(var_5_1)
	end
end

function var_0_0._btnaddlineOnClick(arg_6_0)
	local var_6_0 = arg_6_0._inpLineOrder:GetText()

	if not arg_6_0._curLevelData then
		return
	end

	if not GMYeShuMeiModel.instance:addOrders(var_6_0) then
		return
	end

	if arg_6_0.orderItems == nil then
		arg_6_0.orderItems = arg_6_0:getUserDataTb_()
	end

	local var_6_1 = arg_6_0:createOrder()

	if var_6_1 and var_6_0 then
		var_6_1.comp:initOrder(var_6_0)
	end

	arg_6_0:switchOrder(var_6_0)
end

function var_0_0._btnloadOnClick(arg_7_0)
	local var_7_0 = tonumber(arg_7_0._inpActId:GetText())

	arg_7_0._curLevelData = GMYeShuMeiModel.instance:setCurLevelId(var_7_0)

	arg_7_0:refreshView()
end

function var_0_0._btnsaveOnClick(arg_8_0)
	GMYeShuMeiModel.instance:saveAndExport()
end

function var_0_0._editableInitView(arg_9_0)
	return
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	return
end

function var_0_0.refreshView(arg_12_0)
	if arg_12_0._curLevelData == nil then
		return
	end

	arg_12_0:_clearLine()
	arg_12_0:_initPoint()
	arg_12_0:_initLine()
	arg_12_0:_initOrder()
end

function var_0_0._initOrder(arg_13_0)
	local var_13_0 = string.split(arg_13_0._curLevelData.orderstr, "|")

	if arg_13_0.orderItems == nil then
		arg_13_0.orderItems = arg_13_0:getUserDataTb_()

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			GMYeShuMeiModel.instance:addOrders(iter_13_1)
			arg_13_0:createOrder().comp:initOrder(iter_13_1)
		end

		arg_13_0:switchOrder(var_13_0[1])
	else
		for iter_13_2, iter_13_3 in ipairs(arg_13_0.orderItems) do
			iter_13_3.comp:onDestroy()
		end

		tabletool.clear(arg_13_0.orderItems)

		for iter_13_4, iter_13_5 in ipairs(var_13_0) do
			(arg_13_0.orderItems[iter_13_4] or arg_13_0:createOrder()).comp:initOrder(iter_13_5)
		end
	end
end

function var_0_0.createOrder(arg_14_0)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = gohelper.clone(arg_14_0._goorder, arg_14_0._orderRoot, "order")
	var_14_0.comp = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_0.go, GMYeShuMeiOrder)

	var_14_0.comp:addDeleteCb(arg_14_0.deleteOrder, arg_14_0)
	var_14_0.comp:addSwitchCb(arg_14_0.switchOrder, arg_14_0)
	table.insert(arg_14_0.orderItems, var_14_0)

	return var_14_0
end

function var_0_0.deleteOrder(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.orderItems) do
		if iter_15_1.comp:getOrder() == arg_15_1 then
			GMYeShuMeiModel.instance:deleteOrders(arg_15_1)
			iter_15_1.comp:onDestroy()
			table.remove(arg_15_0.orderItems, iter_15_0)

			if #arg_15_0.orderItems > 0 then
				GMYeShuMeiModel.instance:setCurLevelOrder(arg_15_0.orderItems[1].comp:getOrder())
				arg_15_0:switchOrder(arg_15_0.orderItems[1].comp:getOrder())
			end
		end
	end
end

function var_0_0.switchOrder(arg_16_0, arg_16_1)
	GMYeShuMeiModel.instance:setCurLevelOrder(arg_16_1)

	local var_16_0 = string.splitToNumber(arg_16_1, "#")
	local var_16_1 = #var_16_0

	arg_16_0:_clearLine()

	for iter_16_0 = 1, var_16_1 - 1 do
		local var_16_2 = arg_16_0:getPointById(var_16_0[iter_16_0])
		local var_16_3 = arg_16_0:getPointById(var_16_0[iter_16_0 + 1])

		if not var_16_2 then
			logError("请检查节点" .. var_16_0[iter_16_0])

			return
		end

		if not var_16_3 then
			logError("请检查节点" .. var_16_0[iter_16_0 + 1])

			return
		end

		if var_16_2 and var_16_3 and not GMYeShuMeiModel.instance:checkLineExist(var_16_2.id, var_16_3.id) then
			local var_16_4 = GMYeShuMeiModel.instance:addLines()
			local var_16_5 = arg_16_0:createLine(var_16_4.id)

			var_16_5:initData(var_16_4)
			var_16_5:updatePoint(var_16_2, var_16_3)

			arg_16_0._lineItem[var_16_4.id] = var_16_5
		end
	end

	arg_16_0:_refreshOrder()
end

function var_0_0._refreshOrder(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.orderItems) do
		iter_17_1.comp:updateOrder()
	end
end

function var_0_0._initPoint(arg_18_0)
	local var_18_0 = arg_18_0._curLevelData.points

	if arg_18_0.pointItems == nil then
		arg_18_0.pointItems = arg_18_0:getUserDataTb_()

		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			arg_18_0:createPoint(iter_18_0).comp:updateInfo(iter_18_1)
		end
	else
		for iter_18_2, iter_18_3 in ipairs(arg_18_0.pointItems) do
			iter_18_3.comp:onDestroy()
		end

		tabletool.clear(arg_18_0.pointItems)

		for iter_18_4, iter_18_5 in ipairs(var_18_0) do
			(arg_18_0.pointItems[iter_18_4] or arg_18_0:createPoint(iter_18_4)).comp:updateInfo(iter_18_5)
		end
	end
end

function var_0_0.createPoint(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getUserDataTb_()

	var_19_0.go = gohelper.clone(arg_19_0._gonode, arg_19_0._nodeRoot, "point" .. arg_19_1)
	var_19_0.comp = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_0.go, GMYeShuMeiPoint)

	table.insert(arg_19_0.pointItems, var_19_0)
	var_19_0.comp:addDeleteCb(arg_19_0.deletePoint, arg_19_0)
	var_19_0.comp:addRefreshLineCb(arg_19_0.refreshAllLine, arg_19_0)

	return var_19_0
end

function var_0_0.deletePoint(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._lineItem) do
		if iter_20_1._point1 and iter_20_1._point1.id == arg_20_1 or iter_20_1._point2 and iter_20_1._point2.id == arg_20_1 then
			iter_20_1:onDestroy()
			arg_20_0:deleteLines(iter_20_1._lineData.id)
		end
	end

	GMYeShuMeiModel.instance:deletePoint(arg_20_1)

	for iter_20_2, iter_20_3 in ipairs(arg_20_0.pointItems) do
		if iter_20_3.comp:checkPointId(arg_20_1) then
			iter_20_3.comp:onDestroy()
			table.remove(arg_20_0.pointItems, iter_20_2)
		end
	end
end

function var_0_0._initLine(arg_21_0)
	arg_21_0._lineItem = arg_21_0:getUserDataTb_()

	local var_21_0 = arg_21_0._curLevelData.lines

	if arg_21_0._lineItem ~= nil then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._lineItem) do
			iter_21_1:onDestroy()
		end

		tabletool.clear(arg_21_0._lineItem)
	else
		arg_21_0._lineItem = arg_21_0:getUserDataTb_()
	end

	for iter_21_2 = 1, #var_21_0 do
		local var_21_1 = var_21_0[iter_21_2]

		if var_21_1 ~= nil then
			local var_21_2 = arg_21_0:createLine(var_21_1.id)

			var_21_2:initData(var_21_1)

			local var_21_3 = arg_21_0:getPointById(var_21_1._beginPointId)
			local var_21_4 = arg_21_0:getPointById(var_21_1._endPointId)

			var_21_2:updatePoint(var_21_3, var_21_4)

			arg_21_0._lineItem[var_21_1.id] = var_21_2
		end
	end
end

function var_0_0.createLine(arg_22_0, arg_22_1)
	if not arg_22_0._curLevelData then
		return
	end

	local var_22_0 = gohelper.clone(arg_22_0._goline, arg_22_0._lineRoot, "line" .. arg_22_1)
	local var_22_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_0, GMYeShuMeiLine)

	gohelper.setActive(var_22_0, true)
	var_22_1:addAddCb(arg_22_0.relyAddLine, arg_22_0)
	var_22_1:addGetIndexCb(arg_22_0.getIndexOfLine, arg_22_0)

	return var_22_1
end

function var_0_0.deleteLines(arg_23_0, arg_23_1)
	if arg_23_0._lineItem[arg_23_1] ~= nil then
		arg_23_0._lineItem[arg_23_1]:onDestroy()

		arg_23_0._lineItem[arg_23_1] = nil
	end

	arg_23_0:refreshAllLine()
end

function var_0_0.getIndexOfLine(arg_24_0, arg_24_1)
	if not arg_24_0._lineItem or #arg_24_0._lineItem == 0 then
		return
	end

	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(arg_24_0._lineItem) do
		var_24_0 = var_24_0 + 1

		if arg_24_1 == iter_24_1._lineData.id then
			return var_24_0
		end
	end
end

function var_0_0.relyAddLine(arg_25_0, arg_25_1)
	if arg_25_0._lineItem == nil then
		arg_25_0._lineItem = arg_25_0:getUserDataTb_()
	end

	arg_25_0._lineItem[arg_25_1._lineData.id] = arg_25_1
end

function var_0_0.getPointById(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.pointItems) do
		if iter_26_1.comp.id == arg_26_1 then
			return iter_26_1.comp
		end
	end

	return nil
end

function var_0_0.refreshAllLine(arg_27_0)
	if arg_27_0._lineItem and #arg_27_0._lineItem > 0 then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._lineItem) do
			if iter_27_1 then
				iter_27_1:updateByPoint()
			end
		end
	end
end

function var_0_0._clearLine(arg_28_0)
	if arg_28_0._lineItem and #arg_28_0._lineItem > 0 then
		for iter_28_0, iter_28_1 in pairs(arg_28_0._lineItem) do
			iter_28_1:onDestroy()
		end

		tabletool.clear(arg_28_0._lineItem)
	end
end

function var_0_0.onClose(arg_29_0)
	GMYeShuMeiModel.instance:clearData()

	if arg_29_0.pointItems and #arg_29_0.pointItems > 0 then
		for iter_29_0, iter_29_1 in ipairs(arg_29_0.pointItems) do
			iter_29_1.comp:onDestroy()
		end
	end

	arg_29_0:_clearLine()
end

function var_0_0.onDestroyView(arg_30_0)
	return
end

return var_0_0
