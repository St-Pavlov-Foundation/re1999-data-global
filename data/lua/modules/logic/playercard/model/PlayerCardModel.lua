module("modules.logic.playercard.model.PlayerCardModel", package.seeall)

slot0 = class("PlayerCardModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.characterSwitchFlag = nil
end

function slot0.updateCardInfo(slot0, slot1, slot2)
	if not (slot2 and slot2.userId or PlayerModel.instance:getMyUserId()) then
		return
	end

	if not slot0:getById(slot3) then
		slot4 = PlayerCardMO.New()

		slot4:init(slot3)
		slot0:addAtLast(slot4)
	end

	slot4:updateInfo(slot1, slot2)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, slot3)
end

function slot0.updateSetting(slot0, slot1)
	if slot0:getCardInfo() then
		slot2:updateShowSetting(slot1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, slot2.userId)
	end
end

function slot0.updateProgressSetting(slot0, slot1)
	if slot0:getCardInfo() then
		slot2:updateProgressSetting(slot1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, slot2.userId)
	end
end

function slot0.updateBaseInfoSetting(slot0, slot1)
	if slot0:getCardInfo() then
		slot2:updateBaseInfoSetting(slot1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, slot2.userId)
	end
end

function slot0.updateHeroCover(slot0, slot1)
	if slot0:getCardInfo() then
		slot2:updateHeroCover(slot1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, slot2.userId)
	end
end

function slot0.updateThemeId(slot0, slot1)
	if slot0:getCardInfo() then
		slot2:updateThemeId(slot1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, slot2.userId)
	end
end

function slot0.updateCritter(slot0, slot1, slot2)
	if slot0:getCardInfo() then
		slot3:updateCritter(slot1, slot2)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, slot3.userId)
	end
end

function slot0.updateAchievement(slot0, slot1)
	if slot0:getCardInfo() then
		slot2:updateAchievement(slot1)
		PlayerCardController.instance:dispatchEvent(PlayerCardEvent.UpdateCardInfo, slot2.userId)
	end
end

function slot0.getCardInfo(slot0, slot1)
	return slot0:getById(slot1 or PlayerModel.instance:getMyUserId())
end

function slot0.getShowAchievement(slot0)
	if slot0:getCardInfo() then
		return slot1:getShowAchievement()
	end
end

function slot0.themeIsUnlock(slot0, slot1)
	return true
end

function slot0.isCharacterSwitchFlag(slot0)
	return slot0.characterSwitchFlag
end

function slot0.setCharacterSwitchFlag(slot0, slot1)
	slot0.characterSwitchFlag = slot1
end

function slot0.setSelectCritterUid(slot0, slot1)
	if slot0:getCardInfo() then
		return slot2:setSelectCritterUid(slot1)
	end
end

function slot0.getSelectCritterUid(slot0)
	if slot0:getCardInfo() then
		return slot1:getSelectCritterUid()
	end
end

function slot0.getPlayerCardSkinId(slot0)
	if slot0:getCardInfo() then
		return slot1:getThemeId()
	end
end

function slot0.setSelectSkinMO(slot0, slot1)
	slot0.selectSkinMO = slot1
end

function slot0.getSelectSkinMO(slot0)
	return slot0.selectSkinMO or nil
end

function slot0.setIsOpenSkinView(slot0, slot1)
	slot0.isopenskin = slot1
end

function slot0.getIsOpenSkinView(slot0)
	return slot0.isopenskin
end

function slot0.setSelectHero(slot0, slot1, slot2)
	slot0.selectHeroId = slot1
	slot0.selectSkinId = slot2
end

function slot0.getSelectHero(slot0)
	return slot0.selectHeroId, slot0.selectSkinId
end

function slot0.checkHeroDiff(slot0)
	slot1, slot2, slot3, slot4 = slot0:getCardInfo():getMainHero()

	if slot1 ~= slot0.selectHeroId or slot2 ~= slot0.selectSkinId then
		return false
	end

	return true
end

function slot0.getCritterOpen(slot0)
	return CritterModel.instance:isCritterUnlock(false) and #CritterModel.instance:getAllCritters() > 0
end

slot0.instance = slot0.New()

return slot0
