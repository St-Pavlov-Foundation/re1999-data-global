module("modules.logic.versionactivity2_5.challenge.view.Act183DungeonView_Detail", package.seeall)

slot0 = class("Act183DungeonView_Detail", BaseView)
slot1 = 0.1
slot2 = 25
slot3 = 0

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "root/#go_topleft")
	slot0._gonormaltype = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_normaltype")
	slot0._goselectnormal = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_normaltype/#go_selectnormal")
	slot0._gounselectnormal = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_normaltype/#go_unselectnormal")
	slot0._gohardtype = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_hardtype")
	slot0._goselecthard = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_hardtype/#go_selecthard")
	slot0._gounselecthard = gohelper.findChild(slot0.viewGO, "root/left/mode/#go_hardtype/#go_unselecthard")
	slot0._btnclicknormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/mode/#go_normaltype/#btn_clicknormal")
	slot0._btnclickhard = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/mode/#go_hardtype/#btn_clickhard")
	slot0._btntask = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/left/#btn_task")
	slot0._goepisodecontainer = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer")
	slot0._gonormalepisode = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer/#go_normalepisode")
	slot0._gobossepisode = gohelper.findChild(slot0.viewGO, "root/middle/#go_episodecontainer/#go_bossepisode")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/top/bar/#btn_reset")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "root/right/#go_detail")
	slot0._btnclosedetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_closedetail")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_normal")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_hard")
	slot0._scrolldetail = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#go_detail/#scroll_detail")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/title/#txt_title")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/top/#txt_desc")
	slot0._godone = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/title/#go_done")
	slot0._goconditions = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions")
	slot0._imageconditionstar = gohelper.findChildImage(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/top/title/#image_conditionstar")
	slot0._goconditiondescs = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/#go_conditiondescs")
	slot0._txtconditionitem = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/#go_conditiondescs/#txt_conditionitem")
	slot0._gobaserulecontainer = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer")
	slot0._gobadgerules = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_badgerules")
	slot0._gobadgeruleitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_badgerules/#go_badgeruleitem")
	slot0._gobaserules = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_baserules")
	slot0._gobaseruleitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_baserules/#go_baseruleitem")
	slot0._goescaperulecontainer = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer")
	slot0._goescaperules = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer/#go_escaperules")
	slot0._goescaperuleitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer/#go_escaperules/#go_escaperuleitem")
	slot0._gorewardcontainer = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer/#go_rewards")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer/#go_rewards/#go_rewarditem")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_start")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_restart")
	slot0._btnbadge = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_badge")
	slot0._golock = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_lock")
	slot0._txtusebadgenum = gohelper.findChildText(slot0.viewGO, "root/right/#go_detail/#btn_badge/#txt_usebadgenum")
	slot0._gobadgedetail = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_badgedetail")
	slot0._btnclosebadge = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#go_badgedetail/#btn_closebadge")
	slot0._btnresetbadge = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#go_badgedetail/#go_badges/#btn_resetbadge")
	slot0._gobadgeitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#go_badgedetail/#go_badges/#go_badgeitem")
	slot0._btnrepress = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_repress")
	slot0._gosetrepresshero = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero")
	slot0._simagerepressheroicon = gohelper.findChildSingleImage(slot0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero/#simage_repressheroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero/#image_Career")
	slot0._gorepressresult = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult")
	slot0._gohasrepress = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_hasrepress")
	slot0._gounrepress = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_unrepress")
	slot0._gorepressrules = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_repressrules")
	slot0._gorepressruleitem = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_repressrules/#go_repressruleitem")
	slot0._gorepressheropos = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_hasrepress/#go_repressheropos")
	slot0._btnresetepisode = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/#btn_resetepisode")
	slot0._btninfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#go_detail/title/#btn_Info")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosedetail:AddClickListener(slot0._btnclosedetailOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnbadge:AddClickListener(slot0._btnbadgeOnClick, slot0)
	slot0._btnclosebadge:AddClickListener(slot0._btnclosebadgeOnClick, slot0)
	slot0._btnresetbadge:AddClickListener(slot0._btnresetbadgeOnClick, slot0)
	slot0._btnrepress:AddClickListener(slot0._btnrepressOnClick, slot0)
	slot0._btnresetepisode:AddClickListener(slot0._btnresetepisodeOnClick, slot0)
	slot0._btninfo:AddClickListener(slot0._btninfoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosedetail:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnbadge:RemoveClickListener()
	slot0._btnclosebadge:RemoveClickListener()
	slot0._btnresetbadge:RemoveClickListener()
	slot0._btnrepress:RemoveClickListener()
	slot0._btnresetepisode:RemoveClickListener()
	slot0._btninfo:RemoveClickListener()
end

function slot0._btnclosedetailOnClick(slot0)
	slot0._expand = false
	slot0._episodeId = nil

	gohelper.setActive(slot0._godetail, false)
	gohelper.setActive(slot0._btnclosedetail.gameObject, false)
	slot0._animator:Play("rightclose", 0, 0)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode)
end

function slot0._btnstartOnClick(slot0)
	Act183HeroGroupController.instance:enterFight(slot0._episodeId, slot0._readyUseBadgeNum, slot0._selectConditionMap)
end

function slot0._btnrestartOnClick(slot0)
	Act183HeroGroupController.instance:enterFight(slot0._episodeId, slot0._readyUseBadgeNum, slot0._selectConditionMap)
end

function slot0._btnbadgeOnClick(slot0)
	slot0:setBadgeDetailsVisible(true)
end

function slot0._btnclosebadgeOnClick(slot0)
	slot0:setBadgeDetailsVisible(false)
end

function slot0._btnresetbadgeOnClick(slot0)
	slot0._readyUseBadgeNum = 0

	slot0:refreshBadgeDetail()
	slot0:refreshBadgeRules()
	slot0:refreshRuleContainVisible()
end

function slot0._btnrepressOnClick(slot0)
	Act183Controller.instance:openAct183RepressView({
		activityId = slot0._activityId,
		episodeMo = slot0._episodeMo
	})
end

function slot0._btnresetepisodeOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act183ResetEpisode, MsgBoxEnum.BoxType.Yes_No, slot0._startResetEpisode, nil, , slot0)
end

function slot0._btninfoOnClick(slot0)
	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId) then
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(slot1.battleId)
	end
