module("modules.logic.player.model.PlayerModel", package.seeall)

slot0 = class("PlayerModel", BaseModel)

function slot0.onInit(slot0)
	slot0._userId = 0
	slot0._name = ""
	slot0._portrait = 0
	slot0._level = 0
	slot0._exp = 0
	slot0._signature = ""
	slot0._birthday = ""
	slot0._showHeros = {}
	slot0._registerTime = 0
	slot0._lastLoginTime = 0
	slot0._lastLogoutTime = 0
	slot0._heroRareNNCount = 0
	slot0._heroRareNCount = 0
	slot0._heroRareRCount = 0
	slot0._heroRareSRCount = 0
	slot0._heroRareSSRCount = 0
	slot0._lastEpisodeId = 0
	slot0._levelup = 0
	slot0._preCommitFeedBackTime = -1
	slot0._bg = 0
	slot0._canRename = false
	slot0._canRenameFlagMonth = nil
	slot0._playerInfo = nil
	slot0._showAchievement = nil
	slot0._totalLoginDays = 0

	slot0:updateAssistRewardCountData(0, 0, true)
end

function slot0.reInit(slot0)
	slot0._simpleProperties = {}
	slot0._playerInfo = nil

	slot0:updateAssistRewardCountData(0, 0, true)
end

function slot0.setPlayerinfo(slot0, slot1)
	slot3 = slot0._lastEpisodeId
	slot0._userId = slot1.userId
	slot0._name = slot1.name
	slot0._portrait = slot1.portrait
	slot0._level = slot1.level
	slot0._exp = slot1.exp
	slot0._signature = slot1.signature
	slot0._birthday = slot1.birthday
	slot0._registerTime = slot1.registerTime
	slot0._lastLoginTime = slot1.lastLoginTime
	slot0._lastLogoutTime = slot1.lastLogoutTime
	slot0._heroRareNNCount = slot1.heroRareNNCount
	slot0._heroRareNCount = slot1.heroRareNCount
	slot0._heroRareRCount = slot1.heroRareRCount
	slot0._heroRareSRCount = slot1.heroRareSRCount
	slot0._heroRareSSRCount = slot1.heroRareSSRCount
	slot0._lastEpisodeId = slot1.lastEpisodeId
	slot0._showAchievement = slot1.showAchievement
	slot0._bg = slot1.bg
	slot0._totalLoginDays = slot1.totalLoginDays

	slot0:_checkHeroinfo(slot1.showHeros)
	PlayerController.instance:dispatchEvent(PlayerEvent.ChangePlayerinfo, slot1)

	if slot0._level < slot0._level and slot2 ~= 0 then
		SDKMgr.instance:upgradeRole(StatModel.instance:generateRoleInfo())
		PlayerController.instance:dispatchEvent(PlayerEvent.PlayerLevelUp, slot2, slot0._level)

		slot0._levelup = slot0._level - slot2
	end

	if slot3 ~= 0 and slot0._lastEpisodeId ~= slot3 then
		SDKMgr.instance:updateRole(StatModel.instance:generateRoleInfo())
	end

	if OpenConfig.instance:isShowWaterMarkConfig() then
		slot0:showWaterMark()
	end

	ActivityEnterMgr.instance:init()
end

function slot0.getAndResetPlayerLevelUp(slot0)
	slot0._levelup = 0

	return slot0._levelup
end

function slot0._checkHeroinfo(slot0, slot1)
	slot0._showHeros = {}

	for slot5 = 1, #slot1 do
		if slot1[slot5].heroId == 0 then
			slot1[slot5] = 0
		end

		table.insert(slot0._showHeros, slot1[slot5])
	end

	for slot5 = 1, 3 do
		if slot5 > #slot0._showHeros then
			slot0._showHeros[slot5] = 0
		end
	end
end

