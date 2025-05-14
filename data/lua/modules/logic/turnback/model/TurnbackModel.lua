module("modules.logic.turnback.model.TurnbackModel", package.seeall)

local var_0_0 = class("TurnbackModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.turnbackSubModuleInfo = {}
	arg_2_0.unExitSubModules = {}
	arg_2_0.turnbackInfoMo = nil
	arg_2_0.targetCategoryId = 0
	arg_2_0.curTurnbackId = 0
	arg_2_0.lastGetSigninDay = nil
end

function var_0_0.setTurnbackInfo(arg_3_0, arg_3_1)
	if TurnbackConfig.instance:getTurnbackCo(arg_3_1.id) then
		arg_3_0.turnbackInfoMo = TurnbackInfoMo.New()

		arg_3_0.turnbackInfoMo:init(arg_3_1)
		arg_3_0:setCurTurnbackId(arg_3_1.id)
		arg_3_0:setTaskInfoList()
		arg_3_0:setSignInInfoList()
		arg_3_0:initRecommendData()
		arg_3_0:getBonusHeroConfigList()
		arg_3_0:_calcAllBonus()
		arg_3_0:setDropInfoList(arg_3_1.dropInfos)
	end
end

function var_0_0.setCurTurnbackId(arg_4_0, arg_4_1)
	arg_4_0.curTurnbackId = arg_4_1
end

function var_0_0.getCurTurnbackId(arg_5_0)
	return arg_5_0.curTurnbackId
end

function var_0_0.isNewType(arg_6_0)
	return arg_6_0.turnbackInfoMo:isNewType()
end

function var_0_0.getCurTurnbackMo(arg_7_0)
	return arg_7_0.turnbackInfoMo
end

function var_0_0.getLeaveTime(arg_8_0)
	return arg_8_0.turnbackInfoMo.leaveTime
end

function var_0_0.getCurTurnbackMoWithNilError(arg_9_0)
	local var_9_0 = arg_9_0:getCurTurnbackMo()

	if not var_9_0 then
		logError("TurnbackModel:getCurTurnbackMoWithNilError, can't find turnbackMo")
	end

	return var_9_0
end

function var_0_0.canShowTurnbackPop(arg_10_0)
	if not arg_10_0.turnbackInfoMo then
		return false
	elseif arg_10_0.turnbackInfoMo.firstShow then
		return false
	end

	return true
end

function var_0_0.initTurnbackSubModules(arg_11_0, arg_11_1)
	local var_11_0 = TurnbackConfig.instance:getAllTurnbackSubModules(arg_11_1)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not arg_11_0.turnbackSubModuleInfo[iter_11_1] then
			local var_11_1 = {
				id = iter_11_1,
				config = TurnbackConfig.instance:getTurnbackSubModuleCo(iter_11_1),
				order = iter_11_0
			}

			arg_11_0.turnbackSubModuleInfo[iter_11_1] = var_11_1
		end
	end

	arg_11_0:removeUnExitSubModules(arg_11_0.turnbackSubModuleInfo)
end

function var_0_0.setTargetCategoryId(arg_12_0, arg_12_1)
	arg_12_0.targetCategoryId = arg_12_1
end

function var_0_0.getTargetCategoryId(arg_13_0, arg_13_1)
	arg_13_0:initTurnbackSubModules(arg_13_1)

	if GameUtil.getTabLen(arg_13_0.turnbackSubModuleInfo) == 0 then
		arg_13_0.targetCategoryId = 0

		return 0
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.turnbackSubModuleInfo) do
		if iter_13_1.config.id == arg_13_0.targetCategoryId and iter_13_1.config.turnbackId == arg_13_1 then
			return arg_13_0.targetCategoryId
		end
	end

	if not arg_13_0:isNewType() then
		arg_13_0.targetCategoryId = arg_13_0:getTargetSubModules()
	else
		arg_13_0.targetCategoryId = arg_13_0:getTargetNewSubModules()
	end

	return arg_13_0.targetCategoryId
end

function var_0_0.getTargetSubModules(arg_14_0)
	if var_0_0.instance:haveOnceBonusReward() then
		return TurnbackEnum.ActivityId.RewardShowView
	elseif var_0_0.instance:haveSignInReward() then
		return TurnbackEnum.ActivityId.SignIn
	elseif var_0_0.instance:haveTaskReward() then
		return TurnbackEnum.ActivityId.TaskView
	end

	return TurnbackEnum.ActivityId.TaskView
