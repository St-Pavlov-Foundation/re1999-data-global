module("modules.logic.versionactivity2_5.challenge.view.Act183SettlementView", package.seeall)

local var_0_0 = class("Act183SettlementView", BaseView)
local var_0_1 = 2
local var_0_2 = {
	"v2a5_challenge_result_roundbg4",
	"v2a5_challenge_result_roundbg3",
	"v2a5_challenge_result_roundbg2",
	"v2a5_challenge_result_roundbg1"
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gohardbg = gohelper.findChild(arg_1_0.viewGO, "root/mask")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._scrollbadge = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/left/#scroll_badge")
	arg_1_0._goepisodeitem = gohelper.findChild(arg_1_0.viewGO, "root/left/#scroll_badge/Viewport/Content/#go_episodeitem")
	arg_1_0._simageplayericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/player/icon/#simage_playericon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/left/player/#txt_name")
	arg_1_0._txtdate = gohelper.findChildText(arg_1_0.viewGO, "root/left/player/#txt_date")
	arg_1_0._imageroundbg = gohelper.findChildImage(arg_1_0.viewGO, "root/left/totalround/#image_roundbg")
	arg_1_0._txttotalround = gohelper.findChildText(arg_1_0.viewGO, "root/left/totalround/#txt_totalround")
	arg_1_0._txtbossbadge = gohelper.findChildText(arg_1_0.viewGO, "root/right/#txt_bossbadge")
	arg_1_0._gobossheros = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_bossheros")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_heroitem")
	arg_1_0._gobuffs = gohelper.findChild(arg_1_0.viewGO, "root/right/buffs/#go_buffs")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "root/right/buffs/#go_buffs/#go_buffitem")
	arg_1_0._simageboss = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/#simage_boss")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._gocontent = gohelper.findChild(arg_5_0.viewGO, "root/left/#scroll_badge/Viewport/Content")
	arg_5_0._heroIconTab = arg_5_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._activityId = arg_7_0.viewParam and arg_7_0.viewParam.activityId
	arg_7_0._groupRecordMo = arg_7_0.viewParam and arg_7_0.viewParam.groupRecordMo

	arg_7_0:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenSettlementView)
end

function var_0_0.refresh(arg_8_0)
	arg_8_0:refreshAllSubEpisodeItems()
	arg_8_0:refreshBossEpisodeItem()
	arg_8_0:refreshPlayerInfo()
	arg_8_0:refreshOtherInfo()
end

function var_0_0.refreshAllSubEpisodeItems(arg_9_0)
	local var_9_0 = arg_9_0._groupRecordMo:getEpusideListByTypeAndPassOrder(Act183Enum.EpisodeType.Sub)

	gohelper.CreateObjList(arg_9_0, arg_9_0.refreshSingleSubEpisodeItem, var_9_0 or {}, arg_9_0._gocontent, arg_9_0._goepisodeitem)
end

function var_0_0.refreshSingleSubEpisodeItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = gohelper.findChildImage(arg_10_1, "image_index")
	local var_10_1 = gohelper.findChildImage(arg_10_1, "image_star")
	local var_10_2 = gohelper.findChild(arg_10_1, "mask")
	local var_10_3 = gohelper.findChildText(arg_10_1, "txt_badgenum")
	local var_10_4 = gohelper.findChildImage(arg_10_1, "rules/go_rule1/image_icon")
	local var_10_5 = gohelper.findChild(arg_10_1, "rules/go_rule1/go_repress")
	local var_10_6 = gohelper.findChild(arg_10_1, "rules/go_rule1/go_escape")
	local var_10_7 = gohelper.findChildImage(arg_10_1, "rules/go_rule2/image_icon")
	local var_10_8 = gohelper.findChild(arg_10_1, "rules/go_rule2/go_repress")
	local var_10_9 = gohelper.findChild(arg_10_1, "rules/go_rule2/go_escape")
	local var_10_10 = gohelper.findChildImage(arg_10_1, "image_episode")
	local var_10_11 = arg_10_2:getRuleStatus(1)
	local var_10_12 = arg_10_2:getRuleStatus(2)
	local var_10_13 = arg_10_2:isAllConditionPass()
	local var_10_14 = arg_10_2:getUseBadgeNum()

	UISpriteSetMgr.instance:setChallengeSprite(var_10_0, "v2a5_challenge_result_level_" .. arg_10_2:getPassOrder())

	var_10_3.text = var_10_14

	gohelper.setActive(var_10_3.gameObject, var_10_14 > 0)
	gohelper.setActive(var_10_2, var_10_14 > 0)

	local var_10_15 = arg_10_2:getEpisodeId()

	Act183Helper.setRuleIcon(var_10_15, 1, var_10_4)
	Act183Helper.setRuleIcon(var_10_15, 2, var_10_7)
	Act183Helper.setSubEpisodeResultIcon(var_10_15, var_10_10)
	gohelper.setActive(var_10_5, var_10_11 == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(var_10_8, var_10_12 == Act183Enum.RuleStatus.Repress)
	gohelper.setActive(var_10_6, var_10_11 == Act183Enum.RuleStatus.Escape)
	gohelper.setActive(var_10_9, var_10_12 == Act183Enum.RuleStatus.Escape)

	local var_10_16 = var_10_13 and "v2a5_challenge_dungeon_reward_star_01" or "v2a5_challenge_dungeon_reward_star_02"

	UISpriteSetMgr.instance:setChallengeSprite(var_10_1, var_10_16)
	arg_10_0:refreshSubEpisodeHeros(arg_10_1, arg_10_2:getHeroMos())
end

function var_0_0.refreshSubEpisodeHeros(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
		local var_11_0 = math.ceil(iter_11_0 / var_0_1)
		local var_11_1 = gohelper.findChild(arg_11_1, "heros/row_" .. var_11_0)

		if gohelper.isNil(var_11_1) then
			local var_11_2 = gohelper.findChild(arg_11_1, "heros/go_horizontal")

			var_11_1 = gohelper.cloneInPlace(var_11_2, "row_" .. var_11_0)

			gohelper.setActive(var_11_1, true)
		end

		local var_11_3 = gohelper.clone(arg_11_0._goheroitem, var_11_1, "hero_" .. iter_11_0)

		arg_11_0:refreshSingleHeroItem(var_11_3, iter_11_1)
		gohelper.setActive(var_11_3, true)
	end
end

function var_0_0.refreshBossEpisodeItem(arg_12_0)
	local var_12_0 = arg_12_0._groupRecordMo:getEpisodeListByType(Act183Enum.EpisodeType.Boss)
	local var_12_1 = var_12_0 and var_12_0[1]

	if not var_12_1 then
		return
	end

	local var_12_2 = var_12_1:getEpisodeId()

	Act183Helper.setBossEpisodeResultIcon(var_12_2, arg_12_0._simageboss)

	local var_12_3 = var_12_1:getUseBadgeNum()

	gohelper.setActive(arg_12_0._txtbossbadge.gameObject, var_12_3 > 0)

	arg_12_0._txtbossbadge.text = var_12_3

	local var_12_4 = var_12_1:getHeroMos()

	gohelper.CreateObjList(arg_12_0, arg_12_0.refreshSingleHeroItem, var_12_4 or {}, arg_12_0._gobossheros, arg_12_0._goheroitem)

	local var_12_5, var_12_6, var_12_7, var_12_8 = arg_12_0._groupRecordMo:getBossEpisodeConditionStatus()

	arg_12_0._unlockConditionMap = Act183Helper.listToMap(var_12_6)
	arg_12_0._passConditionMap = Act183Helper.listToMap(var_12_7)
	arg_12_0._chooseConditionMap = Act183Helper.listToMap(var_12_8)

	gohelper.CreateObjList(arg_12_0, arg_12_0.refreshBossEpisodeCondition, var_12_5 or {}, arg_12_0._gobuffs, arg_12_0._gobuffitem)
end

function var_0_0.refreshSingleHeroItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChildSingleImage(arg_13_1, "simage_heroicon")
	local var_13_1 = arg_13_2:getHeroIconUrl()

	var_13_0:LoadImage(var_13_1)

	arg_13_0._heroIconTab[var_13_0] = true
end

function var_0_0.refreshBossEpisodeCondition(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.onceAddComponent(arg_14_1, gohelper.Type_Image)
	local var_14_1 = arg_14_0._unlockConditionMap[arg_14_2] ~= nil
	local var_14_2 = arg_14_0._chooseConditionMap[arg_14_2] ~= nil
	local var_14_3 = "v2a5_challenge_dungeon_reward_star_02"

	if var_14_2 then
		var_14_3 = "v2a5_challenge_dungeon_reward_star_01"
	elseif var_14_1 then
		var_14_3 = "v2a5_challenge_dungeon_reward_star_03"
	end

	UISpriteSetMgr.instance:setChallengeSprite(var_14_0, var_14_3)
end

function var_0_0.refreshPlayerInfo(arg_15_0)
	arg_15_0._txtname.text = arg_15_0._groupRecordMo:getUserName()
	arg_15_0._portraitId = arg_15_0._groupRecordMo:getPortrait()

	if not arg_15_0._liveHeadIcon then
		arg_15_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_15_0._simageplayericon)
	end

	arg_15_0._liveHeadIcon:setLiveHead(arg_15_0._portraitId)

	arg_15_0._txtdate.text = TimeUtil.timestampToString(arg_15_0._groupRecordMo:getFinishedTime() / 1000)
end

function var_0_0.refreshOtherInfo(arg_16_0)
	local var_16_0 = arg_16_0._groupRecordMo:getAllRound()

	arg_16_0._txttotalround.text = var_16_0

	local var_16_1 = Act183Helper.getRoundStage(var_16_0)
	local var_16_2 = var_0_2[var_16_1]

	if var_16_2 then
		UISpriteSetMgr.instance:setChallengeSprite(arg_16_0._imageroundbg, var_16_2)
	else
		logError(string.format("缺少回合数挡位 --> 回合数背景图配置 allRoundNum = %s, stage = %s", var_16_0, var_16_1))
	end

	local var_16_3 = arg_16_0._groupRecordMo:getGroupType()

	gohelper.setActive(arg_16_0._gohardbg, var_16_3 == Act183Enum.GroupType.HardMain)
end

function var_0_0.releaseAllSingleImage(arg_17_0)
	if arg_17_0._heroIconTab then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._heroIconTab) do
			iter_17_0:UnLoadImage()
		end
	end
end

function var_0_0.onClose(arg_18_0)
	arg_18_0:releaseAllSingleImage()
	arg_18_0._simageplayericon:UnLoadImage()
	arg_18_0._simageboss:UnLoadImage()
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
