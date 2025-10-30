module("modules.logic.versionactivity3_0.maLiAnNaAct201.model.mo.MaLiAnNaGameSlotMo", package.seeall)

local var_0_0 = class("MaLiAnNaGameSlotMo", MaLiAnNaLaLevelMoSlot)

function var_0_0.create(arg_1_0)
	local var_1_0 = var_0_0.New()

	var_1_0:updatePos(arg_1_0.posX, arg_1_0.posY)
	var_1_0:init(arg_1_0.id, arg_1_0.configId)
	var_1_0:updateHeroId(arg_1_0.heroId)

	return var_1_0
end

function var_0_0.ctor(arg_2_0)
	var_0_0.super.ctor(arg_2_0)
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.id = arg_3_1
	arg_3_0.configId = arg_3_2
	arg_3_0._slotSoldierList = {}
	arg_3_0._config = Activity201MaLiAnNaConfig.instance:getSlotConfigById(arg_3_0.configId)
	arg_3_0._slotCamp = arg_3_0._config.initialCamp
	arg_3_0._generateSoliderSpeed = arg_3_0._config.soldierRecover
	arg_3_0._soliderLimit = arg_3_0._config.soldierLimit
	arg_3_0._dispatchInterval = arg_3_0._config.dispatchInterval
	arg_3_0._dispatchValue = 0
	arg_3_0._dispatchPath = {}
	arg_3_0._generateTime = 0
	arg_3_0._dispatchTime = 0
	arg_3_0._skillGenerateSoliderEffectTime = 0
	arg_3_0._soliderCampIndex = {}

	for iter_3_0, iter_3_1 in pairs(Activity201MaLiAnNaEnum.CampType) do
		arg_3_0._soliderCampIndex[iter_3_1] = {}
	end

	arg_3_0._slotType = Activity201MaLiAnNaEnum.SlotType.normal
	arg_3_0._skill = nil

	if not string.nilorempty(arg_3_0._config.type) then
		arg_3_0._slotType = string.splitToNumber(arg_3_0._config.type, "#")[1]
	end

	local var_3_0, var_3_1, var_3_2, var_3_3 = arg_3_0:getSlotConstValue()
	local var_3_4, var_3_5 = arg_3_0:getPosXY()

	arg_3_0.basePosX = var_3_4
	arg_3_0.basePosY = var_3_5

	arg_3_0:updatePos(var_3_4 + var_3_2, var_3_5 + var_3_3)
	arg_3_0:initByConfig()
	arg_3_0:initPassiveSkill()
end

function var_0_0.initByConfig(arg_4_0)
	if arg_4_0._config == nil then
		return
	end

	for iter_4_0 = 1, arg_4_0._config.initialSoldier do
		arg_4_0:createSolider(arg_4_0._slotCamp)
	end
end

function var_0_0.updateHeroId(arg_5_0, arg_5_1)
	arg_5_0.heroId = arg_5_1

	if arg_5_0.heroId and arg_5_0.heroId ~= 0 then
		arg_5_0:createSolider(arg_5_0._slotCamp, arg_5_0.heroId)
	end
end

function var_0_0.update(arg_6_0, arg_6_1)
	arg_6_0:_generateSolider(arg_6_1)
	arg_6_0:_dispatchSoldier(arg_6_1)

	for iter_6_0, iter_6_1 in pairs(arg_6_0._slotSoldierList) do
		if iter_6_1 then
			iter_6_1:update(arg_6_1)

			if iter_6_1:getCamp() ~= arg_6_0._slotCamp then
				iter_6_1:setCamp(arg_6_0._slotCamp)
			end
		end
	end

	if isDebugBuild then
		-- block empty
	end
end

function var_0_0._generateSolider(arg_7_0, arg_7_1)
	arg_7_0._skillGenerateSoliderEffectTime = math.max(arg_7_0._skillGenerateSoliderEffectTime - arg_7_1, 0)

	if arg_7_0._skillGenerateSoliderEffectTime > 0 then
		return
	end

	arg_7_0._generateTime = arg_7_0._generateTime + arg_7_1 * 1000 * (1 + arg_7_0:_getSlotSoliderSpeedPercent() / 1000)

	if arg_7_0._generateTime < arg_7_0._generateSoliderSpeed then
		return
	end

	arg_7_0._generateTime = 0

	if arg_7_0:soliderCountIsLimit() then
		return
	end

	arg_7_0:createSolider(arg_7_0._slotCamp)
	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.GenerateSolider, arg_7_0:getId(), 1)
