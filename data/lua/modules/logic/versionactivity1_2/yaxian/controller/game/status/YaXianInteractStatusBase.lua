module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractStatusBase", package.seeall)

local var_0_0 = class("YaXianInteractStatusBase", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.interactItem = arg_2_1
	arg_2_0.interactMo = arg_2_1.interactMo
	arg_2_0.iconGoContainer = arg_2_1.iconGoContainer
	arg_2_0.config = arg_2_0.interactMo.config

	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, arg_2_0.onUpdateEffectInfo, arg_2_0)
	arg_2_0:addEventCb(YaXianGameController.instance, YaXianEvent.RefreshInteractStatus, arg_2_0.refreshStatus, arg_2_0)
end

function var_0_0.onUpdateEffectInfo(arg_3_0)
	arg_3_0:refreshStatus(arg_3_0.isShow)
end

function var_0_0.refreshStatus(arg_4_0, arg_4_1)
	arg_4_0:stopLoopSwitchAnimation()

	arg_4_0.isShow = arg_4_1

	if not arg_4_1 then
		gohelper.setActive(arg_4_0.iconGo, false)

		return
	end

	if not arg_4_0.iconGo then
		arg_4_0:loadIconPrefab()

		return
	end

	if not YaXianGameController.instance:isSelectingPlayer() then
		gohelper.setActive(arg_4_0.iconGo, false)

		return
	end

	arg_4_0:updateStatus()

	local var_4_0 = arg_4_0:hasStatus()

	gohelper.setActive(arg_4_0.iconGo, var_4_0)

	if var_4_0 then
		arg_4_0:startStatusAnimation()
	end
end

function var_0_0.updateStatus(arg_5_0)
	arg_5_0.statusDict = {}
end

function var_0_0.addStatus(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.statusDict[arg_6_1]

	if not var_6_0 then
		var_6_0 = YaXianGameController.instance:getInteractStatusPool():getObject()
		arg_6_0.statusDict[arg_6_1] = var_6_0
	end

	var_6_0:addStatus(arg_6_1, arg_6_2)
end

function var_0_0.hasStatus(arg_7_0)
	return arg_7_0.statusDict and next(arg_7_0.statusDict)
end

function var_0_0.loadIconPrefab(arg_8_0)
	if arg_8_0.iconLoader then
		return
	end

	arg_8_0.iconLoader = PrefabInstantiate.Create(arg_8_0.iconGoContainer)

	arg_8_0.iconLoader:startLoad(YaXianGameEnum.SceneResPath.MonsterStatus, arg_8_0.onIconLoadCallback, arg_8_0)
end

function var_0_0.onIconLoadCallback(arg_9_0)
	arg_9_0.iconGo = arg_9_0.iconLoader:getInstGO()
	arg_9_0.statusGoDict = arg_9_0:getUserDataTb_()
	arg_9_0.statusGoDict[YaXianGameEnum.IconStatus.Assassinate] = gohelper.findChild(arg_9_0.iconGo, "ansha")
	arg_9_0.statusGoDict[YaXianGameEnum.IconStatus.Fight] = gohelper.findChild(arg_9_0.iconGo, "zhandou")
	arg_9_0.statusGoDict[YaXianGameEnum.IconStatus.InVisible] = gohelper.findChild(arg_9_0.iconGo, "yingsheng")
	arg_9_0.statusGoDict[YaXianGameEnum.IconStatus.ThroughWall] = gohelper.findChild(arg_9_0.iconGo, "chuanqiang")
	arg_9_0.statusGoDict[YaXianGameEnum.IconStatus.PlayerAssassinate] = gohelper.findChild(arg_9_0.iconGo, "dead")
	arg_9_0.statusAnimatorDict = arg_9_0:getUserDataTb_()
	arg_9_0.statusDirectionDict = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_0.statusGoDict) do
		arg_9_0.statusAnimatorDict[iter_9_0] = iter_9_1:GetComponent(typeof(UnityEngine.Animator))

		if YaXianGameEnum.DirectionIcon[iter_9_0] then
			arg_9_0.statusDirectionDict[iter_9_0] = arg_9_0:getUserDataTb_()

			for iter_9_2, iter_9_3 in pairs(YaXianGameEnum.MoveDirection) do
				arg_9_0.statusDirectionDict[iter_9_0][iter_9_3] = gohelper.findChild(iter_9_1, YaXianGameEnum.DirectionName[iter_9_3])
			end
		end
	end

	arg_9_0:refreshStatus(arg_9_0.isShow)
end

