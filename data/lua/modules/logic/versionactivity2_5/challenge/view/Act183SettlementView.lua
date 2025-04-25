module("modules.logic.versionactivity2_5.challenge.view.Act183SettlementView", package.seeall)

slot0 = class("Act183SettlementView", BaseView)
slot1 = 2
slot2 = {
	"v2a5_challenge_result_roundbg4",
	"v2a5_challenge_result_roundbg3",
	"v2a5_challenge_result_roundbg2",
	"v2a5_challenge_result_roundbg1"
}

function slot0.onInitView(slot0)
	slot0._gohardbg = gohelper.findChild(slot0.viewGO, "root/mask")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._scrollbadge = gohelper.findChildScrollRect(slot0.viewGO, "root/left/#scroll_badge")
	slot0._goepisodeitem = gohelper.findChild(slot0.viewGO, "root/left/#scroll_badge/Viewport/Content/#go_episodeitem")
	slot0._simageplayericon = gohelper.findChildSingleImage(slot0.viewGO, "root/left/player/icon/#simage_playericon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "root/left/player/#txt_name")
	slot0._txtdate = gohelper.findChildText(slot0.viewGO, "root/left/player/#txt_date")
	slot0._imageroundbg = gohelper.findChildImage(slot0.viewGO, "root/left/totalround/#image_roundbg")
	slot0._txttotalround = gohelper.findChildText(slot0.viewGO, "root/left/totalround/#txt_totalround")
	slot0._txtbossbadge = gohelper.findChildText(slot0.viewGO, "root/right/#txt_bossbadge")
	slot0._gobossheros = gohelper.findChild(slot0.viewGO, "root/right/#go_bossheros")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "root/#go_heroitem")
	slot0._gobuffs = gohelper.findChild(slot0.viewGO, "root/right/buffs/#go_buffs")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "root/right/buffs/#go_buffs/#go_buffitem")
	slot0._simageboss = gohelper.findChildSingleImage(slot0.viewGO, "root/right/#simage_boss")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "root/left/#scroll_badge/Viewport/Content")
	slot0._heroIconTab = slot0:getUserDataTb_()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._activityId = slot0.viewParam and slot0.viewParam.activityId
	slot0._groupRecordMo = slot0.viewParam and slot0.viewParam.groupRecordMo

	slot0:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenSettlementView)
end

function slot0.refresh(slot0)
	slot0:refreshAllSubEpisodeItems()
	slot0:refreshBossEpisodeItem()
	slot0:refreshPlayerInfo()
	slot0:refreshOtherInfo()
end

function slot0.refreshAllSubEpisodeItems(slot0)
	gohelper.CreateObjList(slot0, slot0.refreshSingleSubEpisodeItem, slot0._groupRecordMo:getEpusideListByTypeAndPassOrder(Act183Enum.EpisodeType.Sub) or {}, slot0._gocontent, slot0._goepisodeitem)
end

