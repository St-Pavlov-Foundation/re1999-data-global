module("modules.logic.commandstation.view.CommandStationBonusItem", package.seeall)

local var_0_0 = class("CommandStationBonusItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goGrey = gohelper.findChild(arg_1_1, "point/grey")
	arg_1_0._txtPoint = gohelper.findChildTextMesh(arg_1_1, "point/#txt_point")
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	local var_2_0 = CommandStationConfig.instance:getCurPaperCount()
	local var_2_1 = tabletool.indexOf(CommandStationModel.instance.gainBonus, arg_2_1.id)
	local var_2_2 = not var_2_1 and var_2_0 >= arg_2_1.pointNum
	local var_2_3 = ItemModel.instance:getItemDataListByConfigStr(arg_2_1.bonus)

	gohelper.setActive(arg_2_0._goGrey, var_2_0 < arg_2_1.pointNum)

	arg_2_0._txtPoint.text = arg_2_1.pointNum

	for iter_2_0 = 1, 2 do
		local var_2_4 = gohelper.findChild(arg_2_0.go, tostring(iter_2_0))

		arg_2_0:_refreshItem(var_2_4, var_2_3[iter_2_0], var_2_1, var_2_2)
	end
end

function var_0_0._refreshItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not arg_3_2 then
		gohelper.setActive(arg_3_1, false)

		return
	end

	gohelper.setActive(arg_3_1, true)

	local var_3_0 = gohelper.findChild(arg_3_1, "go_canget")
	local var_3_1 = gohelper.findChildButtonWithAudio(arg_3_1, "go_canget/btn_click")
	local var_3_2 = gohelper.findChild(arg_3_1, "go_receive")
	local var_3_3 = gohelper.findChild(arg_3_1, "go_icon")

	gohelper.setActive(var_3_0, arg_3_4)
	gohelper.setActive(var_3_2, arg_3_3)

	local var_3_4

	if var_3_3.transform.childCount > 0 then
		var_3_4 = MonoHelper.getLuaComFromGo(var_3_3.transform:GetChild(var_3_3.transform.childCount - 1).gameObject, CommonPropItemIcon)
	end

	var_3_4 = var_3_4 or IconMgr.instance:getCommonPropItemIcon(var_3_3)

	var_3_4:onUpdateMO(arg_3_2)
	var_3_4:setConsume(true)
	var_3_4:showStackableNum2()
	var_3_4:isShowEffect(true)
	var_3_4:setAutoPlay(true)
	var_3_4:setCountFontSize(48)
	arg_3_0:addClickCb(var_3_1, arg_3_0._sendGetAllBonus, arg_3_0)
end

function var_0_0._sendGetAllBonus(arg_4_0)
	CommandStationRpc.instance:sendCommandPostBonusAllRequest()
end

return var_0_0
