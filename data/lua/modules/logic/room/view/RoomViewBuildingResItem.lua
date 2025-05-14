module("modules.logic.room.view.RoomViewBuildingResItem", package.seeall)

local var_0_0 = class("RoomViewBuildingResItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goselect = gohelper.findChild(arg_1_0._go, "go_select")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0._go, "go_unselect")
	arg_1_0._goline = gohelper.findChild(arg_1_0._go, "go_line")
	arg_1_0._txt1 = gohelper.findChildText(arg_1_0._go, "go_select/txt")
	arg_1_0._txt2 = gohelper.findChildText(arg_1_0._go, "go_unselect/txt")
	arg_1_0._btnItem = SLFramework.UGUI.ButtonWrap.Get(arg_1_0._go)

	arg_1_0._btnItem:AddClickListener(arg_1_0._btnitemOnClick, arg_1_0)
end

function var_0_0.removeEventListeners(arg_2_0)
	arg_2_0._btnItem:RemoveClickListener()

	arg_2_0._callback = nil
	arg_2_0._callbackObj = nil
end

function var_0_0._btnitemOnClick(arg_3_0)
	if arg_3_0._callback then
		if arg_3_0._callbackObj ~= nil then
			arg_3_0._callback(arg_3_0._callbackObj, arg_3_0._data)
		else
			arg_3_0._callback(arg_3_0._data)
		end
	end
end

function var_0_0.getGO(arg_4_0)
	return arg_4_0._go
end

function var_0_0.setCallback(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._callback = arg_5_1
	arg_5_0._callbackObj = arg_5_2
end

function var_0_0.setSelect(arg_6_0, arg_6_1)
	if arg_6_0._isSelect == arg_6_1 then
		return
	end

	arg_6_0._isSelect = arg_6_1 and true or false

	gohelper.setActive(arg_6_0._goselect, arg_6_1)
	gohelper.setActive(arg_6_0._gounselect, not arg_6_1)
end

function var_0_0.getData(arg_7_0)
	return arg_7_0._data
end

function var_0_0.setData(arg_8_0, arg_8_1)
	if arg_8_0._data ~= arg_8_1 then
		arg_8_0._data = arg_8_1

		arg_8_0:_refreshUI()
	end
end

function var_0_0.setLineActive(arg_9_0, arg_9_1)
	if arg_9_1 ~= null then
		gohelper.setActive(arg_9_0._goline, arg_9_1)
	end
end

function var_0_0._refreshUI(arg_10_0)
	if arg_10_0._data and arg_10_0._txt1 then
		local var_10_0 = luaLang(arg_10_0._data.nameLanguage)

		arg_10_0._txt1.text = var_10_0
		arg_10_0._txt2.text = var_10_0
	end
end

return var_0_0
