module("modules.logic.sp01.act205.view.ocean.Act205OceanResultView", package.seeall)

local var_0_0 = class("Act205OceanResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtneedPoint = gohelper.findChildText(arg_1_0.viewGO, "Left/Need/#txt_needPoint")
	arg_1_0._gonormalAll = gohelper.findChild(arg_1_0.viewGO, "Left/#go_normalAll")
	arg_1_0._txttotalDiceNum = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_normalAll/#txt_totalDiceNum")
	arg_1_0._txtdiceNum1 = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_normalAll/Dice1/#txt_diceNum1")
	arg_1_0._txtdiceNum2 = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_normalAll/Dice2/#txt_diceNum2")
	arg_1_0._txtdiceNum3 = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_normalAll/Dice3/#txt_diceNum3")
	arg_1_0._gospAll = gohelper.findChild(arg_1_0.viewGO, "Left/#go_spAll")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "Right/#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "Right/#go_fail")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_Desc")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "Right/#go_reward")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_reward/#go_rewardItem")
	arg_1_0._btnfinish = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/LayoutGroup/#btn_finish")
	arg_1_0._btnnewGame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/LayoutGroup/#btn_newGame")
	arg_1_0._txtGameTimes = gohelper.findChildText(arg_1_0.viewGO, "Right/LayoutGroup/#btn_newGame/#txt_GameTimes")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfinish:AddClickListener(arg_2_0._btnfinishOnClick, arg_2_0)
	arg_2_0._btnnewGame:AddClickListener(arg_2_0._btnnewGameOnClick, arg_2_0)
	arg_2_0:addEventCb(Act205Controller.instance, Act205Event.OnDailyRefresh, arg_2_0.refreshTimesInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfinish:RemoveClickListener()
	arg_3_0._btnnewGame:RemoveClickListener()
	arg_3_0:removeEventCb(Act205Controller.instance, Act205Event.OnDailyRefresh, arg_3_0.refreshTimesInfo, arg_3_0)
end

function var_0_0._btnfinishOnClick(arg_4_0)
	Act205OceanModel.instance:cleanSelectData()

	arg_4_0.gameInfoMo = Act205Model.instance:getGameInfoMo(arg_4_0.activityId, arg_4_0.gameType)

	if arg_4_0.gameInfoMo and arg_4_0.gameInfoMo.haveGameCount > 0 then
		Act205Controller.instance:openGameStartView(arg_4_0.activityId, arg_4_0.gameType)
	end

	TaskDispatcher.runDelay(arg_4_0.closeThis, arg_4_0, 0.1)
end

function var_0_0._btnnewGameOnClick(arg_5_0)
	Activity205Rpc.instance:sendAct205GetInfoRequest(arg_5_0.activityId, arg_5_0.openOceanSelectView, arg_5_0)
end

function var_0_0.openOceanSelectView(arg_6_0)
	Act205OceanModel.instance:cleanSelectData()
	Act205Controller.instance:openOceanSelectView({
		gameStageId = arg_6_0.gameType
	})
	TaskDispatcher.runDelay(arg_6_0.closeThis, arg_6_0, 0.1)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.rewardItemTab = arg_7_0:getUserDataTb_()
	arg_7_0._txtSpAll = gohelper.findChildText(arg_7_0.viewGO, "Left/#go_spAll/txt_total")
	arg_7_0._txtSpAll.text = "?"

	gohelper.setActive(arg_7_0._gorewardItem, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.activityId = Act205Enum.ActId
	arg_9_0.gameType = Act205Enum.GameStageId.Ocean
	arg_9_0.isHasWinDice = arg_9_0.viewParam.isHasWinDice
	arg_9_0.randomDiceNumList = arg_9_0.viewParam.randomDiceNumList

	local var_9_0 = Act205OceanModel.instance:getCurSelectGoldId()

	arg_9_0.goldConfig = Act205Config.instance:getDiceGoalConfig(var_9_0)
	arg_9_0.gameInfoMo = Act205Model.instance:getGameInfoMo(arg_9_0.activityId, arg_9_0.gameType)

	arg_9_0:refreshDicePointUI()
	arg_9_0:refreshRightUI()
end

function var_0_0.refreshDicePointUI(arg_10_0)
	local var_10_0 = string.splitToNumber(arg_10_0.goldConfig.goalRange, "#")

	arg_10_0._txtneedPoint.text = string.format("%s~%s", var_10_0[1], var_10_0[2])

	gohelper.setActive(arg_10_0._gonormalAll, not arg_10_0.isHasWinDice)
	gohelper.setActive(arg_10_0._gospAll, arg_10_0.isHasWinDice)

	if not arg_10_0.isHasWinDice then
		local var_10_1 = 0

		for iter_10_0, iter_10_1 in ipairs(arg_10_0.randomDiceNumList) do
			arg_10_0["_txtdiceNum" .. iter_10_0].text = iter_10_1
			var_10_1 = var_10_1 + iter_10_1
		end

		arg_10_0._txttotalDiceNum.text = var_10_1
		arg_10_0.isWin = var_10_1 >= var_10_0[1] and var_10_1 <= var_10_0[2]
	else
		arg_10_0.isWin = true
	end
end

function var_0_0.refreshRightUI(arg_11_0)
	gohelper.setActive(arg_11_0._gosuccess, arg_11_0.isWin)
	gohelper.setActive(arg_11_0._gofail, not arg_11_0.isWin)

	local var_11_0 = arg_11_0.isWin and arg_11_0.goldConfig.winRewardId or arg_11_0.goldConfig.failRewardId
	local var_11_1 = Act205Config.instance:getGameRewardConfig(Act205Enum.GameStageId.Ocean, var_11_0)

	arg_11_0._txtDesc.text = var_11_1.rewardDesc

	arg_11_0:refreshTimesInfo()
	arg_11_0:createRewardItem(var_11_1)
	TaskDispatcher.runDelay(arg_11_0.showRewardItemGet, arg_11_0, 0.5)

	if arg_11_0.isWin then
		AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_win)
	else
		AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_fail)
	end
end

function var_0_0.refreshTimesInfo(arg_12_0)
	arg_12_0.gameInfoMo = Act205Model.instance:getGameInfoMo(arg_12_0.activityId, arg_12_0.gameType)

	local var_12_0 = arg_12_0.gameInfoMo and arg_12_0.gameInfoMo.haveGameCount or 0
	local var_12_1 = Act205Config.instance:getStageConfig(Act205Enum.ActId, Act205Enum.GameStageId.Ocean).times

	gohelper.setActive(arg_12_0._btnnewGame.gameObject, var_12_0 > 0)

	if var_12_0 > 0 then
		arg_12_0._txtGameTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_remainGameTimes"), var_12_0, var_12_1)
	end
end

function var_0_0.createRewardItem(arg_13_0, arg_13_1)
	local var_13_0 = GameUtil.splitString2(arg_13_1.bonus, true)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = arg_13_0.rewardItemTab[iter_13_0]

		if not var_13_1 then
			var_13_1 = {
				go = gohelper.clone(arg_13_0._gorewardItem, arg_13_0._goreward, "rewardItem_" .. iter_13_0)
			}
			var_13_1.pos = gohelper.findChild(var_13_1.go, "go_rewardPos")
			var_13_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_13_1.pos)
			var_13_1.goRewardGet = gohelper.findChild(var_13_1.go, "go_rewardGet")
			arg_13_0.rewardItemTab[iter_13_0] = var_13_1
		end

		var_13_1.itemIcon:setMOValue(iter_13_1[1], iter_13_1[2], iter_13_1[3])
		gohelper.setActive(var_13_1.goRewardGet, false)
		var_13_1.itemIcon:isShowCount(true)
		var_13_1.itemIcon:setCountFontSize(40)
		var_13_1.itemIcon:showStackableNum2()
		var_13_1.itemIcon:setHideLvAndBreakFlag(true)
		var_13_1.itemIcon:hideEquipLvAndBreak(true)
		gohelper.setActive(var_13_1.go, true)
	end

	for iter_13_2 = #var_13_0 + 1, #arg_13_0.rewardItemTab do
		local var_13_2 = arg_13_0.rewardItemTab[iter_13_2]

		if var_13_2 then
			gohelper.setActive(var_13_2.go, false)
		end
	end
end

function var_0_0.showRewardItemGet(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.rewardItemTab) do
		gohelper.setActive(iter_14_1.goRewardGet, true)
	end
end

function var_0_0.onClose(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.closeThis, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
