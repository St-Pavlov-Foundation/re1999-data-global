module("modules.logic.playercard.controller.PlayerCardController", package.seeall)

slot0 = class("PlayerCardController", BaseController)

function slot0.reInit(slot0)
	slot0.viewParam = nil
end

function slot0.openPlayerCardView(slot0, slot1)
	slot0.viewParam = slot1 or {}
	slot2 = slot1 and slot1.userId or PlayerModel.instance:getMyUserId()
	slot0.viewParam.userId = slot2

	if PlayerModel.instance:isPlayerSelf(slot2) then
		PlayerCardRpc.instance:sendGetPlayerCardInfoRequest(slot0._openPlayerCardView, slot0)
	else
		PlayerCardRpc.instance:sendGetOtherPlayerCardInfoRequest(slot2, slot0._openPlayerCardView, slot0)
	end
end

function slot0._openPlayerCardView(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.NewPlayerCardContentView, slot0.viewParam)
end

function slot0.playChangeEffectAudio(slot0)
	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
end

function slot0.saveAchievement(slot0)
	slot1, slot2 = PlayerCardAchievementSelectListModel.instance:getSaveRequestParam()

	PlayerCardRpc.instance:sendSetPlayerCardShowAchievementRequest(slot1, slot2)
end

function slot0.statStart(slot0)
	if not PlayerCardModel.instance:getCardInfo():isSelf() then
		return
	end

	slot0.startTime = ServerTime.now()
end

function slot0.statEnd(slot0)
	if not PlayerCardModel.instance:getCardInfo():isSelf() then
		return
	end

	slot3, slot4, slot5, slot6 = slot0:getStatHeroCover(slot1.heroCover)
	slot7, slot8, slot9 = slot0:getStatAchievement()
	slot12, slot13 = slot0:getStatCritter()

	StatController.instance:track(StatEnum.EventName.ExitPlayerCard, {
		[StatEnum.EventProperties.Time] = slot0:getUseTime(),
		[StatEnum.EventProperties.HeroId] = slot3,
		[StatEnum.EventProperties.skinId] = slot4,
		[StatEnum.EventProperties.HeroName] = slot5,
		[StatEnum.EventProperties.skinName] = slot6,
		[StatEnum.EventProperties.DisplaySingleAchievementName] = slot7,
		[StatEnum.EventProperties.DisplayGroupAchievementName] = slot8,
		[StatEnum.EventProperties.MedalNum] = slot9,
		[StatEnum.EventProperties.GameProgress] = slot0:getStatProgress(),
		[StatEnum.EventProperties.BaseInfomation] = slot0:getStatBaseInfo(),
		[StatEnum.EventProperties.CritterId] = slot12,
		[StatEnum.EventProperties.CritterName] = slot13,
		[StatEnum.EventProperties.PlayerCardSkinName] = slot0:getSkinName(),
		[StatEnum.EventProperties.HeadName] = slot0:getHeadName()
	})
end

function slot0.statSetHeroCover(slot0, slot1)
	slot2, slot3, slot4, slot5 = slot0:getStatHeroCover(slot1)

	StatController.instance:track(StatEnum.EventName.PlaycardSetHeroCover, {
		[StatEnum.EventProperties.HeroId] = slot2,
		[StatEnum.EventProperties.skinId] = slot3,
		[StatEnum.EventProperties.HeroName] = slot4,
		[StatEnum.EventProperties.skinName] = slot5
	})
end

