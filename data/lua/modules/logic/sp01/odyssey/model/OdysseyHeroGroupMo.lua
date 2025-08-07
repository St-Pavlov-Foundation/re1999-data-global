module("modules.logic.sp01.odyssey.model.OdysseyHeroGroupMo", package.seeall)

local var_0_0 = class("OdysseyHeroGroupMo", HeroGroupMO)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.no
	arg_1_0.groupId = arg_1_1.no
	arg_1_0.name = tostring(arg_1_1.name)

	if arg_1_1.clothId and arg_1_1.clothId == 0 then
		local var_1_0 = lua_cloth.configList[1].id

		if PlayerClothModel.instance:canUse(var_1_0) then
			arg_1_1.clothId = var_1_0
		end
	end

	arg_1_0.clothId = arg_1_1.clothId or 0
	arg_1_0.heroList = {}
	arg_1_0.assistBossId = nil
	arg_1_0.odysseyEquips = {}
	arg_1_0.isReplay = false
	arg_1_0.odysseySuitDic = {}
	arg_1_0._playerMax = OdysseyEnum.MaxHeroGroupCount
	arg_1_0._roleNum = OdysseyEnum.MaxHeroGroupCount
	arg_1_0.odysseyEquipDic = {}
	arg_1_0.heroIdPosDic = {}

	local var_1_1 = {}
	local var_1_2
	local var_1_3 = arg_1_1.heroes and #arg_1_1.heroes or 0

	for iter_1_0 = 1, var_1_3 do
		local var_1_4 = arg_1_1.heroes[iter_1_0]
		local var_1_5 = var_1_4.trialId
		local var_1_6 = var_1_5 ~= nil and var_1_5 ~= 0
		local var_1_7

		if var_1_6 then
			var_1_7 = lua_hero_trial.configDict[var_1_5][0]

			local var_1_8 = tostring(tonumber(var_1_5 .. "." .. "0") - 1099511627776)

			table.insert(arg_1_0.heroList, tostring(var_1_8))

			var_1_1[var_1_4.position] = {
				var_1_5,
				0
			}
			var_1_2 = -var_1_5
		else
			if var_1_4.heroId ~= 0 then
				local var_1_9 = HeroModel.instance:getByHeroId(var_1_4.heroId)

				table.insert(arg_1_0.heroList, tostring(var_1_9.uid))
			else
				table.insert(arg_1_0.heroList, tostring(var_1_4.heroId))
			end

			var_1_2 = var_1_4.heroId
		end

		arg_1_0.heroIdPosDic[var_1_4.position] = var_1_2

		if var_1_4.mindId ~= nil then
			local var_1_10

			if var_1_6 then
				var_1_10 = -var_1_7.equipId or 0
			else
				var_1_10 = var_1_4.mindId
			end

			local var_1_11 = {
				index = iter_1_0 - 1,
				equipUid = {
					tostring(var_1_10)
				}
			}

			arg_1_0:updatePosEquips(var_1_11)
		end

		arg_1_0:updateOdysseyEquips(var_1_4)

		for iter_1_1, iter_1_2 in ipairs(var_1_4.equips) do
			if iter_1_2.equipUid ~= 0 then
				arg_1_0.odysseyEquipDic[iter_1_2.equipUid] = {
					heroId = var_1_2,
					heroPos = var_1_4.position,
					slotId = iter_1_2.slotId
				}
			end
		end
	end

	arg_1_0.haveSuit = false

	for iter_1_3, iter_1_4 in ipairs(arg_1_1.suits) do
		if iter_1_4 then
			if arg_1_0.odysseySuitDic[iter_1_4.suitId] == nil then
				arg_1_0.odysseySuitDic[iter_1_4.suitId] = iter_1_4
			end

			if iter_1_4.count > 0 then
				arg_1_0.haveSuit = true
			end
		end
	end

	arg_1_0.trialDict = var_1_1

	for iter_1_5 = var_1_3 + 1, OdysseyEnum.MaxHeroGroupCount do
		table.insert(arg_1_0.heroList, "0")
	end
end

function var_0_0.updateOdysseyEquips(arg_2_0, arg_2_1)
	local var_2_0 = OdysseyHeroGroupEquipMo.New()

	var_2_0:init(arg_2_1)
	arg_2_0:setOdysseyEquips(var_2_0)
end

function var_0_0.getOdysseyEquips(arg_3_0, arg_3_1)
	return arg_3_0.odysseyEquips[arg_3_1]
end

function var_0_0.setOdysseyEquips(arg_4_0, arg_4_1)
	arg_4_0.odysseyEquips[arg_4_1.index] = arg_4_1
end

function var_0_0.swapOdysseyEquips(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getOdysseyEquips(arg_5_1)
	local var_5_1 = arg_5_0:getOdysseyEquips(arg_5_2)

	var_5_0.index = arg_5_2
	var_5_1.index = arg_5_1

	arg_5_0:setOdysseyEquips(var_5_0)
	arg_5_0:setOdysseyEquips(var_5_1)
end

function var_0_0.swapOdysseyEquip(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_0:getOdysseyEquips(arg_6_1)
	local var_6_1 = arg_6_0:getOdysseyEquips(arg_6_2)
	local var_6_2 = var_6_0.equipUid[arg_6_3] or 0

	var_6_0.equipUid[arg_6_3] = var_6_1.equipUid[arg_6_4]
	var_6_1.equipUid[arg_6_4] = var_6_2
end

function var_0_0.setOdysseyEquip(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:checkOdysseyEquipIsUse(arg_7_3)

	arg_7_0:getOdysseyEquips(arg_7_1 - 1).equipUid[arg_7_2] = arg_7_3
end

function var_0_0.replaceOdysseyEquip(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:setOdysseyEquip(arg_8_1, arg_8_2, arg_8_3)
end

function var_0_0.unloadOdysseyEquip(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:setOdysseyEquip(arg_9_1, arg_9_2, 0)
end

function var_0_0.checkOdysseyEquipIsUse(arg_10_0, arg_10_1)
	if arg_10_1 ~= nil and arg_10_1 ~= 0 then
		local var_10_0 = arg_10_0.odysseyEquipDic[arg_10_1]

		if var_10_0 then
			arg_10_0:setOdysseyEquip(var_10_0.heroPos, var_10_0.slotId, 0)
		end
	end
end

function var_0_0.isEquipUse(arg_11_0, arg_11_1)
	return arg_11_0.odysseyEquipDic[arg_11_1] ~= nil
end

function var_0_0.getEquipByUid(arg_12_0, arg_12_1)
	return arg_12_0.odysseyEquipDic[arg_12_1]
end

function var_0_0.getOdysseyEquipSuit(arg_13_0, arg_13_1)
	return arg_13_0.odysseySuitDic[arg_13_1]
end

function var_0_0.updatePosEquips(arg_14_0, arg_14_1)
	for iter_14_0 = 0, OdysseyEnum.MaxHeroGroupCount do
		local var_14_0 = arg_14_0.equips[iter_14_0]

		if var_14_0 and var_14_0.equipUid and #var_14_0.equipUid > 0 and arg_14_1.equipUid and #arg_14_1.equipUid > 0 then
			for iter_14_1 = 1, 1 do
				if var_14_0.equipUid[iter_14_1] == arg_14_1.equipUid[iter_14_1] then
					var_14_0.equipUid[iter_14_1] = "0"
				end
			end
		end
	end

	local var_14_1 = HeroGroupEquipMO.New()

	var_14_1:init(arg_14_1)

	arg_14_0.equips[arg_14_1.index] = var_14_1
end

return var_0_0
