module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapNodeItem", package.seeall)

local var_0_0 = class("WuErLiXiGameMapNodeItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "icon")
	arg_1_0._goselected = gohelper.findChild(arg_1_1, "#go_Selected")
	arg_1_0._gounplaceable = gohelper.findChild(arg_1_1, "#go_Unplaceable")
	arg_1_0._goput = gohelper.findChild(arg_1_1, "#go_Put")
	arg_1_0._gohighlight = gohelper.findChild(arg_1_1, "#go_Highlight")
	arg_1_0._goconfirm = gohelper.findChild(arg_1_1, "#go_Confirm")
end

function var_0_0.setItem(arg_2_0, arg_2_1)
	arg_2_0._nodeMo = arg_2_1

	gohelper.setActive(arg_2_0.go, true)

	arg_2_0.go.name = arg_2_1.x .. "_" .. arg_2_1.y

	arg_2_0:refreshItem()
end

function var_0_0.hide(arg_3_0)
	gohelper.setActive(arg_3_0.go, false)
end

function var_0_0.showUnplace(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._gounplaceable, arg_4_1)
end

function var_0_0.showHightLight(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 and not arg_5_0._nodeMo:getNodeUnit()

	gohelper.setActive(arg_5_0._gohighlight, arg_5_1)
end

function var_0_0.showPlaceable(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._goconfirm, arg_6_1)
end

function var_0_0.showPut(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._goput, arg_7_1)
end

function var_0_0.showSelect(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goselected, arg_8_1)
end

function var_0_0.refreshItem(arg_9_0)
	local var_9_0 = WuErLiXiMapModel.instance:getCurSelectUnit()

	arg_9_0._unitMo = arg_9_0._nodeMo:getNodeUnit()

	if arg_9_0._unitMo then
		gohelper.setActive(arg_9_0._goselected, var_9_0[1] == arg_9_0._unitMo.x and var_9_0[2] == arg_9_0._unitMo.y)

		if arg_9_0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalStart or arg_9_0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd then
			UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_9_0._imageicon, "v2a4_wuerlixi_node_icon4")

			return
		end
	else
		gohelper.setActive(arg_9_0._goselected, false)
	end

	if WuErLiXiMapModel.instance:isNodeHasInitUnit(arg_9_0._nodeMo) then
		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_9_0._imageicon, "v2a4_wuerlixi_node_icon5")

		return
	end

	if WuErLiXiMapModel.instance:isNodeHasUnit(arg_9_0._nodeMo) then
		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_9_0._imageicon, "v2a4_wuerlixi_node_icon2")

		return
	end

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_9_0._imageicon, "v2a4_wuerlixi_node_icon1")
end

function var_0_0.getNodeMo(arg_10_0)
	return arg_10_0._nodeMo
end

function var_0_0.destroy(arg_11_0)
	return
end

return var_0_0
