module("modules.ugui.icon.common.CommonRedDotIcon", package.seeall)

local var_0_0 = class("CommonRedDotIcon", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, arg_1_1)
	arg_1_0._txtCount = gohelper.findChildText(arg_1_0.go, "type2/#txt_count")
	arg_1_0.typeGoDict = arg_1_0:getUserDataTb_()

	for iter_1_0, iter_1_1 in pairs(RedDotEnum.Style) do
		arg_1_0.typeGoDict[iter_1_1] = gohelper.findChild(arg_1_0.go, "type" .. iter_1_1)

		gohelper.setActive(arg_1_0.typeGoDict[iter_1_1], false)
	end
end

function var_0_0.addEventListeners(arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, arg_2_0.refreshDot, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0.refreshRelateDot, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, arg_2_0.refreshDot, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, arg_3_0.refreshDot, arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, arg_3_0.refreshDot, arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0.refreshRelateDot, arg_3_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, arg_3_0.refreshDot, arg_3_0)
end

function var_0_0.onStart(arg_4_0)
	arg_4_0:refreshDot()
end

function var_0_0.refreshDot(arg_5_0)
	gohelper.setActive(arg_5_0.go, false)

	if arg_5_0.overrideFunc then
		local var_5_0, var_5_1 = pcall(arg_5_0.overrideFunc, arg_5_0.overrideFuncObj, arg_5_0)

		if not var_5_0 then
			logError(string.format("CommonRedDotIcon:overrideFunc error:%s", var_5_1))
		end

		return
	end

	arg_5_0:defaultRefreshDot()
end

function var_0_0.defaultRefreshDot(arg_6_0)
	arg_6_0.show = false

	if arg_6_0.infoList then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.infoList) do
			arg_6_0.show = RedDotModel.instance:isDotShow(iter_6_1.id, iter_6_1.uid)

			if arg_6_0.show then
				local var_6_0 = RedDotModel.instance:getDotInfoCount(iter_6_1.id, iter_6_1.uid)

				arg_6_0._txtCount.text = var_6_0

				local var_6_1 = RedDotConfig.instance:getRedDotCO(iter_6_1.id).style

				arg_6_0:showRedDot(var_6_1)

				return
			end
		end
	end
end

function var_0_0.refreshRelateDot(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		if arg_7_0.infoDict[iter_7_0] then
			arg_7_0:refreshDot()

			return
		end
	end
end

function var_0_0.setScale(arg_8_0, arg_8_1)
	transformhelper.setLocalScale(arg_8_0.go.transform, arg_8_1, arg_8_1, arg_8_1)
end

function var_0_0.setId(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:setMultiId({
		{
			id = arg_9_1,
			uid = arg_9_2
		}
	})
end

function var_0_0.setMultiId(arg_10_0, arg_10_1)
	arg_10_0.infoDict = {}

	if arg_10_1 then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
			iter_10_1.uid = iter_10_1.uid or 0
			arg_10_0.infoDict[iter_10_1.id] = iter_10_1.uid
		end
	end

	arg_10_0.infoList = arg_10_1
end

function var_0_0.showRedDot(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0.go, arg_11_0.show)

	if arg_11_0.show then
		for iter_11_0, iter_11_1 in pairs(RedDotEnum.Style) do
			gohelper.setActive(arg_11_0.typeGoDict[iter_11_1], arg_11_1 == iter_11_1)
		end
	end
end

function var_0_0.SetRedDotTrsWithType(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0.typeGoDict[arg_12_1].transform

	recthelper.setAnchor(var_12_0, arg_12_2, arg_12_3)
end

function var_0_0.setRedDotTranScale(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_2 = arg_13_2 or 1
	arg_13_3 = arg_13_3 or 1
	arg_13_4 = arg_13_4 or 1

	local var_13_0 = arg_13_0.typeGoDict[arg_13_1].transform

	transformhelper.setLocalScale(var_13_0, arg_13_2, arg_13_3, arg_13_4)
end

function var_0_0.setRedDotTranLocalRotation(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_2 = arg_14_2 or 0
	arg_14_3 = arg_14_3 or 0
	arg_14_4 = arg_14_4 or 0

	local var_14_0 = arg_14_0.typeGoDict[arg_14_1].transform

	transformhelper.setLocalRotation(var_14_0, arg_14_2, arg_14_3, arg_14_4)
end

function var_0_0.overrideRefreshDotFunc(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.overrideFunc = arg_15_1
	arg_15_0.overrideFuncObj = arg_15_2
end

function var_0_0.onDestroy(arg_16_0)
	return
end

return var_0_0
