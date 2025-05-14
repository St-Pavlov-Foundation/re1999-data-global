module("modules.logic.versionactivity2_4.warmup.model.V2a4_WarmUpBattleRoundMO", package.seeall)

local var_0_0 = string.format
local var_0_1 = table.insert
local var_0_2 = class("V2a4_WarmUpBattleRoundMO")

function var_0_2.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._index = arg_1_2
	arg_1_0._waveMO = arg_1_1
	arg_1_0._gachaMO = arg_1_3
	arg_1_0._isFinished = false
	arg_1_0._isWin = false
	arg_1_0._state = V2a4_WarmUpEnum.RoundState.None
	arg_1_0._userAnsIsYes = nil
end

function var_0_2.index(arg_2_0)
	return arg_2_0._index
end

function var_0_2.isWin(arg_3_0)
	return arg_3_0._isWin
end

function var_0_2.isFinished(arg_4_0)
	return arg_4_0._isFinished
end

function var_0_2.userAnsIsYes(arg_5_0)
	return arg_5_0._userAnsIsYes
end

function var_0_2.cfgId(arg_6_0)
	return arg_6_0._gachaMO:cfgId()
end

function var_0_2.type(arg_7_0)
	return arg_7_0._gachaMO:type()
end

function var_0_2.isText(arg_8_0)
	return arg_8_0:type() == V2a4_WarmUpEnum.AskType.Text
end

function var_0_2.isPhoto(arg_9_0)
	return arg_9_0:type() == V2a4_WarmUpEnum.AskType.Photo
end

function var_0_2.resUrl(arg_10_0)
	local var_10_0 = arg_10_0._gachaMO:imgName()

	return ResUrl.getV2a4WarmUpSingleBg(var_10_0)
end

function var_0_2.answer(arg_11_0, arg_11_1)
	if arg_11_0._isFinished then
		return
	end

	arg_11_0._isFinished = true
	arg_11_0._userAnsIsYes = arg_11_1
	arg_11_0._isWin = arg_11_0._gachaMO:ansIsYes() == arg_11_1
end

function var_0_2.isPreTalk(arg_12_0)
	return arg_12_0._state == V2a4_WarmUpEnum.RoundState.PreTalk
end

function var_0_2.isAsk(arg_13_0)
	return arg_13_0._state == V2a4_WarmUpEnum.RoundState.Ask
end

function var_0_2.isWaitAns(arg_14_0)
	return arg_14_0._state == V2a4_WarmUpEnum.RoundState.WaitAns
end

function var_0_2.isAnsed(arg_15_0)
	return arg_15_0._state == V2a4_WarmUpEnum.RoundState.Ansed
end

function var_0_2.isReplyResult(arg_16_0)
	return arg_16_0._state == V2a4_WarmUpEnum.RoundState.ReplyResult
end

function var_0_2.isLastRound(arg_17_0)
	return arg_17_0._waveMO:isLastRound()
end

function var_0_2.isFirstRound(arg_18_0)
	return arg_18_0._waveMO:isFirstRound()
end

function var_0_2.isFirstWave(arg_19_0)
	return arg_19_0._waveMO:isFirstWave()
end

function var_0_2.isNeedPreface(arg_20_0)
	return arg_20_0:isFirstWave() and not V2a4_WarmUpController.instance:getIsShownPreface()
end

function var_0_2.isNeedPassTalkAllYes(arg_21_0)
	return arg_21_0:isLastRound() and arg_21_0._waveMO:isAllAskYes()
end

