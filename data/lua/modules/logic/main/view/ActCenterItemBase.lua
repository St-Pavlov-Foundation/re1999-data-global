module("modules.logic.main.view.ActCenterItemBase", package.seeall)

local var_0_0 = class("ActCenterItemBase", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0._transform = arg_1_1.transform
	arg_1_0._imgGo = gohelper.findChild(arg_1_1, "bg")
	arg_1_0._imgitem = gohelper.findChildImage(arg_1_1, "bg")
	arg_1_0._btnitem = gohelper.findChildClick(arg_1_1, "bg")
	arg_1_0._goactivityreddot = gohelper.findChild(arg_1_1, "go_activityreddot")
	arg_1_0._txttheme = gohelper.findChildText(arg_1_1, "txt_theme")
	arg_1_0._godeadline = gohelper.findChild(arg_1_1, "#go_deadline")
	arg_1_0._txttime = gohelper.findChildText(arg_1_1, "#go_deadline/#txt_time")
	arg_1_0._act_iconbgGo = gohelper.findChild(arg_1_1, "act_iconbg")
	arg_1_0._act_iconbg_effGo = gohelper.findChild(arg_1_1, "act_iconbg_eff")
	arg_1_0._goexpup = gohelper.findChild(arg_1_0.go, "#go_expup")

	arg_1_0:onInit(arg_1_1)
	arg_1_0:_addEvent()
	gohelper.setActive(arg_1_1, true)
end

function var_0_0.onDestroyView(arg_2_0)
	arg_2_0:_removeEvent()
	gohelper.setActive(arg_2_0.go, false)
	gohelper.destroy(arg_2_0.go)
	arg_2_0:onDestroy()
	arg_2_0:__onDispose()
end

function var_0_0._addEvent(arg_3_0)
	arg_3_0._btnitem:AddClickListener(arg_3_0.onClick, arg_3_0)
	arg_3_0:onAddEvent()
end

function var_0_0._removeEvent(arg_4_0)
	arg_4_0._btnitem:RemoveClickListener()
	arg_4_0:onRemoveEvent()
end

function var_0_0._onOpen(arg_5_0, ...)
	arg_5_0:onOpen(...)
end

function var_0_0.refresh(arg_6_0, ...)
	if not arg_6_0.__isFirst then
		arg_6_0:_onOpen(...)

		arg_6_0.__isFirst = true
	end

	arg_6_0:onRefresh(...)
end

function var_0_0._addNotEventRedDot(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._redDot = RedDotController.instance:addNotEventRedDot(arg_7_0._goactivityreddot, arg_7_1, arg_7_2)
end

function var_0_0.isShowRedDot(arg_8_0)
	return arg_8_0._redDot and arg_8_0._redDot.isShowRedDot
end

function var_0_0._setMainSprite(arg_9_0, arg_9_1)
	UISpriteSetMgr.instance:setMainSprite(arg_9_0._imgitem, arg_9_1)
end

function var_0_0.setSiblingIndex(arg_10_0, arg_10_1)
	arg_10_0._transform:SetSiblingIndex(arg_10_1)
end

function var_0_0._refreshRedDot(arg_11_0)
	if arg_11_0._redDot then
		arg_11_0._redDot:refreshRedDot()
	end
end

function var_0_0.setCustomData(arg_12_0, arg_12_1)
	arg_12_0._data = arg_12_1
end

function var_0_0.getCustomData(arg_13_0)
	return arg_13_0._data
end

function var_0_0.onInit(arg_14_0, arg_14_1)
	return
end

function var_0_0.onDestroy(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	return
end

function var_0_0.onRefresh(arg_17_0, ...)
	arg_17_0:refreshRedDot()
end

function var_0_0.onAddEvent(arg_18_0)
	return
end

function var_0_0.onRemoveEvent(arg_19_0)
	return
end

function var_0_0.onClick(arg_20_0)
	assert(false, "please override 'onClick' function!!")
end

return var_0_0
