module("modules.logic.versionactivity2_3.act174.model.Activity174Model", package.seeall)

slot0 = class("Activity174Model", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.actInfoDic = {}
	slot0.turnShowUnlockTeamTipDict = nil
end

function slot0.getCurActId(slot0)
	return slot0.curActId
end

function slot0.getActInfo(slot0, slot1)
	if not slot0.actInfoDic[slot1 or slot0:getCurActId()] then
		logError("actInfo not exist" .. slot1)
	end

	return slot3
end

function slot0.setActInfo(slot0, slot1, slot2)
	if not slot0.actInfoDic[slot1] then
		slot0.actInfoDic[slot1] = Act174MO.New()
	end

	slot0.actInfoDic[slot1]:initBadgeInfo(slot1)
	slot0.actInfoDic[slot1]:init(slot2)

	slot0.curActId = slot1
end

function slot0.updateGameInfo(slot0, slot1, slot2, slot3)
	slot0:getActInfo(slot1):updateGameInfo(slot2, slot3)
	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateGameInfo)
end

function slot0.updateShopInfo(slot0, slot1, slot2, slot3)
	slot4 = slot0:getActInfo(slot1)

	slot4:updateShopInfo(slot2)

	slot4.gameInfo.coin = slot3
end

function slot0.updateTeamInfo(slot0, slot1, slot2)
	slot0:getActInfo(slot1):updateTeamInfo(slot2)
end

function slot0.updateIsBet(slot0, slot1, slot2)
	slot0:getActInfo(slot1):updateIsBet(slot2)
end

function slot0.endGameReply(slot0, slot1, slot2)
	slot3 = slot0:getActInfo(slot1)
	slot3.gameInfo.state = Activity174Enum.GameState.None

	slot3:setEndInfo(slot2)
	Activity174Controller.instance:dispatchEvent(Activity174Event.EndGame)
end

function slot0.triggerEffectPush(slot0, slot1, slot2, slot3)
	slot0:getActInfo(slot1):triggerEffectPush(slot2, slot3)
end

function slot0.initUnlockNewTeamTipCache(slot0)
	if slot0.turnShowUnlockTeamTipDict then
		return
	end

	if not string.nilorempty(GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, "")) then
		slot0.turnShowUnlockTeamTipDict = cjson.decode(slot1)
	end

	slot0.turnShowUnlockTeamTipDict = slot0.turnShowUnlockTeamTipDict or {}
end

function slot0.clearUnlockNewTeamTipCache(slot0)
	slot0.turnShowUnlockTeamTipDict = nil

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, "")
end

function slot0.setHasShowUnlockNewTeamTip(slot0, slot1)
	slot0:initUnlockNewTeamTipCache()

	slot0.turnShowUnlockTeamTipDict[tostring(slot1)] = true

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, cjson.encode(slot0.turnShowUnlockTeamTipDict) or "")
end

function slot0.getIsShowUnlockNewTeamTip(slot0, slot1)
	slot2 = false

	if Activity174Config.instance:isUnlockNewTeamTurn(slot1) then
		slot0:initUnlockNewTeamTipCache()

		slot2 = not slot0.turnShowUnlockTeamTipDict[tostring(slot1)]
	end

	return slot2
end

function slot0.geAttackStatisticsByServerData(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		if slot2[slot8.heroUid] then
			slot10 = {
				heroUid = slot8.heroUid,
				harm = slot8.harm,
				hurt = slot8.hurt,
				heal = slot8.heal
			}

			for slot15, slot16 in ipairs(slot8.cards) do
				-- Nothing
			end

			slot10.cards = {
				[slot15] = {
					skillId = slot16.skillId,
					useCount = slot16.useCount
				}
			}
			slot10.getBuffs = slot8.getBuffs
			slot10.entityMO = Activity174Helper.getEmptyFightEntityMO(slot10.heroUid, Activity174Config.instance:getRoleCoByHeroId(slot9))
			slot3[slot7] = slot10
		end
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
