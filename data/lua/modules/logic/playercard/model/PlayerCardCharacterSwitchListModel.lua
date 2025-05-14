module("modules.logic.playercard.model.PlayerCardCharacterSwitchListModel", package.seeall)

local var_0_0 = class("PlayerCardCharacterSwitchListModel", ListScrollModel)

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

	local var_3_0 = HeroModel.instance:getList()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_1 = CharacterMainHeroMO.New()

		var_3_1:init(iter_3_1, iter_3_1.config.skinId, false)
		table.insert(arg_3_0._mainHeroList, var_3_1)
	end
end

function var_0_0._isDefaultSkinId(arg_4_0, arg_4_1)
	return arg_4_1.skinId == arg_4_1.heroMO.config.skinId
end

function var_0_0._commonSort(arg_5_0, arg_5_1, arg_5_2)
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

function var_0_0.changeMainHero(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_1 = arg_12_1 and tonumber(arg_12_1)
	arg_12_2 = arg_12_2 and tonumber(arg_12_2)

	local var_12_0 = arg_12_4 and 1 or 0

	if not arg_12_2 or arg_12_2 == 0 then
		arg_12_2 = HeroConfig.instance:getHeroCO(arg_12_1).skinId
	end

	local var_12_1 = table.concat({
		arg_12_1,
		arg_12_2,
		var_12_0
	}, "#")

	if not string.nilorempty(var_12_1) then
		local var_12_2 = PlayerCardModel.instance:isCharacterSwitchFlag()

		if var_12_2 == nil then
			ViewMgr.instance:openView(ViewName.PlayerCardCharacterSwitchTipsView, {
				heroParam = var_12_1
			})
		else
			arg_12_0:changeMainHeroByParam(var_12_1, var_12_2)
		end
	end
end

function var_0_0.changeMainHeroByParam(arg_13_0, arg_13_1, arg_13_2)
	if string.nilorempty(arg_13_1) then
		return
	end

	if arg_13_2 then
		local var_13_0 = string.splitToNumber(arg_13_1, "#")
		local var_13_1 = var_13_0[1]
		local var_13_2 = var_13_0[2]

		CharacterSwitchListModel.instance:changeMainHero(var_13_1, var_13_2)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.RefreshMainHeroSkin)
		CharacterController.instance:dispatchEvent(CharacterEvent.MainThumbnailSignature, var_13_1)
	end

	PlayerCardRpc.instance:sendSetPlayerCardHeroCoverRequest(arg_13_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
