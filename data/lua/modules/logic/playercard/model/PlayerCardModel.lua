-- chunkname: @modules/logic/playercard/model/PlayerCardModel.lua

module("modules.logic.playercard.model.PlayerCardModel", package.seeall)

local PlayerCardModel = class("PlayerCardModel", BaseModel)

function PlayerCardModel:onInit()
	self:reInit()
end

function PlayerCardModel:reInit()
	self.characterSwitchFlag = nil
end

function PlayerCardModel:updateCardInfo(cardInfo, playerInfo)
	local userId = playerInfo and playerInfo.userId or PlayerModel.instance:getMyUserId()

	if not userId then
		return
	end

	local mo = self:getById(userId)

	if not mo then
		mo = PlayerCardMO.New()

		mo:init(userId)
		self:addAtLast(mo)
	end

	mo:updateInfo(cardInfo, playerInfo)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, userId)
	self:setShowRed()
end

function PlayerCardModel:setShowRed()
	self._showRed = false

	local list = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.PlayerBg)

	for _, co in ipairs(list) do
		local id = co.id
		local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.PlayerCardNewBgSkinRed) .. id
		local value = PlayerPrefsHelper.getNumber(key, 0)

		if value == 1 then
			self._showRed = true

			break
		end
	end
end

function PlayerCardModel:getShowRed()
	return self._showRed
end

function PlayerCardModel:updateSetting(showSettings)
	local mo = self:getCardInfo()

	if mo then
		mo:updateShowSetting(showSettings)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateProgressSetting(showSettings)
	local mo = self:getCardInfo()

	if mo then
		mo:updateProgressSetting(showSettings)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateBaseInfoSetting(showSettings)
	local mo = self:getCardInfo()

	if mo then
		mo:updateBaseInfoSetting(showSettings)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateHeroCover(heroCover)
	local mo = self:getCardInfo()

	if mo then
		mo:updateHeroCover(heroCover)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateThemeId(themeId)
	local mo = self:getCardInfo()

	if mo then
		mo:updateThemeId(themeId)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateCritter(critterId, skinId)
	local mo = self:getCardInfo()

	if mo then
		mo:updateCritter(critterId, skinId)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:updateAchievement(showAchievement)
	local mo = self:getCardInfo()

	if mo then
		mo:updateAchievement(showAchievement)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, mo.userId)
	end
end

function PlayerCardModel:getCardInfo(userId)
	userId = userId or PlayerModel.instance:getMyUserId()

	return self:getById(userId)
end

function PlayerCardModel:getShowAchievement()
	local mo = self:getCardInfo()

	if mo then
		return mo:getShowAchievement()
	end
end

function PlayerCardModel:themeIsUnlock(themeId)
	return true
end

function PlayerCardModel:isCharacterSwitchFlag()
	return self.characterSwitchFlag
end

function PlayerCardModel:setCharacterSwitchFlag(value)
	self.characterSwitchFlag = value
end

function PlayerCardModel:setSelectCritterUid(critterUid)
	local mo = self:getCardInfo()

	if mo then
		return mo:setSelectCritterUid(critterUid)
	end
end

function PlayerCardModel:getSelectCritterUid()
	local mo = self:getCardInfo()

	if mo then
		return mo:getSelectCritterUid()
	end
end

function PlayerCardModel:getPlayerCardSkinId()
	local mo = self:getCardInfo()

	if mo then
		return mo:getThemeId()
	end
end

function PlayerCardModel:setSelectSkinMO(skinMO)
	self.selectSkinMO = skinMO
end

function PlayerCardModel:getSelectSkinMO()
	return self.selectSkinMO or nil
end

function PlayerCardModel:setIsOpenSkinView(state)
	self.isopenskin = state
end

function PlayerCardModel:getIsOpenSkinView()
	return self.isopenskin
end

function PlayerCardModel:setSelectHero(heroId, skinId)
	self.selectHeroId = heroId
	self.selectSkinId = skinId
end

function PlayerCardModel:getSelectHero()
	return self.selectHeroId, self.selectSkinId
end

function PlayerCardModel:checkHeroDiff()
	local heroId, skinId, _, isL2d = self:getCardInfo():getMainHero()

	if heroId ~= self.selectHeroId or skinId ~= self.selectSkinId then
		return false
	end

	return true
end

function PlayerCardModel:getCritterOpen()
	local isCritterUnlock = CritterModel.instance:isCritterUnlock(false)
	local allCritterList = CritterModel.instance:getAllCritters()
	local isCritterOpen = isCritterUnlock and #allCritterList > 0

	return isCritterOpen
end

PlayerCardModel.instance = PlayerCardModel.New()

return PlayerCardModel