end

function var_0_0.soliderCountIsLimit(arg_8_0)
	local var_8_0, var_8_1, var_8_2 = arg_8_0:getSoliderCount()

	return var_8_0 >= arg_8_0._soliderLimit
end

function var_0_0.createSolider(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 == nil then
		local var_9_0 = Activity201MaLiAnNaEnum.soliderGenerateIdByCamp.mySolider

		if arg_9_1 == Activity201MaLiAnNaEnum.CampType.Enemy then
			var_9_0 = Activity201MaLiAnNaEnum.soliderGenerateIdByCamp.enemySolider
		end

		if arg_9_1 == Activity201MaLiAnNaEnum.CampType.Middle then
			var_9_0 = Activity201MaLiAnNaEnum.soliderGenerateIdByCamp.middleSolider
		end

		arg_9_2 = Activity201MaLiAnNaConfig.instance:getConstValueNumber(var_9_0)
	end

	if arg_9_2 then
		local var_9_1 = MaLiAnNaLaSoliderMoUtil.instance:createSoliderMo(arg_9_2)

		var_9_1:setCamp(arg_9_1 and arg_9_1 or arg_9_0._slotCamp)
		var_9_1:setLocalPos(arg_9_0.posX, arg_9_0.posY)
		arg_9_0:_updateSoliderList(var_9_1, false)

		return true
	end

	return false
end

function var_0_0.removeSolider(arg_10_0)
	local var_10_0 = #arg_10_0._slotSoldierList

	if var_10_0 <= 0 then
		return nil
	end

	local var_10_1

	for iter_10_0 = 1, var_10_0 do
		local var_10_2 = arg_10_0._slotSoldierList[iter_10_0]

		if not var_10_2:isHero() then
			var_10_1 = var_10_2

			table.remove(arg_10_0._slotSoldierList, iter_10_0)

			break
		end
	end

	arg_10_0:_updateCurCamp()

	return var_10_1
end

function var_0_0.enterSoldier(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == nil or arg_11_1:isDead() then
		return false
	end

	if arg_11_0._slotCamp ~= arg_11_1:getCamp() then
		if arg_11_0._slotType == Activity201MaLiAnNaEnum.SlotType.trench and arg_11_0._skill ~= nil and arg_11_0._skill:canUseSkill(arg_11_0, arg_11_1) then
			local var_11_0 = arg_11_1:getHp()
			local var_11_1 = arg_11_0._skill:getHp()

			arg_11_1:updateHp(-var_11_1, false)
			arg_11_0._skill:soliderAttack(var_11_0)

			return true
		end

		local var_11_2 = #arg_11_0._slotSoldierList

		if var_11_2 > 0 then
			local var_11_3 = arg_11_0._slotSoldierList[var_11_2]

			if var_11_3 and var_11_3:getCamp() ~= arg_11_1:getCamp() and not var_11_3:isDead() and not arg_11_1:isDead() then
				local var_11_4 = arg_11_1:getHp()
				local var_11_5 = var_11_3:getHp()

				arg_11_1:updateHp(-var_11_5, false)
				var_11_3:updateHp(-var_11_4, false)

				return true, var_11_3
			end
		end
	elseif arg_11_1:isMoveEnd() or arg_11_2 then
		arg_11_0:_updateSoliderList(arg_11_1, true)
		arg_11_0:_checkSoliderEnterPassive(arg_11_1)

		return false
	end

	return true
end

function var_0_0._clearCampIndex(arg_12_0)
	if arg_12_0._soliderCampIndex == nil then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0._soliderCampIndex) do
		tabletool.clear(iter_12_1)
	end
end

function var_0_0._updateSoliderList(arg_13_0, arg_13_1)
	if arg_13_1 == nil or arg_13_1:isDead() then
		return
	end

	if not arg_13_1:isDead() then
		arg_13_1:changeState(Activity201MaLiAnNaEnum.SoliderState.InSlot)
		table.insert(arg_13_0._slotSoldierList, arg_13_1)
	end

	arg_13_0:_updateCurCamp()
end

function var_0_0.soliderDead(arg_14_0, arg_14_1)
	if arg_14_0._slotSoldierList == nil or #arg_14_0._slotSoldierList <= 0 or arg_14_1 == nil then
		return false
	end

	local var_14_0 = false

	for iter_14_0 = 1, #arg_14_0._slotSoldierList do
		if arg_14_1:getId() == arg_14_0._slotSoldierList[iter_14_0]:getId() then
			table.remove(arg_14_0._slotSoldierList, iter_14_0)

			var_14_0 = true

			break
		end
	end

	if var_14_0 then
		arg_14_0:_updateCurCamp()
	end

	return var_14_0
end

function var_0_0._updateCurCamp(arg_15_0)
	arg_15_0:_sortSoliderList()

	if #arg_15_0._slotSoldierList > 0 then
		arg_15_0:updateSlotCamp(arg_15_0._slotSoldierList[1]:getCamp())
	else
		arg_15_0:updateSlotCamp(Activity201MaLiAnNaEnum.CampType.Middle)
	end
end

function var_0_0.setDispatchSoldierInfo(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0._dispatchId = arg_16_1
	arg_16_0._disPatchHeroFirst = arg_16_3

	if not arg_16_0:isSame(arg_16_2) then
		arg_16_0._dispatchValue = 0
	end

	arg_16_0._dispatchValue = Activity201MaLiAnNaConfig.instance:getConstValueNumber(2) + arg_16_0._dispatchValue

	if arg_16_0._dispatchPath then
		tabletool.clear(arg_16_0._dispatchPath)
	end

	if arg_16_2 then
		tabletool.addValues(arg_16_0._dispatchPath, arg_16_2)
	end
end

function var_0_0.clearDisPatchInfo(arg_17_0)
	arg_17_0._dispatchValue = 0
	arg_17_0._dispatchId = nil
	arg_17_0._disPatchHeroFirst = false

	if arg_17_0._dispatchPath ~= nil then
		tabletool.clear(arg_17_0._dispatchPath)
	end
end

function var_0_0.isSame(arg_18_0, arg_18_1)
	if arg_18_1 == nil or arg_18_0._dispatchPath == nil then
		return false
	end

	if #arg_18_1 ~= #arg_18_0._dispatchPath then
		return false
	end

	for iter_18_0 = 1, #arg_18_1 do
		if arg_18_1[iter_18_0] ~= arg_18_0._dispatchPath[iter_18_0] then
			return false
		end
	end

	return true
end

function var_0_0._dispatchSoldier(arg_19_0, arg_19_1)
	arg_19_0._dispatchTime = arg_19_0._dispatchTime + arg_19_1 * 1000

	if arg_19_0._dispatchTime < arg_19_0._dispatchInterval then
		return
	end

	arg_19_0._dispatchTime = 0

	if arg_19_0._dispatchId == nil then
		return
	end

	if not arg_19_0:canDispatch() then
		return
	end

	if arg_19_0._dispatchValue == 0 and arg_19_0._dispatchId ~= nil then
		arg_19_0:clearDisPatchInfo()

		return
	end

	local var_19_0 = arg_19_0:getDisPatchSolider()

	if var_19_0 then
		var_19_0:setMovePointPath(arg_19_0._dispatchPath)
		var_19_0:setDispatchGroupId(arg_19_0._dispatchId)
		Activity201MaLiAnNaGameController.instance:dispatchSolider(var_19_0)
		var_19_0:changeState(Activity201MaLiAnNaEnum.SoliderState.Moving)

		arg_19_0._dispatchValue = arg_19_0._dispatchValue - 1
	end
end

function var_0_0.getDisPatchList(arg_20_0)
	local var_20_0 = Activity201MaLiAnNaConfig.instance:getConstValueNumber(2)
	local var_20_1 = #arg_20_0._slotSoldierList
	local var_20_2 = math.min(var_20_0, var_20_1 - 1)
	local var_20_3 = {}

	if not arg_20_0._disPatchHeroFirst then
		for iter_20_0 = 1, var_20_2 do
			local var_20_4 = var_20_1 - iter_20_0 + 1

			if var_20_4 > 1 then
				local var_20_5 = var_20_4 - 1

				if arg_20_0._slotSoldierList[var_20_5]:isHero() then
					var_20_4 = var_20_5
				end
			end

			table.insert(var_20_3, var_20_4)
		end
	else
		for iter_20_1 = 1, var_20_2 do
			table.insert(var_20_3, iter_20_1)
		end
	end

	return var_20_3
end

function var_0_0.getDisPatchSolider(arg_21_0)
	local var_21_0 = arg_21_0._disPatchHeroFirst and 1 or #arg_21_0._slotSoldierList

	if not arg_21_0._disPatchHeroFirst and var_21_0 > 1 then
		local var_21_1 = var_21_0 - 1

		if arg_21_0._slotSoldierList[var_21_1]:isHero() then
			var_21_0 = var_21_1
		end
	end

	return table.remove(arg_21_0._slotSoldierList, var_21_0)
end

function var_0_0.isInCanSelectRange(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0, var_22_1, var_22_2, var_22_3 = arg_22_0:getSlotConstValue()

	return MathUtil.isPointInCircleRange(arg_22_0.posX, arg_22_0.posY, var_22_0, arg_22_1, arg_22_2)
end

function var_0_0.getSlotConstValue(arg_23_0)
	return Activity201MaLiAnNaConfig.instance:getSlotConstValue(arg_23_0.configId)
end

function var_0_0.canDispatch(arg_24_0)
	return tabletool.len(arg_24_0._slotSoldierList) > 1 and arg_24_0._skillGenerateSoliderEffectTime <= 0
end

function var_0_0.getSlotCamp(arg_25_0)
	return arg_25_0._slotCamp
end

function var_0_0.campIsSameInit(arg_26_0)
	return arg_26_0._slotCamp == arg_26_0._config.initialCamp
end

function var_0_0.isInDispatch(arg_27_0)
	return arg_27_0._dispatchId ~= nil
end

function var_0_0.updateSlotCamp(arg_28_0, arg_28_1)
	if arg_28_0._slotCamp == nil or arg_28_0._slotCamp ~= arg_28_1 then
		arg_28_0._slotCamp = arg_28_1

		Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.SlotChangeCamp, arg_28_0.configId, arg_28_1)
		arg_28_0:clearDisPatchInfo()

		arg_28_0._skillGenerateSoliderEffectTime = 0
	end
end

function var_0_0._sortSoliderList(arg_29_0)
	if arg_29_0._slotSoldierList == nil then
		return
	end

	table.sort(arg_29_0._slotSoldierList, function(arg_30_0, arg_30_1)
		if arg_30_0:isHero() and not arg_30_1:isHero() then
			return true
		elseif not arg_30_0:isHero() and arg_30_1:isHero() then
			return false
		end

		return arg_30_0:getId() < arg_30_1:getId()
	end)
end

function var_0_0.getAndRemoveNormalSolider(arg_31_0)
	local var_31_0 = table.remove(arg_31_0._slotSoldierList, #arg_31_0._slotSoldierList)

	arg_31_0:_updateCurCamp()

	return var_31_0
end

function var_0_0.getSoliderCount(arg_32_0)
	local var_32_0 = 0
	local var_32_1 = 0

	for iter_32_0, iter_32_1 in ipairs(arg_32_0._slotSoldierList) do
		if not iter_32_1:isHero() then
			var_32_0 = var_32_0 + 1
		end

		var_32_1 = var_32_1 + 1
	end

	return var_32_0, var_32_1 - var_32_0, var_32_1
end

function var_0_0.getHeroSoliderList(arg_33_0)
	if arg_33_0._heroList == nil then
		arg_33_0._heroList = {}
	end

	tabletool.clear(arg_33_0._heroList)

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._slotSoldierList) do
		if iter_33_1:isHero() then
			arg_33_0._heroList[#arg_33_0._heroList + 1] = iter_33_1
		end
	end

	return arg_33_0._heroList
end

function var_0_0.getNormalSolider(arg_34_0)
	if arg_34_0._slotSoldierList == nil then
		return
	end

	for iter_34_0, iter_34_1 in ipairs(arg_34_0._slotSoldierList) do
		if not iter_34_1:isHero() then
			return iter_34_1
		end
	end

	return nil
end

function var_0_0.getId(arg_35_0)
	return arg_35_0.id
end

function var_0_0.getConfig(arg_36_0)
	return arg_36_0._config
end

function var_0_0.getBasePosXY(arg_37_0)
	return arg_37_0.basePosX, arg_37_0.basePosY
end

function var_0_0.getSoliderPercent(arg_38_0)
	local var_38_0, var_38_1, var_38_2 = arg_38_0:getSoliderCount()

	return var_38_0 / arg_38_0._soliderLimit * 1000
end

function var_0_0.getDistanceTo(arg_39_0, arg_39_1)
	if arg_39_1 == nil then
		return 0
	end

	return MathUtil.vec2_lengthSqr(arg_39_0.posX, arg_39_0.posY, arg_39_1.posX, arg_39_1.posY)
end

function var_0_0.canAI(arg_40_0)
	return arg_40_0._slotCamp == Activity201MaLiAnNaEnum.CampType.Enemy
end

function var_0_0.setSkillGenerateSoliderEffectTime(arg_41_0, arg_41_1)
	arg_41_0._skillGenerateSoliderEffectTime = arg_41_1
end

function var_0_0.skillToCreateSolider(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 == nil or arg_42_2 == nil then
		return
	end

	for iter_42_0 = 1, arg_42_1 do
		arg_42_0:createSolider(arg_42_2)
	end
end

function var_0_0.skillToRemoveSolider(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1 == nil or arg_43_2 == nil then
		return
	end

	local var_43_0 = arg_43_0:getSoliderCount()
	local var_43_1 = math.min(var_43_0, arg_43_1)

	for iter_43_0 = #arg_43_0._slotSoldierList, 1, -1 do
		if var_43_1 == 0 then
			return
		end

		local var_43_2 = arg_43_0._slotSoldierList[iter_43_0]

		if var_43_2 and not var_43_2:isHero() and var_43_2:getCamp() == arg_43_2 then
			var_43_2:updateHp(-1, true)

			var_43_1 = var_43_1 - 1
		end
	end
end

function var_0_0._checkSoliderEnterPassive(arg_44_0, arg_44_1)
	if arg_44_1 == nil then
		return
	end

	local var_44_0, var_44_1 = arg_44_1:getEnterSlotSkillValue()

	if var_44_0 == nil then
		return
	end

	if var_44_1 ~= nil then
		if var_44_1 > 0 then
			arg_44_0:skillToCreateSolider(var_44_1, var_44_0)

			if isDebugBuild then
				logNormal("技能增加据点英雄：" .. arg_44_0:getConfig().baseId .. " 数量：" .. var_44_1 .. " 阵营: " .. var_44_0)
			end
		else
			arg_44_0:skillToRemoveSolider(var_44_1, var_44_0)

			if isDebugBuild then
				logNormal("技能减少据点英雄：" .. arg_44_0:getConfig().baseId .. " 数量：" .. var_44_1 .. " 阵营: " .. var_44_0)
			end
		end
	end
end

function var_0_0._getSlotSoliderSpeedPercent(arg_45_0)
	local var_45_0 = 0

	for iter_45_0, iter_45_1 in ipairs(arg_45_0._slotSoldierList) do
		var_45_0 = var_45_0 + iter_45_1:getSkillSpeedUp()
	end

	return (math.max(0, var_45_0))
end

function var_0_0.initPassiveSkill(arg_46_0)
	if arg_46_0._skill ~= nil then
		return
	end

	arg_46_0._skill = MaLiAnNaSkillUtils.createSkillBySlotType(arg_46_0._config.type)

	if arg_46_0._slotType == Activity201MaLiAnNaEnum.SlotType.bunker then
		arg_46_0._skill:setParams(arg_46_0.posX, arg_46_0.posY, arg_46_0._slotCamp)
	end
end

function var_0_0.skillUpdate(arg_47_0, arg_47_1)
	if arg_47_0._skill == nil then
		return
	end

	arg_47_0._skill:update(arg_47_1)
end

function var_0_0.getSkill(arg_48_0)
	return arg_48_0._skill
end

function var_0_0.destroy(arg_49_0)
	arg_49_0._skill = nil
	arg_49_0._config = nil

	for iter_49_0, iter_49_1 in pairs(arg_49_0._slotSoldierList) do
		if iter_49_1 then
			iter_49_1:clear()
		end
	end

	arg_49_0._slotSoldierList = nil
end

function var_0_0.dumpInfo(arg_50_0)
	local var_50_0 = ((("" .. arg_50_0.id .. "------------------------\n") .. "据点阵营:" .. tostring(arg_50_0._slotCamp) .. "\n") .. "士兵数量:" .. tostring(#arg_50_0._slotSoldierList) .. "\n") .. "士兵列表:\n"
	local var_50_1 = ""

	for iter_50_0 = 1, #arg_50_0._slotSoldierList do
		local var_50_2 = arg_50_0._slotSoldierList[iter_50_0]

		var_50_1 = var_50_1 .. tostring(var_50_2:getId()) .. ", "
	end

	local var_50_3 = var_50_0 .. "士兵ID:" .. var_50_1 .. "\n"

	logNormal("MaLiAnNaGameSlotMo->:", var_50_3)
end

return var_0_0
