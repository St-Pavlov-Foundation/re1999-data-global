module("modules.logic.dungeon.model.RoleStoryDispatchHeroListModel", package.seeall)

local var_0_0 = class("RoleStoryDispatchHeroListModel", ListScrollModel)

function var_0_0.onOpenDispatchView(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.storyMo = arg_1_1
	arg_1_0.dispatchMo = arg_1_2
	arg_1_0.maxSelectCount = arg_1_2.config.count

	arg_1_0:refreshEffectHero()
	arg_1_0:initHeroList()
end

function var_0_0.canShowTalk(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return false
	end

	local var_2_0 = tonumber(arg_2_1.heroid) or 0

	if not var_2_0 or var_2_0 == 0 then
		return true
	end

	return arg_2_0:getSelectedIndex(var_2_0) ~= nil
end

function var_0_0.refreshEffectHero(arg_3_0)
	arg_3_0.effectHeroDict = arg_3_0.dispatchMo:getEffectHeros()
end

function var_0_0.isEffectHero(arg_4_0, arg_4_1)
	return arg_4_0.effectHeroDict[arg_4_1]
end

function var_0_0.refreshHero(arg_5_0)
	arg_5_0:resortHeroList()
	arg_5_0:setList(arg_5_0.heroList)
end

function var_0_0.resortHeroList(arg_6_0)
	table.sort(arg_6_0.heroList, var_0_0._sortFunc)
end

function var_0_0._sortFunc(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:isDispatched()
	local var_7_1 = arg_7_1:isDispatched()

	if var_7_0 ~= var_7_1 then
		return var_7_1
	end

	local var_7_2 = arg_7_0:isEffectHero()

	if var_7_2 ~= arg_7_1:isEffectHero() then
		return var_7_2
	end

	if arg_7_0.rare ~= arg_7_1.rare then
		return arg_7_0.rare > arg_7_1.rare
	end

	if arg_7_0.level ~= arg_7_1.level then
		return arg_7_0.level > arg_7_1.level
	end

	return arg_7_0.heroId > arg_7_1.heroId
end

function var_0_0.initHeroList(arg_8_0)
	if arg_8_0.heroList then
		return
	end

	arg_8_0.heroList = {}
	arg_8_0.heroDict = {}

	for iter_8_0, iter_8_1 in ipairs(HeroModel.instance:getList()) do
		if not arg_8_0.heroDict[iter_8_1.heroId] then
			local var_8_0 = RoleStoryDispatchHeroMo.New()

			var_8_0:init(iter_8_1, arg_8_0.storyMo.id, arg_8_0:isEffectHero(iter_8_1.heroId))
			table.insert(arg_8_0.heroList, var_8_0)

			arg_8_0.heroDict[var_8_0.heroId] = var_8_0
		end
	end
end

function var_0_0.initSelectedHeroList(arg_9_0, arg_9_1)
	arg_9_0.selectedHeroList = {}
	arg_9_0.selectedHeroIndexDict = {}

	if arg_9_1 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
			local var_9_0 = arg_9_0:getDispatchHeroMo(iter_9_1)

			if var_9_0 then
				table.insert(arg_9_0.selectedHeroList, var_9_0)

				arg_9_0.selectedHeroIndexDict[iter_9_1] = iter_9_0
			else
				logError("not found dispatched hero id : " .. tostring(iter_9_1))
			end
		end
	end
end

function var_0_0.sendDispatch(arg_10_0)
	if not arg_10_0.storyMo or not arg_10_0.dispatchMo then
		return
	end

	if arg_10_0.dispatchMo:getDispatchState() ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	local var_10_0 = GameUtil.splitString2(arg_10_0.dispatchMo.config.consume, true)
	local var_10_1 = 1
	local var_10_2 = {}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		table.insert(var_10_2, {
			type = iter_10_1[1],
			id = iter_10_1[2],
			quantity = iter_10_1[3] * var_10_1
		})
	end

	local var_10_3, var_10_4, var_10_5 = ItemModel.instance:hasEnoughItems(var_10_2)

	if not var_10_4 then
		if RoleStoryModel.instance:checkTodayCanExchange() then
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough1, var_10_5, var_10_3)
		else
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough2, var_10_5, var_10_3)
		end

		return
	end

	local var_10_6 = arg_10_0:getDispatchHeros()

	if #var_10_6 ~= arg_10_0.maxSelectCount then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchLessMinHero)

		return
	end

	local var_10_7 = {}

	for iter_10_2, iter_10_3 in ipairs(var_10_6) do
		table.insert(var_10_7, iter_10_3.heroId)
	end

	if arg_10_0.storyMo:isScoreFull() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryDispatchTips, MsgBoxEnum.BoxType.Yes_No, function()
			HeroStoryRpc.instance:sendHeroStoryDispatchRequest(arg_10_0.storyMo.id, arg_10_0.dispatchMo.id, var_10_7)
		end)

		return
	end

	HeroStoryRpc.instance:sendHeroStoryDispatchRequest(arg_10_0.storyMo.id, arg_10_0.dispatchMo.id, var_10_7)