end

function var_0_0.getTargetNewSubModules(arg_15_0)
	if var_0_0.instance:haveSignInReward() then
		return TurnbackEnum.ActivityId.NewSignIn
	elseif var_0_0.instance:haveTaskReward() then
		return TurnbackEnum.ActivityId.NewTaskView
	end

	return TurnbackEnum.ActivityId.NewSignIn
end

function var_0_0.haveOnceBonusReward(arg_16_0)
	return not arg_16_0.turnbackInfoMo.onceBonus
end

function var_0_0.haveSignInReward(arg_17_0)
	return TurnbackSignInModel.instance:getTheFirstCanGetIndex() ~= 0
end

function var_0_0.setLastGetSigninReward(arg_18_0, arg_18_1)
	arg_18_0.lastGetSigninDay = arg_18_1
end

function var_0_0.getLastGetSigninReward(arg_19_0)
	return arg_19_0.lastGetSigninDay
end

function var_0_0.haveTaskReward(arg_20_0)
	local var_20_0 = TurnbackTaskModel.instance:haveTaskItemReward()
	local var_20_1 = arg_20_0:getCurHasGetTaskBonus()
	local var_20_2 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_20_0.curTurnbackId)
	local var_20_3 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_2) do
		local var_20_4 = {
			config = iter_20_1
		}

		var_20_4.hasGetState = false

		for iter_20_2, iter_20_3 in ipairs(var_20_1) do
			if iter_20_1.id == iter_20_3 then
				var_20_4.hasGetState = true

				break
			end
		end

		var_20_3[iter_20_0] = var_20_4
	end

	local var_20_5 = arg_20_0.turnbackInfoMo.bonusPoint
	local var_20_6 = false

	for iter_20_4, iter_20_5 in ipairs(var_20_3) do
		if var_20_5 >= iter_20_5.config.needPoint and iter_20_5.hasGetState == false then
			var_20_6 = true

			break
		end
	end

	return var_20_0 or var_20_6
end

function var_0_0.addUnExitSubModule(arg_21_0, arg_21_1)
	arg_21_0.unExitSubModules[arg_21_1] = arg_21_1
end

function var_0_0.removeUnExitSubModules(arg_22_0, arg_22_1)
	if GameUtil.getTabLen(arg_22_1) == 0 then
		return
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0.unExitSubModules) do
		for iter_22_2, iter_22_3 in ipairs(arg_22_1) do
			if iter_22_3.id == iter_22_1 then
				table.remove(arg_22_1, iter_22_2)
			end
		end
	end

	return arg_22_1
end

