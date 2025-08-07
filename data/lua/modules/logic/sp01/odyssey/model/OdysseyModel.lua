module("modules.logic.sp01.odyssey.model.OdysseyModel", package.seeall)

local var_0_0 = class("OdysseyModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:initPropInfoData()
	arg_2_0:initFightInfoData()
	arg_2_0:clearResultInfo()
end

function var_0_0.onReceiveOdysseyGetInfoReply(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:setPropInfo(arg_3_1.propInfo, arg_3_2)
	OdysseyDungeonModel.instance:updateMapInfo(arg_3_1.mapInfo)
	OdysseyItemModel.instance:updateBagInfo(arg_3_1.bagInfo)
	OdysseyTalentModel.instance:updateTalentInfo(arg_3_1.talentInfo)
	OdysseyHeroGroupModel.instance:updateFormInfo(arg_3_1.formInfo.currForm)
	arg_3_0:setFightInfo(arg_3_1.fightInfo)
end

function var_0_0.initPropInfoData(arg_4_0)
	arg_4_0.heroOldExp = 0
	arg_4_0.heroCurExp = 0
	arg_4_0.heroCurLevel = 0
	arg_4_0.heroOldLevel = 0
end

function var_0_0.setPropInfo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.heroCurLevel = arg_5_1.level
	arg_5_0.heroCurExp = arg_5_1.exp
	arg_5_0.parasm = arg_5_1.parasm

	if not arg_5_2 and (not arg_5_0.heroOldLevel or arg_5_0.heroOldLevel == 0) then
		arg_5_0:updateHeroOldLevel(arg_5_0.heroCurLevel, arg_5_0.heroCurExp)
	end

	OdysseyController.instance:dispatchEvent(OdysseyEvent.RefreshHeroInfo)
end

function var_0_0.updateHeroLevel(arg_6_0, arg_6_1)
	arg_6_0.heroCurLevel = arg_6_1.newLevel
	arg_6_0.heroCurExp = arg_6_1.newExp

	if arg_6_1.reason ~= OdysseyEnum.Reason.ConquestFightReward and arg_6_1.reason ~= OdysseyEnum.Reason.MythicFightReward then
		arg_6_0:updateHeroOldLevel(arg_6_1.oldLevel, arg_6_1.oldExp)
	end
end

function var_0_0.updateHeroOldLevel(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.heroOldLevel = arg_7_1
	arg_7_0.heroOldExp = arg_7_2
end

function var_0_0.getHeroCurLevelAndExp(arg_8_0)
	return arg_8_0.heroCurLevel, arg_8_0.heroCurExp
end

function var_0_0.getHeroOldLevelAndExp(arg_9_0)
	return arg_9_0.heroOldLevel, arg_9_0.heroOldExp
end

function var_0_0.getHeroAddExp(arg_10_0)
	local var_10_0 = 0

	if arg_10_0.heroOldLevel ~= arg_10_0.heroCurLevel then
		for iter_10_0 = arg_10_0.heroOldLevel, arg_10_0.heroCurLevel do
			local var_10_1 = OdysseyConfig.instance:getLevelConfig(iter_10_0)

			if iter_10_0 == arg_10_0.heroOldLevel and iter_10_0 < arg_10_0.heroCurLevel then
				var_10_0 = var_10_1.needExp - arg_10_0.heroOldExp
			elseif iter_10_0 > arg_10_0.heroOldLevel and iter_10_0 < arg_10_0.heroCurLevel then
				var_10_0 = var_10_0 + var_10_1.needExp
			elseif iter_10_0 == arg_10_0.heroCurLevel then
				var_10_0 = var_10_0 + arg_10_0.heroCurExp
			end
		end
	elseif arg_10_0.heroOldExp ~= arg_10_0.heroCurExp then
		var_10_0 = arg_10_0.heroCurExp - arg_10_0.heroOldExp
	end

	return var_10_0
end

function var_0_0.initFightInfoData(arg_11_0)
	arg_11_0.mercenarySuitMap = {}
	arg_11_0.mercenaryNextRefreshTime = 0
	arg_11_0.religionMemberMap = {}
end

function var_0_0.setFightInfo(arg_12_0, arg_12_1)
	if not arg_12_1.mercenaryInfo then
		return
	end

	arg_12_0:setMercenaryInfo(arg_12_1.mercenaryInfo)
	arg_12_0:setAllReligionInfo(arg_12_1.religionInfo)
end

function var_0_0.setMercenaryInfo(arg_13_0, arg_13_1)
	arg_13_0:updateMercenaryNextRefreshTime(arg_13_1.nextRefTime)

	for iter_13_0, iter_13_1 in ipairs(arg_13_1.suits) do
		arg_13_0.mercenarySuitMap[iter_13_1.type] = iter_13_1.suitId
	end
end

function var_0_0.updateMercenaryNextRefreshTime(arg_14_0, arg_14_1)
	arg_14_0.mercenaryNextRefreshTime = tonumber(arg_14_1) or 0
end

function var_0_0.getRemainMercenaryRefreshTime(arg_15_0)
	return Mathf.Max(0, arg_15_0.mercenaryNextRefreshTime / 1000 - ServerTime.now())
end

function var_0_0.getMercenaryNextRefreshTime(arg_16_0)
	return arg_16_0.mercenaryNextRefreshTime
end

function var_0_0.getMercenaryTypeSuit(arg_17_0, arg_17_1)
	local var_17_0 = OdysseyEnum.MercenaryTypeToSuit[arg_17_1]
	local var_17_1 = OdysseyConfig.instance:getConstConfig(var_17_0)
	local var_17_2 = string.splitToNumber(var_17_1.value, "#")[1]

	return arg_17_0.mercenarySuitMap[arg_17_1] or var_17_2
end

function var_0_0.updateMercenaryTypeSuit(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.mercenarySuitMap[arg_18_1] = arg_18_2
end

function var_0_0.setAllReligionInfo(arg_19_0, arg_19_1)
	if arg_19_1 then
		for iter_19_0, iter_19_1 in ipairs(arg_19_1.members) do
			arg_19_0:setReligionInfo(iter_19_1)
		end
	end
end

function var_0_0.setReligionInfo(arg_20_0, arg_20_1)
	local var_20_0 = {
		religionId = arg_20_1.religionId,
		status = arg_20_1.status
	}

	arg_20_0.religionMemberMap[arg_20_1.religionId] = var_20_0
end

function var_0_0.getReligionInfoData(arg_21_0, arg_21_1)
	return arg_21_0.religionMemberMap[arg_21_1]
end

function var_0_0.setFightResultInfo(arg_22_0, arg_22_1)
	arg_22_0._resultMo = OdysseyResultMo.New()

	arg_22_0._resultMo:init(arg_22_1)
end

function var_0_0.getFightResultInfo(arg_23_0)
	return arg_23_0._resultMo
end

function var_0_0.clearResultInfo(arg_24_0)
	arg_24_0._resultMo = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
