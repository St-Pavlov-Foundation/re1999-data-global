module("modules.logic.fight.view.FightViewRedAndBlueArea", package.seeall)

local var_0_0 = class("FightViewRedAndBlueArea", BaseView)

var_0_0.LoadStatus = {
	Loaded = 3,
	Loading = 2,
	None = 1
}
var_0_0.PointIndexList = {
	{},
	{
		3
	},
	{
		2,
		3
	},
	{
		2,
		3,
		4
	},
	{
		1,
		2,
		3,
		4
	},
	{
		1,
		2,
		3,
		4,
		5
	},
	{
		1,
		2,
		3,
		4,
		5,
		6
	}
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollViewObj = gohelper.findChild(arg_1_0.viewGO, "root/playcards/#scroll_cards")
	arg_1_0._rectTrScrollView = arg_1_0._scrollViewObj:GetComponent(gohelper.Type_RectTransform)
	arg_1_0._playCardItemRoot = gohelper.findChild(arg_1_0.viewGO, "root/playcards/#scroll_cards/Viewport/Content")
	arg_1_0._playCardItemTransform = arg_1_0._playCardItemRoot:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.LY_cardLoadStatus = var_0_0.LoadStatus.None
	arg_1_0._goLyCardContainer = gohelper.findChild(arg_1_0.viewGO, "root/playcards/#go_LYcard")
	arg_1_0._rectTrLyCardContainer = arg_1_0._goLyCardContainer:GetComponent(gohelper.Type_RectTransform)
	arg_1_0.LY_cardLoadStatus = var_0_0.LoadStatus.None

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
	arg_4_0:addEventCb(FightController.instance, FightEvent.LY_HadRedAndBluePointChange, arg_4_0.onLY_HadRedAndBluePointChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.LY_PointAreaSizeChange, arg_4_0.refreshLYCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.SetBlockCardOperate, arg_4_0.refreshLYCard, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnPlayCardFlowDone, arg_4_0.refreshLYCard, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnPlayAssistBossCardFlowDone, arg_4_0.refreshLYCard, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_4_0.onStageChange, arg_4_0, LuaEventSystem.Low)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_4_0.refreshLYCard, arg_4_0, LuaEventSystem.Low)
end

function var_0_0.onStageChange(arg_5_0)
	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		FightDataHelper.LYDataMgr:refreshPointList(true)

		return arg_5_0:refreshLYCard()
	end
end

function var_0_0.onLY_HadRedAndBluePointChange(arg_6_0)
	if arg_6_0.LY_cardLoadStatus == var_0_0.LoadStatus.Loading then
		return
	end

	if arg_6_0.LY_cardLoadStatus == var_0_0.LoadStatus.Loaded then
		return arg_6_0:refreshLYCard()
	end

	arg_6_0.LY_cardLoadStatus = var_0_0.LoadStatus.Loading
	arg_6_0.LYLoader = PrefabInstantiate.Create(arg_6_0._goLyCardContainer)

	arg_6_0.LYLoader:startLoad(FightLYWaitAreaCard.LY_CardPath, arg_6_0.onLoadLYCardDone, arg_6_0)
end

function var_0_0.onLoadLYCardDone(arg_7_0, arg_7_1)
	arg_7_0.LY_cardLoadStatus = var_0_0.LoadStatus.Loaded

	local var_7_0 = arg_7_0.LYLoader:getInstGO()

	arg_7_0.LY_instanceGo = var_7_0
	arg_7_0.LY_goCardBack = gohelper.findChild(var_7_0, "current/back")

	gohelper.setActive(arg_7_0.LY_goCardBack, false)

	arg_7_0.LY_pointItemList = {}

	for iter_7_0 = 1, FightLYWaitAreaCard.LY_MAXPoint do
		local var_7_1 = arg_7_0:getUserDataTb_()

		var_7_1.go = gohelper.findChild(var_7_0, "current/font/energy/" .. iter_7_0)
		var_7_1.goRed = gohelper.findChild(var_7_1.go, "red")
		var_7_1.goBlue = gohelper.findChild(var_7_1.go, "green")
		var_7_1.goBoth = gohelper.findChild(var_7_1.go, "both")
		var_7_1.animator = var_7_1.go:GetComponent(gohelper.Type_Animator)

		table.insert(arg_7_0.LY_pointItemList, var_7_1)
	end

	arg_7_0:refreshLYCard()
end

