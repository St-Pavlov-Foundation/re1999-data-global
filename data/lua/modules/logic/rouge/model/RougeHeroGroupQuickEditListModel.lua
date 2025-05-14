module("modules.logic.rouge.model.RougeHeroGroupQuickEditListModel", package.seeall)

local var_0_0 = class("RougeHeroGroupQuickEditListModel", ListScrollModel)

function var_0_0.calcTotalCapacity(arg_1_0)
	local var_1_0 = 0

	for iter_1_0, iter_1_1 in pairs(arg_1_0._inTeamHeroUidList) do
		local var_1_1 = HeroModel.instance:getById(iter_1_1)

		if var_1_1 then
			var_1_0 = var_1_0 + RougeController.instance:getRoleStyleCapacity(var_1_1, iter_1_0 > RougeEnum.FightTeamNormalHeroNum and not arg_1_0._skipAssitType)
		end
	end

	return var_1_0 + arg_1_0:_getAssitCapacity() + RougeHeroGroupEditListModel.instance:getAssistCapacity()
end

function var_0_0._isTeamCapacityEnough(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = 0
	local var_2_1 = false

	for iter_2_0, iter_2_1 in pairs(arg_2_0._inTeamHeroUidList) do
		local var_2_2 = HeroModel.instance:getById(iter_2_1)

		if iter_2_1 == arg_2_2 then
			var_2_1 = true
		end

		if var_2_2 then
			var_2_0 = var_2_0 + RougeController.instance:getRoleStyleCapacity(var_2_2, iter_2_0 > RougeEnum.FightTeamNormalHeroNum and not arg_2_0._skipAssitType)
		end
	end

	if not var_2_1 then
		local var_2_3 = HeroModel.instance:getById(arg_2_2)

		if var_2_3 then
			var_2_0 = var_2_0 + RougeController.instance:getRoleStyleCapacity(var_2_3, arg_2_1 > RougeEnum.FightTeamNormalHeroNum and not arg_2_0._skipAssitType)
		end
	end

	return var_2_0 + arg_2_0:_getAssitCapacity(arg_2_1, arg_2_2) + RougeHeroGroupEditListModel.instance:getAssistCapacity() <= RougeHeroGroupEditListModel.instance:getTotalCapacity()
end

function var_0_0._getAssitCapacity(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._edityType ~= RougeEnum.HeroGroupEditType.Fight then
		return 0
	end

	local var_3_0

	if arg_3_1 and arg_3_2 then
		var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs(arg_3_0._inTeamHeroUidList) do
			if HeroModel.instance:getById(iter_3_1) then
				var_3_0[iter_3_0] = iter_3_1
			elseif arg_3_2 then
				var_3_0[iter_3_0] = arg_3_2
				arg_3_2 = nil
			end
		end
	end

	var_3_0 = var_3_0 or arg_3_0._inTeamHeroUidList

	local var_3_1 = 0
	local var_3_2 = RougeHeroSingleGroupModel.instance:getList()
	local var_3_3 = {}
	local var_3_4 = {}

	for iter_3_2, iter_3_3 in ipairs(var_3_2) do
		var_3_3[iter_3_2] = nil

		if iter_3_2 <= RougeEnum.FightTeamNormalHeroNum then
			local var_3_5 = var_3_0[iter_3_2]
			local var_3_6 = HeroModel.instance:getById(var_3_5)

			var_3_3[iter_3_2] = var_3_6

			if var_3_6 then
				var_3_4[var_3_6.heroId] = var_3_6
			end
		else
			local var_3_7 = iter_3_3:getHeroMO()

			if var_3_7 and not var_3_4[var_3_7.heroId] and var_3_3[iter_3_2 - RougeEnum.FightTeamNormalHeroNum] then
				var_3_3[iter_3_2] = var_3_7
			end
		end
	end

	for iter_3_4, iter_3_5 in pairs(var_3_3) do
		if iter_3_4 > RougeEnum.FightTeamNormalHeroNum then
			var_3_1 = var_3_1 + RougeController.instance:getRoleStyleCapacity(iter_3_5, iter_3_4 > RougeEnum.FightTeamNormalHeroNum and not arg_3_0._skipAssitType)
		end
	end

	return var_3_1
end

function var_0_0.copyQuickEditCardList(arg_4_0)
	arg_4_0._edityType = RougeHeroGroupEditListModel.instance:getHeroGroupEditType()
	arg_4_0._isSelectHeroType = arg_4_0._edityType == RougeEnum.HeroGroupEditType.SelectHero
	arg_4_0._isInitType = arg_4_0._edityType == RougeEnum.HeroGroupEditType.Init
	arg_4_0._skipAssitType = not arg_4_0._isSelectHeroType and not arg_4_0._isInitType

	if arg_4_0._isInitType then
		arg_4_0._battleRoleNum = RougeEnum.InitTeamHeroNum
	else
		arg_4_0._battleRoleNum = RougeEnum.DefaultTeamHeroNum
	end

	local var_4_0

	if arg_4_0._isSelectHeroType then
		var_4_0 = RougeHeroGroupEditListModel.instance:getSelectHeroList(CharacterBackpackCardListModel.instance:getCharacterCardList())
	elseif arg_4_0._edityType == RougeEnum.HeroGroupEditType.Init then
		var_4_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()
	else
		var_4_0 = RougeHeroGroupEditListModel.instance:getTeamList(CharacterBackpackCardListModel.instance:getCharacterCardList())
	end

	local var_4_1 = {}
	local var_4_2 = {}

	arg_4_0._inTeamHeroUidMap = {}
	arg_4_0._inTeamHeroUidList = {}
	arg_4_0._originalHeroUidList = {}
	arg_4_0._assitPosIndex = {}
	arg_4_0._selectUid = nil

	local var_4_3 = RougeHeroSingleGroupModel.instance:getList()

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		local var_4_4 = arg_4_0:isPositionOpen(iter_4_0)
		local var_4_5 = iter_4_1.heroUid

		if tonumber(var_4_5) > 0 and not var_4_2[var_4_5] then
			table.insert(var_4_1, HeroModel.instance:getById(var_4_5))

			if var_4_4 then
				arg_4_0._inTeamHeroUidMap[var_4_5] = 1
			end

			var_4_2[var_4_5] = true
		elseif RougeHeroSingleGroupModel.instance:getByIndex(iter_4_0).trial then
			table.insert(var_4_1, HeroGroupTrialModel.instance:getById(var_4_5))

			if var_4_4 then
				arg_4_0._inTeamHeroUidMap[var_4_5] = 1
			end

			var_4_2[var_4_5] = true
		end

		if var_4_4 then
			table.insert(arg_4_0._inTeamHeroUidList, var_4_5)
			table.insert(arg_4_0._originalHeroUidList, var_4_5)
		end

		if iter_4_0 > RougeEnum.FightTeamNormalHeroNum then
			arg_4_0._assitPosIndex[var_4_5] = iter_4_0
		end
	end

	local var_4_6 = RougeHeroGroupEditListModel.instance:getAssistHeroId()
	local var_4_7 = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_0) do
		if not var_4_2[iter_4_3.uid] then
			var_4_2[iter_4_3.uid] = true

			if arg_4_0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(iter_4_3.heroId) > 0 then
					table.insert(var_4_7, iter_4_3)
				else
					table.insert(var_4_1, iter_4_3)
				end
			elseif iter_4_3.heroId ~= var_4_6 then
				table.insert(var_4_1, iter_4_3)
			end
		end
	end

	if arg_4_0.adventure then
		tabletool.addValues(var_4_1, var_4_7)
	end

	arg_4_0:setList(var_4_1)
end

function var_0_0.keepSelect(arg_5_0, arg_5_1)
	arg_5_0._selectIndex = arg_5_1

	local var_5_0 = arg_5_0:getList()

	if #arg_5_0._scrollViews > 0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._scrollViews) do
			iter_5_1:selectCell(arg_5_1, true)
		end

		if var_5_0[arg_5_1] then
			return var_5_0[arg_5_1]
		end
	end
end

function var_0_0.isInTeamHero(arg_6_0, arg_6_1)
	return arg_6_0._inTeamHeroUidMap and arg_6_0._inTeamHeroUidMap[arg_6_1]
end

function var_0_0.getHeroTeamPos(arg_7_0, arg_7_1)
	if arg_7_0._inTeamHeroUidList then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._inTeamHeroUidList) do
			if iter_7_1 == arg_7_1 then
				return iter_7_0
			end
		end
	end

	return 0
