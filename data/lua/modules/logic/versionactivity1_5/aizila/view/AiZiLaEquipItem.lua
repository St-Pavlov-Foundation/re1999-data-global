module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEquipItem", package.seeall)

local var_0_0 = class("AiZiLaEquipItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gounSelected = gohelper.findChild(arg_1_0.viewGO, "go_unSelected")
	arg_1_0._txtunlevel = gohelper.findChildText(arg_1_0.viewGO, "go_unSelected/txt_unlevel")
	arg_1_0._txtunname = gohelper.findChildText(arg_1_0.viewGO, "go_unSelected/txt_unname")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "go_selected")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "go_selected/txt_level")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "go_selected/txt_name")
	arg_1_0._goLeUp = gohelper.findChild(arg_1_0.viewGO, "image_LvUp")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn_Click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._btnClickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
end

function var_0_0._btnClickOnClick(arg_4_0)
	AiZiLaController.instance:dispatchEvent(AiZiLaEvent.UISelectEquipType, arg_4_0:getTypeId())
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._govxrefresh = gohelper.findChild(arg_5_0.viewGO, "vx_refresh")
end

function var_0_0.onDestroy(arg_6_0)
	return
end

function var_0_0.setName(arg_7_0, arg_7_1)
	arg_7_0._txtunname.text = arg_7_1
	arg_7_0._txtname.text = arg_7_1
end

function var_0_0.setCfg(arg_8_0, arg_8_1)
	arg_8_0._config = arg_8_1
	arg_8_0._typeId = arg_8_1.typeId

	arg_8_0:setName(arg_8_1.name)
end

function var_0_0.getTypeId(arg_9_0)
	return arg_9_0._typeId
end

function var_0_0.refreshUpLevel(arg_10_0)
	arg_10_0:refreshUI()
	gohelper.setActive(arg_10_0._govxrefresh, false)
	gohelper.setActive(arg_10_0._govxrefresh, true)
end

function var_0_0.refreshUI(arg_11_0, arg_11_1)
	local var_11_0 = AiZiLaModel.instance:getEquipMO(arg_11_0._typeId)

	gohelper.setActive(arg_11_0._txtlevel, var_11_0)
	gohelper.setActive(arg_11_0._txtunlevel, var_11_0)
	gohelper.setActive(arg_11_0._goLeUp, arg_11_1 ~= true and var_11_0 and var_11_0:isCanUpLevel())

	if var_11_0 then
		local var_11_1 = var_11_0:getConfig()
		local var_11_2 = var_11_1 and var_11_1.level

		if arg_11_0._lastLevel ~= var_11_2 then
			arg_11_0._lastLevel = var_11_2

			local var_11_3 = string.format("Lv.%s", var_11_2)

			arg_11_0._txtlevel.text = var_11_3
			arg_11_0._txtunlevel.text = var_11_3
		end
	end
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._goselected, arg_12_1)
	gohelper.setActive(arg_12_0._gounSelected, not arg_12_1)
end

return var_0_0
