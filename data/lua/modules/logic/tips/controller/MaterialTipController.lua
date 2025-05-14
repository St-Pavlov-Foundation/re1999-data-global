﻿module("modules.logic.tips.controller.MaterialTipController", package.seeall)

local var_0_0 = class("MaterialTipController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.showMaterialInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7, arg_3_8, arg_3_9, arg_3_10, arg_3_11, arg_3_12, arg_3_13)
	arg_3_1 = tonumber(arg_3_1)
	arg_3_2 = tonumber(arg_3_2)

	local var_3_0 = {
		type = arg_3_1,
		id = arg_3_2,
		inpack = arg_3_3,
		uid = arg_3_4,
		canJump = not arg_3_5,
		recordFarmItem = arg_3_6,
		fakeQuantity = arg_3_7,
		needQuantity = arg_3_8,
		isConsume = arg_3_9,
		jumpFinishCallback = arg_3_10,
		jumpFinishCallbackObj = arg_3_11,
		jumpFinishCallbackParam = arg_3_12,
		roomBuildingLevel = arg_3_13 and arg_3_13.roomBuildingLevel
	}

	arg_3_0:showMaterialInfoWithData(arg_3_1, arg_3_2, var_3_0)
end

function var_0_0.showMaterialInfoWithData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_3.type = arg_4_1
	arg_4_3.id = arg_4_2

	local var_4_0 = arg_4_3.inpack

	if arg_4_1 == MaterialEnum.MaterialType.Item then
		local var_4_1 = ItemModel.instance:getItemConfig(arg_4_1, arg_4_2)

		if var_4_1.subType == ItemEnum.SubType.MainSceneSkin then
			ViewMgr.instance:openView(ViewName.MainSceneSkinMaterialTipView, arg_4_3)

			return
		end

		if var_4_0 ~= true and MaterialEnum.SubTypePackages[var_4_1.subType] then
			ViewMgr.instance:openView(ViewName.MaterialPackageTipView, arg_4_3)
		elseif ItemEnum.RoomBackpackPropSubType[var_4_1.subType] then
			ViewMgr.instance:openView(ViewName.RoomManufactureMaterialTipView, arg_4_3)
		else
			ViewMgr.instance:openView(ViewName.MaterialTipView, arg_4_3)
		end
	elseif arg_4_1 == MaterialEnum.MaterialType.Currency then
		arg_4_3.inpack = false

		if arg_4_2 ~= CurrencyEnum.CurrencyType.Act186 then
			ViewMgr.instance:openView(ViewName.MaterialTipView, arg_4_3)
		end
	elseif arg_4_1 == MaterialEnum.MaterialType.Hero then
		arg_4_3.hero = true

		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			heroId = arg_4_2
		})
	elseif arg_4_1 == MaterialEnum.MaterialType.HeroSkin then
		CharacterController.instance:openCharacterSkinTipView(arg_4_2)
	elseif arg_4_1 == MaterialEnum.MaterialType.Equip then
		EquipController.instance:openEquipView({
			equipId = arg_4_2
		})
	elseif arg_4_1 == MaterialEnum.MaterialType.PlayerCloth then
		arg_4_3.isTip = true

		ViewMgr.instance:openView(ViewName.PlayerClothView, arg_4_3)
	elseif arg_4_1 == MaterialEnum.MaterialType.Building or arg_4_1 == MaterialEnum.MaterialType.BlockPackage then
		ViewMgr.instance:openView(ViewName.RoomMaterialTipView, arg_4_3)
	elseif arg_4_1 == MaterialEnum.MaterialType.EquipCard then
		Activity104Controller.instance:openSeasonCelebrityCardTipView(arg_4_3)
	elseif arg_4_1 == MaterialEnum.MaterialType.Season123EquipCard then
		Season123Controller.instance:openSeasonCelebrityCardTipView(arg_4_3)
	elseif arg_4_1 == MaterialEnum.MaterialType.Antique then
		AntiqueController.instance:openAntiqueView(arg_4_2)
	elseif arg_4_1 == MaterialEnum.MaterialType.Critter then
		local var_4_2 = ItemModel.instance:getItemConfig(arg_4_1, arg_4_2)
		local var_4_3 = CritterHelper.buildFakeCritterMoByConfig(var_4_2)

		CritterController.instance:openRoomCritterDetailView(true, var_4_3, true)
	else
		arg_4_3.special = true

		ViewMgr.instance:openView(ViewName.MaterialTipView, arg_4_3)
	end
