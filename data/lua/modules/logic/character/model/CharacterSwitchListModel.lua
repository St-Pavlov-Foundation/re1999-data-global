module("modules.logic.character.model.CharacterSwitchListModel", package.seeall)

local var_0_0 = class("CharacterSwitchListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._tempHeroId = nil
	arg_1_0._tempSkinId = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._tempHeroId = nil
	arg_2_0._tempSkinId = nil
end

function var_0_0.initHeroList(arg_3_0)
	arg_3_0._mainHeroList = {}
	arg_3_0.curHeroId = nil

	local var_3_0 = CharacterMainHeroMO.New()

	var_3_0:init(nil, 0, true)
	table.insert(arg_3_0._mainHeroList, var_3_0)

	local var_3_1 = HeroModel.instance:getList()

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_2 = CharacterMainHeroMO.New()

		var_3_2:init(iter_3_1, iter_3_1.config.skinId, false)
		table.insert(arg_3_0._mainHeroList, var_3_2)
	end
end

function var_0_0._isDefaultSkinId(arg_4_0, arg_4_1)
	return arg_4_1.skinId == arg_4_1.heroMO.config.skinId
end

function var_0_0._commonSort(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1.isRandom then
		return true
	end

	if arg_5_2.isRandom then
		return false
	end

	if arg_5_1.heroMO.heroId == arg_5_0.curHeroId then
		return true
	end

	if arg_5_2.heroMO.heroId == arg_5_0.curHeroId then
		return false
	end

	if arg_5_1.heroMO.heroId == arg_5_2.heroMO.heroId then
		return arg_5_0:_isDefaultSkinId(arg_5_1) and not arg_5_0:_isDefaultSkinId(arg_5_2)
	end

	return nil
end

function var_0_0.sortByTime(arg_6_0, arg_6_1)
	table.sort(arg_6_0._mainHeroList, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_6_0:_commonSort(arg_7_0, arg_7_1)

		if var_7_0 ~= nil then
			return var_7_0
		end

		if arg_7_0.heroMO.createTime ~= arg_7_1.heroMO.createTime then
			if arg_6_1 then
				return arg_7_0.heroMO.createTime < arg_7_1.heroMO.createTime
			else
				return arg_7_0.heroMO.createTime > arg_7_1.heroMO.createTime
			end
		end

		return arg_7_0.heroMO.heroId < arg_7_1.heroMO.heroId
	end)
	arg_6_0:setList(arg_6_0._mainHeroList)
end

function var_0_0.sortByRare(arg_8_0, arg_8_1)
	table.sort(arg_8_0._mainHeroList, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_8_0:_commonSort(arg_9_0, arg_9_1)

		if var_9_0 ~= nil then
			return var_9_0
		end

		if arg_9_0.heroMO.config.rare == arg_9_1.heroMO.config.rare then
			return arg_9_0.heroMO.config.id < arg_9_1.heroMO.config.id
		end

		if arg_9_0.heroMO.config.rare ~= arg_9_1.heroMO.config.rare then
			if arg_8_1 then
				return arg_9_0.heroMO.config.rare < arg_9_1.heroMO.config.rare
			else
				return arg_9_0.heroMO.config.rare > arg_9_1.heroMO.config.rare
			end
		end

		return arg_9_0.heroMO.heroId < arg_9_1.heroMO.heroId
	end)
	arg_8_0:setList(arg_8_0._mainHeroList)
end

function var_0_0.getMoByHeroId(arg_10_0, arg_10_1)
	if not arg_10_0._mainHeroList then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._mainHeroList) do
		if not iter_10_1.heroMO and not arg_10_1 or iter_10_1.heroMO and iter_10_1.heroMO.heroId == arg_10_1 then
			return iter_10_1
		end
	end
end

function var_0_0.getMoByHero(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._mainHeroList then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._mainHeroList) do
		if arg_11_2 and iter_11_1.skinId == arg_11_2 then
			return iter_11_1
		end

		if not arg_11_2 and iter_11_1.heroMO.heroId and iter_11_1.skinId == iter_11_1.heroMO.config.skinId then
			return iter_11_1
		end
	end
end

function var_0_0.getMainHero(arg_12_0, arg_12_1)
	local var_12_0 = PlayerModel.instance:getSimpleProperty(PlayerEnum.SimpleProperty.MainHero)
	local var_12_1 = string.splitToNumber(var_12_0, "#")
	local var_12_2 = var_12_1[1]
	local var_12_3 = var_12_1[2]
	local var_12_4 = var_12_2 == -1

	if var_12_4 then
		if arg_12_1 or not arg_12_0._tempHeroId or not arg_12_0._tempSkinId then
			local var_12_5 = HeroModel.instance:getList()
			local var_12_6 = var_12_5[math.random(#var_12_5)]

			if var_12_6 then
				local var_12_7 = {
					var_12_6.config.skinId
				}

				for iter_12_0, iter_12_1 in ipairs(var_12_6.skinInfoList) do
					table.insert(var_12_7, iter_12_1.skin)
				end

				arg_12_0._tempHeroId = var_12_6.heroId
				arg_12_0._tempSkinId = var_12_7[math.random(#var_12_7)]

				CharacterController.instance:dispatchEvent(CharacterEvent.RandomMainHero, arg_12_0._tempHeroId, arg_12_0._tempSkinId)
			end
		else
			return arg_12_0._tempHeroId, arg_12_0._tempSkinId, true
		end
	else
		if not var_12_2 or var_12_2 == 0 or not HeroConfig.instance:getHeroCO(var_12_2) then
			var_12_2 = arg_12_0:getDefaultHeroId()
			var_12_3 = nil
		end

		if (not var_12_3 or var_12_3 == 0) and var_12_2 and var_12_2 ~= 0 then
			local var_12_8 = HeroConfig.instance:getHeroCO(var_12_2)

			var_12_3 = var_12_8 and var_12_8.skinId
		end

		arg_12_0._tempHeroId = var_12_2
		arg_12_0._tempSkinId = var_12_3
	end

	local var_12_9 = ""

	if var_12_2 then
		var_12_9 = tostring(var_12_2)

		if var_12_3 then
			var_12_9 = var_12_9 .. "#" .. tostring(var_12_3)
		end
	end

	if not string.nilorempty(var_12_9) and var_12_9 ~= var_12_0 then
		PlayerModel.instance:forceSetSimpleProperty(PlayerEnum.SimpleProperty.MainHero, var_12_9)
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.MainHero, var_12_9)
	end

	return var_12_2, var_12_3, var_12_4
end

function var_0_0.getDefaultHeroId(arg_13_0)
	local var_13_0 = CommonConfig.instance:getConstNum(ConstEnum.MainViewDefaultHeroId)
	local var_13_1 = HeroModel.instance:getList()
	local var_13_2 = #var_13_1 > 0 and var_13_1[1].config.id or nil

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_3 = iter_13_1.config.id

		if var_13_3 == var_13_0 then
			return var_13_0
		end

		if var_13_3 < var_13_2 then
			var_13_2 = var_13_3
		end
	end

	return var_13_2
end

function var_0_0.changeMainHero(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1 = arg_14_1 and tonumber(arg_14_1)
	arg_14_2 = arg_14_2 and tonumber(arg_14_2)

	if arg_14_3 then
		arg_14_1 = -1
		arg_14_2 = -1
	elseif not arg_14_2 or arg_14_2 == 0 then
		arg_14_2 = HeroConfig.instance:getHeroCO(arg_14_1).skinId
	end

	local var_14_0 = ""

	if arg_14_1 then
		var_14_0 = tostring(arg_14_1)

		if arg_14_2 then
			var_14_0 = var_14_0 .. "#" .. tostring(arg_14_2)
		end
	end

	if not string.nilorempty(var_14_0) then
		PlayerModel.instance:forceSetSimpleProperty(PlayerEnum.SimpleProperty.MainHero, var_14_0)
		PlayerRpc.instance:sendSetSimplePropertyRequest(PlayerEnum.SimpleProperty.MainHero, tostring(var_14_0))
		CharacterController.instance:dispatchEvent(CharacterEvent.ChangeMainHero)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