function var_0_0.startStatusAnimation(arg_10_0)
	if not arg_10_0.statusDict then
		gohelper.setActive(arg_10_0.iconGo, false)

		return
	end

	arg_10_0.statusLen = tabletool.len(arg_10_0.statusDict)

	if arg_10_0.statusLen <= 0 then
		gohelper.setActive(arg_10_0.iconGo, false)

		return
	end

	gohelper.setActive(arg_10_0.iconGo, true)

	if arg_10_0.statusLen == 1 then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.statusDict) do
			arg_10_0:showOneStatusIcon(iter_10_0)
		end

		return
	end

	arg_10_0.statusList = {}

	for iter_10_2, iter_10_3 in pairs(arg_10_0.statusDict) do
		table.insert(arg_10_0.statusList, iter_10_2)
	end

	arg_10_0.currentShowStatusIndex = 0

	arg_10_0:startLoopSwitchAnimation()
end

function var_0_0.showOneStatusIcon(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.statusGoDict) do
		gohelper.setActive(iter_11_1, false)
	end

	gohelper.setActive(arg_11_0.statusGoDict[arg_11_1], true)

	if YaXianGameEnum.DirectionIcon[arg_11_1] then
		local var_11_0 = arg_11_0.statusDict[arg_11_1]

		for iter_11_2, iter_11_3 in pairs(arg_11_0.statusDirectionDict[arg_11_1]) do
			gohelper.setActive(iter_11_3, false)
		end

		if var_11_0.directionList then
			for iter_11_4, iter_11_5 in pairs(var_11_0.directionList) do
				gohelper.setActive(arg_11_0.statusDirectionDict[arg_11_1][iter_11_5], true)
			end
		end
	end
end

function var_0_0.stopStatusAnimation(arg_12_0)
	arg_12_0:stopLoopSwitchAnimation()
	gohelper.setActive(arg_12_0.iconGo, false)

	if arg_12_0.statusDict then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.statusDict) do
			YaXianGameController.instance:getInteractStatusPool():putObject(iter_12_1)
		end
	end

	arg_12_0.statusDict = nil
	arg_12_0.statusList = nil
end

function var_0_0.startLoopSwitchAnimation(arg_13_0)
	arg_13_0.flow = FlowSequence.New()

	local var_13_0 = arg_13_0.currentShowStatusIndex

	if var_13_0 > 0 then
		local var_13_1 = arg_13_0.statusList[var_13_0]
		local var_13_2 = arg_13_0.statusAnimatorDict[var_13_1]

		arg_13_0.flow:addWork(DelayFuncWork.New(arg_13_0.playIconCloseAnimation, arg_13_0, YaXianGameEnum.IconAnimationDuration, var_13_2))
	end

	arg_13_0.currentShowStatusIndex = arg_13_0.currentShowStatusIndex + 1

	if arg_13_0.currentShowStatusIndex > arg_13_0.statusLen then
		arg_13_0.currentShowStatusIndex = 1
	end

	local var_13_3 = arg_13_0.statusList[arg_13_0.currentShowStatusIndex]
	local var_13_4 = arg_13_0.statusAnimatorDict[var_13_3]

	arg_13_0.flow:addWork(DelayFuncWork.New(arg_13_0.playIconOpenAnimation, arg_13_0, YaXianGameEnum.IconAnimationDuration, var_13_4))
	arg_13_0.flow:registerDoneListener(arg_13_0.onSwitchAnimationDone, arg_13_0)
	arg_13_0.flow:start()
end

function var_0_0.playIconCloseAnimation(arg_14_0, arg_14_1)
	arg_14_1:Play("close")
end

function var_0_0.playIconOpenAnimation(arg_15_0, arg_15_1)
	arg_15_0:showOneStatusIcon(arg_15_0.statusList[arg_15_0.currentShowStatusIndex])
	arg_15_1:Play("open")
end

function var_0_0.onSwitchAnimationDone(arg_16_0)
	TaskDispatcher.runDelay(arg_16_0.startLoopSwitchAnimation, arg_16_0, YaXianGameEnum.IconAnimationSwitchInterval)
end

function var_0_0.stopLoopSwitchAnimation(arg_17_0)
	if arg_17_0.flow then
		arg_17_0.flow:destroy()
	end

	TaskDispatcher.cancelTask(arg_17_0.startLoopSwitchAnimation, arg_17_0)
end

function var_0_0.dispose(arg_18_0)
	arg_18_0:stopStatusAnimation()

	if arg_18_0.iconLoader then
		arg_18_0.iconLoader:dispose()
	end

	arg_18_0:__onDispose()
end

return var_0_0
