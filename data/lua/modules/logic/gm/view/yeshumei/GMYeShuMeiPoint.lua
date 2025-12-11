module("modules.logic.gm.view.yeshumei.GMYeShuMeiPoint", package.seeall)

local var_0_0 = class("GMYeShuMeiPoint", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._tr = arg_1_1.transform

	arg_1_0:initPos(0, 0)
	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._dropdown = gohelper.findChildDropdown(arg_1_1, "Dropdown")
	arg_1_0._btndelete = gohelper.findChildButton(arg_1_1, "btn/btn_delete")
	arg_1_0._txtpos = gohelper.findChildText(arg_1_1, "#txt_pos")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_1, "#txt_index")
	arg_1_0._gostart = gohelper.findChild(arg_1_1, "#go_start")
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "#go_normal")
	arg_1_0._godisturb = gohelper.findChild(arg_1_1, "#go_disturb")

	CommonDragHelper.instance:registerDragObj(arg_1_0.go, arg_1_0._beginDrag, arg_1_0._onDrag, arg_1_0._endDrag, arg_1_0._checkDrag, arg_1_0, nil, true)
end

function var_0_0.initPos(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._localPosX = arg_2_1
	arg_2_0._localPosY = arg_2_2

	transformhelper.setLocalPosXY(arg_2_0._tr, arg_2_1, arg_2_2)
end

function var_0_0.getLocalPos(arg_3_0)
	return arg_3_0._localPosX, arg_3_0._localPosY
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	arg_4_0._mo = arg_4_1
	arg_4_0.id = arg_4_1.id
	arg_4_0.typeId = arg_4_1.typeId
	arg_4_0.posX = arg_4_1.posX
	arg_4_0.posY = arg_4_1.posY

	arg_4_0:initPos(arg_4_0.posX, arg_4_0.posY)

	arg_4_0._txtpos.text = string.format("(%.1f, %.1f)", arg_4_0.posX, arg_4_0.posY)
	arg_4_0._txtindex.text = arg_4_0.id

	arg_4_0:_initTypeDropdown()
	arg_4_0:_updateType(arg_4_0.typeId)
end

function var_0_0.clearPoint(arg_5_0)
	arg_5_0.id = 0
	arg_5_0.typeId = 1
	arg_5_0.posX = 0
	arg_5_0.posY = 0

	arg_5_0:initPos(arg_5_0.posX, arg_5_0.posY)
	gohelper.setActive(arg_5_0.go, false)
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0._dropdown:AddOnValueChanged(arg_6_0._dropdownChange, arg_6_0)
	arg_6_0._btndelete:AddClickListener(arg_6_0._onClickBtnDelete, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0._dropdown:RemoveOnValueChanged()
	arg_7_0._btndelete:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(arg_7_0.go)
end

function var_0_0._initTypeDropdown(arg_8_0)
	arg_8_0._typeNameIdList = {}

	if arg_8_0._dropdown then
		local var_8_0 = YeShuMeiEnum.PointTypeName

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			table.insert(arg_8_0._typeNameIdList, iter_8_0)
		end

		arg_8_0._dropdown:ClearOptions()
		arg_8_0._dropdown:AddOptions(var_8_0)

		local var_8_1 = 0
		local var_8_2 = 1

		for iter_8_2 = 1, #arg_8_0._typeNameIdList do
			if arg_8_0._mo.typeId ~= 0 and arg_8_0._typeNameIdList[iter_8_2] == arg_8_0._mo.typeId then
				var_8_1 = iter_8_2 - 1
				var_8_2 = arg_8_0._mo.typeId
			end
		end

		arg_8_0._dropdown:SetValue(var_8_1)

		arg_8_0.typeId = var_8_2
	end
end

function var_0_0._dropdownChange(arg_9_0, arg_9_1)
	if arg_9_0.isDraging then
		return
	end

	local var_9_0
	local var_9_1 = (arg_9_1 + 1 ~= 1 or nil) and arg_9_0._typeNameIdList[arg_9_1 + 1]

	if var_9_1 ~= arg_9_0.typeId then
		arg_9_0.typeId = var_9_1

		arg_9_0._mo:updateTypeId(arg_9_0.typeId)
	end

	arg_9_0:_updateType(arg_9_0.typeId)
end

function var_0_0._beginDrag(arg_10_0)
	arg_10_0.isDraging = true
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2.position
	local var_11_1 = recthelper.screenPosToAnchorPos(var_11_0, arg_11_0._tr.parent)

	recthelper.setAnchor(arg_11_0._tr, var_11_1.x, var_11_1.y)
	arg_11_0:updateLocalPos()
end

function var_0_0.updateLocalPos(arg_12_0)
	local var_12_0, var_12_1 = transformhelper.getLocalPos(arg_12_0._tr)

	arg_12_0._localPosX = var_12_0
	arg_12_0._localPosY = var_12_1

	arg_12_0._mo:updatePos(arg_12_0._localPosX, arg_12_0._localPosY)

	arg_12_0._txtpos.text = string.format("(%.1f, %.1f)", arg_12_0._localPosX, arg_12_0._localPosY)

	arg_12_0._refreshLineCb(arg_12_0._refreshLineObj)
end

function var_0_0._endDrag(arg_13_0)
	arg_13_0.isDraging = false
end

function var_0_0.checkPointId(arg_14_0, arg_14_1)
	return arg_14_1 == arg_14_0.id
end

function var_0_0._onClickBtnDelete(arg_15_0)
	if arg_15_0._deleteCb ~= nil then
		arg_15_0._deleteCb(arg_15_0._deleteObj, arg_15_0.id)
	end
end

function var_0_0._onClick(arg_16_0)
	local var_16_0 = GMYeShuMeiModel.instance:getCurLine()

	if var_16_0 == nil then
		return
	end

	var_16_0:addPoint(arg_16_0)
end

function var_0_0.addDeleteCb(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._deleteCb = arg_17_1
	arg_17_0._deleteObj = arg_17_2
end

function var_0_0.addRefreshLineCb(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._refreshLineCb = arg_18_1
	arg_18_0._refreshLineObj = arg_18_2
end

function var_0_0._updateType(arg_19_0, arg_19_1)
	if arg_19_1 == YeShuMeiEnum.PointType.Start then
		gohelper.setActive(arg_19_0._gostart, true)
		gohelper.setActive(arg_19_0._gonormal, false)
		gohelper.setActive(arg_19_0._godisturb, false)
	elseif arg_19_1 == YeShuMeiEnum.PointType.Disturb then
		gohelper.setActive(arg_19_0._gostart, false)
		gohelper.setActive(arg_19_0._gonormal, false)
		gohelper.setActive(arg_19_0._godisturb, true)
	else
		gohelper.setActive(arg_19_0._gostart, false)
		gohelper.setActive(arg_19_0._gonormal, true)
		gohelper.setActive(arg_19_0._godisturb, false)
	end
end

function var_0_0.onDestroy(arg_20_0)
	arg_20_0:clearPoint()
	arg_20_0:removeEventListeners()
	gohelper.destroy(arg_20_0.go)
end

return var_0_0