function var_0_2._moveState(arg_22_0)
	local var_22_0 = arg_22_0._state + 1

	arg_22_0._tmp_dialogStep = 0

	if var_22_0 == V2a4_WarmUpEnum.RoundState.__End then
		arg_22_0._tmp_dialogCOList = {}

		return false
	end

	if arg_22_0:isWaitAns() then
		arg_22_0._state = arg_22_0._isFinished and var_22_0 or arg_22_0._state
	else
		arg_22_0._state = var_22_0
	end

	local var_22_1

	if isDebugBuild then
		local var_22_2 = {}

		function var_22_1(arg_23_0, arg_23_1)
			if not arg_23_0 then
				var_0_1(var_22_2, var_0_0("error state = %s, dialog type = %s", var_0_2.s_state(arg_22_0._state), arg_23_1))
				arg_22_0:dump(var_22_2, 1)
				logError(table.concat(var_22_2, "\n"))
			end
		end
	end

	if arg_22_0:isPreTalk() then
		if arg_22_0:isFirstRound() then
			if arg_22_0:isNeedPreface() then
				arg_22_0._tmp_dialogCOList = arg_22_0._gachaMO:getDialogCOList_prefaceAndPreTalk()

				V2a4_WarmUpController.instance:setIsShownPreface(true)
			else
				arg_22_0._tmp_dialogCOList = arg_22_0._gachaMO:getDialogCOList_preTalk()
			end
		else
			return arg_22_0:_moveState()
		end
	elseif arg_22_0:isAsk() then
		arg_22_0._tmp_dialogCOList = arg_22_0._gachaMO:getDialogCOList_yesorno()
	elseif arg_22_0:isWaitAns() then
		local var_22_3 = V2a4_WarmUpEnum.DialogType.Wait
		local var_22_4 = V2a4_WarmUpConfig.instance:getRandomDialogCO(var_22_3)

		if isDebugBuild then
			var_22_1(var_22_4 ~= nil, var_22_3)
		end

		arg_22_0._tmp_dialogCOList = arg_22_0._gachaMO:getDialogCOList(var_22_4.id)
	elseif arg_22_0:isAnsed() then
		local var_22_5 = arg_22_0:userAnsIsYes() and V2a4_WarmUpEnum.DialogType.AnsTrue or V2a4_WarmUpEnum.DialogType.AnsFalse
		local var_22_6 = V2a4_WarmUpConfig.instance:getRandomDialogCO(var_22_5)

		if isDebugBuild then
			var_22_1(var_22_6 ~= nil, var_22_5)
		end

		arg_22_0._tmp_dialogCOList = arg_22_0._gachaMO:getDialogCOList(var_22_6.id)
	elseif arg_22_0:isReplyResult() then
		if arg_22_0:isWin() then
			if arg_22_0:isLastRound() then
				arg_22_0._tmp_dialogCOList = arg_22_0:isNeedPassTalkAllYes() and arg_22_0._gachaMO:getDialogCOList_passTalkAllYes() or arg_22_0._gachaMO:getDialogCOList_passTalk()
			else
				local var_22_7 = V2a4_WarmUpEnum.DialogType.ReplyAnsRight
				local var_22_8 = V2a4_WarmUpConfig.instance:getRandomDialogCO(var_22_7)

				if not var_22_8 then
					arg_22_0._tmp_dialogStep = 0
					arg_22_0._tmp_dialogCOList = {}

					return true
				end

				arg_22_0._tmp_dialogCOList = arg_22_0._gachaMO:getDialogCOList(var_22_8.id)
			end
		else
			arg_22_0._tmp_dialogCOList = arg_22_0._gachaMO:getDialogCOList_failTalk()
		end
	end

	arg_22_0._tmp_dialogStep = 1

	return true
end

function var_0_2.moveStep(arg_24_0)
	local var_24_0 = arg_24_0._tmp_dialogCOList or {}
	local var_24_1 = arg_24_0._tmp_dialogStep or 0
	local var_24_2

	if isDebugBuild then
		local var_24_3 = {}

		function var_24_2(arg_25_0)
			if not arg_25_0 then
				var_0_1(var_24_3, var_0_0("error step: %s", arg_24_0._tmp_dialogStep))
				arg_24_0:dump(var_24_3, 1)
				logError(table.concat(var_24_3, "\n"))
			end
		end
	end

	if var_24_1 < #var_24_0 then
		local var_24_4 = var_24_1 + 1

		arg_24_0._tmp_dialogStep = var_24_4

		if isDebugBuild then
			var_24_2(var_24_0[var_24_4] ~= nil)
		end

		return true, var_24_0[var_24_4]
	end

	return arg_24_0:_moveState(), arg_24_0._tmp_dialogCOList[1]
end

function var_0_2.isLastStep(arg_26_0)
	local var_26_0 = arg_26_0._tmp_dialogCOList or {}

	return (arg_26_0._tmp_dialogStep or 0) == #var_26_0
end

function var_0_2.s_state(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(V2a4_WarmUpEnum.RoundState) do
		if iter_27_1 == arg_27_0 then
			return iter_27_0
		end
	end

	return "[V2a4_WarmUpBattleRoundMO.s_state] error!!"
end

function var_0_2.dump(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or 0

	local var_28_0 = string.rep("\t", arg_28_2)

	var_0_1(arg_28_1, var_28_0 .. var_0_0("index = %s", arg_28_0._index))
	var_0_1(arg_28_1, var_28_0 .. var_0_0("wave = %s", arg_28_0._waveMO:index()))
	var_0_1(arg_28_1, var_28_0 .. var_0_0("isFinished = %s", arg_28_0._isFinished))
	var_0_1(arg_28_1, var_28_0 .. var_0_0("isWin = %s", arg_28_0._isWin))
	var_0_1(arg_28_1, var_28_0 .. var_0_0("state = %s", var_0_2.s_state(arg_28_0._state)))
	var_0_1(arg_28_1, var_28_0 .. var_0_0("_step = %s", arg_28_0._tmp_dialogStep or 0))

	local var_28_1 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0._tmp_dialogCOList or {}) do
		var_0_1(var_28_1, iter_28_1.id)
	end

	var_0_1(arg_28_1, var_28_0 .. var_0_0("_stepList = %s", table.concat(var_28_1, ",")))
	var_0_1(arg_28_1, var_28_0 .. "GachaRound = {")
	arg_28_0._gachaMO:dump(arg_28_1, arg_28_2 + 1)
	var_0_1(arg_28_1, var_28_0 .. "}")
end

return var_0_2
