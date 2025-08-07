module("modules.ugui.icon.common.CommonRedDotIcon", package.seeall)

local var_0_0 = class("CommonRedDotIcon", ListScrollCell)

function var_0_0.forceCheckDotIsShow(arg_1_0)
	arg_1_0.show = false

	if arg_1_0.infoList then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0.infoList) do
			arg_1_0.show = RedDotModel.instance:isDotShow(iter_1_1.id, iter_1_1.uid)

			if arg_1_0.show then
				return true
			end
		end
	end

	return false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, arg_2_1)
	arg_2_0._txtCount = gohelper.findChildText(arg_2_0.go, "type2/#txt_count")
	arg_2_0.typeGoDict = arg_2_0:getUserDataTb_()

	for iter_2_0, iter_2_1 in pairs(RedDotEnum.Style) do
		arg_2_0.typeGoDict[iter_2_1] = gohelper.findChild(arg_2_0.go, "type" .. iter_2_1)

		gohelper.setActive(arg_2_0.typeGoDict[iter_2_1], false)
	end
end

function var_0_0.addEventListeners(arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, arg_3_0.refreshDot, arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, arg_3_0.refreshDot, arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshRelateDot, arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, arg_3_0.refreshDot, arg_3_0)
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.UseMainUI, arg_3_0.defaultRefreshDot, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, arg_4_0.refreshDot, arg_4_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, arg_4_0.refreshDot, arg_4_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_4_0.refreshRelateDot, arg_4_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, arg_4_0.refreshDot, arg_4_0)
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.UseMainUI, arg_4_0.defaultRefreshDot, arg_4_0)
end

function var_0_0.onStart(arg_5_0)
	arg_5_0:refreshDot()
end

function var_0_0.refreshDot(arg_6_0)
	gohelper.setActive(arg_6_0.go, false)

	if arg_6_0.overrideFunc then
		local var_6_0, var_6_1 = pcall(arg_6_0.overrideFunc, arg_6_0.overrideFuncObj, arg_6_0)

		if not var_6_0 then
			logError(string.format("CommonRedDotIcon:overrideFunc error:%s", var_6_1))
		end

		return
	end

	arg_6_0:defaultRefreshDot()
end

function var_0_0.defaultRefreshDot(arg_7_0)
	arg_7_0.show = false

	local var_7_0 = MainUISwitchModel.instance:getCurUseUI()

	if arg_7_0.infoList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.infoList) do
			arg_7_0.show = RedDotModel.instance:isDotShow(iter_7_1.id, iter_7_1.uid)

			if arg_7_0.show then
				local var_7_1 = RedDotModel.instance:getDotInfoCount(iter_7_1.id, iter_7_1.uid)

				arg_7_0._txtCount.text = var_7_1

				local var_7_2 = RedDotConfig.instance:getRedDotCO(iter_7_1.id).style
				local var_7_3 = MainUISwitchConfig.instance:getUIReddotStyle(var_7_0, iter_7_1.id)

				if var_7_3 then
					var_7_2 = var_7_3.style
				end

				arg_7_0:showRedDot(var_7_2)

				return
			end
		end
	end
end

function var_0_0.refreshRelateDot(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		if arg_8_0.infoDict[iter_8_0] then
			arg_8_0:refreshDot()

			return
		end
	end
end

function var_0_0.setScale(arg_9_0, arg_9_1)
	transformhelper.setLocalScale(arg_9_0.go.transform, arg_9_1, arg_9_1, arg_9_1)
end

function var_0_0.setId(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:setMultiId({
		{
			id = arg_10_1,
			uid = arg_10_2
		}
	})
end

function var_0_0.setMultiId(arg_11_0, arg_11_1)
	arg_11_0.infoDict = {}

	if arg_11_1 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			iter_11_1.uid = iter_11_1.uid or 0
			arg_11_0.infoDict[iter_11_1.id] = iter_11_1.uid
		end
	end

	arg_11_0.infoList = arg_11_1
end

function var_0_0.showRedDot(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0.go, arg_12_0.show)

	if arg_12_0.show then
		for iter_12_0, iter_12_1 in pairs(RedDotEnum.Style) do
			gohelper.setActive(arg_12_0.typeGoDict[iter_12_1], arg_12_1 == iter_12_1)
		end
	end
end

function var_0_0.SetRedDotTrsWithType(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0.typeGoDict[arg_13_1].transform

	recthelper.setAnchor(var_13_0, arg_13_2, arg_13_3)
end

function var_0_0.setRedDotTranScale(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_2 = arg_14_2 or 1
	arg_14_3 = arg_14_3 or 1
	arg_14_4 = arg_14_4 or 1

	local var_14_0 = arg_14_0.typeGoDict[arg_14_1].transform

	transformhelper.setLocalScale(var_14_0, arg_14_2, arg_14_3, arg_14_4)
end

function var_0_0.setRedDotTranLocalRotation(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_2 = arg_15_2 or 0
	arg_15_3 = arg_15_3 or 0
	arg_15_4 = arg_15_4 or 0

	local var_15_0 = arg_15_0.typeGoDict[arg_15_1].transform

	transformhelper.setLocalRotation(var_15_0, arg_15_2, arg_15_3, arg_15_4)
end

function var_0_0.overrideRefreshDotFunc(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0.overrideFunc = arg_16_1
	arg_16_0.overrideFuncObj = arg_16_2
end

function var_0_0.onDestroy(arg_17_0)
	return
end

return var_0_0
