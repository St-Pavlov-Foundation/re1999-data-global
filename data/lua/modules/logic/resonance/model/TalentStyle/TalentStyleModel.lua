module("modules.logic.resonance.model.TalentStyle.TalentStyleModel", package.seeall)

local var_0_0 = class("TalentStyleModel", BaseModel)

function var_0_0.openView(arg_1_0, arg_1_1)
	arg_1_0._heroId = arg_1_1
	arg_1_0._heroMo = HeroModel.instance:getByHeroId(arg_1_1)
	arg_1_0._selectStyleId = nil
	arg_1_0._unlockIdList = arg_1_0:getUnlockStyle(arg_1_1)
	arg_1_0._newUnlockStyle = nil

	arg_1_0:refreshNewState(arg_1_1)
	TalentStyleListModel.instance:initData(arg_1_1)
end

function var_0_0.getHeroMainCubeMo(arg_2_0, arg_2_1)
	local var_2_0 = HeroModel.instance:getByHeroId(arg_2_1)

	return var_2_0 and var_2_0.talentCubeInfos:getMainCubeMo()
end

function var_0_0.getHeroUseCubeStyleId(arg_3_0, arg_3_1)
	local var_3_0 = HeroModel.instance:getByHeroId(arg_3_1)

	return var_3_0 and var_3_0:getHeroUseCubeStyleId()
end

function var_0_0.getHeroUseCubeId(arg_4_0, arg_4_1)
	local var_4_0 = HeroModel.instance:getByHeroId(arg_4_1)

	return var_4_0 and var_4_0:getHeroUseStyleCubeId()
end

