module("modules.logic.character.model.CharacterDestinyModel", package.seeall)

local var_0_0 = class("CharacterDestinyModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onRankUp(arg_3_0, arg_3_1)
	return
end

function var_0_0.getCurSlotAttrInfos(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = {}
	local var_4_3 = CharacterDestinyConfig.instance:getCurDestinySlotAddAttr(arg_4_1, arg_4_2, arg_4_3)
	local var_4_4 = CharacterDestinyConfig.instance:getNextDestinySlotCo(arg_4_1, arg_4_2, arg_4_3)
	local var_4_5 = CharacterDestinyConfig.instance:getLockAttr(arg_4_1, arg_4_2)
	local var_4_6 = {}

	if var_4_4 then
		local var_4_7 = GameUtil.splitString2(var_4_4.effect, true)

		for iter_4_0, iter_4_1 in ipairs(var_4_7) do
			local var_4_8 = HeroConfig.instance:getHeroAttributeCO(iter_4_1[1]).showType == 1 and iter_4_1[2] * 0.1 or iter_4_1[2]

			var_4_6[iter_4_1[1]] = var_4_8
		end
	end

	if arg_4_2 > 0 then
		if var_4_3 then
			for iter_4_2, iter_4_3 in pairs(var_4_3) do
				if LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, iter_4_2) then
					local var_4_9 = {
						attrId = iter_4_2,
						curNum = var_4_3[iter_4_2],
						nextNum = var_4_6[iter_4_2]
					}

					var_4_9.isSpecial = false

					table.insert(var_4_0, var_4_9)
				else
					local var_4_10 = {
						attrId = iter_4_2,
						curNum = var_4_3[iter_4_2],
						nextNum = var_4_6[iter_4_2]
					}

					var_4_10.isSpecial = true

					table.insert(var_4_1, var_4_10)
				end
			end

			table.sort(var_4_0, arg_4_0.sortAttr)
			table.sort(var_4_1, arg_4_0.sortAttr)
		end
	else
		if not var_4_2[1] then
			var_4_2[1] = {}
		end

		for iter_4_4, iter_4_5 in pairs(CharacterDestinyEnum.DestinyUpBaseAttr) do
			local var_4_11 = {
				attrId = iter_4_5,
				curNum = var_4_6[iter_4_5]
			}

			table.insert(var_4_2[1], var_4_11)
		end
	end

	if var_4_5 then
		for iter_4_6, iter_4_7 in pairs(var_4_5) do
			for iter_4_8, iter_4_9 in pairs(iter_4_7) do
				local var_4_12 = {
					attrId = iter_4_8,
					curNum = iter_4_9
				}

				if not arg_4_0:__isHadAttr(var_4_0, iter_4_8) and not arg_4_0:__isHadAttr(var_4_1, iter_4_8) and not arg_4_0:_isHadAttr(var_4_2, iter_4_8) then
					if not var_4_2[iter_4_6] then
						var_4_2[iter_4_6] = {}
					end

					table.insert(var_4_2[iter_4_6], var_4_12)
				end
			end
		end

		for iter_4_10, iter_4_11 in pairs(var_4_2) do
			table.sort(iter_4_11, arg_4_0.sortAttr)
		end
	end

	return var_4_0, var_4_1, var_4_2
end

function var_0_0.sortAttr(arg_5_0, arg_5_1)
	local var_5_0 = LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, arg_5_0.attrId)

	if var_5_0 ~= LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, arg_5_1.attrId) then
		return var_5_0
	end

	return arg_5_0.attrId < arg_5_1.attrId
end

function var_0_0._isHadAttr(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 then
		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			if arg_6_0:__isHadAttr(iter_6_1, arg_6_2) then
				return true
			end
		end
	end
end

function var_0_0.__isHadAttr(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			if iter_7_1.attrId == arg_7_2 then
				return true
			end
		end
	end
end

function var_0_0.destinyUpBaseReverseParseAttr(arg_8_0, arg_8_1)
	if not arg_8_0._reverseParseBaseAttrList then
		arg_8_0._reverseParseBaseAttrList = {}

		for iter_8_0, iter_8_1 in pairs(CharacterDestinyEnum.DestinyUpBaseParseAttr) do
			for iter_8_2, iter_8_3 in ipairs(iter_8_1) do
				arg_8_0._reverseParseBaseAttrList[iter_8_3] = iter_8_0
			end
		end
	end

	return arg_8_0._reverseParseBaseAttrList[arg_8_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
