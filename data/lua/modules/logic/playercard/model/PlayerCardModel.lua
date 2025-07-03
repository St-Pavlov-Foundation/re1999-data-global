module("modules.logic.playercard.model.PlayerCardModel", package.seeall)

local var_0_0 = class("PlayerCardModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.characterSwitchFlag = nil
end

function var_0_0.updateCardInfo(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2 and arg_3_2.userId or PlayerModel.instance:getMyUserId()

	if not var_3_0 then
		return
	end

	local var_3_1 = arg_3_0:getById(var_3_0)

	if not var_3_1 then
		var_3_1 = PlayerCardMO.New()

		var_3_1:init(var_3_0)
		arg_3_0:addAtLast(var_3_1)
	end

	var_3_1:updateInfo(arg_3_1, arg_3_2)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_3_0)
	arg_3_0:setShowRed()
end

function var_0_0.setShowRed(arg_4_0)
	arg_4_0._showRed = false

	local var_4_0 = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.PlayerBg)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = iter_4_1.id
		local var_4_2 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. var_4_1

		if PlayerPrefsHelper.getNumber(var_4_2, 0) == 1 then
			arg_4_0._showRed = true

			break
		end
	end
end

function var_0_0.getShowRed(arg_5_0)
	return arg_5_0._showRed
end

function var_0_0.updateSetting(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getCardInfo()

	if var_6_0 then
		var_6_0:updateShowSetting(arg_6_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_6_0.userId)
	end
end

function var_0_0.updateProgressSetting(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getCardInfo()

	if var_7_0 then
		var_7_0:updateProgressSetting(arg_7_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_7_0.userId)
	end
end

function var_0_0.updateBaseInfoSetting(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getCardInfo()

	if var_8_0 then
		var_8_0:updateBaseInfoSetting(arg_8_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_8_0.userId)
	end
end

function var_0_0.updateHeroCover(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getCardInfo()

	if var_9_0 then
		var_9_0:updateHeroCover(arg_9_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_9_0.userId)
	end
end

function var_0_0.updateThemeId(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getCardInfo()

	if var_10_0 then
		var_10_0:updateThemeId(arg_10_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_10_0.userId)
	end
end

function var_0_0.updateCritter(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0:getCardInfo()

	if var_11_0 then
		var_11_0:updateCritter(arg_11_1, arg_11_2)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_11_0.userId)
	end
end

function var_0_0.updateAchievement(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getCardInfo()

	if var_12_0 then
		var_12_0:updateAchievement(arg_12_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_12_0.userId)
	end
end

function var_0_0.getCardInfo(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or PlayerModel.instance:getMyUserId()

	return arg_13_0:getById(arg_13_1)
end

function var_0_0.getShowAchievement(arg_14_0)
	local var_14_0 = arg_14_0:getCardInfo()

	if var_14_0 then
		return var_14_0:getShowAchievement()
	end
end

function var_0_0.themeIsUnlock(arg_15_0, arg_15_1)
	return true
end

function var_0_0.isCharacterSwitchFlag(arg_16_0)
	return arg_16_0.characterSwitchFlag
end

function var_0_0.setCharacterSwitchFlag(arg_17_0, arg_17_1)
	arg_17_0.characterSwitchFlag = arg_17_1
end

function var_0_0.setSelectCritterUid(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getCardInfo()

	if var_18_0 then
		return var_18_0:setSelectCritterUid(arg_18_1)
	end
end

function var_0_0.getSelectCritterUid(arg_19_0)
	local var_19_0 = arg_19_0:getCardInfo()

	if var_19_0 then
		return var_19_0:getSelectCritterUid()
	end
end

function var_0_0.getPlayerCardSkinId(arg_20_0)
	local var_20_0 = arg_20_0:getCardInfo()

	if var_20_0 then
		return var_20_0:getThemeId()
	end
end

function var_0_0.setSelectSkinMO(arg_21_0, arg_21_1)
	arg_21_0.selectSkinMO = arg_21_1
end

function var_0_0.getSelectSkinMO(arg_22_0)
	return arg_22_0.selectSkinMO or nil
end

function var_0_0.setIsOpenSkinView(arg_23_0, arg_23_1)
	arg_23_0.isopenskin = arg_23_1
end

function var_0_0.getIsOpenSkinView(arg_24_0)
	return arg_24_0.isopenskin
end

function var_0_0.setSelectHero(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.selectHeroId = arg_25_1
	arg_25_0.selectSkinId = arg_25_2
end

function var_0_0.getSelectHero(arg_26_0)
	return arg_26_0.selectHeroId, arg_26_0.selectSkinId
end

function var_0_0.checkHeroDiff(arg_27_0)
	local var_27_0, var_27_1, var_27_2, var_27_3 = arg_27_0:getCardInfo():getMainHero()

	if var_27_0 ~= arg_27_0.selectHeroId or var_27_1 ~= arg_27_0.selectSkinId then
		return false
	end

	return true
end

function var_0_0.getCritterOpen(arg_28_0)
	local var_28_0 = CritterModel.instance:isCritterUnlock(false)
	local var_28_1 = CritterModel.instance:getAllCritters()

	return var_28_0 and #var_28_1 > 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
