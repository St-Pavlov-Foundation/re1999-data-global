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

	arg_1_0:_initActEff()

	arg_1_0._goexpup = gohelper.findChild(arg_1_0.go, "#go_expup")

	arg_1_0:onInit(arg_1_1)
	arg_1_0:_addEvent()
	gohelper.setActive(arg_1_1, true)
end

function var_0_0.onDestroyView(arg_2_0)
	arg_2_0:_removeEvent()
	arg_2_0:onDestroy()
	gohelper.destroy(arg_2_0.go)
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

function var_0_0.getMainActAtmosphereConfig(arg_14_0)
	return ActivityConfig.instance:getMainActAtmosphereConfig()
end

function var_0_0.isShowActivityEffect(arg_15_0, arg_15_1)
	if arg_15_0._isShowActivityEffect == nil or arg_15_1 then
		arg_15_0._isShowActivityEffect = ActivityModel.showActivityEffect()
	end

	return arg_15_0._isShowActivityEffect
end

function var_0_0._initActEff(arg_16_0)
	local var_16_0 = ActivityConfig.instance:getMainActAtmosphereConfig()

	arg_16_0._mainViewActBtnGoList = arg_16_0:getUserDataTb_()

	for iter_16_0, iter_16_1 in ipairs(var_16_0.mainViewActBtn or {}) do
		arg_16_0._mainViewActBtnGoList[iter_16_0] = gohelper.findChild(arg_16_0.go, iter_16_1)
	end

	local var_16_1 = arg_16_0:isShowActivityEffect()

	for iter_16_2, iter_16_3 in pairs(arg_16_0._mainViewActBtnGoList) do
		gohelper.setActive(iter_16_3, var_16_1)
	end

	arg_16_0:_setActive_act_iconbg(var_16_1 and ActivityModel.checkIsShowFxVisible())
end

function var_0_0.onInit(arg_17_0, arg_17_1)
	return
end

function var_0_0.onDestroy(arg_18_0)
	return
end

function var_0_0.onOpen(arg_19_0)
	return
end

function var_0_0.onRefresh(arg_20_0, ...)
	arg_20_0:refreshRedDot()
end

function var_0_0.onAddEvent(arg_21_0)
	return
end

function var_0_0.onRemoveEvent(arg_22_0)
	return
end

function var_0_0.onClick(arg_23_0)
	assert(false, "please override 'onClick' function!!")
end

function var_0_0._setActive_act_iconbg(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._act_iconbgGo, arg_24_1)
	gohelper.setActive(arg_24_0._act_iconbg_effGo, arg_24_1)
end

return var_0_0