function var_0_0.refreshLYCard(arg_8_0)
	if arg_8_0.LY_cardLoadStatus ~= var_0_0.LoadStatus.Loaded then
		gohelper.setActive(arg_8_0._goLyCardContainer, false)

		return
	end

	local var_8_0 = FightDataHelper.LYDataMgr:getPointList()

	if not var_8_0 then
		gohelper.setActive(arg_8_0._goLyCardContainer, false)

		return
	end

	gohelper.setActive(arg_8_0._goLyCardContainer, true)

	local var_8_1 = #var_8_0
	local var_8_2 = FightDataHelper.LYDataMgr.LYPointAreaSize

	arg_8_0:getOpRedOrBlueList(FightDataHelper.operationDataMgr:getOpList())
	arg_8_0:resetAllPoint()

	local var_8_3 = math.min(math.max(0, var_8_2), FightLYWaitAreaCard.LY_MAXPoint)
	local var_8_4 = var_0_0.PointIndexList[var_8_3 + 1] or {}

	for iter_8_0 = 1, var_8_3 do
		local var_8_5 = var_8_4[iter_8_0]
		local var_8_6 = var_8_5 and arg_8_0.LY_pointItemList[var_8_5]

		if var_8_6 then
			gohelper.setActive(var_8_6.go, true)

			local var_8_7

			if iter_8_0 <= var_8_1 then
				var_8_7 = var_8_0[iter_8_0]

				var_8_6.animator:Play("empty", 0, 0)
			else
				var_8_7 = arg_8_0.tempPointList[iter_8_0 - var_8_1]

				if var_8_7 and var_8_7 ~= FightEnum.CardColor.None then
					var_8_6.animator:Play("loop", 0, 0)
				else
					var_8_6.animator:Play("empty", 0, 0)
				end
			end

			gohelper.setActive(var_8_6.goRed, var_8_7 == FightEnum.CardColor.Red)
			gohelper.setActive(var_8_6.goBlue, var_8_7 == FightEnum.CardColor.Blue)
			gohelper.setActive(var_8_6.goBoth, var_8_7 == FightEnum.CardColor.Both)
		end
	end

	arg_8_0:refreshLYContainerAnchorX()
end

function var_0_0.resetAllPoint(arg_9_0)
	for iter_9_0 = 1, FightLYWaitAreaCard.LY_MAXPoint do
		local var_9_0 = arg_9_0.LY_pointItemList[iter_9_0]

		gohelper.setActive(var_9_0.go, false)
	end
end

var_0_0.AddRedOrBlueBehaviorId = 60154

function var_0_0.getOpRedOrBlueList(arg_10_0, arg_10_1)
	arg_10_0.tempPointList = arg_10_0.tempPointList or {}

	tabletool.clear(arg_10_0.tempPointList)

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = iter_10_1 and iter_10_1.cardInfoMO
		local var_10_1 = var_10_0 and var_10_0.skillId
		local var_10_2 = var_10_1 and lua_skill.configDict[var_10_1]

		if var_10_2 then
			for iter_10_2 = 1, FightEnum.MaxBehavior do
				local var_10_3 = var_10_2["behavior" .. iter_10_2]

				if not string.nilorempty(var_10_3) then
					local var_10_4 = FightStrUtil.instance:getSplitToNumberCache(var_10_3, "#")

					if var_10_4 and var_10_4[1] == var_0_0.AddRedOrBlueBehaviorId then
						local var_10_5 = var_10_4[2]
						local var_10_6 = var_10_4[3]

						for iter_10_3 = 1, var_10_6 do
							table.insert(arg_10_0.tempPointList, var_10_5)
						end
					end
				end
			end
		end

		if iter_10_1 and iter_10_1.cardColor ~= FightEnum.CardColor.None then
			table.insert(arg_10_0.tempPointList, iter_10_1.cardColor)
		end
	end

	return arg_10_0.tempPointList
end

function var_0_0.refreshLYContainerAnchorX(arg_11_0)
	if arg_11_0.LY_cardLoadStatus ~= var_0_0.LoadStatus.Loaded then
		return
	end

	local var_11_0 = recthelper.getWidth(arg_11_0._playCardItemTransform)
	local var_11_1 = recthelper.getWidth(arg_11_0._rectTrScrollView)
	local var_11_2 = math.min(var_11_0, var_11_1) / 2

	recthelper.setAnchorX(arg_11_0._rectTrLyCardContainer, var_11_2 + FightEnum.LYPlayCardAreaOffset)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0.LYLoader then
		arg_13_0.LYLoader:dispose()

		arg_13_0.LYLoader = nil

		gohelper.destroy(arg_13_0.LY_instanceGo)
	end

	arg_13_0.LY_cardLoadStatus = var_0_0.LoadStatus.None
end

return var_0_0
