module("modules.logic.resonance.model.HeroResonaceModel", package.seeall)

local var_0_0 = class("HeroResonaceModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._copyShareCode = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._copyShareCode = nil
end

function var_0_0.getCurLayoutShareCode(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.talentCubeInfos.data_list

	if var_3_0 and tabletool.len(var_3_0) > 0 then
		local var_3_1 = {}
		local var_3_2 = arg_3_1:getHeroUseCubeStyleId() or 0

		table.insert(var_3_1, var_3_2)

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			local var_3_3 = iter_3_1.cubeId

			if var_3_3 > 100 then
				local var_3_4 = var_3_3 % 10

				var_3_3 = math.floor(var_3_3 / 10)
			end

			local var_3_5 = bit.lshift(var_3_3 - 1, 2) + iter_3_1.direction

			table.insert(var_3_1, var_3_5)

			local var_3_6 = bit.lshift(iter_3_1.posX, 4) + iter_3_1.posY

			table.insert(var_3_1, var_3_6)
		end

		local var_3_7 = string.char(unpack(var_3_1))

		return Base64Util.encode(var_3_7)
	end
end

function var_0_0.decodeLayoutShareCode(arg_4_0, arg_4_1)
	local var_4_0 = Base64Util.decode(arg_4_1)
	local var_4_1 = {}
	local var_4_2 = string.byte(var_4_0, 1)

	for iter_4_0 = 1, string.len(var_4_0) / 2 do
		local var_4_3 = string.byte(var_4_0, iter_4_0 * 2)
		local var_4_4 = string.byte(var_4_0, iter_4_0 * 2 + 1)

		if not var_4_3 or not var_4_4 then
			return
		end

		if var_4_3 < 0 then
			var_4_3 = var_4_3 + 256
		end

		local var_4_5 = bit.rshift(var_4_3, 2) + 1
		local var_4_6 = bit.band(var_4_3, 3)
		local var_4_7 = bit.rshift(var_4_4, 4)
		local var_4_8 = bit.band(var_4_4, 15)
		local var_4_9 = {
			cubeId = var_4_5,
			direction = var_4_6,
			posX = var_4_7,
			posY = var_4_8
		}

		table.insert(var_4_1, var_4_9)
	end

	return var_4_1, var_4_2
end

function var_0_0.canUseLayoutShareCode(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0:decodeLayoutShareCode(arg_5_2)

	if not var_5_0 or tabletool.len(var_5_0) == 0 then
		if not string.nilorempty(arg_5_2) then
			return false, ToastEnum.CharacterTalentCopyCodeError
		end

		return
	end

	local var_5_1 = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(arg_5_1.heroId, arg_5_1.talent), ",")
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_3 = HeroResonanceConfig.instance:getCubeConfigNotError(iter_5_1.cubeId)

		if var_5_3 then
			local var_5_4 = GameUtil.splitString2(var_5_3.shape, true, "#", ",")
			local var_5_5 = {}

			for iter_5_2 = 1, #var_5_4 do
				for iter_5_3 = 1, #var_5_4[iter_5_2] do
					if not var_5_5[iter_5_2 - 1] then
						var_5_5[iter_5_2 - 1] = {}
					end

					var_5_5[iter_5_2 - 1][iter_5_3 - 1] = var_5_4[iter_5_2][iter_5_3]
				end
			end

			local var_5_6 = arg_5_0:rotationMatrix(var_5_5, iter_5_1.direction)

			if arg_5_0:_isOverCell(var_5_6, var_5_1, iter_5_1) then
				return
			end

			if not var_5_2[iter_5_1.cubeId] then
				var_5_2[iter_5_1.cubeId] = 0
			end

			var_5_2[iter_5_1.cubeId] = var_5_2[iter_5_1.cubeId] + 1
		else
			return false, ToastEnum.CharacterTalentCopyCodeError
		end
	end

	local var_5_7 = arg_5_1.talentCubeInfos.own_cube_dic

	for iter_5_4, iter_5_5 in pairs(var_5_2) do
		local var_5_8 = var_5_7[iter_5_4]

		if not var_5_8 or iter_5_5 > var_5_8.own + var_5_8.use then
			return
		end
	end

	return true
end

function var_0_0._isOverCell(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0, var_6_1 = arg_6_0:getMatrixRange(arg_6_1, arg_6_3)

	return var_6_0 > arg_6_2[1] or var_6_1 > arg_6_2[2]
end

function var_0_0.getMatrixRange(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = 0
	local var_7_1 = 0

	if arg_7_1 then
		for iter_7_0 = 0, GameUtil.getTabLen(arg_7_1) - 1 do
			local var_7_2 = arg_7_1[iter_7_0]

			for iter_7_1 = 0, GameUtil.getTabLen(var_7_2) - 1 do
				if var_7_2[iter_7_1] == 1 then
					if var_7_0 < iter_7_1 then
						var_7_0 = iter_7_1
					end

					if var_7_1 < iter_7_0 then
						var_7_1 = iter_7_0
					end
				end
			end
		end
	end

	return arg_7_2.posX + var_7_0 + 1, arg_7_2.posY + var_7_1 + 1
end

function var_0_0.rotationMatrix(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1

	while arg_8_2 > 0 do
		var_8_0 = {}

		local var_8_1 = GameUtil.getTabLen(arg_8_1)
		local var_8_2 = GameUtil.getTabLen(arg_8_1[0])

		for iter_8_0 = 0, var_8_2 - 1 do
			var_8_0[iter_8_0] = {}

			for iter_8_1 = 0, var_8_1 - 1 do
				var_8_0[iter_8_0][iter_8_1] = arg_8_1[var_8_1 - iter_8_1 - 1][iter_8_0]
			end
		end

		arg_8_2 = arg_8_2 - 1

		if arg_8_2 > 0 then
			arg_8_1 = var_8_0
		end
	end

	return var_8_0
end

function var_0_0._isUseTalentStyle(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 and arg_9_2 > 0 then
		return TalentStyleModel.instance:getCubeMoByStyle(arg_9_1, arg_9_2)._isUse
	end
end

function var_0_0._isUnlockTalentStyle(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 and arg_10_2 > 0 then
		local var_10_0 = TalentStyleModel.instance:getCubeMoByStyle(arg_10_1, arg_10_2)

		return var_10_0._isUnlock, var_10_0
	end
end

function var_0_0.getShareTalentAttrInfos(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	if not arg_11_2 then
		return var_11_0
	end

	local var_11_1 = {}
	local var_11_2 = arg_11_1:getTalentGain()
	local var_11_3 = arg_11_1.talentCubeInfos.own_main_cube_id
	local var_11_4 = SkillConfig.instance:getTalentDamping()
	local var_11_5 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		local var_11_6 = iter_11_1.cubeId

		if not var_11_5[var_11_6] then
			var_11_5[var_11_6] = {}
		end

		table.insert(var_11_5[var_11_6], iter_11_1)
	end

	for iter_11_2, iter_11_3 in pairs(var_11_5) do
		local var_11_7 = {}
		local var_11_8 = iter_11_2

		if var_11_3 == iter_11_2 and arg_11_3 ~= 0 then
			local var_11_9 = TalentStyleModel.instance:getCubeMoByStyle(arg_11_1.heroId, arg_11_3)

			if var_11_9 and var_11_9._isUnlock then
				var_11_8 = var_11_9._replaceId
			end
		end

		local var_11_10 = #iter_11_3
		local var_11_11 = var_11_10 >= var_11_4[1][1] and (var_11_10 >= var_11_4[2][1] and var_11_4[2][2] or var_11_4[1][2]) or nil

		for iter_11_4 = 1, var_11_10 do
			arg_11_1:getTalentAttrGainSingle(var_11_8, var_11_7)
		end

		for iter_11_5, iter_11_6 in pairs(var_11_7) do
			if var_11_11 then
				var_11_7[iter_11_5] = iter_11_6 * (var_11_11 / 1000)
			end

			if var_11_7[iter_11_5] > 0 then
				var_11_1[iter_11_5] = (var_11_1[iter_11_5] or 0) + var_11_7[iter_11_5]
			end
		end
	end

	for iter_11_7, iter_11_8 in pairs(var_11_1) do
		local var_11_12 = var_11_2[iter_11_7]
		local var_11_13 = {
			key = iter_11_7,
			value = var_11_12 and var_11_12.value or 0,
			shareValue = iter_11_8 or 0
		}

		table.insert(var_11_0, var_11_13)
	end

	for iter_11_9, iter_11_10 in pairs(var_11_2) do
		if not arg_11_0:_isHasAttr(var_11_0, iter_11_9) then
			local var_11_14 = {
				key = iter_11_9,
				value = iter_11_10 and iter_11_10.value or 0
			}

			var_11_14.shareValue = 0

			table.insert(var_11_0, var_11_14)
		end
	end

	table.sort(var_11_0, arg_11_0._sortAttr)

	return var_11_0
end

function var_0_0._isHasAttr(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 then
		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			if iter_12_1.key == arg_12_2 then
				return true
			end
		end
	end
end

function var_0_0._sortAttr(arg_13_0, arg_13_1)
	return HeroConfig.instance:getIDByAttrType(arg_13_0.key) < HeroConfig.instance:getIDByAttrType(arg_13_1.key)
end

function var_0_0.saveShareCode(arg_14_0, arg_14_1)
	arg_14_0._copyShareCode = arg_14_1
end

function var_0_0.getShareCode(arg_15_0)
	return arg_15_0._copyShareCode
end

function var_0_0.getSpecialCn(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1 and arg_16_1:getTalentTxtByHeroType() or 1

	return luaLang("talent_character_talentcn" .. var_16_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
