module("modules.logic.room.view.topright.RoomViewTopRightBaseItem", package.seeall)

local var_0_0 = class("RoomViewTopRightBaseItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._param = arg_1_1
	arg_1_0._parent = arg_1_0._param.parent
	arg_1_0._index = arg_1_0._param.index
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._bgType = 2
	arg_2_0.go = arg_2_1
	arg_2_0._resourceItem = arg_2_0:getUserDataTb_()
	arg_2_0._resourceItem.go = arg_2_0.go
	arg_2_0._resourceItem.canvasGroup = arg_2_0._resourceItem.go:GetComponent(typeof(UnityEngine.CanvasGroup))

	for iter_2_0 = 1, 2 do
		local var_2_0 = gohelper.findChild(arg_2_0._resourceItem.go, "bg" .. iter_2_0)

		gohelper.setActive(var_2_0, iter_2_0 == arg_2_0._bgType)
	end

	arg_2_0._resourceItem.txtquantity = gohelper.findChildText(arg_2_0._resourceItem.go, "txt_quantity")
	arg_2_0._resourceItem.txtaddNum = gohelper.findChildText(arg_2_0._resourceItem.go, "txt_quantity/txt_addNum")
	arg_2_0._resourceItem.btnclick = gohelper.findChildButtonWithAudio(arg_2_0._resourceItem.go, "btn_click")
	arg_2_0._resourceItem.goflypos = gohelper.findChild(arg_2_0._resourceItem.go, "go_flypos")
	arg_2_0._resourceItem.goeffect = gohelper.findChild(arg_2_0._resourceItem.go, "go_flypos/#flyvx")

	arg_2_0._resourceItem.btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
	gohelper.setActive(arg_2_0._resourceItem.go, true)
	gohelper.setActive(arg_2_0._resourceItem.goflypos, true)
	gohelper.setActive(arg_2_0._resourceItem.goeffect, false)
	gohelper.setActive(arg_2_0._resourceItem.txtaddNum, false)

	arg_2_0._canvasGroup = arg_2_0.go:GetComponent(typeof(UnityEngine.CanvasGroup))

	if arg_2_0._customOnInit then
		arg_2_0:_customOnInit()
	end

	arg_2_0:_refreshUI()
end

function var_0_0._setShow(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.go, arg_3_1)

	arg_3_0._canvasGroup.alpha = arg_3_1 and 1 or 0
	arg_3_0._canvasGroup.blocksRaycasts = arg_3_1
end

function var_0_0._customOnInit(arg_4_0)
	return
end

function var_0_0._onClick(arg_5_0)
	return
end

function var_0_0.addEventListeners(arg_6_0)
	return
end

function var_0_0.removeEventListeners(arg_7_0)
	return
end

function var_0_0._refreshUI(arg_8_0)
	return
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0._resourceItem.btnclick:RemoveClickListener()

	if arg_9_0._customOnDestory then
		arg_9_0:_customOnDestory()
	end
end

function var_0_0._customOnDestory(arg_10_0)
	return
end

return var_0_0