function slot0.getPlayinfo(slot0)
	slot0._playerInfo = slot0._playerInfo or {}
	slot1 = slot0._playerInfo
	slot1.userId = slot0._userId
	slot1.name = slot0._name
	slot1.portrait = slot0._portrait
	slot1.level = slot0._level
	slot1.exp = slot0._exp
	slot1.signature = slot0._signature
	slot1.birthday = slot0._birthday
	slot1.showHeros = slot0._showHeros
	slot1.registerTime = slot0._registerTime
	slot1.lastLoginTime = slot0._lastLoginTime
	slot1.lastLogoutTime = slot0._lastLogoutTime
	slot1.heroRareNNCount = slot0._heroRareNNCount
	slot1.heroRareNCount = slot0._heroRareNCount
	slot1.heroRareRCount = slot0._heroRareRCount
	slot1.heroRareSRCount = slot0._heroRareSRCount
	slot1.heroRareSSRCount = slot0._heroRareSSRCount
	slot1.lastEpisodeId = slot0._lastEpisodeId
	slot1.showAchievement = slot0._showAchievement
	slot1.bg = slot0._bg
	slot1.totalLoginDays = slot0._totalLoginDays

	return slot0._playerInfo
end

function slot0.getExpNowAndMax(slot0)
	slot1 = slot0._exp
	slot2 = 0

	if slot0._level < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		slot2 = PlayerConfig.instance:getPlayerLevelCO(slot0._level + 1).exp
	else
		slot1 = PlayerConfig.instance:getPlayerLevelCO(slot0._level).exp
	end

	return {
		slot1,
		slot2
	}
end

function slot0.getPlayerLevel(slot0)
	return slot0._level
end

function slot0.setPlayerName(slot0, slot1)
	slot0._name = slot1

	slot0:_changePlayerbassinfo()
	PlayerController.instance:dispatchEvent(PlayerEvent.ChangePlayerName)
end

function slot0.setPlayerSignature(slot0, slot1)
	slot0._signature = slot1

	slot0:_changePlayerbassinfo()
end

function slot0.setPlayerBirthday(slot0, slot1)
	slot0._birthday = slot1

	slot0:_changePlayerbassinfo()
end

function slot0.getPlayerBirthday(slot0)
	return slot0._birthday or ""
end

function slot0.setPlayerPortrait(slot0, slot1)
	PlayerController.instance:dispatchEvent(PlayerEvent.SetPortrait, slot1)

	slot0._portrait = slot1

	slot0:_changePlayerbassinfo()
end

function slot0.setShowHeroUniqueIds(slot0)
	PlayerController.instance:dispatchEvent(PlayerEvent.SetShowHero, slot0._showHeros)
end

function slot0._changePlayerbassinfo(slot0)
	PlayerController.instance:dispatchEvent(PlayerEvent.PlayerbassinfoChange, slot0:getPlayinfo())
end

function slot0.getShowHeros(slot0)
	return slot0._showHeros
end

function slot0.getShowHeroUid(slot0)
	slot1 = {}

	for slot5 = 1, #slot0._showHeros do
		if slot0._showHeros[slot5] ~= 0 then
			table.insert(slot1, HeroModel.instance:getByHeroId(slot0._showHeros[slot5].heroId).uid)
		else
			table.insert(slot1, 0)
		end
	end

	return slot1
end

function slot0.setShowHero(slot0, slot1, slot2)
	if slot2 ~= 0 then
		slot0._showHeros[slot1] = slot0:_setSimpleinfo(slot2)
	else
		slot0._showHeros[slot1] = 0
	end
end

function slot0._setSimpleinfo(slot0, slot1)
	slot2 = HeroModel.instance:getByHeroId(slot1)

	return {
		uid = slot2.uid,
		heroId = slot2.heroId,
		level = slot2.level,
		rank = slot2.rank,
		exSkillLevel = slot2.exSkillLevel,
		skin = slot2.skin
	}
end

function slot0.updateAssistRewardCountData(slot0, slot1, slot2, slot3)
	slot0._assistRewardCount = slot1 or 0
	slot0._hasReceiveAssistBonus = slot2 or 0

	if slot3 then
		return
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.UpdateAssistRewardCount)
end

function slot0.getAssistRewardCount(slot0)
	return slot0._assistRewardCount or 0
end

function slot0.isHasAssistReward(slot0)
	if slot0:isGetAssistRewardReachingLimit() then
		return false
	end

	return slot0:getAssistRewardCount() and slot3 > 0
end