function slot0.refreshSingleSubEpisodeItem(slot0, slot1, slot2, slot3)
	slot7 = gohelper.findChildText(slot1, "txt_badgenum")
	slot15 = slot2:getRuleStatus(1)
	slot16 = slot2:getRuleStatus(2)
	slot18 = slot2:getUseBadgeNum()

	UISpriteSetMgr.instance:setChallengeSprite(gohelper.findChildImage(slot1, "image_index"), "v2a5_challenge_result_level_" .. slot2:getPassOrder())

	slot7.text = slot18

	gohelper.setActive(slot7.gameObject, slot18 > 0)
	gohelper.setActive(gohelper.findChild(slot1, "mask"), slot18 > 0)

	slot19 = slot2:getEpisodeId()

	Act183Helper.setRuleIcon(slot19, 1, gohelper.findChildImage(slot1, "rules/go_rule1/image_icon"))
	Act183Helper.setRuleIcon(slot19, 2, gohelper.findChildImage(slot1, "rules/go_rule2/image_icon"))
	Act183Helper.setSubEpisodeResultIcon(slot19, gohelper.findChildImage(slot1, "image_episode"))
	gohelper.setActive(gohelper.findChild(slot1, "rules/go_rule1/go_repress"), slot15 == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(gohelper.findChild(slot1, "rules/go_rule2/go_repress"), slot16 == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(gohelper.findChild(slot1, "rules/go_rule1/go_escape"), slot15 == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(gohelper.findChild(slot1, "rules/go_rule2/go_escape"), slot16 == Act183Enum.RuleStatus.Escape)
	UISpriteSetMgr.instance:setChallengeSprite(gohelper.findChildImage(slot1, "image_star"), slot2:isAllConditionPass() and "v2a5_challenge_dungeon_reward_star_01" or "v2a5_challenge_dungeon_reward_star_02")
	slot0:refreshSubEpisodeHeros(slot1, slot2:getHeroMos())
end

function slot0.refreshSubEpisodeHeros(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		if gohelper.isNil(gohelper.findChild(slot1, "heros/row_" .. math.ceil(slot6 / uv0))) then
			gohelper.setActive(gohelper.cloneInPlace(gohelper.findChild(slot1, "heros/go_horizontal"), "row_" .. slot8), true)
		end

		slot10 = gohelper.clone(slot0._goheroitem, slot9, "hero_" .. slot6)

		slot0:refreshSingleHeroItem(slot10, slot7)
		gohelper.setActive(slot10, true)
	end
end

function slot0.refreshBossEpisodeItem(slot0)
	if not (slot0._groupRecordMo:getEpisodeListByType(Act183Enum.EpisodeType.Boss) and slot1[1]) then
		return
	end

	Act183Helper.setBossEpisodeResultIcon(slot2:getEpisodeId(), slot0._simageboss)
	gohelper.setActive(slot0._txtbossbadge.gameObject, slot2:getUseBadgeNum() > 0)

	slot0._txtbossbadge.text = slot4

	gohelper.CreateObjList(slot0, slot0.refreshSingleHeroItem, slot2:getHeroMos() or {}, slot0._gobossheros, slot0._goheroitem)

	slot6, slot7, slot8, slot9 = slot0._groupRecordMo:getBossEpisodeConditionStatus()
	slot0._unlockConditionMap = Act183Helper.listToMap(slot7)
	slot0._passConditionMap = Act183Helper.listToMap(slot8)
	slot0._chooseConditionMap = Act183Helper.listToMap(slot9)

	gohelper.CreateObjList(slot0, slot0.refreshBossEpisodeCondition, slot6 or {}, slot0._gobuffs, slot0._gobuffitem)
end

function slot0.refreshSingleHeroItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildSingleImage(slot1, "simage_heroicon")

	slot4:LoadImage(slot2:getHeroIconUrl())

	slot0._heroIconTab[slot4] = true
end

function slot0.refreshBossEpisodeCondition(slot0, slot1, slot2, slot3)
	slot4 = gohelper.onceAddComponent(slot1, gohelper.Type_Image)
	slot5 = slot0._unlockConditionMap[slot2] ~= nil
	slot7 = "v2a5_challenge_dungeon_reward_star_02"

	if slot0._chooseConditionMap[slot2] ~= nil then
		slot7 = "v2a5_challenge_dungeon_reward_star_01"
	elseif slot5 then
		slot7 = "v2a5_challenge_dungeon_reward_star_03"
	end

	UISpriteSetMgr.instance:setChallengeSprite(slot4, slot7)
end

function slot0.refreshPlayerInfo(slot0)
	slot0._txtname.text = slot0._groupRecordMo:getUserName()
	slot0._portraitId = slot0._groupRecordMo:getPortrait()

	if not slot0._liveHeadIcon then
		slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageplayericon)
	end

	slot0._liveHeadIcon:setLiveHead(slot0._portraitId)

	slot0._txtdate.text = TimeUtil.timestampToString(slot0._groupRecordMo:getFinishedTime() / 1000)
end

function slot0.refreshOtherInfo(slot0)
	slot1 = slot0._groupRecordMo:getAllRound()
	slot0._txttotalround.text = slot1

	if uv0[Act183Helper.getRoundStage(slot1)] then
		UISpriteSetMgr.instance:setChallengeSprite(slot0._imageroundbg, slot3)
	else
		logError(string.format("缺少回合数挡位 --> 回合数背景图配置 allRoundNum = %s, stage = %s", slot1, slot2))
	end

	gohelper.setActive(slot0._gohardbg, slot0._groupRecordMo:getGroupType() == Act183Enum.GroupType.HardMain)
end

function slot0.releaseAllSingleImage(slot0)
	if slot0._heroIconTab then
		for slot4, slot5 in pairs(slot0._heroIconTab) do
			slot4:UnLoadImage()
		end
	end
end

function slot0.onClose(slot0)
	slot0:releaseAllSingleImage()
	slot0._simageplayericon:UnLoadImage()
	slot0._simageboss:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
