module("modules.logic.player.model.PlayerModel", package.seeall)

local var_0_0 = class("PlayerModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._userId = 0
	arg_1_0._name = ""
	arg_1_0._portrait = 0
	arg_1_0._level = 0
	arg_1_0._exp = 0
	arg_1_0._signature = ""
	arg_1_0._birthday = ""
	arg_1_0._showHeros = {}
	arg_1_0._registerTime = 0
	arg_1_0._lastLoginTime = 0
	arg_1_0._lastLogoutTime = 0
	arg_1_0._heroRareNNCount = 0
	arg_1_0._heroRareNCount = 0
	arg_1_0._heroRareRCount = 0
	arg_1_0._heroRareSRCount = 0
	arg_1_0._heroRareSSRCount = 0
	arg_1_0._lastEpisodeId = 0
	arg_1_0._levelup = 0
	arg_1_0._preCommitFeedBackTime = -1
	arg_1_0._bg = 0
	arg_1_0._canRename = false
	arg_1_0._canRenameFlagMonth = nil
	arg_1_0._playerInfo = nil
	arg_1_0._showAchievement = nil
	arg_1_0._totalLoginDays = 0

	arg_1_0:updateAssistRewardCountData(0, 0, true)
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._simpleProperties = {}
	arg_2_0._playerInfo = nil

	arg_2_0:updateAssistRewardCountData(0, 0, true)
end

function var_0_0.setPlayerinfo(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._level
	local var_3_1 = arg_3_0._lastEpisodeId

	arg_3_0._userId = arg_3_1.userId
	arg_3_0._name = arg_3_1.name
	arg_3_0._portrait = arg_3_1.portrait
	arg_3_0._level = arg_3_1.level
	arg_3_0._exp = arg_3_1.exp
	arg_3_0._signature = arg_3_1.signature
	arg_3_0._birthday = arg_3_1.birthday
	arg_3_0._registerTime = arg_3_1.registerTime
	arg_3_0._lastLoginTime = arg_3_1.lastLoginTime
	arg_3_0._lastLogoutTime = arg_3_1.lastLogoutTime
	arg_3_0._heroRareNNCount = arg_3_1.heroRareNNCount
	arg_3_0._heroRareNCount = arg_3_1.heroRareNCount
	arg_3_0._heroRareRCount = arg_3_1.heroRareRCount
	arg_3_0._heroRareSRCount = arg_3_1.heroRareSRCount
	arg_3_0._heroRareSSRCount = arg_3_1.heroRareSSRCount
	arg_3_0._lastEpisodeId = arg_3_1.lastEpisodeId
	arg_3_0._showAchievement = arg_3_1.showAchievement
	arg_3_0._bg = arg_3_1.bg
	arg_3_0._totalLoginDays = arg_3_1.totalLoginDays

	arg_3_0:_checkHeroinfo(arg_3_1.showHeros)
	PlayerController.instance:dispatchEvent(PlayerEvent.ChangePlayerinfo, arg_3_1)

	if var_3_0 < arg_3_0._level and var_3_0 ~= 0 then
		SDKMgr.instance:upgradeRole(StatModel.instance:generateRoleInfo())
		PlayerController.instance:dispatchEvent(PlayerEvent.PlayerLevelUp, var_3_0, arg_3_0._level)

		arg_3_0._levelup = arg_3_0._level - var_3_0
	end

	if var_3_1 ~= 0 and arg_3_0._lastEpisodeId ~= var_3_1 then
		SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
	end

	if OpenConfig.instance:isShowWaterMarkConfig() then
		arg_3_0:showWaterMark()
	end

	ActivityEnterMgr.instance:init()
end

function var_0_0.getAndResetPlayerLevelUp(arg_4_0)
	local var_4_0 = arg_4_0._levelup

	arg_4_0._levelup = 0

	return var_4_0
end

function var_0_0._checkHeroinfo(arg_5_0, arg_5_1)
	arg_5_0._showHeros = {}

	for iter_5_0 = 1, #arg_5_1 do
		if arg_5_1[iter_5_0].heroId == 0 then
			arg_5_1[iter_5_0] = 0
		end

		table.insert(arg_5_0._showHeros, arg_5_1[iter_5_0])
	end

	for iter_5_1 = 1, 3 do
		if iter_5_1 > #arg_5_0._showHeros then
			arg_5_0._showHeros[iter_5_1] = 0
		end
	end
end

function var_0_0.getPlayinfo(arg_6_0)
	arg_6_0._playerInfo = arg_6_0._playerInfo or {}

	local var_6_0 = arg_6_0._playerInfo

	var_6_0.userId = arg_6_0._userId
	var_6_0.name = arg_6_0._name
	var_6_0.portrait = arg_6_0._portrait
	var_6_0.level = arg_6_0._level
	var_6_0.exp = arg_6_0._exp
	var_6_0.signature = arg_6_0._signature
	var_6_0.birthday = arg_6_0._birthday
	var_6_0.showHeros = arg_6_0._showHeros
	var_6_0.registerTime = arg_6_0._registerTime
	var_6_0.lastLoginTime = arg_6_0._lastLoginTime
	var_6_0.lastLogoutTime = arg_6_0._lastLogoutTime
	var_6_0.heroRareNNCount = arg_6_0._heroRareNNCount
	var_6_0.heroRareNCount = arg_6_0._heroRareNCount
	var_6_0.heroRareRCount = arg_6_0._heroRareRCount
	var_6_0.heroRareSRCount = arg_6_0._heroRareSRCount
	var_6_0.heroRareSSRCount = arg_6_0._heroRareSSRCount
	var_6_0.lastEpisodeId = arg_6_0._lastEpisodeId
	var_6_0.showAchievement = arg_6_0._showAchievement
	var_6_0.bg = arg_6_0._bg
	var_6_0.totalLoginDays = arg_6_0._totalLoginDays

	return arg_6_0._playerInfo
end

function var_0_0.getExpNowAndMax(arg_7_0)
	local var_7_0 = arg_7_0._exp
	local var_7_1 = 0

	if arg_7_0._level < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		var_7_1 = PlayerConfig.instance:getPlayerLevelCO(arg_7_0._level + 1).exp
	else
		var_7_1 = PlayerConfig.instance:getPlayerLevelCO(arg_7_0._level).exp
		var_7_0 = var_7_1
	end

	return {
		var_7_0,
		var_7_1
	}
end

function var_0_0.getPlayerLevel(arg_8_0)
	return arg_8_0._level
end

function var_0_0.setPlayerName(arg_9_0, arg_9_1)
	arg_9_0._name = arg_9_1

	arg_9_0:_changePlayerbassinfo()
	PlayerController.instance:dispatchEvent(PlayerEvent.ChangePlayerName)
end

function var_0_0.setPlayerSignature(arg_10_0, arg_10_1)
	arg_10_0._signature = arg_10_1

	arg_10_0:_changePlayerbassinfo()
end

function var_0_0.setPlayerBirthday(arg_11_0, arg_11_1)
	arg_11_0._birthday = arg_11_1

	arg_11_0:_changePlayerbassinfo()
end

function var_0_0.getPlayerBirthday(arg_12_0)
	return arg_12_0._birthday or ""
end

function var_0_0.setPlayerPortrait(arg_13_0, arg_13_1)
	PlayerController.instance:dispatchEvent(PlayerEvent.SetPortrait, arg_13_1)

	arg_13_0._portrait = arg_13_1

	arg_13_0:_changePlayerbassinfo()
end

function var_0_0.setShowHeroUniqueIds(arg_14_0)
	PlayerController.instance:dispatchEvent(PlayerEvent.SetShowHero, arg_14_0._showHeros)
end

function var_0_0._changePlayerbassinfo(arg_15_0)
	local var_15_0 = arg_15_0:getPlayinfo()

	PlayerController.instance:dispatchEvent(PlayerEvent.PlayerbassinfoChange, var_15_0)
end

function var_0_0.getShowHeros(arg_16_0)
	return arg_16_0._showHeros
end

function var_0_0.getShowHeroUid(arg_17_0)
	local var_17_0 = {}

	for iter_17_0 = 1, #arg_17_0._showHeros do
		if arg_17_0._showHeros[iter_17_0] ~= 0 then
			local var_17_1 = HeroModel.instance:getByHeroId(arg_17_0._showHeros[iter_17_0].heroId).uid

			table.insert(var_17_0, var_17_1)
		else
			table.insert(var_17_0, 0)
		end
	end

	return var_17_0
end

function var_0_0.setShowHero(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 ~= 0 then
		arg_18_0._showHeros[arg_18_1] = arg_18_0:_setSimpleinfo(arg_18_2)
	else
		arg_18_0._showHeros[arg_18_1] = 0
	end
end

function var_0_0._setSimpleinfo(arg_19_0, arg_19_1)
	local var_19_0 = HeroModel.instance:getByHeroId(arg_19_1)

	return {
		uid = var_19_0.uid,
		heroId = var_19_0.heroId,
		level = var_19_0.level,
		rank = var_19_0.rank,
		exSkillLevel = var_19_0.exSkillLevel,
		skin = var_19_0.skin
	}
end

function var_0_0.updateAssistRewardCountData(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	arg_20_0._assistRewardCount = arg_20_1 or 0
	arg_20_0._hasReceiveAssistBonus = arg_20_2 or 0

	if arg_20_3 then
		return
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.UpdateAssistRewardCount)
end

function var_0_0.getAssistRewardCount(arg_21_0)
	return arg_21_0._assistRewardCount or 0
end

function var_0_0.isHasAssistReward(arg_22_0)
	local var_22_0 = false

	if arg_22_0:isGetAssistRewardReachingLimit() then
		return var_22_0
	end

	local var_22_1 = arg_22_0:getAssistRewardCount()

	return var_22_1 and var_22_1 > 0
end

function var_0_0.getMaxAssistRewardCount(arg_23_0)
	return CommonConfig.instance:getConstNum(ConstEnum.AssistRewardMaxNum) or 0
end

function var_0_0.getHasReceiveAssistBonus(arg_24_0)
	return arg_24_0._hasReceiveAssistBonus or 0
end

function var_0_0.isGetAssistRewardReachingLimit(arg_25_0)
	return arg_25_0:getMaxAssistRewardCount() <= arg_25_0:getHasReceiveAssistBonus()
end

function var_0_0.updateSimpleProperties(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		arg_26_0:updateSimpleProperty(iter_26_1)
	end
end

local var_0_1 = {
	[PlayerEnum.SimpleProperty.SkinState] = KeyValueSimplePropertyMO,
	[PlayerEnum.SimpleProperty.MainSceneSkinRedDot] = KeyValueSimplePropertyMO
}

function var_0_0._getSimplePropMo(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._simpleProperties[arg_27_1]

	if not var_27_0 then
		var_27_0 = (var_0_1[arg_27_1] or SimplePropertyMO).New()
		arg_27_0._simpleProperties[arg_27_1] = var_27_0
	end

	return var_27_0
end

function var_0_0.updateSimpleProperty(arg_28_0, arg_28_1)
	arg_28_0._simpleProperties = arg_28_0._simpleProperties or {}

	arg_28_0:_getSimplePropMo(arg_28_1.id):init(arg_28_1)
end

function var_0_0.forceSetSimpleProperty(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0._simpleProperties[arg_29_1]

	if var_29_0 then
		var_29_0.property = arg_29_2
	end
end

function var_0_0.getSimpleProperty(arg_30_0, arg_30_1)
	if arg_30_0._simpleProperties then
		local var_30_0 = arg_30_0._simpleProperties[arg_30_1]

		return var_30_0 and var_30_0.property
	end

	return nil
end

function var_0_0.getPropKeyValue(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	return arg_31_0:_getSimplePropMo(arg_31_1):getValue(arg_31_2, arg_31_3)
end

function var_0_0.setPropKeyValue(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	arg_32_0:_getSimplePropMo(arg_32_1):setValue(arg_32_2, arg_32_3)
end

function var_0_0.getPropKeyValueString(arg_33_0, arg_33_1)
	return arg_33_0:_getSimplePropMo(arg_33_1):getString()
end

function var_0_0.getMyUserId(arg_34_0)
	return arg_34_0._userId
end

function var_0_0.isPlayerSelf(arg_35_0, arg_35_1)
	local var_35_0 = true
	local var_35_1 = arg_35_0:getMyUserId()

	if var_35_1 and arg_35_1 then
		var_35_0 = arg_35_1 == var_35_1
	end

	return var_35_0
end

function var_0_0.logout(arg_36_0)
	return
end

function var_0_0.showWaterMark(arg_37_0)
	ViewMgr.instance:openView(ViewName.WaterMarkView, {
		userId = arg_37_0._userId
	})
end

function var_0_0.changeWaterMarkStatus(arg_38_0, arg_38_1)
	if not arg_38_0.waterMarkView then
		arg_38_0:showWaterMark()
	end

	if arg_38_1 then
		arg_38_0.waterMarkView:showWaterMark()
	else
		arg_38_0.waterMarkView:hideWaterMark()
	end
end

function var_0_0.getPreFeedBackTime(arg_39_0)
	return arg_39_0._preCommitFeedBackTime
end

function var_0_0.setPreFeedBackTime(arg_40_0)
	arg_40_0._preCommitFeedBackTime = Time.time
end

function var_0_0.setMainThumbnail(arg_41_0, arg_41_1)
	arg_41_0._mainThumbnail = arg_41_1
end

function var_0_0.getMainThumbnail(arg_42_0)
	return arg_42_0._mainThumbnail
end

local var_0_2 = 18000

function var_0_0.setCanRename(arg_43_0, arg_43_1)
	arg_43_0._canRename = arg_43_1 == true

	local var_43_0 = os.date("*t", ServerTime.nowInLocal() - var_0_2)

	if var_43_0 then
		arg_43_0._canRenameFlagMonth = var_43_0.month
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.RenameFlagUpdate)
end

function var_0_0.setExtraRename(arg_44_0, arg_44_1)
	arg_44_0.extraRenameCount = arg_44_1
end

function var_0_0.getExtraRename(arg_45_0)
	return arg_45_0.extraRenameCount or 0
end

function var_0_0.checkCanRenameReset(arg_46_0)
	local var_46_0 = os.date("*t", ServerTime.nowInLocal() - var_0_2)

	if var_46_0 and arg_46_0._canRenameFlagMonth ~= nil and arg_46_0._canRenameFlagMonth ~= var_46_0.month then
		logNormal("CanRenameFlag Reset")
		arg_46_0:setCanRename(true)
	end
end

function var_0_0.getCanRename(arg_47_0)
	return arg_47_0._canRename
end

function var_0_0.getShowAchievement(arg_48_0)
	return arg_48_0._showAchievement
end

function var_0_0.getPlayerPrefsKey(arg_49_0, arg_49_1)
	return arg_49_1 .. arg_49_0._userId
end

function var_0_0.getPlayerRegisterTime(arg_50_0)
	return arg_50_0._registerTime
end

var_0_0.instance = var_0_0.New()

return var_0_0