end

function var_0_0.selectHero(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getHeroTeamPos(arg_8_1)

	if var_8_0 ~= 0 then
		arg_8_0._inTeamHeroUidList[var_8_0] = "0"
		arg_8_0._inTeamHeroUidMap[arg_8_1] = nil

		arg_8_0:onModelUpdate()

		arg_8_0._selectUid = nil

		return true
	else
		if arg_8_0._isInitType and not arg_8_0:_isTeamCapacityEnough(var_8_0, arg_8_1) then
			GameFacade.showToast(ToastEnum.RougeTeamCapacityFull)

			return false
		end

		if arg_8_0._isSelectHeroType and not arg_8_0:_isTeamCapacityEnough(var_8_0, arg_8_1) then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return false
		end

		if arg_8_0._edityType == RougeEnum.HeroGroupEditType.Fight and not arg_8_0:_isTeamCapacityEnough(var_8_0, arg_8_1) then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return false
		end

		if arg_8_0:isTeamFull() then
			GameFacade.showToast(ToastEnum.RougeTeamFull)

			return false
		end

		local var_8_1 = 0

		for iter_8_0 = 1, #arg_8_0._inTeamHeroUidList do
			local var_8_2 = arg_8_0._inTeamHeroUidList[iter_8_0]

			if var_8_2 == 0 or var_8_2 == "0" and not arg_8_0:_skipAssistPos(iter_8_0) then
				arg_8_0._inTeamHeroUidList[iter_8_0] = arg_8_1
				arg_8_0._inTeamHeroUidMap[arg_8_1] = 1

				arg_8_0:onModelUpdate()

				return true
			end
		end

		arg_8_0._selectUid = arg_8_1
	end

	return false
end

function var_0_0.isRepeatHero(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._inTeamHeroUidMap then
		return false
	end

	for iter_9_0 in pairs(arg_9_0._inTeamHeroUidMap) do
		local var_9_0 = arg_9_0:getById(iter_9_0)

		if var_9_0.heroId == arg_9_1 and arg_9_2 ~= var_9_0.uid then
			return true
		end
	end

	return false
end

function var_0_0.isTrialLimit(arg_10_0)
	if not arg_10_0._inTeamHeroUidMap then
		return false
	end

	local var_10_0 = 0

	for iter_10_0 in pairs(arg_10_0._inTeamHeroUidMap) do
		if arg_10_0:getById(iter_10_0):isTrial() then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0 >= HeroGroupTrialModel.instance:getLimitNum()
end

function var_0_0.inInTeam(arg_11_0, arg_11_1)
	if not arg_11_0._inTeamHeroUidMap then
		return false
	end

	return arg_11_0._inTeamHeroUidMap[arg_11_1] and true or false
end

function var_0_0.getHeroUids(arg_12_0)
	return arg_12_0._inTeamHeroUidList
end

function var_0_0.getHeroUidByPos(arg_13_0, arg_13_1)
	return arg_13_0._inTeamHeroUidList[arg_13_1]
end

function var_0_0.getAssitPosIndex(arg_14_0, arg_14_1)
	return arg_14_0._assitPosIndex[arg_14_1]
end

function var_0_0.getIsDirty(arg_15_0)
	for iter_15_0 = 1, #arg_15_0._inTeamHeroUidList do
		if arg_15_0._inTeamHeroUidList[iter_15_0] ~= arg_15_0._originalHeroUidList[iter_15_0] then
			return true
		end
	end

	return false
end

function var_0_0.cancelAllSelected(arg_16_0)
	if arg_16_0._scrollViews then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._scrollViews) do
			local var_16_0 = iter_16_1:getFirstSelect()
			local var_16_1 = arg_16_0:getIndex(var_16_0)

			iter_16_1:selectCell(var_16_1, false)
		end
	end
end

function var_0_0.isPositionOpen(arg_17_0, arg_17_1)
	if arg_17_0._isSelectHeroType or arg_17_0._isInitType then
		return true
	end

	return RougeHeroGroupModel.instance:isPositionOpen(arg_17_1)
end

function var_0_0.isTeamFull(arg_18_0)
	if arg_18_0._isSelectHeroType then
		return false
	end

	local var_18_0 = arg_18_0._battleRoleNum

	for iter_18_0 = 1, math.min(var_18_0, #arg_18_0._inTeamHeroUidList) do
		local var_18_1 = arg_18_0:isPositionOpen(iter_18_0)

		if arg_18_0._inTeamHeroUidList[iter_18_0] == "0" and var_18_1 and not arg_18_0:_skipAssistPos(iter_18_0) then
			return false
		end
	end

	return true
end

function var_0_0._skipAssistPos(arg_19_0, arg_19_1)
	return RougeHeroGroupEditListModel.instance:getAssistPos() == arg_19_1
end

function var_0_0.setParam(arg_20_0, arg_20_1)
	arg_20_0.adventure = arg_20_1
end

function var_0_0.clear(arg_21_0)
	arg_21_0._inTeamHeroUidMap = nil
	arg_21_0._inTeamHeroUidList = nil
	arg_21_0._originalHeroUidList = nil
	arg_21_0._selectIndex = nil
	arg_21_0._selectUid = nil

	var_0_0.super.clear(arg_21_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
