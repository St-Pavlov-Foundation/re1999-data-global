module("modules.logic.sp01.act205.view.ocean.Act205OceanShowView", package.seeall)

local var_0_0 = class("Act205OceanShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtneedPoints = gohelper.findChildText(arg_1_0.viewGO, "#txt_needPoints")
	arg_1_0._goDice1 = gohelper.findChild(arg_1_0.viewGO, "#go_Dice1")
	arg_1_0._goDice2 = gohelper.findChild(arg_1_0.viewGO, "#go_Dice2")
	arg_1_0._goDice3 = gohelper.findChild(arg_1_0.viewGO, "#go_Dice3")

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

var_0_0.rotationDict = {
	Vector3(90, 0, 0),
	Vector3(90, 90, 0),
	Vector3(90, 180, 0),
	Vector3(90, -90, 0),
	Vector3(0, 0, 0),
	(Vector3(180, 0, 0))
}

function var_0_0._onEscBtnClick(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.dictItemMap = arg_5_0:getUserDataTb_()
	arg_5_0._animPlayerView = SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.activityId = Act205Enum.ActId
	arg_7_0.gameType = Act205Enum.GameStageId.Ocean
	arg_7_0.gameInfoMo = Act205Model.instance:getGameInfoMo(arg_7_0.activityId, arg_7_0.gameType)

	arg_7_0:refreshUI()
	arg_7_0:refreshDice()
	arg_7_0._animPlayerView:Play("open", arg_7_0.showDiceAnim, arg_7_0)
	NavigateMgr.instance:addEscape(arg_7_0.viewName, arg_7_0._onEscBtnClick, arg_7_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_yun)
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = Act205OceanModel.instance:getCurSelectGoldId()

	arg_8_0.goldConfig = Act205Config.instance:getDiceGoalConfig(var_8_0)
	arg_8_0.goladRangeList = string.splitToNumber(arg_8_0.goldConfig.goalRange, "#")
	arg_8_0._txtneedPoints.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act205_ocean_needPoints"), arg_8_0.goladRangeList[1], arg_8_0.goladRangeList[2])
end

function var_0_0.refreshDice(arg_9_0)
	local var_9_0 = Act205OceanModel.instance:getcurSelectDiceIdList()
	local var_9_1 = Act205Config.instance:getWinDiceConfig()

	arg_9_0.isHasWinDice = tabletool.indexOf(var_9_0, var_9_1.id)
	arg_9_0.randomDiceNumList = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_2 = {}
		local var_9_3 = arg_9_0.viewContainer:getSetting().otherRes[1]

		var_9_2.go = arg_9_0:getResInst(var_9_3, arg_9_0["_goDice" .. iter_9_0], "diceItem" .. iter_9_0)
		var_9_2.anim = var_9_2.go:GetComponent(gohelper.Type_Animator)
		var_9_2.goNormal = gohelper.findChild(var_9_2.go, "touzi_ani/go_normal")
		var_9_2.goWin = gohelper.findChild(var_9_2.go, "touzi_ani/go_win")

		if not arg_9_0.isHasWinDice then
			var_9_2.normalTxtDiceNumList = {}

			local var_9_4 = Act205Config.instance:getDicePoolConfig(iter_9_1)
			local var_9_5 = string.splitToNumber(var_9_4.dicePoints, "#")

			for iter_9_2, iter_9_3 in ipairs(var_9_5) do
				var_9_2.normalTxtDiceNumList[iter_9_2] = gohelper.findChildText(var_9_2.go, "touzi_ani/go_normal/" .. iter_9_2 .. "/txt_num")
				var_9_2.normalTxtDiceNumList[iter_9_2].text = iter_9_3
			end

			var_9_2.randomIndex = math.random(#var_9_5)

			table.insert(arg_9_0.randomDiceNumList, var_9_5[var_9_2.randomIndex])
		else
			var_9_2.randomIndex = math.random(6)
		end

		var_9_2.curDiceRoot = arg_9_0.isHasWinDice and var_9_2.goWin or var_9_2.goNormal

		gohelper.setActive(var_9_2.goNormal, not arg_9_0.isHasWinDice)
		gohelper.setActive(var_9_2.goWin, arg_9_0.isHasWinDice)
		gohelper.setActive(var_9_2.go, false)

		arg_9_0.dictItemMap[iter_9_0] = var_9_2
	end
end

function var_0_0.showDiceAnim(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.dictItemMap) do
		gohelper.setActive(iter_10_1.go, true)
		iter_10_1.anim:Play("in", 0, 0)
		iter_10_1.anim:Update(0)

		local var_10_0, var_10_1, var_10_2 = transformhelper.getLocalRotation(iter_10_1.curDiceRoot.transform)

		iter_10_1.rotateTweenId = ZProj.TweenHelper.DOLocalRotate(iter_10_1.curDiceRoot.transform, var_10_0 + math.random(100, 200), var_10_1 + math.random(100, 200), var_10_2 + math.random(100, 200), 0.5, arg_10_0._delayTweenRotate, arg_10_0, iter_10_1, EaseType.Linear)
	end

	arg_10_0.isWin = arg_10_0:checkIsWin()

	TaskDispatcher.runDelay(arg_10_0.playFinishAnim, arg_10_0, 1.1)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_touzi)
end

function var_0_0._delayTweenRotate(arg_11_0, arg_11_1)
	local var_11_0 = var_0_0.rotationDict[arg_11_1.randomIndex]

	if var_11_0 then
		arg_11_1.rotateTweenId = ZProj.TweenHelper.DOLocalRotate(arg_11_1.curDiceRoot.transform, var_11_0.x, var_11_0.y, var_11_0.z, 0.2, nil, nil, nil, EaseType.Linear)
	end
end

function var_0_0.playFinishAnim(arg_12_0)
	arg_12_0._animPlayerView:Play(arg_12_0.isWin and "finish2" or "finish1", arg_12_0.sendGameFinish, arg_12_0)
end

function var_0_0.sendGameFinish(arg_13_0)
	if not Act205Model.instance:isGameStageOpen(arg_13_0.gameType, true) then
		return
	end

	local var_13_0 = string.nilorempty(arg_13_0.gameInfoMo:getGameInfo()) and 0 or tonumber(arg_13_0.gameInfoMo:getGameInfo())
	local var_13_1 = arg_13_0.isWin and 0 or var_13_0 + 1
	local var_13_2 = arg_13_0.isWin and arg_13_0.goldConfig.winRewardId or arg_13_0.goldConfig.failRewardId
	local var_13_3 = {
		activityId = arg_13_0.activityId,
		gameType = arg_13_0.gameType,
		gameInfo = tostring(var_13_1),
		rewardId = var_13_2
	}

	Activity205Rpc.instance:sendAct205FinishGameRequest(var_13_3, arg_13_0.openResultView, arg_13_0)
end

function var_0_0.checkIsWin(arg_14_0)
	if arg_14_0.isHasWinDice then
		return true
	else
		local var_14_0 = 0

		for iter_14_0, iter_14_1 in ipairs(arg_14_0.randomDiceNumList) do
			var_14_0 = var_14_0 + iter_14_1
		end

		return var_14_0 >= arg_14_0.goladRangeList[1] and var_14_0 <= arg_14_0.goladRangeList[2]
	end
end

function var_0_0.openResultView(arg_15_0)
	local var_15_0 = {
		isHasWinDice = arg_15_0.isHasWinDice,
		randomDiceNumList = arg_15_0.randomDiceNumList
	}

	Act205Controller.instance:openOceanResultView(var_15_0)
	Activity205Rpc.instance:sendAct205GetGameInfoRequest(Act205Enum.ActId)
	arg_15_0:closeThis()
end

function var_0_0.onClose(arg_16_0)
	Act205OceanModel.instance:cleanLocalSaveKey()
	TaskDispatcher.cancelTask(arg_16_0.playFinishAnim, arg_16_0)

	for iter_16_0, iter_16_1 in pairs(arg_16_0.dictItemMap) do
		if iter_16_1.rotateTweenId then
			ZProj.TweenHelper.KillById(iter_16_1.rotateTweenId)

			iter_16_1.rotateTweenId = nil
		end
	end
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0