end

function var_0_0.onUseOptionalHeroGift(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 or #arg_5_2 < 0 then
		return
	end

	local var_5_0 = {}
	local var_5_1 = {
		materialId = arg_5_1.id,
		quantity = arg_5_1.quantity
	}

	table.insert(var_5_0, var_5_1)
	ItemRpc.instance:sendUseItemRequest(var_5_0, arg_5_2[1])
	CustomPickChoiceController.instance:dispatchEvent(CustomPickChoiceEvent.onCustomPickComplete)
end

function var_0_0.openView_LifeCirclePickChoice(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = ItemConfig.instance:getItemConfig(arg_6_1, arg_6_2)

	arg_6_0:_openView_LifeCirclePickChoice(var_6_0, arg_6_3)
end

function var_0_0._openView_LifeCirclePickChoice(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or 1

	if arg_7_2 <= 0 then
		return
	end

	local var_7_0 = arg_7_1.effect

	if string.nilorempty(var_7_0) then
		return
	end

	local var_7_1 = string.split(var_7_0, "|")
	local var_7_2 = {}
	local var_7_3
	local var_7_4 = #var_7_1

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_5 = tonumber(iter_7_1)

		table.insert(var_7_2, var_7_5)

		if var_7_3 == nil then
			if not HeroModel.instance:getByHeroId(var_7_5) then
				var_7_3 = false
			elseif iter_7_0 == var_7_4 then
				var_7_3 = true
			end
		end
	end

	local var_7_6 = var_7_3 and luaLang("lifecirclepickchoice_txt_Title_custom") or luaLang("lifecirclepickchoice_txt_Title_random")
	local var_7_7 = var_7_3 and luaLang("lifecirclepickchoice_txt_confirm_custom") or luaLang("lifecirclepickchoice_txt_confirm_random")
	local var_7_8 = {
		heroIdList = var_7_2,
		title = var_7_6,
		confirmDesc = var_7_7,
		isCustomSelect = var_7_3,
		callback = function(arg_8_0)
			local var_8_0 = var_7_3 and arg_8_0:selectedHeroId() or 0

			if var_7_3 and var_8_0 == 0 then
				GameFacade.showToast(ToastEnum.MaterialTipController_LifeCirclePickChoiceSelectOneTips)

				return
			end

			local var_8_1 = arg_7_1.id

			MaterialRpc.instance:set_onReceiveMaterialChangePushOnce(arg_7_0._onReceiveMaterialChangePush_LifeCirclePickChoice, arg_7_0)
			HeroRpc.instance:set_onReceiveHeroGainPushOnce(arg_7_0._onReceiveHeroGainPush_LifeCirclePickChoice, arg_7_0)
			CharacterModel.instance:setGainHeroViewShowState(true)
			ItemRpc.instance:simpleSendUseItemRequest(var_8_1, arg_7_2, var_8_0, arg_8_0.closeThis, arg_8_0)
		end
	}

	ViewMgr.instance:openView(ViewName.LifeCirclePickChoice, var_7_8)
end

function var_0_0._onReceiveMaterialChangePush_LifeCirclePickChoice(arg_9_0, arg_9_1, arg_9_2)
	CharacterModel.instance:setGainHeroViewShowState(false)

	if arg_9_1 ~= 0 then
		return
	end

	LifeCircleController.instance:onReceiveMaterialChangePush(arg_9_2)
end

function var_0_0._onReceiveHeroGainPush_LifeCirclePickChoice(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	LifeCircleController.instance:onReceiveHeroGainPush(arg_10_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