end

function var_0_0.isEnoughHeroCount(arg_12_0)
	return #arg_12_0:getDispatchHeros() >= arg_12_0.maxSelectCount
end

function var_0_0.sendReset(arg_13_0)
	if not arg_13_0.storyMo or not arg_13_0.dispatchMo then
		return
	end

	if arg_13_0.dispatchMo:getDispatchState() ~= RoleStoryEnum.DispatchState.Dispatching then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RoleStoryDispatchResetTips, MsgBoxEnum.BoxType.Yes_No, function()
		if arg_13_0.dispatchMo:getDispatchState() == RoleStoryEnum.DispatchState.Dispatching then
			HeroStoryRpc.instance:sendHeroStoryDispatchResetRequest(arg_13_0.storyMo.id, arg_13_0.dispatchMo.id)
		end
	end)
end

function var_0_0.sendGetReward(arg_15_0)
	if not arg_15_0.storyMo or not arg_15_0.dispatchMo then
		return
	end

	if arg_15_0.dispatchMo:getDispatchState() ~= RoleStoryEnum.DispatchState.Canget then
		return
	end

	if arg_15_0.storyMo:isScoreFull() then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchRewardTips)
	end

	HeroStoryRpc.instance:sendHeroStoryDispatchCompleteRequest(arg_15_0.storyMo.id, arg_15_0.dispatchMo.id)
end

function var_0_0.clickHeroMo(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	if arg_16_1:isDispatched() then
		GameFacade.showToast(ToastEnum.RoleStoryDispatchSelectTips)

		return
	end

	if arg_16_0.selectedHeroIndexDict[arg_16_1.heroId] then
		arg_16_0:deselectMo(arg_16_1)
	else
		arg_16_0:selectMo(arg_16_1)
	end
end

function var_0_0.selectMo(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	if arg_17_0.selectedHeroIndexDict[arg_17_1.heroId] then
		return
	end

	if #arg_17_0.selectedHeroList == arg_17_0.maxSelectCount then
		return
	end

	table.insert(arg_17_0.selectedHeroList, arg_17_1)

	arg_17_0.selectedHeroIndexDict[arg_17_1.heroId] = #arg_17_0.selectedHeroList

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeSelectedHero)
end

function var_0_0.deselectMo(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	local var_18_0 = arg_18_0.selectedHeroIndexDict[arg_18_1.heroId]

	if not var_18_0 then
		return
	end

	table.remove(arg_18_0.selectedHeroList, var_18_0)

	arg_18_0.selectedHeroIndexDict[arg_18_1.heroId] = nil

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.selectedHeroList) do
		arg_18_0.selectedHeroIndexDict[iter_18_1.heroId] = iter_18_0
	end

	RoleStoryController.instance:dispatchEvent(RoleStoryEvent.ChangeSelectedHero)
end

function var_0_0.getDispatchHeroMo(arg_19_0, arg_19_1)
	return arg_19_0.heroDict[arg_19_1]
end

function var_0_0.getSelectedIndex(arg_20_0, arg_20_1)
	return arg_20_0.selectedHeroIndexDict[arg_20_1]
end

function var_0_0.getDispatchHeros(arg_21_0)
	return arg_21_0.selectedHeroList
end

function var_0_0.getDispatchHeroIndexDict(arg_22_0)
	return arg_22_0.selectedHeroIndexDict
end

function var_0_0.resetSelectHeroList(arg_23_0)
	arg_23_0.selectedHeroList = {}
	arg_23_0.selectedHeroIndexDict = {}
end

function var_0_0.onCloseDispatchView(arg_24_0)
	arg_24_0:clear()
end

function var_0_0.clearSelectedHeroList(arg_25_0)
	arg_25_0.selectedHeroList = nil
	arg_25_0.selectedHeroIndexDict = nil
end

function var_0_0.clear(arg_26_0)
	arg_26_0:clearSelectedHeroList()

	arg_26_0.heroList = nil
	arg_26_0.heroDict = nil

	var_0_0.super.clear(arg_26_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