function slot0.getMaxAssistRewardCount(slot0)
	return CommonConfig.instance:getConstNum(ConstEnum.AssistRewardMaxNum) or 0
end

function slot0.getHasReceiveAssistBonus(slot0)
	return slot0._hasReceiveAssistBonus or 0
end

function slot0.isGetAssistRewardReachingLimit(slot0)
	return slot0:getMaxAssistRewardCount() <= slot0:getHasReceiveAssistBonus()
end

function slot0.updateSimpleProperties(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:updateSimpleProperty(slot6)
	end
end

slot1 = {
	[PlayerEnum.SimpleProperty.SkinState] = KeyValueSimplePropertyMO
}

function slot0._getSimplePropMo(slot0, slot1)
	if not slot0._simpleProperties[slot1] then
		slot0._simpleProperties[slot1] = (uv0[slot1] or SimplePropertyMO).New()
	end

	return slot2
end

function slot0.updateSimpleProperty(slot0, slot1)
	slot0._simpleProperties = slot0._simpleProperties or {}

	slot0:_getSimplePropMo(slot1.id):init(slot1)
end

function slot0.forceSetSimpleProperty(slot0, slot1, slot2)
	if slot0._simpleProperties[slot1] then
		slot3.property = slot2
	end
end

function slot0.getSimpleProperty(slot0, slot1)
	if slot0._simpleProperties then
		return slot0._simpleProperties[slot1] and slot2.property
	end

	return nil
end

function slot0.getPropKeyValue(slot0, slot1, slot2, slot3)
	return slot0:_getSimplePropMo(slot1):getValue(slot2, slot3)
end

function slot0.setPropKeyValue(slot0, slot1, slot2, slot3)
	slot0:_getSimplePropMo(slot1):setValue(slot2, slot3)
end

function slot0.getPropKeyValueString(slot0, slot1)
	return slot0:_getSimplePropMo(slot1):getString()
end

function slot0.getMyUserId(slot0)
	return slot0._userId
end

function slot0.isPlayerSelf(slot0, slot1)
	slot2 = true

	if slot0:getMyUserId() and slot1 then
		slot2 = slot1 == slot3
	end

	return slot2
end

function slot0.logout(slot0)
end

function slot0.showWaterMark(slot0)
	ViewMgr.instance:openView(ViewName.WaterMarkView, {
		userId = slot0._userId
	})
end

function slot0.changeWaterMarkStatus(slot0, slot1)
	if not slot0.waterMarkView then
		slot0:showWaterMark()
	end

	if slot1 then
		slot0.waterMarkView:showWaterMark()
	else
		slot0.waterMarkView:hideWaterMark()
	end
end

function slot0.getPreFeedBackTime(slot0)
	return slot0._preCommitFeedBackTime
end

function slot0.setPreFeedBackTime(slot0)
	slot0._preCommitFeedBackTime = Time.time
end

function slot0.setMainThumbnail(slot0, slot1)
	slot0._mainThumbnail = slot1
end

function slot0.getMainThumbnail(slot0)
	return slot0._mainThumbnail
end

slot2 = 18000

function slot0.setCanRename(slot0, slot1)
	slot0._canRename = slot1 == true

	if os.date("*t", ServerTime.nowInLocal() - uv0) then
		slot0._canRenameFlagMonth = slot2.month
	end

	PlayerController.instance:dispatchEvent(PlayerEvent.RenameFlagUpdate)
end

function slot0.setExtraRename(slot0, slot1)
	slot0.extraRenameCount = slot1
end

function slot0.getExtraRename(slot0)
	return slot0.extraRenameCount or 0
end

function slot0.checkCanRenameReset(slot0)
	if os.date("*t", ServerTime.nowInLocal() - uv0) and slot0._canRenameFlagMonth ~= nil and slot0._canRenameFlagMonth ~= slot1.month then
		logNormal("CanRenameFlag Reset")
		slot0:setCanRename(true)
	end
end

function slot0.getCanRename(slot0)
	return slot0._canRename
end

function slot0.getShowAchievement(slot0)
	return slot0._showAchievement
end

function slot0.getPlayerPrefsKey(slot0, slot1)
	return slot1 .. slot0._userId
end

slot0.instance = slot0.New()

return slot0
