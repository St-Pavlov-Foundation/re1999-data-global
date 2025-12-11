module("modules.logic.gm.view.yeshumei.GMYeShuMeiLine", package.seeall)

local var_0_0 = class("GMYeShuMeiLine", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
	arg_1_0._btnDelete = gohelper.findChildButton(arg_1_1, "btn/btn_delete")
	arg_1_0._txtname = gohelper.findChildText(arg_1_1, "#txt_name")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnDelete:AddClickListener(arg_2_0._onDeleteClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnDelete:RemoveClickListener()
end

function var_0_0._onDeleteClick(arg_4_0)
	if arg_4_0._point2 == nil or arg_4_0._point1 == nil and GMYeShuMeiModel.instance:getCurLine() ~= nil then
		arg_4_0:onDestroy()
		GMYeShuMeiModel.instance:deleteLines(arg_4_0._lineData.id)
		GMYeShuMeiModel.instance:setCurLine(nil)

		return
	end

	if arg_4_0._lineData == nil then
		return
	end

	local var_4_0 = arg_4_0._lineData.id

	GMYeShuMeiModel.instance:deleteLines(var_4_0)

	if arg_4_0._deleteCb ~= nil then
		arg_4_0._deleteCb(arg_4_0._deleteObj, var_4_0)
	end
end

function var_0_0.initData(arg_5_0, arg_5_1)
	arg_5_0._lineData = arg_5_1
	arg_5_0.id = arg_5_1.id
end

function var_0_0.updatePoint(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._point1 = arg_6_1
	arg_6_0._point2 = arg_6_2

	arg_6_0:updateByPoint()
end

function var_0_0.addPoint(arg_7_0, arg_7_1)
	if arg_7_0._point1 == nil then
		arg_7_0._point1 = arg_7_1
	end

	if arg_7_0._point2 == nil and arg_7_0._point1.id ~= arg_7_1.id then
		arg_7_0._point2 = arg_7_1
	end

	arg_7_0:updateByPoint()

	if arg_7_0._point1 ~= nil and arg_7_0._point2 ~= nil then
		if arg_7_0._okCb ~= nil then
			arg_7_0._okCb(arg_7_0._okObj, arg_7_0)
		end

		GMYeShuMeiModel.instance:setCurLine(nil)
	end
end

function var_0_0.updateByPoint(arg_8_0)
	if arg_8_0._point1 ~= nil and arg_8_0._point2 ~= nil then
		local var_8_0, var_8_1 = arg_8_0._point1:getLocalPos()
		local var_8_2, var_8_3 = arg_8_0._point2:getLocalPos()

		arg_8_0:updateItem(var_8_0, var_8_1, var_8_2, var_8_3)
		arg_8_0._lineData:updatePos(var_8_0, var_8_1, var_8_2, var_8_3)
		arg_8_0._lineData:updatePoint(arg_8_0._point1.id, arg_8_0._point2.id)

		local var_8_4 = arg_8_0._getIndexCb(arg_8_0._getIndexObj, arg_8_0._lineData.id)

		arg_8_0._txtname.text = string.format("%s - %s", arg_8_0._point1.id, arg_8_0._point2.id)
	end
end

function var_0_0.addDeleteCb(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._deleteCb = arg_9_1
	arg_9_0._deleteObj = arg_9_2
end

function var_0_0.addAddCb(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._okCb = arg_10_1
	arg_10_0._okObj = arg_10_2
end

function var_0_0.addGetIndexCb(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._getIndexCb = arg_11_1
	arg_11_0._getIndexObj = arg_11_2
end

function var_0_0.updateItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	transformhelper.setLocalPosXY(arg_12_0._tr, arg_12_1, arg_12_2)

	local var_12_0 = MathUtil.vec2_length(arg_12_1, arg_12_2, arg_12_3, arg_12_4)

	recthelper.setWidth(arg_12_0._tr, var_12_0)

	local var_12_1 = MathUtil.calculateV2Angle(arg_12_3, arg_12_4, arg_12_1, arg_12_2)

	transformhelper.setEulerAngles(arg_12_0._tr, 0, 0, var_12_1)

	local var_12_2 = arg_12_0._getIndexCb(arg_12_0._getIndexObj, arg_12_0._lineData.id)

	arg_12_0._txtname.text = string.format("%s - %s", arg_12_0._point1.id, arg_12_0._point2.id)
end

function var_0_0.onDestroy(arg_13_0)
	gohelper.destroy(arg_13_0.go)
	GMYeShuMeiModel.instance:deleteLines(arg_13_0.id)
end

return var_0_0