function slot0.getStatHeroCover(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")
	slot4 = slot2[2]
	slot5 = ""
	slot6 = ""

	if not string.nilorempty(slot2[1]) then
		slot5 = HeroConfig.instance:getHeroCO(slot3).name
	end

	if not string.nilorempty(slot4) then
		slot6 = SkinConfig.instance:getSkinCo(slot4).name
	end

	return slot3, slot4, slot5, slot6
end

function slot0.statSetAchievement(slot0)
	slot1, slot2, slot3 = slot0:getStatAchievement()

	StatController.instance:track(StatEnum.EventName.PlaycardDisplayMedal, {
		[StatEnum.EventProperties.DisplaySingleAchievementName] = slot1,
		[StatEnum.EventProperties.DisplayGroupAchievementName] = slot2,
		[StatEnum.EventProperties.MedalNum] = slot3
	})
end

function slot0.getStatAchievement(slot0)
	if not PlayerCardModel.instance:getShowAchievement() or string.nilorempty(slot1) then
		return nil, , 
	end

	slot2, slot3 = AchievementUtils.decodeShowStr(slot1)

	return slot0:getAchievementNameListByTaskId(slot2), slot0:getGroupNameListByTaskId(slot3), PlayerCardModel.instance:getCardInfo().achievementCount
end

function slot0.statSetProgress(slot0)
	StatController.instance:track(StatEnum.EventName.PlaycardSetGameProgress, {
		[StatEnum.EventProperties.GameProgress] = slot0:getStatProgress()
	})
end

function slot0.getStatProgress(slot0)
	slot1 = {}

	if PlayerCardModel.instance:getCardInfo():getProgressSetting() and #slot3 > 0 then
		for slot7, slot8 in ipairs(slot3) do
			slot9 = slot8[2]

			table.insert(slot1, PlayerCardConfig.instance:getCardProgressById(slot9).name)
			table.insert(slot1, slot2:getProgressByIndex(slot9))
		end
	end

	return slot1
end

function slot0.getStatBaseInfo(slot0)
	slot1 = {}
	slot2 = PlayerCardModel.instance:getCardInfo()

	table.insert(slot1, PlayerCardConfig.instance:getCardBaseInfoById(1).name)
	table.insert(slot1, slot2:getBaseInfoByIndex(1))

	if slot2:getBaseInfoSetting() and #slot6 > 0 then
		for slot10, slot11 in ipairs(slot6) do
			slot12 = slot11[2]

			table.insert(slot1, PlayerCardConfig.instance:getCardBaseInfoById(slot12).name)
			table.insert(slot1, slot2:getBaseInfoByIndex(slot12))
		end
	end

	return slot1
end

function slot0.statSetBaseInfo(slot0)
	StatController.instance:track(StatEnum.EventName.PlaycardSetBasicInfomation, {
		[StatEnum.EventProperties.BaseInfomation] = slot0:getStatBaseInfo()
	})
end

function slot0.statSetCritter(slot0)
	slot1, slot2 = slot0:getStatCritter()

	StatController.instance:track(StatEnum.EventName.PlaycardSetCritter, {
		[StatEnum.EventProperties.CritterId] = slot1,
		[StatEnum.EventProperties.CritterName] = slot2
	})
end

function slot0.getStatCritter(slot0)
	slot2 = ""
	slot3 = nil

	if PlayerCardModel.instance:getCritterOpen() then
		slot5, slot6 = PlayerCardModel.instance:getCardInfo():getCritter()

		if not string.nilorempty(slot5) then
			slot3 = CritterConfig.instance:getCritterName(slot5)
		end
	end

	return slot2, slot3
end

function slot0.getAchievementNameListByTaskId(slot0, slot1)
	slot2 = {}
	slot3 = {}

	if slot1 and #slot1 > 0 then
		for slot7, slot8 in ipairs(slot1) do
			if AchievementConfig.instance:getTask(slot8) and not slot3[slot9.achievementId] then
				table.insert(slot2, AchievementConfig.instance:getAchievement(slot9.achievementId) and slot10.name or "")

				slot3[slot9.achievementId] = true
			end
		end
	end

	return slot2
end

function slot0.getUseTime(slot0)
	slot1 = 0

	if slot0.startTime then
		slot1 = ServerTime.now() - slot0.startTime
	end

	return slot1
end

function slot0.getGroupNameListByTaskId(slot0, slot1)
	slot2 = {}
	slot3 = {}

	if slot1 and #slot1 > 0 then
		for slot7, slot8 in ipairs(slot1) do
			if AchievementConfig.instance:getTask(slot8) and AchievementConfig.instance:getGroup(AchievementConfig.instance:getAchievement(slot9.achievementId) and slot10.groupId) and not slot3[slot11] then
				table.insert(slot2, slot12 and slot12.name or "")

				slot3[slot11] = true
			end
		end
	end

	return slot2
end

function slot0.getSkinName(slot0)
	if PlayerCardModel.instance:getCardInfo():getThemeId() ~= 0 then
		return ItemConfig.instance:getItemCo(slot2).name
	end

	return "默认"
end

function slot0.getHeadName(slot0)
	return lua_item.configDict[PlayerModel.instance:getPlayinfo().portrait].name
end

slot0.instance = slot0.New()

return slot0