function var_0_0.removeUnExitCategory(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		if iter_23_1 == TurnbackEnum.ActivityId.DungeonShowView and not arg_23_0.turnbackInfoMo:isAdditionInOpenTime() then
			arg_23_0:addUnExitSubModule(iter_23_1)
			table.remove(arg_23_1, iter_23_0)
		end

		if iter_23_1 == TurnbackEnum.ActivityId.RecommendView and (TurnbackRecommendModel.instance:getCanShowRecommendCount() == 0 or not arg_23_0.turnbackInfoMo:isInReommendTime()) then
			arg_23_0:addUnExitSubModule(iter_23_1)
			table.remove(arg_23_1, iter_23_0)
		end
	end

	return arg_23_1
end

function var_0_0.getRemainTime(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getCurTurnbackMo()

	if var_24_0 then
		local var_24_1 = (arg_24_1 or var_24_0.endTime) - ServerTime.now()
		local var_24_2 = Mathf.Floor(var_24_1 / TimeUtil.OneDaySecond)
		local var_24_3 = var_24_1 % TimeUtil.OneDaySecond
		local var_24_4 = Mathf.Floor(var_24_3 / TimeUtil.OneHourSecond)
		local var_24_5 = var_24_3 % TimeUtil.OneHourSecond
		local var_24_6 = Mathf.Floor(var_24_5 / TimeUtil.OneMinuteSecond)
		local var_24_7 = Mathf.Floor(var_24_5 % TimeUtil.OneMinuteSecond)

		return var_24_2, var_24_4, var_24_6, var_24_7
	else
		return 0, 0, 0, 0
	end
end

function var_0_0.isInOpenTime(arg_25_0)
	if arg_25_0.turnbackInfoMo then
		return arg_25_0.turnbackInfoMo:isInOpenTime()
	end
end

function var_0_0.setTaskInfoList(arg_26_0)
	TurnbackTaskModel.instance:setTaskInfoList(arg_26_0.turnbackInfoMo.tasks)

	if not arg_26_0:isNewType() then
		TurnbackTaskModel.instance:refreshList(TurnbackTaskModel.instance:getCurTaskLoopType())
	else
		TurnbackTaskModel.instance:refreshListNewTaskList()
	end
end

function var_0_0.getBuyDoubleBonus(arg_27_0)
	return arg_27_0.turnbackInfoMo:getBuyDoubleBonus()
end

function var_0_0.updateHasGetTaskBonus(arg_28_0, arg_28_1)
	arg_28_0.turnbackInfoMo:updateHasGetTaskBonus(arg_28_1.hasGetTaskBonus)
end

function var_0_0.updateCurBonusPoint(arg_29_0, arg_29_1)
	arg_29_0.turnbackInfoMo.bonusPoint = arg_29_1
end

function var_0_0.getCurHasGetTaskBonus(arg_30_0)
	return arg_30_0.turnbackInfoMo.hasGetTaskBonus
end

function var_0_0.setOnceBonusGetState(arg_31_0)
	arg_31_0.turnbackInfoMo.onceBonus = true
end

function var_0_0.getOnceBonusGetState(arg_32_0)
	return arg_32_0.turnbackInfoMo.onceBonus
end

function var_0_0.setSignInInfoList(arg_33_0)
	TurnbackSignInModel.instance:setSignInInfoList(arg_33_0.turnbackInfoMo.signInInfos)
end

function var_0_0.getCurSignInDay(arg_34_0)
	return arg_34_0.turnbackInfoMo.signInDay
end

function var_0_0.initRecommendData(arg_35_0)
	TurnbackRecommendModel.instance:initReommendShowState(arg_35_0.curTurnbackId)
end

function var_0_0.isAdditionValid(arg_36_0)
	local var_36_0 = false
	local var_36_1 = arg_36_0:getCurTurnbackMo()

	if var_36_1 then
		var_36_0 = var_36_1:isAdditionValid()
	end

	return var_36_0
end

function var_0_0.isShowTurnBackAddition(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:isAdditionValid()
	local var_37_1 = var_0_0.instance:getCurTurnbackId()
	local var_37_2 = TurnbackConfig.instance:isTurnBackAdditionToChapter(var_37_1, arg_37_1)

	return var_37_0 and var_37_2
end

function var_0_0.getAdditionCountInfo(arg_38_0)
	local var_38_0 = arg_38_0:getCurTurnbackId()
	local var_38_1 = TurnbackConfig.instance:getAdditionTotalCount(var_38_0)
	local var_38_2 = 0
	local var_38_3 = arg_38_0:getCurTurnbackMoWithNilError()

	if var_38_3 then
		var_38_2 = var_38_3:getRemainAdditionCount()
	end

	return var_38_2, var_38_1
end

function var_0_0.getAdditionRewardList(arg_39_0, arg_39_1)
	local var_39_0 = {}

	if not arg_39_1 then
		return var_39_0
	end

	local var_39_1 = arg_39_0:getCurTurnbackId()
	local var_39_2 = TurnbackConfig.instance:getAdditionRate(var_39_1)

	if var_39_2 and var_39_2 > 0 then
		for iter_39_0, iter_39_1 in ipairs(arg_39_1) do
			local var_39_3 = {
				iter_39_1[1],
				iter_39_1[2],
				math.ceil(iter_39_1[3] * var_39_2 / 1000),
				isAddition = true
			}

			table.insert(var_39_0, var_39_3)
		end
	end

	return var_39_0
end

function var_0_0.getMonthCardShowState(arg_40_0)
	local var_40_0 = arg_40_0:getCurTurnbackMo()

	if var_40_0 == nil then
		return false
	end

	local var_40_1 = var_40_0.config

	if var_40_1 == nil then
		return false
	end

	if var_40_1.monthCardAddedId == nil then
		return false
	end

	local var_40_2 = StoreConfig.instance:getMonthCardAddConfig(var_40_1.monthCardAddedId)

	if var_40_2 == nil then
		return false
	end

	return var_40_0.monthCardAddedBuyCount < var_40_2.limit
end

function var_0_0.getCurrentTurnbackMonthCardId(arg_41_0)
	local var_41_0 = arg_41_0:getCurTurnbackMo()

	if var_41_0 == nil then
		return nil
	end

	return var_41_0.config.monthCardAddedId
end

function var_0_0.addCurrentMonthBuyCount(arg_42_0)
	local var_42_0 = arg_42_0:getCurTurnbackMo()

	if var_42_0 == nil then
		return
	end

	var_42_0.monthCardAddedBuyCount = var_42_0.monthCardAddedBuyCount + 1
end

function var_0_0.getCanGetRewardList(arg_43_0)
	local var_43_0 = {}
	local var_43_1 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_43_0.curTurnbackId)

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		if arg_43_0:checkBonusCanGetById(iter_43_1.id) then
			table.insert(var_43_0, iter_43_1.id)
		end
	end

	return var_43_0
end

function var_0_0.getNextUnlockReward(arg_44_0)
	local var_44_0 = arg_44_0:getCurrentPointId()
	local var_44_1 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_44_0.curTurnbackId)

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		if var_44_0 < iter_44_1.needPoint then
			return iter_44_1.id
		end
	end

	if var_44_0 >= var_44_1[#var_44_1].needPoint then
		return var_44_1[#var_44_1].id
	end
end

function var_0_0.checkBonusCanGetById(arg_45_0, arg_45_1)
	if arg_45_0:getCurrentPointId() >= TurnbackConfig.instance:getTurnbackTaskBonusCo(arg_45_0.curTurnbackId, arg_45_1).needPoint and not arg_45_0:checkBonusGetById(arg_45_1) then
		return true
	end

	return false
end

function var_0_0.getCurrentPointId(arg_46_0)
	local var_46_0, var_46_1 = TurnbackConfig.instance:getBonusPointCo(arg_46_0.curTurnbackId)
	local var_46_2 = CurrencyModel.instance:getCurrency(var_46_1)

	return var_46_2 and var_46_2.quantity or 0
end

function var_0_0.checkBonusGetById(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:getCurHasGetTaskBonus()

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		if arg_47_1 == iter_47_1 then
			return true
		end
	end

	return false
end

function var_0_0.checkHasGetAllTaskReward(arg_48_0)
	local var_48_0 = arg_48_0:getCurHasGetTaskBonus()
	local var_48_1 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_48_0.curTurnbackId)

	if #var_48_0 == #var_48_1 then
		return true
	end

	return false
end

function var_0_0._calcAllBonus(arg_49_0)
	arg_49_0.bounsdict = {}
	arg_49_0.allBonusList = {}

	local var_49_0 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_49_0.curTurnbackId)

	for iter_49_0, iter_49_1 in ipairs(var_49_0) do
		arg_49_0:_calcBonus(arg_49_0.bounsdict, arg_49_0.allBonusList, iter_49_1.bonus)
	end
end

function var_0_0.getAllBonus(arg_50_0)
	return arg_50_0.allBonusList
end

function var_0_0.getAllBonusCount(arg_51_0)
	return #arg_51_0.allBonusList
end

function var_0_0._calcBonus(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	for iter_52_0, iter_52_1 in pairs(string.split(arg_52_3, "|")) do
		local var_52_0 = string.splitToNumber(iter_52_1, "#")
		local var_52_1 = var_52_0[2]
		local var_52_2 = var_52_0[3]

		if not arg_52_1[var_52_1] then
			arg_52_1[var_52_1] = var_52_0

			table.insert(arg_52_2, var_52_0)
		else
			arg_52_1[var_52_1][3] = arg_52_1[var_52_1][3] + var_52_2
		end
	end
end

function var_0_0.getFirstBonusHeroConfig(arg_53_0)
	if not arg_53_0.bonusHeroConfigList then
		return arg_53_0:getBonusHeroConfigList()[1]
	else
		return arg_53_0.bonusHeroConfigList[1]
	end
end

function var_0_0.getBonusHeroConfigList(arg_54_0)
	if arg_54_0.bonusHeroConfigList then
		return arg_54_0.bonusHeroConfigList
	else
		arg_54_0.bonusHeroConfigList = {}
		arg_54_0.unlockHeroList = {}

		local var_54_0 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_54_0.curTurnbackId)

		for iter_54_0, iter_54_1 in ipairs(var_54_0) do
			if iter_54_1 and not string.nilorempty(iter_54_1.character) then
				if not arg_54_0.firstBonusHeroConfig then
					arg_54_0.firstBonusHeroConfig = iter_54_1
				end

				local var_54_1 = iter_54_1.id

				if arg_54_0:checkBonusGetById(var_54_1) then
					table.insert(arg_54_0.unlockHeroList, var_54_1)
				end

				table.insert(arg_54_0.bonusHeroConfigList, iter_54_1)
			end
		end
	end
end

function var_0_0.getUnlockHeroList(arg_55_0)
	arg_55_0.unlockHeroList = {}

	local var_55_0 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_55_0.curTurnbackId)

	for iter_55_0, iter_55_1 in ipairs(var_55_0) do
		if iter_55_1 and not string.nilorempty(iter_55_1.character) then
			if arg_55_0:getCurrentPointId() >= iter_55_1.needPoint then
				table.insert(arg_55_0.unlockHeroList, iter_55_1)
			else
				table.insert(arg_55_0.unlockHeroList, iter_55_1)

				return arg_55_0.unlockHeroList
			end
		end
	end

	return arg_55_0.unlockHeroList
end

function var_0_0.setDropInfoList(arg_56_0, arg_56_1)
	arg_56_0._dropInfoList = {}

	local var_56_0 = TurnbackConfig.instance:getDropCoList()

	if arg_56_1 then
		for iter_56_0, iter_56_1 in ipairs(var_56_0) do
			local var_56_1 = {
				co = iter_56_1
			}

			if #arg_56_1 > 0 then
				for iter_56_2, iter_56_3 in ipairs(arg_56_1) do
					if iter_56_1.id == iter_56_3.type then
						var_56_1.progress = iter_56_3.currentNum / iter_56_3.totalNum
					end
				end
			else
				var_56_1.progress = 0
			end

			arg_56_0._dropInfoList[iter_56_1.id] = var_56_1
		end
	end
end

function var_0_0.getDropInfoByType(arg_57_0, arg_57_1)
	return arg_57_0._dropInfoList and arg_57_0._dropInfoList[arg_57_1]
end

function var_0_0.getDropInfoList(arg_58_0)
	local var_58_0 = {}
	local var_58_1 = {}
	local var_58_2 = {}
	local var_58_3 = TurnbackConfig.instance:getDropCoCount()

	if arg_58_0._dropInfoList and #arg_58_0._dropInfoList > 0 then
		while #var_58_2 < 4 do
			local var_58_4 = math.random(1, var_58_3)

			if not tabletool.indexOf(var_58_2, var_58_4) then
				local var_58_5 = TurnbackConfig.instance:getDropCoById(var_58_4)

				if var_58_5.level == 2 and #var_58_0 < TurnbackEnum.Level2Count then
					local var_58_6 = arg_58_0._dropInfoList[var_58_4]

					table.insert(var_58_0, var_58_6)
					table.insert(var_58_2, var_58_4)
				elseif var_58_5.level == 3 and #var_58_1 < TurnbackEnum.Level3Count then
					local var_58_7 = arg_58_0._dropInfoList[var_58_4]

					table.insert(var_58_1, var_58_7)
					table.insert(var_58_2, var_58_4)
				end
			end
		end
	end

	return var_58_0, var_58_1
end

function var_0_0.getContentWidth(arg_59_0)
	local var_59_0 = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(arg_59_0.curTurnbackId)
	local var_59_1 = 50
	local var_59_2 = 50
	local var_59_3 = 100
	local var_59_4 = #var_59_0
	local var_59_5 = 100

	return var_59_1 + var_59_2 + var_59_5 * var_59_4 + var_59_3 * (var_59_4 - 1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
