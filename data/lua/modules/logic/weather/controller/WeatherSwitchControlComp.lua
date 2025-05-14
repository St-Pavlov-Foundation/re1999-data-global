module("modules.logic.weather.controller.WeatherSwitchControlComp", package.seeall)

local var_0_0 = class("WeatherSwitchControlComp", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_up")
	arg_1_0._goexpand = gohelper.findChild(arg_1_0.viewGO, "#go_expand")
	arg_1_0._gonumitem = gohelper.findChild(arg_1_0.viewGO, "#go_expand/go_numitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_expand/#btn_close")
	arg_1_0._btnmiddle = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_middle")
	arg_1_0._middleicon = gohelper.findChildImage(arg_1_0.viewGO, "#btn_middle/icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#btn_middle/icon/#txt_num")
	arg_1_0._btndown = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_down")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnup:AddClickListener(arg_2_0._btnupOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnmiddle:AddClickListener(arg_2_0._btnmiddleOnClick, arg_2_0)
	arg_2_0._btndown:AddClickListener(arg_2_0._btndownOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnup:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnmiddle:RemoveClickListener()
	arg_3_0._btndown:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._goexpand, false)
end

function var_0_0._btnupOnClick(arg_5_0)
	arg_5_0._switchComp:switchPrevLightMode()
	arg_5_0:_updateBtnStatus()
	arg_5_0:_startDelayUpdateStatus()
end

function var_0_0._btnmiddleOnClick(arg_6_0)
	arg_6_0._showExpand = true

	gohelper.setActive(arg_6_0._goexpand, true)

	local var_6_0 = arg_6_0._switchComp:getReportList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if not arg_6_0._itemList[iter_6_0] then
			local var_6_1 = gohelper.cloneInPlace(arg_6_0._gonumitem, iter_6_0)

			arg_6_0:_onItemShow(var_6_1, iter_6_1, iter_6_0)
		else
			local var_6_2 = arg_6_0._itemList[iter_6_0]

			gohelper.setActive(var_6_2 and var_6_2.go, true)
		end
	end

	for iter_6_2 = #var_6_0 + 1, #arg_6_0._itemList do
		local var_6_3 = arg_6_0._itemList[iter_6_2]

		gohelper.setActive(var_6_3 and var_6_3.go, false)
	end

	arg_6_0:_updateItemSelectStatus()
end

function var_0_0._onItemShow(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	gohelper.findChildText(arg_7_1, "#txt_num").text = arg_7_3

	local var_7_0 = gohelper.findChild(arg_7_1, "select")
	local var_7_1 = gohelper.findChildButtonWithAudio(arg_7_1, "#btn_click")

	var_7_1:AddClickListener(arg_7_0._btnclickOnClick, arg_7_0, arg_7_3)

	arg_7_0._itemList[arg_7_3] = {
		go = arg_7_1,
		selectGo = var_7_0,
		btn = var_7_1
	}

	gohelper.setActive(arg_7_1, true)
	gohelper.setActive(var_7_0, false)
	gohelper.setSiblingAfter(arg_7_1, arg_7_0._gonumitem)
end

function var_0_0._btnclickOnClick(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._goexpand, false)

	if arg_8_0._switchComp:getReportIndex() == arg_8_1 then
		return
	end

	arg_8_0._switchComp:switchReport(arg_8_1)
end

function var_0_0._btndownOnClick(arg_9_0)
	arg_9_0._switchComp:switchNextLightMode()
	arg_9_0:_updateBtnStatus()
	arg_9_0:_startDelayUpdateStatus()
end

function var_0_0._updateBtnStatus(arg_10_0)
	if not arg_10_0._switchComp then
		return
	end

	local var_10_0 = arg_10_0._switchComp:getLightMode()
	local var_10_1 = arg_10_0._switchComp:getReportIndex()

	arg_10_0._txtnum.text = var_10_1
	arg_10_0._btnup.button.interactable = var_10_0 ~= 1
	arg_10_0._btndown.button.interactable = var_10_0 ~= 4

	UISpriteSetMgr.instance:setStoreGoodsSprite(arg_10_0._middleicon, arg_10_0._iconMap[var_10_0])
	arg_10_0:_updateItemSelectStatus()
end

function var_0_0._updateItemSelectStatus(arg_11_0)
	local var_11_0 = arg_11_0._switchComp:getReportIndex()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._itemList) do
		gohelper.setActive(iter_11_1.selectGo, iter_11_0 == var_11_0)
	end
end

function var_0_0._editableInitView(arg_12_0)
	gohelper.setActive(arg_12_0._goexpand, false)
	gohelper.setActive(arg_12_0._gonumitem, false)
	gohelper.setActive(arg_12_0._btnclose, false)

	arg_12_0._itemList = arg_12_0:getUserDataTb_()
	arg_12_0._iconMap = {
		[WeatherEnum.LightModeDuring] = "store_weathericon_01",
		[WeatherEnum.LightModeOvercast] = "store_weathericon_03",
		[WeatherEnum.LightModeDusk] = "store_weathericon_02",
		[WeatherEnum.LightModeNight] = "store_weathericon_04"
	}
	arg_12_0._cdTime = CommonConfig.instance:getConstNum(ConstEnum.MainSceneChangeCD) / 1000

	arg_12_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_12_0._onTouch, arg_12_0)
end

function var_0_0._startDelayUpdateStatus(arg_13_0)
	arg_13_0._btnup.button.interactable = false
	arg_13_0._btndown.button.interactable = false

	TaskDispatcher.cancelTask(arg_13_0._delayUpdateStatus, arg_13_0)
	TaskDispatcher.runDelay(arg_13_0._delayUpdateStatus, arg_13_0, arg_13_0._cdTime)
end

function var_0_0._delayUpdateStatus(arg_14_0)
	arg_14_0:_updateBtnStatus()
end

function var_0_0._onTouch(arg_15_0)
	if arg_15_0._showExpand then
		arg_15_0._showExpand = false

		return
	end

	gohelper.setActive(arg_15_0._goexpand, false)
end

function var_0_0._editableAddEvents(arg_16_0)
	return
end

function var_0_0._editableRemoveEvents(arg_17_0)
	return
end

function var_0_0.updateScene(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0._switchComp then
		arg_18_0._switchComp:removeReportChangeCallback()

		arg_18_0._switchComp = nil
	end

	arg_18_0._switchComp = arg_18_2:getSwitchComp(arg_18_1)

	gohelper.setActive(arg_18_0.viewGO, arg_18_0._switchComp ~= nil)

	if not arg_18_0._switchComp then
		return
	end

	arg_18_0._switchComp:addReportChangeCallback(arg_18_0._updateBtnStatus, arg_18_0)
	arg_18_0:_updateBtnStatus()
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._switchComp = nil

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._itemList) do
		iter_19_1.btn:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_19_0._delayUpdateStatus, arg_19_0)
end

return var_0_0
