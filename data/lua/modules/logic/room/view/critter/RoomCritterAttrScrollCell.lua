module("modules.logic.room.view.critter.RoomCritterAttrScrollCell", package.seeall)

local var_0_0 = class("RoomCritterAttrScrollCell", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#txt_name/#image_icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_num")
	arg_1_0._txtratio = gohelper.findChildText(arg_1_0.viewGO, "#txt_ratio")

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
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.getDataMO(arg_7_0)
	return arg_7_0._critterAttributeInfoMO
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._critterAttributeInfoMO = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = arg_11_0._critterAttributeInfoMO

	if not var_11_0 then
		return
	end

	local var_11_1 = math.floor(var_11_0.rate * 0.01) * 0.01 .. luaLang("multiple")

	arg_11_0._txtnum.text = var_11_0.value
	arg_11_0._txtratio.text = var_11_1

	if arg_11_0._txtname then
		arg_11_0._txtname.text = var_11_0:getName()
	end

	if arg_11_0._imageicon and not string.nilorempty(var_11_0:getIcon()) then
		UISpriteSetMgr.instance:setCritterSprite(arg_11_0._imageicon, var_11_0:getIcon())
	end

	gohelper.setActive(arg_11_0._goArrow, var_11_0:getIsAddition())
end

return var_0_0
