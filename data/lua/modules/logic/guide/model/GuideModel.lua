module("modules.logic.guide.model.GuideModel", package.seeall)

local var_0_0 = class("GuideModel", BaseModel)

var_0_0.GuideFlag = {
	FightForbidRoundView = 3,
	SeasonDiscount = 28,
	FightForbidCloseSkilltip = 25,
	FightForbidLongPressCard = 2,
	MaskUseMainCamera = 23,
	FightDoingEnterPassedEpisode = 10,
	FightForbidClickTechnique = 7,
	AutoChessToast = 45,
	KeepEpisodeItemLock = 29,
	FightDoingSubEntity = 5,
	PinballBanOper = 34,
	FeiLinShiDuoBanOper = 35,
	AutoChessSetPlaceIndex = 37,
	AutoChessEnableExchangeEXP = 39,
	AutoChessEnableSale = 40,
	AutoChessEnableDragChess = 43,
	SkipShowDungeonMapLevelView = 26,
	DontOpenMain = 24,
	FightBackSkipDungeonView = 9,
	AutoChessEnableUseSkill = 44,
	CooperGarlandForceRemove = 46,
	JumpGameLongPressGuide = 47,
	UseBlock = 17,
	FightForbidAutoFight = 4,
	AutoChessEnablePreviewEnemy = 41,
	FightForbidRestrainTag = 6,
	FightForbidClickOpenView = 15,
	MainViewGuideId = 32,
	SurvivalGuideLock = 48,
	SkipShowElementAnim = 19,
	FightForbidSpeed = 8,
	MoveFightBtn2MapView = 21,
	FightMoveCard = 1,
	SkipInitElement = 20,
	AutoChessBanAllOper = 36,
	PutTalent = 22,
	MainViewGuideBlock = 31,
	TianShiNaNaBanOper = 33,
	ForceJumpToMainView = 14,
	AutoChessEnableDragFreeChess = 38,
	DelayGetPointReward = 18,
	Guidepost = 12,
	SeasonUTTU = 27,
	SkipClickElement = 13,
	RoomForbidBtn = 16,
	FightSetSpecificCardIndex = 30,
	FightLeadRoleSkillGuide = 11
}