function var_0_0.UseStyle(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 then
		if arg_5_2._isUnlock then
			if not arg_5_2._isUse then
				local var_5_0 = arg_5_2._styleId
				local var_5_1 = arg_5_0:getTalentTemplateId(arg_5_1)

				HeroRpc.instance:setUseTalentStyleRequest(arg_5_1, var_5_1, var_5_0)
				arg_5_0:selectCubeStyle(arg_5_1, arg_5_2._styleId)
			end
		elseif HeroModel.instance:getByHeroId(arg_5_1).config.heroType == 6 then
			GameFacade.showToast(ToastEnum.TalentStyleLock2)
		else
			GameFacade.showToast(ToastEnum.TalentStyleLock1)
		end
	end
end

function var_0_0.getTalentTemplateId(arg_6_0, arg_6_1)
	local var_6_0 = HeroModel.instance:getByHeroId(arg_6_1)

	return var_6_0 and var_6_0.useTalentTemplateId
end

function var_0_0.getHeroUseCubeMo(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getHeroUseCubeStyleId(arg_7_1)

	return (arg_7_0:getCubeMoByStyle(arg_7_1, var_7_0))
end

function var_0_0.getSelectStyleId(arg_8_0, arg_8_1)
	if not arg_8_0._selectStyleId then
		arg_8_0._selectStyleId = arg_8_0:getHeroUseCubeStyleId(arg_8_1)
	end

	return arg_8_0._selectStyleId
end

function var_0_0.selectCubeStyle(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0._selectStyleId == arg_9_2 then
		return
	end

	arg_9_0._selectStyleId = arg_9_2

	arg_9_0:setNewSelectStyle(arg_9_2)
	TalentStyleListModel.instance:refreshData(arg_9_1, arg_9_2)
	CharacterController.instance:dispatchEvent(CharacterEvent.onSelectTalentStyle, arg_9_2)
end

function var_0_0.getSelectCubeMo(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getSelectStyleId(arg_10_1)
	local var_10_1 = arg_10_0:getStyleCoList(arg_10_1)

	if var_10_1 and var_10_1[var_10_0] then
		return var_10_1[var_10_0]
	end

	arg_10_0:selectCubeStyle(arg_10_1, 0)
end

function var_0_0.clear(arg_11_0)
	arg_11_0:setHeroUseSelectId()
end

function var_0_0.getTalentStyle(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = HeroResonanceConfig.instance:getTalentStyle(arg_12_1)

	if var_12_0 and var_12_0[arg_12_2] then
		return var_12_0[arg_12_2]
	end
end

function var_0_0.getStyleCoList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getHeroMainCubeMo(arg_13_1)

	if var_13_0 then
		local var_13_1 = var_13_0 and var_13_0.id

		if var_13_1 then
			return (HeroResonanceConfig.instance:getTalentStyle(var_13_1))
		end
	end
end

function var_0_0.getStyleMoList(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getStyleCoList(arg_14_1)

	return (arg_14_0:refreshMoList(arg_14_1, var_14_0))
end

function var_0_0.refreshMoList(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}

	if arg_15_2 then
		local var_15_1 = HeroModel.instance:getByHeroId(arg_15_1)
		local var_15_2 = var_15_1 and var_15_1.talent or 0
		local var_15_3, var_15_4, var_15_5 = arg_15_0:getCurInfo(arg_15_1)

		for iter_15_0, iter_15_1 in pairs(arg_15_2) do
			if iter_15_1:isCanUnlock(var_15_2) then
				local var_15_6 = iter_15_1._styleId
				local var_15_7 = LuaUtil.tableContains(var_15_5, var_15_6)

				iter_15_1:onRefresh(var_15_3, var_15_4, var_15_7)
				table.insert(var_15_0, iter_15_1)
			end
		end
	end

	return var_15_0
end

function var_0_0.refreshNewState(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getStyleMoList(arg_16_1)
	local var_16_1 = HeroModel.instance:getByHeroId(arg_16_1)

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		iter_16_1:setNew(var_16_1.isShowTalentStyleRed)
	end
end

function var_0_0.hideNewState(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getStyleMoList(arg_17_1)

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		iter_17_1:setNew(false)
	end
end

function var_0_0.getCurInfo(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getHeroUseCubeStyleId(arg_18_1)
	local var_18_1 = arg_18_0:getSelectStyleId(arg_18_1)
	local var_18_2 = arg_18_0._unlockIdList

	return var_18_0, var_18_1, var_18_2
end

function var_0_0.getCubeMoByStyle(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0:getStyleCoList(arg_19_1)

	if var_19_0 and var_19_0[arg_19_2] then
		return var_19_0[arg_19_2]
	end

	return var_19_0 and var_19_0[0]
end

function var_0_0.refreshUnlockInfo(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getStyleCoList(arg_20_1)

	arg_20_0:refreshUnlockList(arg_20_1)

	local var_20_1, var_20_2, var_20_3 = arg_20_0:getCurInfo(arg_20_1)

	for iter_20_0, iter_20_1 in pairs(var_20_0) do
		local var_20_4 = LuaUtil.tableContains(var_20_3, iter_20_1._styleId)

		iter_20_1:onRefresh(var_20_1, var_20_2, var_20_4)
	end
end

function var_0_0.getUnlockStyle(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getStyleCoList(arg_21_1)
	local var_21_1 = 0

	if var_21_0 then
		for iter_21_0, iter_21_1 in pairs(var_21_0) do
			var_21_1 = math.max(iter_21_0, var_21_1)
		end
	end

	local var_21_2 = HeroModel.instance:getByHeroId(arg_21_1).talentStyleUnlock

	return (arg_21_0:parseUnlock(var_21_2, var_21_1))
end

function var_0_0.refreshUnlockList(arg_22_0, arg_22_1)
	arg_22_0._unlockIdList = arg_22_0:getUnlockStyle(arg_22_1)
end

function var_0_0.parseUnlock(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {}
	local var_23_1 = arg_23_1

	for iter_23_0 = arg_23_2, 0, -1 do
		local var_23_2 = 2^iter_23_0

		if var_23_2 <= var_23_1 then
			table.insert(var_23_0, iter_23_0)

			var_23_1 = var_23_1 - var_23_2

			if var_23_1 == 0 then
				break
			end
		end
	end

	if var_23_1 ~= 0 then
		logError("解锁数据计算错误：" .. arg_23_1)
	end

	return var_23_0
end

function var_0_0.getLevelUnlockStyle(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = HeroResonanceConfig.instance:getTalentStyle(arg_24_1)

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		if iter_24_1._styleCo.level == arg_24_2 then
			return true
		end
	end
end

function var_0_0.isUnlockStyleSystem(arg_25_0, arg_25_1)
	return arg_25_1 >= 10
end

function var_0_0.setNewUnlockStyle(arg_26_0, arg_26_1)
	arg_26_0._newUnlockStyle = arg_26_1
end

function var_0_0.getNewUnlockStyle(arg_27_0)
	return arg_27_0._newUnlockStyle
end

function var_0_0.setNewSelectStyle(arg_28_0, arg_28_1)
	arg_28_0._newSelectStyle = arg_28_1
end

function var_0_0.getNewSelectStyle(arg_29_0)
	return arg_29_0._newSelectStyle
end

function var_0_0.isPlayAnim(arg_30_0, arg_30_1, arg_30_2)
	return GameUtil.playerPrefsGetNumberByUserId(arg_30_0:getPlayUnlockAnimKey(arg_30_1, arg_30_2), 0) == 0
end

function var_0_0.setPlayAnim(arg_31_0, arg_31_1, arg_31_2)
	return GameUtil.playerPrefsSetNumberByUserId(arg_31_0:getPlayUnlockAnimKey(arg_31_1, arg_31_2), 1)
end

function var_0_0.getPlayUnlockAnimKey(arg_32_0, arg_32_1, arg_32_2)
	return "TalentStyleModel_PlayUnlockAnim_" .. arg_32_1 .. "_" .. arg_32_2
end

function var_0_0.isPlayStyleEnterBtnAnim(arg_33_0, arg_33_1)
	return GameUtil.playerPrefsGetNumberByUserId(arg_33_0:getPlayStyleEnterBtnAnimKey(arg_33_1), 0) == 0
end

function var_0_0.setPlayStyleEnterBtnAnim(arg_34_0, arg_34_1)
	return GameUtil.playerPrefsSetNumberByUserId(arg_34_0:getPlayStyleEnterBtnAnimKey(arg_34_1), 1)
end

function var_0_0.getPlayStyleEnterBtnAnimKey(arg_35_0, arg_35_1)
	return "PlayStyleEnterBtnAnimKey_" .. arg_35_1
end

function var_0_0.setHeroTalentStyleStatInfo(arg_36_0, arg_36_1)
	if not arg_36_0.unlockStateInfo then
		arg_36_0.unlockStateInfo = {}
	end

	if not arg_36_0.unlockStateInfo[arg_36_1.heroId] then
		arg_36_0.unlockStateInfo[arg_36_1.heroId] = {}
	end

	local var_36_0 = 0

	if arg_36_1.stylePercentList then
		for iter_36_0 = 1, #arg_36_1.stylePercentList do
			local var_36_1 = arg_36_1.stylePercentList[iter_36_0]
			local var_36_2 = arg_36_0:getCubeMoByStyle(arg_36_1.heroId, var_36_1.style)

			var_36_2:setUnlockPercent(var_36_1.percent)

			arg_36_0.unlockStateInfo[arg_36_1.heroId][var_36_1.style] = var_36_2
			var_36_0 = math.max(var_36_1.percent, var_36_0)
		end
	end

	if arg_36_0.unlockStateInfo[arg_36_1.heroId] then
		for iter_36_1, iter_36_2 in pairs(arg_36_0.unlockStateInfo[arg_36_1.heroId]) do
			iter_36_2:setHotUnlockStyle(var_36_0 == iter_36_2:getUnlockPercent())
		end
	end
end

function var_0_0.sortUnlockPercent(arg_37_0, arg_37_1)
	return arg_37_0:getUnlockPercent() > arg_37_1:getUnlockPercent()
end

function var_0_0.getHeroTalentStyleStatInfo(arg_38_0, arg_38_1)
	return arg_38_0.unlockStateInfo and arg_38_0.unlockStateInfo[arg_38_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