end

function slot0._startResetEpisode(slot0)
	Act183Controller.instance:resetEpisode(slot0._activityId, slot0._episodeId)
end

function slot0._editableInitView(slot0)
	slot0._expand = false
	slot0._badgeItemTab = slot0:getUserDataTb_()
	slot0._rewardItemTab = slot0:getUserDataTb_()
	slot0._selectConditionMap = {}

	slot0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, slot0._onClickEpisode, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, slot0._onUpdateRepressInfo, slot0)
	slot0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateGroupInfo, slot0._onUpdateGroupInfo, slot0)

	slot0._animator = gohelper.onceAddComponent(slot0.viewGO, gohelper.Type_Animator)
	slot0._imagebadgebtn = gohelper.onceAddComponent(slot0._btnbadge.gameObject, gohelper.Type_Image)
	slot0._txtbtnrepress = gohelper.findChildText(slot0._btnrepress.gameObject, "txt_Cn")
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content")

	gohelper.setActive(slot0._btnclosedetail, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshEpisodeDetail()
end

function slot0._onClickEpisode(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._episodeId ~= slot1 then
		if slot0._expand then
			slot0._animator:Play("rightswitch", 0, 0)
		else
			slot0._animator:Play("rightopen", 0, 0)
		end
	end

	slot0._expand = true
	slot0._nextEpisodeMo = Act183Model.instance:getEpisodeMoById(slot1)

	if not slot0._nextEpisodeMo then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(slot0.switchEpisodeDetail, slot0)
	TaskDispatcher.runDelay(slot0.switchEpisodeDetail, slot0, uv0)
end

function slot0.switchEpisodeDetail(slot0)
	slot0:refreshEpisodeDetail(slot0._nextEpisodeMo)
	gohelper.setActive(slot0._btnclosedetail.gameObject, true)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
end

function slot0._onUpdateRepressInfo(slot0, slot1, slot2)
	if not slot0._expand then
		return
	end

	if slot0._episodeId == slot1 then
		slot0:refreshEpisodeDetail(slot2)
	end
end

function slot0._onUpdateGroupInfo(slot0)
	if not slot0._expand then
		return
	end

	slot1 = nil

	if slot0._episodeId then
		slot1 = Act183Model.instance:getEpisodeMoById(slot0._episodeId)
	end

	slot0:refreshEpisodeDetail(slot1)
end

function slot0.refreshEpisodeDetail(slot0, slot1)
	gohelper.setActive(slot0._godetail, slot0._expand)

	if not slot0._expand then
		return
	end

	slot0:_scrollDetailToTargetPos(0)
	slot0:refreshInfo(slot1)

	if not slot0._episodeMo then
		return
	end

	slot0:refreshBg()
	slot0:refreshConditions()
	slot0:refreshBadgeRules()
	slot0:refreshBaseRules()
	slot0:refreshRuleContainVisible()
	slot0:refreshEscapeRules()
	slot0:refreshFightRewards()
	slot0:refreshRepressResult()
	slot0:focusEscapeRules()
	gohelper.setActive(slot0._godone, slot0._status == Act183Enum.EpisodeStatus.Finished)
	gohelper.setActive(slot0._btnstart.gameObject, slot0._status == Act183Enum.EpisodeStatus.Unlocked)
	gohelper.setActive(slot0._btnrestart.gameObject, slot0._isCanRestart)
	gohelper.setActive(slot0._btnresetepisode.gameObject, slot0._isCanReset)
	gohelper.setActive(slot0._golock, slot0._status == Act183Enum.EpisodeStatus.Locked)
	slot0:refreshRestartBtnSize()
	slot0:refreshBadgeBtn()
	slot0:refreshRepressBtn()
end

function slot0.refreshInfo(slot0, slot1)
	if slot1 then
		slot0._episodeMo = slot1
	end

	slot0._status = slot0._episodeMo:getStatus()
	slot0._episodeCo = slot0._episodeMo:getConfig()
	slot0._episodeId = slot0._episodeMo:getEpisodeId()
	slot0._episodeType = slot0._episodeMo:getEpisodeType()
	slot0._passOrder = slot0._episodeMo:getPassOrder()
	slot0._groupId = slot0._episodeCo.groupId
	slot0._activityId = slot0._episodeCo.activityId
	slot0._txttitle.text = slot0._episodeCo.title
	slot0._txtdesc.text = slot0._episodeCo.desc
	slot0._groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(slot0._groupId)
	slot0._escapeRules = slot0._groupEpisodeMo:getEscapeRules(slot0._episodeCo.episodeId)
	slot0._isCanRestart = slot0._groupEpisodeMo:isEpisodeCanRestart(slot0._episodeCo.episodeId)
	slot0._isCanReset = slot0._groupEpisodeMo:isEpisodeCanReset(slot0._episodeCo.episodeId)
	slot0._isCanReRepress = slot0._groupEpisodeMo:isEpisodeCanReRepress(slot0._episodeCo.episodeId)
	slot0._groupType = slot0._groupEpisodeMo:getGroupType()
	slot0._maxPassOrder = slot0._groupEpisodeMo:findMaxPassOrder()
	slot0._useBadgeNum = slot0._episodeMo:getUseBadgeNum()
	slot0._readyUseBadgeNum = slot0._useBadgeNum
	slot0._fightConditionIds, slot0._passFightConditionIds = slot0._groupEpisodeMo:getTotalAndPassConditionIds(slot0._episodeId)
	slot0._fightConditionIdMap = Act183Helper.listToMap(slot0._fightConditionIds)
	slot0._passFightConditionIdMap = Act183Helper.listToMap(slot0._passFightConditionIds)

	slot0:initSelectConditionMap()
end

function slot0.initSelectConditionMap(slot0)
	slot0._selectConditionMap = {}
	slot0._selectConditionIds = {}
	slot1 = false

	if slot0._episodeType == Act183Enum.EpisodeType.Boss and Act183Helper.getSelectConditionIdsInLocal(slot0._activityId, slot0._episodeId) then
		for slot6, slot7 in ipairs(slot2) do
			if slot0._passFightConditionIdMap[slot7] then
				slot0._selectConditionMap[slot7] = true

				table.insert(slot0._selectConditionIds, slot7)
			else
				slot1 = true
			end
		end
	end

	if slot1 then
		Act183Helper.saveSelectConditionIdsInLocal(slot0._activityId, slot0._episodeId, slot0._selectConditionIds)
	end
end

function slot0.refreshBg(slot0)
	gohelper.setActive(slot0._gonormal, slot0._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(slot0._gohard, slot0._groupType == Act183Enum.GroupType.HardMain)
end

function slot0.refreshConditions(slot0)
	slot2 = slot0._episodeMo:getConditionIds() and #slot1 > 0

	gohelper.setActive(slot0._goconditions, slot2)

	if not slot2 then
		return
	end

	gohelper.CreateObjList(slot0, slot0.refreshSingleCondition, slot1, slot0._goconditiondescs, slot0._txtconditionitem.gameObject)
	ZProj.UGUIHelper.SetGrayscale(slot0._imageconditionstar.gameObject, not slot0._episodeMo:isAllConditionPass())
end

function slot0.refreshSingleCondition(slot0, slot1, slot2, slot3)
	if not Act183Config.instance:getConditionCo(slot2) then
		return
	end

	slot5 = slot1:GetComponent(gohelper.Type_TextMesh)
	slot5.text = SkillHelper.buildDesc(slot4.decs1)

	SkillHelper.addHyperLinkClick(slot5)
	gohelper.setActive(gohelper.findChild(slot1, "star"), slot0._episodeMo:isConditionPass(slot2))
end

function slot0.refreshBaseRules(slot0)
	slot0._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(slot0._episodeId)
	slot0._hasBaseRules = slot0._baseRules and #slot0._baseRules > 0

	gohelper.setActive(slot0._gobaserules, slot0._hasBaseRules)

	if not slot0._hasBaseRules then
		return
	end

	gohelper.CreateObjList(slot0, slot0.refreshSingleBaseRule, slot0._baseRules, slot0._gobaserules, slot0._gobaseruleitem)
end

function slot0.refreshSingleBaseRule(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildText(slot1, "txt_desc")
	slot4.text = SkillHelper.buildDesc(slot2)

	SkillHelper.addHyperLinkClick(slot4)
	Act183Helper.setRuleIcon(slot0._episodeId, slot3, gohelper.findChildImage(slot1, "image_icon"))
end

function slot0.refreshBadgeRules(slot0, slot1)
	slot0._hasBadgeRules = slot0._readyUseBadgeNum > 0

	gohelper.setActive(slot0._gobadgerules, slot0._hasBadgeRules)

	if not slot0._hasBadgeRules then
		return
	end

	slot0._isNeedPlayBadgeAnim = slot1

	gohelper.CreateObjList(slot0, slot0.refreshBadgeRule, {
		Act183Config.instance:getBadgeCo(slot0._activityId, slot0._readyUseBadgeNum)
	}, slot0._gobadgerules, slot0._gobadgeruleitem)
end

function slot0.refreshBadgeRule(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildText(slot1, "txt_desc")
	slot4.text = SkillHelper.buildDesc(slot2.decs)

	SkillHelper.addHyperLinkClick(slot4)

	if slot0._isNeedPlayBadgeAnim then
		gohelper.onceAddComponent(slot1, gohelper.Type_Animator):Play("in", 0, 0)
	end
end

function slot0.refreshRuleContainVisible(slot0)
	gohelper.setActive(slot0._gobaserulecontainer, slot0._hasBaseRules or slot0._hasBadgeRules)
end

function slot0.focusBageRules(slot0)
	ZProj.UGUIHelper.RebuildLayout(slot0._gobadgerules.transform)
	slot0:_scrollDetailToTargetPos(recthelper.getAnchorY(slot0._gobadgerules.transform) + recthelper.getHeight(slot0._gobadgerules.transform) / 2)
end

function slot0._scrollDetailToTargetPos(slot0, slot1)
	ZProj.UGUIHelper.RebuildLayout(slot0._goScrollContent.transform)

	slot0._scrolldetail.verticalNormalizedPosition = 1 - math.abs(slot1) / (recthelper.getHeight(slot0._goScrollContent.transform) - recthelper.getHeight(slot0._scrolldetail.transform))
end

function slot0.refreshFightRewards(slot0)
	slot1 = slot0._episodeType == Act183Enum.EpisodeType.Boss

	gohelper.setActive(slot0._gorewardcontainer, slot1)

	if not slot1 then
		return
	end

	slot2 = {
		[slot8] = true
	}
	slot6 = slot0._groupId
	slot0._subEpisodeConditions = Act183Config.instance:getGroupSubEpisodeConditions(slot0._activityId, slot6)

	for slot6, slot7 in ipairs(slot0._subEpisodeConditions) do
		slot0:refreshSingleReward(slot0:_getOrCreateRewardItem(slot6), slot7, slot6)
	end

	for slot6, slot7 in pairs(slot0._rewardItemTab) do
		if not slot2[slot7] then
			gohelper.setActive(slot7.viewGO, false)
		end
	end
end

function slot0._getOrCreateRewardItem(slot0, slot1)
	if not slot0._rewardItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._gorewarditem, "rewad_" .. slot1)
		slot2.goselectbg = gohelper.findChild(slot2.viewGO, "btn_check/#go_BG1")
		slot2.gounselectbg = gohelper.findChild(slot2.viewGO, "btn_check/#go_BG2")
		slot2.imageicon = gohelper.findChildImage(slot2.viewGO, "image_icon")
		slot2.txtcondition = gohelper.findChildText(slot2.viewGO, "txt_condition")

		SkillHelper.addHyperLinkClick(slot2.txtcondition)

		slot2.txteffect = gohelper.findChildText(slot2.viewGO, "txt_effect")
		slot2.btncheck = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_check")

		slot2.btncheck:AddClickListener(slot0._onClickRewardItem, slot0, slot1)

		slot2.goselect = gohelper.findChild(slot2.viewGO, "btn_check/go_select")
		slot0._rewardItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onClickRewardItem(slot0, slot1)
	if not Act183Config.instance:getConditionCo(slot0._subEpisodeConditions and slot0._subEpisodeConditions[slot1]) then
		return
	end

	slot4 = nil

	if #slot0._selectConditionIds > 0 then
		slot0._selectConditionMap[table.remove(slot0._selectConditionIds, 1)] = false
	end

	if slot4 ~= slot3.id then
		slot0._selectConditionMap[slot3.id] = true

		table.insert(slot0._selectConditionIds, slot3.id)
	end

	Act183Helper.saveSelectConditionIdsInLocal(slot0._activityId, slot0._episodeId, slot0._selectConditionIds)
	slot0:refreshFightRewards()
end

function slot0.refreshSingleReward(slot0, slot1, slot2, slot3)
	if not Act183Config.instance:getConditionCo(slot2) then
		return
	end

	slot1.txtcondition.text = SkillHelper.buildDesc(slot4.decs1)
	slot1.txteffect.text = slot4.decs2
	slot8 = slot0._groupEpisodeMo:isConditionPass(slot2)

	ZProj.UGUIHelper.SetGrayscale(slot1.imageicon.gameObject, not slot8)
	gohelper.setActive(slot1.goselect, slot0._selectConditionMap[slot2])
	gohelper.setActive(slot1.btncheck.gameObject, slot8 and slot0._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(slot1.goselectbg, slot7)
	gohelper.setActive(slot1.gounselectbg, not slot7 and slot8)
	gohelper.setActive(slot1.viewGO, true)

	if slot8 then
		UISpriteSetMgr.instance:setChallengeSprite(slot1.imageicon, slot7 and "v2a5_challenge_dungeon_reward_star_01" or "v2a5_challenge_dungeon_reward_star_03")
	else
		UISpriteSetMgr.instance:setChallengeSprite(slot1.imageicon, "v2a5_challenge_dungeon_reward_star_02")
	end
end

function slot0.releaseRewardItems(slot0)
	if slot0._rewardItemTab then
		for slot4, slot5 in pairs(slot0._rewardItemTab) do
			slot5.btncheck:RemoveClickListener()
		end
	end
end

function slot0.refreshEscapeRules(slot0)
	slot3 = slot0._episodeType == Act183Enum.EpisodeType.Sub and (slot0._escapeRules and #slot0._escapeRules > 0)

	gohelper.setActive(slot0._goescaperulecontainer, slot3)

	if not slot3 then
		return
	end

	slot0._hasPlayRefreshAnimRuleIds = Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(slot0._episodeId)
	slot0._hasPlayRefreshAnimRuleIdMap = Act183Helper.listToMap(slot0._hasPlayRefreshAnimRuleIds)
	slot0._needFocusEscapeRule = false

	gohelper.CreateObjList(slot0, slot0.refreshSingleEscapeRule, slot0._escapeRules, slot0._goescaperules, slot0._goescaperuleitem)
	Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(slot0._episodeId, slot0._hasPlayRefreshAnimRuleIds)
end

function slot0.refreshSingleEscapeRule(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildText(slot1, "txt_desc")
	slot4.text = SkillHelper.buildDesc(slot2.ruleDesc)

	SkillHelper.addHyperLinkClick(slot4)
	Act183Helper.setRuleIcon(slot2.episodeId, slot2.ruleIndex, gohelper.findChildImage(slot1, "image_icon"))

	slot12 = slot0._maxPassOrder and slot2.passOrder == slot0._maxPassOrder and not (slot0._hasPlayRefreshAnimRuleIdMap[string.format("%s_%s", slot7, slot8)] ~= nil)

	gohelper.onceAddComponent(slot1, gohelper.Type_Animator):Play(slot12 and "in" or "idle", 0, 0)

	if slot12 then
		slot0._hasPlayRefreshAnimRuleIdMap[slot10] = true

		table.insert(slot0._hasPlayRefreshAnimRuleIds, slot10)

		slot0._needFocusEscapeRule = true
	end
end

function slot0.focusEscapeRules(slot0)
	if slot0._status ~= Act183Enum.EpisodeStatus.Unlocked or not slot0._needFocusEscapeRule then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_RefreshEscapeRule)
	gohelper.setActive(slot0._goescaperulecontainer, true)
	ZProj.UGUIHelper.RebuildLayout(slot0._goescaperules.transform)
	ZProj.UGUIHelper.RebuildLayout(slot0._goescaperulecontainer.transform)
	ZProj.UGUIHelper.RebuildLayout(slot0._goScrollContent.transform)
	slot0:_scrollDetailToTargetPos(recthelper.getAnchorY(slot0._goescaperulecontainer.transform) + recthelper.getHeight(slot0._goescaperulecontainer.transform) / 2)
end

function slot0.refreshRepressResult(slot0)
	slot4 = slot0._status == Act183Enum.EpisodeStatus.Finished and slot0._episodeType == Act183Enum.EpisodeType.Sub and not Act183Helper.isLastPassEpisodeInType(slot0._episodeMo)

	gohelper.setActive(slot0._gorepressresult, slot4)

	if not slot4 then
		return
	end

	gohelper.setActive(slot0._gohasrepress, false)
	gohelper.setActive(slot0._gounrepress, true)
	gohelper.CreateObjList(slot0, slot0.refreshSingleRepressResult, slot0._baseRules, slot0._gorepressrules, slot0._gorepressruleitem)
end

function slot0.refreshSingleRepressResult(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildText(slot1, "txt_desc")
	slot10 = slot0._episodeMo:getRuleStatus(slot3) == Act183Enum.RuleStatus.Repress
	slot4.text = SkillHelper.buildDesc(slot2)

	SkillHelper.addHyperLinkClick(slot4)
	gohelper.setActive(gohelper.findChild(slot1, "image_icon/go_disable"), slot10)
	gohelper.setActive(gohelper.findChild(slot1, "#go_Disable"), slot10)
	gohelper.setActive(gohelper.findChild(slot1, "image_icon/go_escape"), not slot10)
	Act183Helper.setRuleIcon(slot0._episodeId, slot3, gohelper.findChildImage(slot1, "image_icon"))

	if slot10 then
		slot12 = slot0._episodeMo:getRepressHeroMo():getHeroId()

		if not slot0._repressHeroItem then
			slot0._repressHeroItem = IconMgr.instance:getCommonHeroIconNew(slot0._gorepressheropos)

			slot0._repressHeroItem:isShowLevel(false)
		end

		slot0._repressHeroItem:onUpdateHeroId(slot12)
		gohelper.setActive(slot0._gohasrepress, true)
		gohelper.setActive(slot0._gounrepress, false)
	end
end

slot4 = {
	CanRestart_HasRepress = {
		610,
		-416
	},
	CanRestart_NotRepress = {
		395,
		-416
	},
	Others = {
		394.33,
		-416
	}
}
slot5 = {
	CanRestart_CanRepress = {
		660,
		-416
	},
	CanRestart_NotRepress = {
		445,
		-416
	},
	Start = {
		445,
		-416
	}
}

function slot0.refreshBadgeBtn(slot0)
	slot0._totalBadgeNum = Act183Model.instance:getActInfo() and slot1:getBadgeNum() or 0
	slot2 = slot0._totalBadgeNum > 0 and slot0._groupType == Act183Enum.GroupType.NormalMain

	gohelper.setActive(slot0._btnbadge.gameObject, slot2)

	if slot2 then
		slot3 = uv0.Others

		if slot0._isCanRestart then
			slot3 = slot0._isCanReRepress and uv0.CanRestart_HasRepress or uv0.CanRestart_NotRepress
		end

		slot0:refreshBadgeBtnDetail(slot3)

		slot4 = slot0:_getBadgeBtnPos()

		recthelper.setAnchor(slot0._btnbadge.transform, slot4[1], slot4[2])
	end
end

function slot0._getBadgeBtnPos(slot0)
	if slot0._isCanRestart then
		if slot0._isCanReRepress then
			return uv0.CanRestart_CanRepress
		end

		return uv0.CanRestart_NotRepress
	end

	return uv0.Start
end

function slot0.refreshBadgeBtnDetail(slot0, slot1)
	slot2 = slot0._readyUseBadgeNum > 0

	gohelper.setActive(slot0._txtusebadgenum.gameObject, slot2)

	slot0._txtusebadgenum.text = slot0._readyUseBadgeNum

	UISpriteSetMgr.instance:setChallengeSprite(slot0._imagebadgebtn, slot2 and "v2a5_challenge_dungeon_iconbtn2" or "v2a5_challenge_dungeon_iconbtn1")

	if slot1 then
		recthelper.setAnchor(slot0._gobadgedetail.transform, slot1[1], slot1[2])
	end
end

function slot0.refreshBadgeDetail(slot0)
	slot1 = {
		[slot6] = true
	}

	for slot5 = 1, slot0._totalBadgeNum do
		slot6 = slot0:_getOrCreateBadgeItem(slot5)

		gohelper.setActive(slot6.viewGO, true)
		UISpriteSetMgr.instance:setChallengeSprite(slot6.imageicon, slot5 <= slot0._readyUseBadgeNum and "v2a5_challenge_badge1" or "v2a5_challenge_badge2")
	end

	for slot5, slot6 in pairs(slot0._badgeItemTab) do
		if not slot1[slot6] then
			gohelper.setActive(slot6.viewGO, false)
		end
	end

	slot0:refreshBadgeBtnDetail()
end

function slot0._getOrCreateBadgeItem(slot0, slot1)
	if not slot0._badgeItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.viewGO = gohelper.cloneInPlace(slot0._gobadgeitem, "badgeitem_" .. slot1)
		slot2.imageicon = gohelper.findChildImage(slot2.viewGO, "image_icon")
		slot2.btnclick = gohelper.findChildButtonWithAudio(slot2.viewGO, "btn_click")

		slot2.btnclick:AddClickListener(slot0._onClickBadgeItem, slot0, slot1)

		slot0._badgeItemTab[slot1] = slot2
	end

	return slot2
end

function slot0._onClickBadgeItem(slot0, slot1)
	slot0._readyUseBadgeNum = slot1

	slot0:refreshBadgeDetail()
	slot0:refreshBadgeRules(true)
	slot0:refreshRuleContainVisible()
	slot0:focusBageRules()
end

function slot0.setBadgeDetailsVisible(slot0, slot1)
	gohelper.setActive(slot0._gobadgedetail, slot1)
	gohelper.setActive(slot0._btnrepress.gameObject, not slot1 and slot0._isCanReRepress)

	if slot1 then
		slot0:refreshBadgeDetail()
	end
end

function slot0.releaseBadgeItems(slot0)
	if slot0._badgeItemTab then
		for slot4, slot5 in pairs(slot0._badgeItemTab) do
			slot5.btnclick:RemoveClickListener()
		end
	end
end

function slot0.refreshRepressBtn(slot0)
	gohelper.setActive(slot0._btnrepress.gameObject, slot0._isCanReRepress)

	if not slot0._isCanReRepress then
		return
	end

	slot2 = slot0._episodeMo:getRepressHeroMo() ~= nil

	gohelper.setActive(slot0._gosetrepresshero, slot2)
	recthelper.setAnchorX(slot0._txtbtnrepress.transform, slot2 and uv0 or uv1)

	if not slot2 then
		return
	end

	slot0._simagerepressheroicon:LoadImage(slot1:getHeroIconUrl())
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. tostring(slot1:getHeroCarrer()))
end

function slot0.refreshRestartBtnSize(slot0)
	slot1 = slot0:_getRestartBtnPos()

	recthelper.setSize(slot0._btnrestart.transform, slot1[3], slot1[4])
	recthelper.setAnchor(slot0._btnrestart.transform, slot1[1], slot1[2])
end

slot6 = {
	CanRepress = {
		785,
		-425,
		340,
		104
	},
	NotRepress = {
		697,
		-425,
		560,
		104
	}
}

function slot0._getRestartBtnPos(slot0)
	if slot0._isCanReRepress then
		return uv0.CanRepress
	end

	return uv0.NotRepress
end

function slot0.onClose(slot0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(slot0.switchEpisodeDetail, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:releaseBadgeItems()
	slot0:releaseRewardItems()
	slot0._simagerepressheroicon:UnLoadImage()
end

return slot0
