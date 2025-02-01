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

function slot0.getCardInfo(slot0, slot1)
	return slot0:getById(slot1 or PlayerModel.instance:getMyUserId())
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

slot0.instance = slot0.New()

return slot0