function var_0_0.onInit(arg_1_0)
	arg_1_0._stepExecList = {}
	arg_1_0._guideHasSetFlag = {}
	arg_1_0._guideFlagDict = {}
	arg_1_0._firstOpenMainViewTime = nil
	arg_1_0._gmStartGuideId = nil
	arg_1_0._fixNextStepGOPathDict = {}
	arg_1_0._lockGuideId = nil
	arg_1_0._guideParam = {
		OnPushBoxWinPause = false
	}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.execStep(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:addStepLog(string.format("%d_%d", arg_3_1, arg_3_2))
end

function var_0_0.onClickJumpGuides(arg_4_0)
	arg_4_0:addStepLog("click jump all guides")
end

function var_0_0.addStepLog(arg_5_0, arg_5_1)
	if #arg_5_0._stepExecList >= 10 then
		table.remove(arg_5_0._stepExecList, 1)
	end

	table.insert(arg_5_0._stepExecList, arg_5_1)
end

function var_0_0.getStepExecStr(arg_6_0)
	return table.concat(arg_6_0._stepExecList, ",")
end

function var_0_0.onOpenMainView(arg_7_0)
	if arg_7_0._firstOpenMainViewTime == nil then
		arg_7_0._firstOpenMainViewTime = Time.time
	end
end

function var_0_0.setFlag(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 then
		arg_8_0._guideHasSetFlag[arg_8_3] = arg_8_0._guideHasSetFlag[arg_8_3] or {}
		arg_8_0._guideHasSetFlag[arg_8_3][arg_8_1] = arg_8_2
	end

	arg_8_0._guideFlagDict[arg_8_1] = arg_8_2
end

function var_0_0.isFlagEnable(arg_9_0, arg_9_1)
	if arg_9_0._guideFlagDict[arg_9_1] ~= nil then
		return true
	end

	return false
end

function var_0_0.getFlagValue(arg_10_0, arg_10_1)
	return arg_10_0._guideFlagDict[arg_10_1]
end

function var_0_0.clearFlagByGuideId(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._guideHasSetFlag[arg_11_1]

	arg_11_0._guideHasSetFlag[arg_11_1] = nil

	if var_11_0 then
		for iter_11_0, iter_11_1 in pairs(var_11_0) do
			if iter_11_1 then
				arg_11_0._guideFlagDict[iter_11_0] = nil
			end
		end
	end
end

function var_0_0.setGuideList(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0 = 1, #arg_12_1 do
		local var_12_1 = arg_12_1[iter_12_0]

		if GuideConfig.instance:getGuideCO(var_12_1.guideId) then
			if GuideConfig.instance:getStepList(var_12_1.guideId) then
				local var_12_2 = GuideMO.New()

				var_12_2:init(var_12_1)
				table.insert(var_12_0, var_12_2)
			else
				logError("guide step config not exist: " .. var_12_1.guideId)
			end
		else
			logError("guide config not exist: " .. var_12_1.guideId)
		end
	end

	arg_12_0:addList(var_12_0)
end

function var_0_0.updateGuideList(arg_13_0, arg_13_1)
	for iter_13_0 = 1, #arg_13_1 do
		local var_13_0 = arg_13_1[iter_13_0]

		arg_13_0:setGMGuideStep(var_13_0)

		local var_13_1 = arg_13_0:getById(var_13_0.guideId)

		if var_13_1 == nil then
			var_13_1 = GuideMO.New()

			if arg_13_0._firstOpenMainViewTime and Time.time - arg_13_0._firstOpenMainViewTime < 6 then
				logNormal(string.format("<color=#FFA500>login trigger guide_%d</color>", var_13_0.guideId))
				var_13_1:init(var_13_0)
			else
				var_13_1:updateGuide(var_13_0)
			end

			arg_13_0:addAtLast(var_13_1)
		elseif var_13_1.isFinish then
			logNormal(string.format("<color=#FFA500>restart guide_%d</color>", var_13_0.guideId))
			var_13_1:init(var_13_0)
		else
			var_13_1:updateGuide(var_13_0)
		end
	end
end

function var_0_0.addEmptyGuide(arg_14_0, arg_14_1)
	if arg_14_0:getById(arg_14_1) == nil then
		local var_14_0 = GuideMO.New()

		var_14_0.id = arg_14_1

		arg_14_0:addAtLast(var_14_0)
	end
end

function var_0_0.clientFinishStep(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:getById(arg_15_1):setClientStep(arg_15_2)
end

function var_0_0.isDoingFirstGuide(arg_16_0)
	return arg_16_0:getDoingGuideId() == 101
end

function var_0_0.lastForceGuideId(arg_17_0)
	return 108
end

function var_0_0.getDoingGuideId(arg_18_0)
	local var_18_0 = arg_18_0:getDoingGuideIdList()

	if var_18_0 then
		for iter_18_0 = #var_18_0, 1, -1 do
			local var_18_1 = GuideConfig.instance:getGuideCO(var_18_0[iter_18_0])

			if var_18_1.parallel == 1 or GuideInvalidController.instance:isInvalid(var_18_1.id) then
				table.remove(var_18_0, iter_18_0)
			end
		end

		return GuideConfig.instance:getHighestPriorityGuideId(var_18_0)
	end
end

function var_0_0.getDoingGuideIdList(arg_19_0)
	local var_19_0
	local var_19_1 = arg_19_0:getList()

	for iter_19_0 = 1, #var_19_1 do
		local var_19_2 = var_19_1[iter_19_0]

		if not var_19_2.isFinish or var_19_2.currStepId > 0 then
			var_19_0 = var_19_0 or {}

			table.insert(var_19_0, var_19_1[iter_19_0].id)
		end
	end

	return var_19_0
end

function var_0_0.isDoingClickGuide(arg_20_0)
	local var_20_0 = arg_20_0:getList()

	for iter_20_0 = 1, #var_20_0 do
		local var_20_1 = var_20_0[iter_20_0]

		if not var_20_1.isFinish or var_20_1.currStepId > 0 then
			local var_20_2 = var_0_0.instance:getStepGOPath(var_20_1.id, var_20_1.currStepId)

			if not string.nilorempty(var_20_2) then
				return true
			end
		end
	end

	return false
end

function var_0_0.isAnyGuideRunning(arg_21_0)
	local var_21_0 = arg_21_0:getList()

	for iter_21_0 = 1, #var_21_0 do
		local var_21_1 = var_21_0[iter_21_0]

		if not var_21_1.isFinish or var_21_1.currStepId > 0 then
			return true
		end
	end

	return false
end

function var_0_0.isGuideRunning(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getById(arg_22_1)

	if var_22_0 and not var_22_0.isFinish then
		return true
	end

	return false
end

function var_0_0.isGuideFinish(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getById(arg_23_1)

	if var_23_0 and var_23_0.isFinish then
		return true
	end

	return false
end

function var_0_0.isStepFinish(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0:isGuideFinish(arg_24_1) then
		return true
	end

	local var_24_0 = arg_24_0:getById(arg_24_1)

	if var_24_0 and arg_24_2 < var_24_0.currStepId then
		return true
	end

	return false
end

function var_0_0.setLockGuide(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0._lockGuideId and not arg_25_0:isGuideFinish(arg_25_0._lockGuideId) and not arg_25_2 then
		logNormal(string.format("<color=#FFA500>setLockGuide old:%s new:%s</color>", arg_25_0._lockGuideId, arg_25_1))

		return
	end

	arg_25_0._lockGuideId = arg_25_1

	logNormal(string.format("<color=#FFA500>setLockGuide guideId:%s</color>", arg_25_0._lockGuideId))
end

function var_0_0.getLockGuideId(arg_26_0)
	if arg_26_0._lockGuideId and arg_26_0:isGuideFinish(arg_26_0._lockGuideId) then
		arg_26_0._lockGuideId = nil
	end

	return arg_26_0._lockGuideId
end

function var_0_0.gmStartGuide(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0._gmStartGuideId = arg_27_1
	arg_27_0._gmStartGuideStep = arg_27_2
end

function var_0_0.setGMGuideStep(arg_28_0, arg_28_1)
	if not arg_28_1 or arg_28_1.guideId ~= arg_28_0._gmStartGuideId or not arg_28_0._gmStartGuideStep then
		return
	end

	arg_28_1.stepId = arg_28_0._gmStartGuideStep
	arg_28_0._gmStartGuideStep = nil

	logNormal(string.format("<color=#FF0000>setGMGuideStep guideId:%d step:%d</color>", arg_28_1.guideId, arg_28_1.stepId))
end

function var_0_0.isGMStartGuide(arg_29_0, arg_29_1)
	return arg_29_1 == arg_29_0._gmStartGuideId
end

function var_0_0.setNextStepGOPath(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = GuideConfig.instance:getNextStepId(arg_30_1, arg_30_2)

	if var_30_0 then
		arg_30_0._fixNextStepGOPathDict[arg_30_1] = arg_30_0._fixNextStepGOPathDict[arg_30_1] or {}
		arg_30_0._fixNextStepGOPathDict[arg_30_1][var_30_0] = arg_30_3
	end
end

function var_0_0.getStepGOPath(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0._fixNextStepGOPathDict[arg_31_1] then
		local var_31_0 = arg_31_0._fixNextStepGOPathDict[arg_31_1][arg_31_2]

		if var_31_0 then
			return var_31_0
		end
	end

	local var_31_1 = GuideConfig.instance:getStepCO(arg_31_1, arg_31_2)

	return var_31_1 and var_31_1.goPath
end

function var_0_0.getGuideParam(arg_32_0)
	return arg_32_0._guideParam
end

var_0_0.instance = var_0_0.New()

return var_0_0
