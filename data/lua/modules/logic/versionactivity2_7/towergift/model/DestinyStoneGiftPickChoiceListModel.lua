module("modules.logic.versionactivity2_7.towergift.model.DestinyStoneGiftPickChoiceListModel", package.seeall)

local var_0_0 = class("DestinyStoneGiftPickChoiceListModel", ListScrollModel)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.heroMo.destinyStoneMo
	local var_1_1 = arg_1_1.heroMo.destinyStoneMo
	local var_1_2 = var_1_0:isUnlockSlot() and 1 or 2
	local var_1_3 = var_1_1:isUnlockSlot() and 1 or 2

	if var_1_2 ~= var_1_3 then
		return var_1_3 < var_1_2
	end

	local var_1_4 = var_1_0.rank
	local var_1_5 = var_1_1.rank

	if var_1_4 ~= var_1_5 then
		return var_1_4 < var_1_5
	end

	return arg_1_0.heroId > arg_1_1.heroId
end

function var_0_0.initList(arg_2_0, arg_2_1)
	arg_2_0._moList = {}

	local var_2_0 = HeroModel.instance:getAllHero()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		if iter_2_1 and arg_2_0:checkHeroOpenDestinyStone(iter_2_1) then
			local var_2_1 = iter_2_1.destinyStoneMo
			local var_2_2 = var_2_1:getStoneMoList()

			if var_2_1:isSlotMaxLevel() then
				for iter_2_2, iter_2_3 in pairs(var_2_2) do
					local var_2_3 = LuaUtil.tableContains(arg_2_1, iter_2_3.stoneId)

					if not iter_2_3.isUnlock and not var_2_3 then
						local var_2_4 = {
							heroMo = iter_2_1,
							heroId = iter_2_1.config.id,
							stoneMo = iter_2_3,
							stoneId = iter_2_3.stoneId
						}

						var_2_4.isUnLock = false

						table.insert(arg_2_0._moList, var_2_4)
					end
				end
			else
				for iter_2_4, iter_2_5 in pairs(var_2_2) do
					if not LuaUtil.tableContains(arg_2_1, iter_2_5.stoneId) then
						local var_2_5 = {
							isUnLock = iter_2_5.isUnlock
						}

						if var_2_5.isUnLock then
							var_2_5.stonelevel = var_2_1.rank
						end

						var_2_5.heroMo = iter_2_1
						var_2_5.heroId = iter_2_1.config.id
						var_2_5.stoneMo = iter_2_5
						var_2_5.stoneId = iter_2_5.stoneId

						table.insert(arg_2_0._moList, var_2_5)
					end
				end
			end
		end
	end

	table.sort(arg_2_0._moList, var_0_1)
	arg_2_0:setList(arg_2_0._moList)
end

function var_0_0.checkHeroOpenDestinyStone(arg_3_0, arg_3_1)
	if not arg_3_1:isHasDestinySystem() then
		return false
	end

	local var_3_0 = arg_3_1.config.rare or 5
	local var_3_1 = CharacterDestinyEnum.DestinyStoneOpenLevelConstId[var_3_0]
	local var_3_2 = CommonConfig.instance:getConstStr(var_3_1)

	if arg_3_1.level >= tonumber(var_3_2) and not arg_3_1.destinyStoneMo:checkAllUnlock() then
		return true
	end

	return false
end

function var_0_0.setCurrentSelectMo(arg_4_0, arg_4_1)
	if not arg_4_0.currentSelectMo then
		arg_4_0.currentSelectMo = arg_4_1
	elseif arg_4_0:isSelectedMo(arg_4_1.stoneId) then
		arg_4_0:clearSelect()
	else
		arg_4_0.currentSelectMo = arg_4_1
	end

	DestinyStoneGiftPickChoiceController.instance:dispatchEvent(DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged)
end

function var_0_0.getCurrentSelectMo(arg_5_0)
	return arg_5_0.currentSelectMo
end

function var_0_0.clearSelect(arg_6_0)
	arg_6_0.currentSelectMo = nil
end

function var_0_0.isSelectedMo(arg_7_0, arg_7_1)
	return arg_7_0.currentSelectMo and arg_7_0.currentSelectMo.stoneId == arg_7_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
