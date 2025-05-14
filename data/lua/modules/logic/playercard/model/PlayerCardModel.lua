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
end

function var_0_0.updateSetting(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getCardInfo()

	if var_4_0 then
		var_4_0:updateShowSetting(arg_4_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_4_0.userId)
	end
end

function var_0_0.updateProgressSetting(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getCardInfo()

	if var_5_0 then
		var_5_0:updateProgressSetting(arg_5_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_5_0.userId)
	end
end

function var_0_0.updateBaseInfoSetting(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getCardInfo()

	if var_6_0 then
		var_6_0:updateBaseInfoSetting(arg_6_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_6_0.userId)
	end
end

function var_0_0.updateHeroCover(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getCardInfo()

	if var_7_0 then
		var_7_0:updateHeroCover(arg_7_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_7_0.userId)
	end
end

function var_0_0.updateThemeId(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getCardInfo()

	if var_8_0 then
		var_8_0:updateThemeId(arg_8_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_8_0.userId)
	end
end

function var_0_0.updateCritter(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getCardInfo()

	if var_9_0 then
		var_9_0:updateCritter(arg_9_1, arg_9_2)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_9_0.userId)
	end
end

function var_0_0.updateAchievement(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getCardInfo()

	if var_10_0 then
		var_10_0:updateAchievement(arg_10_1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, var_10_0.userId)
	end
end

function var_0_0.getCardInfo(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or PlayerModel.instance:getMyUserId()

	return arg_11_0:getById(arg_11_1)
end

function var_0_0.getShowAchievement(arg_12_0)
	local var_12_0 = arg_12_0:getCardInfo()

	if var_12_0 then
		return var_12_0:getShowAchievement()
	end
end

function var_0_0.themeIsUnlock(arg_13_0, arg_13_1)
	return true
end

function var_0_0.isCharacterSwitchFlag(arg_14_0)
	return arg_14_0.characterSwitchFlag
end

function var_0_0.setCharacterSwitchFlag(arg_15_0, arg_15_1)
	arg_15_0.characterSwitchFlag = arg_15_1
end

function var_0_0.setSelectCritterUid(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getCardInfo()

	if var_16_0 then
		return var_16_0:setSelectCritterUid(arg_16_1)
	end
end

function var_0_0.getSelectCritterUid(arg_17_0)
	local var_17_0 = arg_17_0:getCardInfo()

	if var_17_0 then
		return var_17_0:getSelectCritterUid()
	end
end

function var_0_0.getPlayerCardSkinId(arg_18_0)
	local var_18_0 = arg_18_0:getCardInfo()

	if var_18_0 then
		return var_18_0:getThemeId()
	end
end

function var_0_0.setSelectSkinMO(arg_19_0, arg_19_1)
	arg_19_0.selectSkinMO = arg_19_1
end

function var_0_0.getSelectSkinMO(arg_20_0)
	return arg_20_0.selectSkinMO or nil
end

function var_0_0.setIsOpenSkinView(arg_21_0, arg_21_1)
	arg_21_0.isopenskin = arg_21_1
end

function var_0_0.getIsOpenSkinView(arg_22_0)
	return arg_22_0.isopenskin
end

function var_0_0.setSelectHero(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.selectHeroId = arg_23_1
	arg_23_0.selectSkinId = arg_23_2
end

function var_0_0.getSelectHero(arg_24_0)
	return arg_24_0.selectHeroId, arg_24_0.selectSkinId
end

function var_0_0.checkHeroDiff(arg_25_0)
	local var_25_0, var_25_1, var_25_2, var_25_3 = arg_25_0:getCardInfo():getMainHero()

	if var_25_0 ~= arg_25_0.selectHeroId or var_25_1 ~= arg_25_0.selectSkinId then
		return false
	end

	return true
end

function var_0_0.getCritterOpen(arg_26_0)
	local var_26_0 = CritterModel.instance:isCritterUnlock(false)
	local var_26_1 = CritterModel.instance:getAllCritters()

	return var_26_0 and #var_26_1 > 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
