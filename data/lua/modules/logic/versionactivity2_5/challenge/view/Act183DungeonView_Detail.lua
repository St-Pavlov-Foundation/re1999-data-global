module("modules.logic.versionactivity2_5.challenge.view.Act183DungeonView_Detail", package.seeall)

local var_0_0 = class("Act183DungeonView_Detail", BaseView)
local var_0_1 = 0.1
local var_0_2 = 25
local var_0_3 = 0

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._gonormaltype = gohelper.findChild(arg_1_0.viewGO, "root/left/mode/#go_normaltype")
	arg_1_0._goselectnormal = gohelper.findChild(arg_1_0.viewGO, "root/left/mode/#go_normaltype/#go_selectnormal")
	arg_1_0._gounselectnormal = gohelper.findChild(arg_1_0.viewGO, "root/left/mode/#go_normaltype/#go_unselectnormal")
	arg_1_0._gohardtype = gohelper.findChild(arg_1_0.viewGO, "root/left/mode/#go_hardtype")
	arg_1_0._goselecthard = gohelper.findChild(arg_1_0.viewGO, "root/left/mode/#go_hardtype/#go_selecthard")
	arg_1_0._gounselecthard = gohelper.findChild(arg_1_0.viewGO, "root/left/mode/#go_hardtype/#go_unselecthard")
	arg_1_0._btnclicknormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/mode/#go_normaltype/#btn_clicknormal")
	arg_1_0._btnclickhard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/mode/#go_hardtype/#btn_clickhard")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/left/#btn_task")
	arg_1_0._goepisodecontainer = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_episodecontainer")
	arg_1_0._gonormalepisode = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_episodecontainer/#go_normalepisode")
	arg_1_0._gobossepisode = gohelper.findChild(arg_1_0.viewGO, "root/middle/#go_episodecontainer/#go_bossepisode")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/top/bar/#btn_reset")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail")
	arg_1_0._btnclosedetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_closedetail")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#go_normal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#go_hard")
	arg_1_0._scrolldetail = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_detail/title/#txt_title")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/top/#txt_desc")
	arg_1_0._godone = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/title/#go_done")
	arg_1_0._goconditions = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions")
	arg_1_0._imageconditionstar = gohelper.findChildImage(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/top/title/#image_conditionstar")
	arg_1_0._goconditiondescs = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/#go_conditiondescs")
	arg_1_0._txtconditionitem = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_conditions/#go_conditiondescs/#txt_conditionitem")
	arg_1_0._gobaserulecontainer = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer")
	arg_1_0._gobadgerules = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_badgerules")
	arg_1_0._gobadgeruleitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_badgerules/#go_badgeruleitem")
	arg_1_0._gobaserules = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_baserules")
	arg_1_0._gobaseruleitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_baserulecontainer/#go_baserules/#go_baseruleitem")
	arg_1_0._goescaperulecontainer = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer")
	arg_1_0._goescaperules = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer/#go_escaperules")
	arg_1_0._goescaperuleitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_escaperulecontainer/#go_escaperules/#go_escaperuleitem")
	arg_1_0._gorewardcontainer = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer/#go_rewards")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_rewardcontainer/#go_rewards/#go_rewarditem")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#btn_start")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#btn_restart")
	arg_1_0._btnbadge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#btn_badge")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#go_lock")
	arg_1_0._txtusebadgenum = gohelper.findChildText(arg_1_0.viewGO, "root/right/#go_detail/#btn_badge/#txt_usebadgenum")
	arg_1_0._gobadgedetail = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#go_badgedetail")
	arg_1_0._btnclosebadge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#go_badgedetail/#btn_closebadge")
	arg_1_0._btnresetbadge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#go_badgedetail/#go_badges/#btn_resetbadge")
	arg_1_0._gobadgeitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#go_badgedetail/#go_badges/#go_badgeitem")
	arg_1_0._btnrepress = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#btn_repress")
	arg_1_0._gosetrepresshero = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero")
	arg_1_0._simagerepressheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero/#simage_repressheroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "root/right/#go_detail/#btn_repress/#go_setrepresshero/#image_Career")
	arg_1_0._gorepressresult = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult")
	arg_1_0._gohasrepress = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_hasrepress")
	arg_1_0._gounrepress = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_unrepress")
	arg_1_0._gorepressrules = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_repressrules")
	arg_1_0._gorepressruleitem = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_repressrules/#go_repressruleitem")
	arg_1_0._gorepressheropos = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content/#go_repressresult/#go_hasrepress/#go_repressheropos")
	arg_1_0._btnresetepisode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/#btn_resetepisode")
	arg_1_0._btninfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/right/#go_detail/title/#btn_Info")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosedetail:AddClickListener(arg_2_0._btnclosedetailOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnbadge:AddClickListener(arg_2_0._btnbadgeOnClick, arg_2_0)
	arg_2_0._btnclosebadge:AddClickListener(arg_2_0._btnclosebadgeOnClick, arg_2_0)
	arg_2_0._btnresetbadge:AddClickListener(arg_2_0._btnresetbadgeOnClick, arg_2_0)
	arg_2_0._btnrepress:AddClickListener(arg_2_0._btnrepressOnClick, arg_2_0)
	arg_2_0._btnresetepisode:AddClickListener(arg_2_0._btnresetepisodeOnClick, arg_2_0)
	arg_2_0._btninfo:AddClickListener(arg_2_0._btninfoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosedetail:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnbadge:RemoveClickListener()
	arg_3_0._btnclosebadge:RemoveClickListener()
	arg_3_0._btnresetbadge:RemoveClickListener()
	arg_3_0._btnrepress:RemoveClickListener()
	arg_3_0._btnresetepisode:RemoveClickListener()
	arg_3_0._btninfo:RemoveClickListener()
end

function var_0_0._btnclosedetailOnClick(arg_4_0)
	arg_4_0._expand = false
	arg_4_0._episodeId = nil

	gohelper.setActive(arg_4_0._godetail, false)
	gohelper.setActive(arg_4_0._btnclosedetail.gameObject, false)
	arg_4_0._animator:Play("rightclose", 0, 0)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode)
end

function var_0_0._btnstartOnClick(arg_5_0)
	Act183HeroGroupController.instance:enterFight(arg_5_0._episodeId, arg_5_0._readyUseBadgeNum, arg_5_0._selectConditionMap)
end

function var_0_0._btnrestartOnClick(arg_6_0)
	Act183HeroGroupController.instance:enterFight(arg_6_0._episodeId, arg_6_0._readyUseBadgeNum, arg_6_0._selectConditionMap)
end

function var_0_0._btnbadgeOnClick(arg_7_0)
	arg_7_0:setBadgeDetailsVisible(true)
end

function var_0_0._btnclosebadgeOnClick(arg_8_0)
	arg_8_0:setBadgeDetailsVisible(false)
end

function var_0_0._btnresetbadgeOnClick(arg_9_0)
	arg_9_0._readyUseBadgeNum = 0

	arg_9_0:refreshBadgeDetail()
	arg_9_0:refreshBadgeRules()
	arg_9_0:refreshRuleContainVisible()
end

function var_0_0._btnrepressOnClick(arg_10_0)
	local var_10_0 = {
		activityId = arg_10_0._activityId,
		episodeMo = arg_10_0._episodeMo
	}

	Act183Controller.instance:openAct183RepressView(var_10_0)
end

function var_0_0._btnresetepisodeOnClick(arg_11_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.Act183ResetEpisode, MsgBoxEnum.BoxType.Yes_No, arg_11_0._startResetEpisode, nil, nil, arg_11_0)
end

function var_0_0._btninfoOnClick(arg_12_0)
	local var_12_0 = DungeonConfig.instance:getEpisodeCO(arg_12_0._episodeId)

	if var_12_0 then
		EnemyInfoController.instance:openEnemyInfoViewByBattleId(var_12_0.battleId)
	end
end

function var_0_0._startResetEpisode(arg_13_0)
	Act183Controller.instance:resetEpisode(arg_13_0._activityId, arg_13_0._episodeId)
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._expand = false
	arg_14_0._badgeItemTab = arg_14_0:getUserDataTb_()
	arg_14_0._rewardItemTab = arg_14_0:getUserDataTb_()
	arg_14_0._selectConditionMap = {}

	arg_14_0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, arg_14_0._onClickEpisode, arg_14_0)
	arg_14_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, arg_14_0._onUpdateRepressInfo, arg_14_0)
	arg_14_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateGroupInfo, arg_14_0._onUpdateGroupInfo, arg_14_0)

	arg_14_0._animator = gohelper.onceAddComponent(arg_14_0.viewGO, gohelper.Type_Animator)
	arg_14_0._imagebadgebtn = gohelper.onceAddComponent(arg_14_0._btnbadge.gameObject, gohelper.Type_Image)
	arg_14_0._txtbtnrepress = gohelper.findChildText(arg_14_0._btnrepress.gameObject, "txt_Cn")
	arg_14_0._goScrollContent = gohelper.findChild(arg_14_0.viewGO, "root/right/#go_detail/#scroll_detail/Viewport/Content")

	gohelper.setActive(arg_14_0._btnclosedetail, false)
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:refreshEpisodeDetail()
end

function var_0_0._onClickEpisode(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	if arg_17_0._episodeId ~= arg_17_1 then
		if arg_17_0._expand then
			arg_17_0._animator:Play("rightswitch", 0, 0)
		else
			arg_17_0._animator:Play("rightopen", 0, 0)
		end
	end

	arg_17_0._expand = true
	arg_17_0._nextEpisodeMo = Act183Model.instance:getEpisodeMoById(arg_17_1)

	if not arg_17_0._nextEpisodeMo then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(arg_17_0.switchEpisodeDetail, arg_17_0)
	TaskDispatcher.runDelay(arg_17_0.switchEpisodeDetail, arg_17_0, var_0_1)
end

function var_0_0.switchEpisodeDetail(arg_18_0)
	arg_18_0:refreshEpisodeDetail(arg_18_0._nextEpisodeMo)
	gohelper.setActive(arg_18_0._btnclosedetail.gameObject, true)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
end

function var_0_0._onUpdateRepressInfo(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0._expand then
		return
	end

	if arg_19_0._episodeId == arg_19_1 then
		arg_19_0:refreshEpisodeDetail(arg_19_2)
	end
end

function var_0_0._onUpdateGroupInfo(arg_20_0)
	if not arg_20_0._expand then
		return
	end

	local var_20_0

	if arg_20_0._episodeId then
		var_20_0 = Act183Model.instance:getEpisodeMoById(arg_20_0._episodeId)
	end

	arg_20_0:refreshEpisodeDetail(var_20_0)
end

function var_0_0.refreshEpisodeDetail(arg_21_0, arg_21_1)
	gohelper.setActive(arg_21_0._godetail, arg_21_0._expand)

	if not arg_21_0._expand then
		return
	end

	arg_21_0:_scrollDetailToTargetPos(0)
	arg_21_0:refreshInfo(arg_21_1)

	if not arg_21_0._episodeMo then
		return
	end

	arg_21_0:refreshBg()
	arg_21_0:refreshConditions()
	arg_21_0:refreshBadgeRules()
	arg_21_0:refreshBaseRules()
	arg_21_0:refreshRuleContainVisible()
	arg_21_0:refreshEscapeRules()
	arg_21_0:refreshFightRewards()
	arg_21_0:refreshRepressResult()
	arg_21_0:focusEscapeRules()
	gohelper.setActive(arg_21_0._godone, arg_21_0._status == Act183Enum.EpisodeStatus.Finished)
	gohelper.setActive(arg_21_0._btnstart.gameObject, arg_21_0._status == Act183Enum.EpisodeStatus.Unlocked)
	gohelper.setActive(arg_21_0._btnrestart.gameObject, arg_21_0._isCanRestart)
	gohelper.setActive(arg_21_0._btnresetepisode.gameObject, arg_21_0._isCanReset)
	gohelper.setActive(arg_21_0._golock, arg_21_0._status == Act183Enum.EpisodeStatus.Locked)
	arg_21_0:refreshRestartBtnSize()
	arg_21_0:refreshBadgeBtn()
	arg_21_0:refreshRepressBtn()
end

function var_0_0.refreshInfo(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_0._episodeMo = arg_22_1
	end

	arg_22_0._status = arg_22_0._episodeMo:getStatus()
	arg_22_0._episodeCo = arg_22_0._episodeMo:getConfig()
	arg_22_0._episodeId = arg_22_0._episodeMo:getEpisodeId()
	arg_22_0._episodeType = arg_22_0._episodeMo:getEpisodeType()
	arg_22_0._passOrder = arg_22_0._episodeMo:getPassOrder()
	arg_22_0._groupId = arg_22_0._episodeCo.groupId
	arg_22_0._activityId = arg_22_0._episodeCo.activityId
	arg_22_0._txttitle.text = arg_22_0._episodeCo.title
	arg_22_0._txtdesc.text = arg_22_0._episodeCo.desc
	arg_22_0._groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(arg_22_0._groupId)
	arg_22_0._escapeRules = arg_22_0._groupEpisodeMo:getEscapeRules(arg_22_0._episodeCo.episodeId)
	arg_22_0._isCanRestart = arg_22_0._groupEpisodeMo:isEpisodeCanRestart(arg_22_0._episodeCo.episodeId)
	arg_22_0._isCanReset = arg_22_0._groupEpisodeMo:isEpisodeCanReset(arg_22_0._episodeCo.episodeId)
	arg_22_0._isCanReRepress = arg_22_0._groupEpisodeMo:isEpisodeCanReRepress(arg_22_0._episodeCo.episodeId)
	arg_22_0._groupType = arg_22_0._groupEpisodeMo:getGroupType()
	arg_22_0._maxPassOrder = arg_22_0._groupEpisodeMo:findMaxPassOrder()
	arg_22_0._useBadgeNum = arg_22_0._episodeMo:getUseBadgeNum()
	arg_22_0._readyUseBadgeNum = arg_22_0._useBadgeNum
	arg_22_0._fightConditionIds, arg_22_0._passFightConditionIds = arg_22_0._groupEpisodeMo:getTotalAndPassConditionIds(arg_22_0._episodeId)
	arg_22_0._fightConditionIdMap = Act183Helper.listToMap(arg_22_0._fightConditionIds)
	arg_22_0._passFightConditionIdMap = Act183Helper.listToMap(arg_22_0._passFightConditionIds)

	arg_22_0:initSelectConditionMap()
end

function var_0_0.initSelectConditionMap(arg_23_0)
	arg_23_0._selectConditionMap = {}
	arg_23_0._selectConditionIds = {}

	local var_23_0 = false

	if arg_23_0._episodeType == Act183Enum.EpisodeType.Boss then
		local var_23_1 = Act183Helper.getSelectConditionIdsInLocal(arg_23_0._activityId, arg_23_0._episodeId)

		if var_23_1 then
			for iter_23_0, iter_23_1 in ipairs(var_23_1) do
				if arg_23_0._passFightConditionIdMap[iter_23_1] then
					arg_23_0._selectConditionMap[iter_23_1] = true

					table.insert(arg_23_0._selectConditionIds, iter_23_1)
				else
					var_23_0 = true
				end
			end
		end
	end

	if var_23_0 then
		Act183Helper.saveSelectConditionIdsInLocal(arg_23_0._activityId, arg_23_0._episodeId, arg_23_0._selectConditionIds)
	end
end

function var_0_0.refreshBg(arg_24_0)
	gohelper.setActive(arg_24_0._gonormal, arg_24_0._groupType ~= Act183Enum.GroupType.HardMain)
	gohelper.setActive(arg_24_0._gohard, arg_24_0._groupType == Act183Enum.GroupType.HardMain)
end

function var_0_0.refreshConditions(arg_25_0)
	local var_25_0 = arg_25_0._episodeMo:getConditionIds()
	local var_25_1 = var_25_0 and #var_25_0 > 0

	gohelper.setActive(arg_25_0._goconditions, var_25_1)

	if not var_25_1 then
		return
	end

	gohelper.CreateObjList(arg_25_0, arg_25_0.refreshSingleCondition, var_25_0, arg_25_0._goconditiondescs, arg_25_0._txtconditionitem.gameObject)

	local var_25_2 = arg_25_0._episodeMo:isAllConditionPass()

	ZProj.UGUIHelper.SetGrayscale(arg_25_0._imageconditionstar.gameObject, not var_25_2)
end

function var_0_0.refreshSingleCondition(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = Act183Config.instance:getConditionCo(arg_26_2)

	if not var_26_0 then
		return
	end

	local var_26_1 = arg_26_1:GetComponent(gohelper.Type_TextMesh)

	var_26_1.text = SkillHelper.buildDesc(var_26_0.decs1)

	SkillHelper.addHyperLinkClick(var_26_1)

	local var_26_2 = arg_26_0._episodeMo:isConditionPass(arg_26_2)
	local var_26_3 = gohelper.findChild(arg_26_1, "star")

	gohelper.setActive(var_26_3, var_26_2)
end

function var_0_0.refreshBaseRules(arg_27_0)
	arg_27_0._baseRules = Act183Config.instance:getEpisodeAllRuleDesc(arg_27_0._episodeId)
	arg_27_0._hasBaseRules = arg_27_0._baseRules and #arg_27_0._baseRules > 0

	gohelper.setActive(arg_27_0._gobaserules, arg_27_0._hasBaseRules)

	if not arg_27_0._hasBaseRules then
		return
	end

	gohelper.CreateObjList(arg_27_0, arg_27_0.refreshSingleBaseRule, arg_27_0._baseRules, arg_27_0._gobaserules, arg_27_0._gobaseruleitem)
end

function var_0_0.refreshSingleBaseRule(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = gohelper.findChildText(arg_28_1, "txt_desc")
	local var_28_1 = gohelper.findChildImage(arg_28_1, "image_icon")

	var_28_0.text = SkillHelper.buildDesc(arg_28_2)

	SkillHelper.addHyperLinkClick(var_28_0)
	Act183Helper.setRuleIcon(arg_28_0._episodeId, arg_28_3, var_28_1)
end

function var_0_0.refreshBadgeRules(arg_29_0, arg_29_1)
	arg_29_0._hasBadgeRules = arg_29_0._readyUseBadgeNum > 0

	gohelper.setActive(arg_29_0._gobadgerules, arg_29_0._hasBadgeRules)

	if not arg_29_0._hasBadgeRules then
		return
	end

	arg_29_0._isNeedPlayBadgeAnim = arg_29_1

	local var_29_0 = Act183Config.instance:getBadgeCo(arg_29_0._activityId, arg_29_0._readyUseBadgeNum)

	gohelper.CreateObjList(arg_29_0, arg_29_0.refreshBadgeRule, {
		var_29_0
	}, arg_29_0._gobadgerules, arg_29_0._gobadgeruleitem)
end

function var_0_0.refreshBadgeRule(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = gohelper.findChildText(arg_30_1, "txt_desc")

	var_30_0.text = SkillHelper.buildDesc(arg_30_2.decs)

	SkillHelper.addHyperLinkClick(var_30_0)

	if arg_30_0._isNeedPlayBadgeAnim then
		gohelper.onceAddComponent(arg_30_1, gohelper.Type_Animator):Play("in", 0, 0)
	end
end

function var_0_0.refreshRuleContainVisible(arg_31_0)
	gohelper.setActive(arg_31_0._gobaserulecontainer, arg_31_0._hasBaseRules or arg_31_0._hasBadgeRules)
end

function var_0_0.focusBageRules(arg_32_0)
	ZProj.UGUIHelper.RebuildLayout(arg_32_0._gobadgerules.transform)

	local var_32_0 = recthelper.getAnchorY(arg_32_0._gobadgerules.transform) + recthelper.getHeight(arg_32_0._gobadgerules.transform) / 2

	arg_32_0:_scrollDetailToTargetPos(var_32_0)
end

function var_0_0._scrollDetailToTargetPos(arg_33_0, arg_33_1)
	ZProj.UGUIHelper.RebuildLayout(arg_33_0._goScrollContent.transform)

	local var_33_0 = recthelper.getHeight(arg_33_0._goScrollContent.transform)
	local var_33_1 = recthelper.getHeight(arg_33_0._scrolldetail.transform)

	arg_33_0._scrolldetail.verticalNormalizedPosition = 1 - math.abs(arg_33_1) / (var_33_0 - var_33_1)
end

function var_0_0.refreshFightRewards(arg_34_0)
	local var_34_0 = arg_34_0._episodeType == Act183Enum.EpisodeType.Boss

	gohelper.setActive(arg_34_0._gorewardcontainer, var_34_0)

	if not var_34_0 then
		return
	end

	local var_34_1 = {}

	arg_34_0._subEpisodeConditions = Act183Config.instance:getGroupSubEpisodeConditions(arg_34_0._activityId, arg_34_0._groupId)

	for iter_34_0, iter_34_1 in ipairs(arg_34_0._subEpisodeConditions) do
		local var_34_2 = arg_34_0:_getOrCreateRewardItem(iter_34_0)

		arg_34_0:refreshSingleReward(var_34_2, iter_34_1, iter_34_0)

		var_34_1[var_34_2] = true
	end

	for iter_34_2, iter_34_3 in pairs(arg_34_0._rewardItemTab) do
		if not var_34_1[iter_34_3] then
			gohelper.setActive(iter_34_3.viewGO, false)
		end
	end
end

function var_0_0._getOrCreateRewardItem(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0._rewardItemTab[arg_35_1]

	if not var_35_0 then
		var_35_0 = arg_35_0:getUserDataTb_()
		var_35_0.viewGO = gohelper.cloneInPlace(arg_35_0._gorewarditem, "rewad_" .. arg_35_1)
		var_35_0.goselectbg = gohelper.findChild(var_35_0.viewGO, "btn_check/#go_BG1")
		var_35_0.gounselectbg = gohelper.findChild(var_35_0.viewGO, "btn_check/#go_BG2")
		var_35_0.imageicon = gohelper.findChildImage(var_35_0.viewGO, "image_icon")
		var_35_0.txtcondition = gohelper.findChildText(var_35_0.viewGO, "txt_condition")

		SkillHelper.addHyperLinkClick(var_35_0.txtcondition)

		var_35_0.txteffect = gohelper.findChildText(var_35_0.viewGO, "txt_effect")
		var_35_0.btncheck = gohelper.findChildButtonWithAudio(var_35_0.viewGO, "btn_check")

		var_35_0.btncheck:AddClickListener(arg_35_0._onClickRewardItem, arg_35_0, arg_35_1)

		var_35_0.goselect = gohelper.findChild(var_35_0.viewGO, "btn_check/go_select")
		arg_35_0._rewardItemTab[arg_35_1] = var_35_0
	end

	return var_35_0
end

function var_0_0._onClickRewardItem(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._subEpisodeConditions and arg_36_0._subEpisodeConditions[arg_36_1]
	local var_36_1 = Act183Config.instance:getConditionCo(var_36_0)

	if not var_36_1 then
		return
	end

	local var_36_2

	if #arg_36_0._selectConditionIds > 0 then
		var_36_2 = table.remove(arg_36_0._selectConditionIds, 1)
		arg_36_0._selectConditionMap[var_36_2] = false
	end

	if var_36_2 ~= var_36_1.id then
		arg_36_0._selectConditionMap[var_36_1.id] = true

		table.insert(arg_36_0._selectConditionIds, var_36_1.id)
	end

	Act183Helper.saveSelectConditionIdsInLocal(arg_36_0._activityId, arg_36_0._episodeId, arg_36_0._selectConditionIds)
	arg_36_0:refreshFightRewards()
end

function var_0_0.refreshSingleReward(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = Act183Config.instance:getConditionCo(arg_37_2)

	if not var_37_0 then
		return
	end

	local var_37_1 = var_37_0.decs1
	local var_37_2 = var_37_0.decs2

	arg_37_1.txtcondition.text = SkillHelper.buildDesc(var_37_1)
	arg_37_1.txteffect.text = var_37_2

	local var_37_3 = arg_37_0._selectConditionMap[arg_37_2]
	local var_37_4 = arg_37_0._groupEpisodeMo:isConditionPass(arg_37_2)

	ZProj.UGUIHelper.SetGrayscale(arg_37_1.imageicon.gameObject, not var_37_4)
	gohelper.setActive(arg_37_1.goselect, var_37_3)
	gohelper.setActive(arg_37_1.btncheck.gameObject, var_37_4 and arg_37_0._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(arg_37_1.goselectbg, var_37_3)
	gohelper.setActive(arg_37_1.gounselectbg, not var_37_3 and var_37_4)
	gohelper.setActive(arg_37_1.viewGO, true)

	if var_37_4 then
		local var_37_5 = var_37_3 and "v2a5_challenge_dungeon_reward_star_01" or "v2a5_challenge_dungeon_reward_star_03"

		UISpriteSetMgr.instance:setChallengeSprite(arg_37_1.imageicon, var_37_5)
	else
		UISpriteSetMgr.instance:setChallengeSprite(arg_37_1.imageicon, "v2a5_challenge_dungeon_reward_star_02")
	end
end

function var_0_0.releaseRewardItems(arg_38_0)
	if arg_38_0._rewardItemTab then
		for iter_38_0, iter_38_1 in pairs(arg_38_0._rewardItemTab) do
			iter_38_1.btncheck:RemoveClickListener()
		end
	end
end

function var_0_0.refreshEscapeRules(arg_39_0)
	local var_39_0 = arg_39_0._episodeType == Act183Enum.EpisodeType.Sub
	local var_39_1 = arg_39_0._escapeRules and #arg_39_0._escapeRules > 0
	local var_39_2 = var_39_0 and var_39_1

	gohelper.setActive(arg_39_0._goescaperulecontainer, var_39_2)

	if not var_39_2 then
		return
	end

	arg_39_0._hasPlayRefreshAnimRuleIds = Act183Helper.getHasPlayRefreshAnimRuleIdsInLocal(arg_39_0._episodeId)
	arg_39_0._hasPlayRefreshAnimRuleIdMap = Act183Helper.listToMap(arg_39_0._hasPlayRefreshAnimRuleIds)
	arg_39_0._needFocusEscapeRule = false

	gohelper.CreateObjList(arg_39_0, arg_39_0.refreshSingleEscapeRule, arg_39_0._escapeRules, arg_39_0._goescaperules, arg_39_0._goescaperuleitem)
	Act183Helper.saveHasPlayRefreshAnimRuleIdsInLocal(arg_39_0._episodeId, arg_39_0._hasPlayRefreshAnimRuleIds)
end

function var_0_0.refreshSingleEscapeRule(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	local var_40_0 = gohelper.findChildText(arg_40_1, "txt_desc")
	local var_40_1 = gohelper.findChildImage(arg_40_1, "image_icon")
	local var_40_2 = gohelper.onceAddComponent(arg_40_1, gohelper.Type_Animator)
	local var_40_3 = arg_40_2.episodeId
	local var_40_4 = arg_40_2.ruleIndex

	var_40_0.text = SkillHelper.buildDesc(arg_40_2.ruleDesc)

	SkillHelper.addHyperLinkClick(var_40_0)
	Act183Helper.setRuleIcon(var_40_3, var_40_4, var_40_1)

	local var_40_5 = arg_40_0._maxPassOrder and arg_40_2.passOrder == arg_40_0._maxPassOrder
	local var_40_6 = string.format("%s_%s", var_40_3, var_40_4)
	local var_40_7 = arg_40_0._hasPlayRefreshAnimRuleIdMap[var_40_6] ~= nil
	local var_40_8 = var_40_5 and not var_40_7

	var_40_2:Play(var_40_8 and "in" or "idle", 0, 0)

	if var_40_8 then
		arg_40_0._hasPlayRefreshAnimRuleIdMap[var_40_6] = true

		table.insert(arg_40_0._hasPlayRefreshAnimRuleIds, var_40_6)

		arg_40_0._needFocusEscapeRule = true
	end
end

function var_0_0.focusEscapeRules(arg_41_0)
	if arg_41_0._status ~= Act183Enum.EpisodeStatus.Unlocked or not arg_41_0._needFocusEscapeRule then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Act183_RefreshEscapeRule)
	gohelper.setActive(arg_41_0._goescaperulecontainer, true)
	ZProj.UGUIHelper.RebuildLayout(arg_41_0._goescaperules.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_41_0._goescaperulecontainer.transform)
	ZProj.UGUIHelper.RebuildLayout(arg_41_0._goScrollContent.transform)

	local var_41_0 = recthelper.getAnchorY(arg_41_0._goescaperulecontainer.transform) + recthelper.getHeight(arg_41_0._goescaperulecontainer.transform) / 2

	arg_41_0:_scrollDetailToTargetPos(var_41_0)
end

function var_0_0.refreshRepressResult(arg_42_0)
	local var_42_0 = arg_42_0._status == Act183Enum.EpisodeStatus.Finished
	local var_42_1 = arg_42_0._episodeType == Act183Enum.EpisodeType.Sub
	local var_42_2 = Act183Helper.isLastPassEpisodeInType(arg_42_0._episodeMo)
	local var_42_3 = var_42_0 and var_42_1 and not var_42_2

	gohelper.setActive(arg_42_0._gorepressresult, var_42_3)

	if not var_42_3 then
		return
	end

	gohelper.setActive(arg_42_0._gohasrepress, false)
	gohelper.setActive(arg_42_0._gounrepress, true)
	gohelper.CreateObjList(arg_42_0, arg_42_0.refreshSingleRepressResult, arg_42_0._baseRules, arg_42_0._gorepressrules, arg_42_0._gorepressruleitem)
end

function var_0_0.refreshSingleRepressResult(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local var_43_0 = gohelper.findChildText(arg_43_1, "txt_desc")
	local var_43_1 = gohelper.findChildImage(arg_43_1, "image_icon")
	local var_43_2 = gohelper.findChild(arg_43_1, "image_icon/go_disable")
	local var_43_3 = gohelper.findChild(arg_43_1, "image_icon/go_escape")
	local var_43_4 = gohelper.findChild(arg_43_1, "#go_Disable")
	local var_43_5 = arg_43_0._episodeMo:getRuleStatus(arg_43_3) == Act183Enum.RuleStatus.Repress

	var_43_0.text = SkillHelper.buildDesc(arg_43_2)

	SkillHelper.addHyperLinkClick(var_43_0)
	gohelper.setActive(var_43_2, var_43_5)
	gohelper.setActive(var_43_4, var_43_5)
	gohelper.setActive(var_43_3, not var_43_5)
	Act183Helper.setRuleIcon(arg_43_0._episodeId, arg_43_3, var_43_1)

	if var_43_5 then
		local var_43_6 = arg_43_0._episodeMo:getRepressHeroMo():getHeroId()

		if not arg_43_0._repressHeroItem then
			arg_43_0._repressHeroItem = IconMgr.instance:getCommonHeroIconNew(arg_43_0._gorepressheropos)

			arg_43_0._repressHeroItem:isShowLevel(false)
		end

		arg_43_0._repressHeroItem:onUpdateHeroId(var_43_6)
		gohelper.setActive(arg_43_0._gohasrepress, true)
		gohelper.setActive(arg_43_0._gounrepress, false)
	end
end

local var_0_4 = {
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
local var_0_5 = {
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

function var_0_0.refreshBadgeBtn(arg_44_0)
	local var_44_0 = Act183Model.instance:getActInfo()

	arg_44_0._totalBadgeNum = var_44_0 and var_44_0:getBadgeNum() or 0

	local var_44_1 = arg_44_0._totalBadgeNum > 0 and arg_44_0._groupType == Act183Enum.GroupType.NormalMain

	gohelper.setActive(arg_44_0._btnbadge.gameObject, var_44_1)

	if var_44_1 then
		local var_44_2 = var_0_4.Others

		if arg_44_0._isCanRestart then
			var_44_2 = arg_44_0._isCanReRepress and var_0_4.CanRestart_HasRepress or var_0_4.CanRestart_NotRepress
		end

		arg_44_0:refreshBadgeBtnDetail(var_44_2)

		local var_44_3 = arg_44_0:_getBadgeBtnPos()

		recthelper.setAnchor(arg_44_0._btnbadge.transform, var_44_3[1], var_44_3[2])
	end
end

function var_0_0._getBadgeBtnPos(arg_45_0)
	if arg_45_0._isCanRestart then
		if arg_45_0._isCanReRepress then
			return var_0_5.CanRestart_CanRepress
		end

		return var_0_5.CanRestart_NotRepress
	end

	return var_0_5.Start
end

function var_0_0.refreshBadgeBtnDetail(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0._readyUseBadgeNum > 0

	gohelper.setActive(arg_46_0._txtusebadgenum.gameObject, var_46_0)

	arg_46_0._txtusebadgenum.text = arg_46_0._readyUseBadgeNum

	local var_46_1 = var_46_0 and "v2a5_challenge_dungeon_iconbtn2" or "v2a5_challenge_dungeon_iconbtn1"

	UISpriteSetMgr.instance:setChallengeSprite(arg_46_0._imagebadgebtn, var_46_1)

	if arg_46_1 then
		recthelper.setAnchor(arg_46_0._gobadgedetail.transform, arg_46_1[1], arg_46_1[2])
	end
end

function var_0_0.refreshBadgeDetail(arg_47_0)
	local var_47_0 = {}

	for iter_47_0 = 1, arg_47_0._totalBadgeNum do
		local var_47_1 = arg_47_0:_getOrCreateBadgeItem(iter_47_0)
		local var_47_2 = iter_47_0 <= arg_47_0._readyUseBadgeNum

		gohelper.setActive(var_47_1.viewGO, true)

		local var_47_3 = var_47_2 and "v2a5_challenge_badge1" or "v2a5_challenge_badge2"

		UISpriteSetMgr.instance:setChallengeSprite(var_47_1.imageicon, var_47_3)

		var_47_0[var_47_1] = true
	end

	for iter_47_1, iter_47_2 in pairs(arg_47_0._badgeItemTab) do
		if not var_47_0[iter_47_2] then
			gohelper.setActive(iter_47_2.viewGO, false)
		end
	end

	arg_47_0:refreshBadgeBtnDetail()
end

function var_0_0._getOrCreateBadgeItem(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0._badgeItemTab[arg_48_1]

	if not var_48_0 then
		var_48_0 = arg_48_0:getUserDataTb_()
		var_48_0.viewGO = gohelper.cloneInPlace(arg_48_0._gobadgeitem, "badgeitem_" .. arg_48_1)
		var_48_0.imageicon = gohelper.findChildImage(var_48_0.viewGO, "image_icon")
		var_48_0.btnclick = gohelper.findChildButtonWithAudio(var_48_0.viewGO, "btn_click")

		var_48_0.btnclick:AddClickListener(arg_48_0._onClickBadgeItem, arg_48_0, arg_48_1)

		arg_48_0._badgeItemTab[arg_48_1] = var_48_0
	end

	return var_48_0
end

function var_0_0._onClickBadgeItem(arg_49_0, arg_49_1)
	arg_49_0._readyUseBadgeNum = arg_49_1

	arg_49_0:refreshBadgeDetail()
	arg_49_0:refreshBadgeRules(true)
	arg_49_0:refreshRuleContainVisible()
	arg_49_0:focusBageRules()
end

function var_0_0.setBadgeDetailsVisible(arg_50_0, arg_50_1)
	gohelper.setActive(arg_50_0._gobadgedetail, arg_50_1)
	gohelper.setActive(arg_50_0._btnrepress.gameObject, not arg_50_1 and arg_50_0._isCanReRepress)

	if arg_50_1 then
		arg_50_0:refreshBadgeDetail()
	end
end

function var_0_0.releaseBadgeItems(arg_51_0)
	if arg_51_0._badgeItemTab then
		for iter_51_0, iter_51_1 in pairs(arg_51_0._badgeItemTab) do
			iter_51_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.refreshRepressBtn(arg_52_0)
	gohelper.setActive(arg_52_0._btnrepress.gameObject, arg_52_0._isCanReRepress)

	if not arg_52_0._isCanReRepress then
		return
	end

	local var_52_0 = arg_52_0._episodeMo:getRepressHeroMo()
	local var_52_1 = var_52_0 ~= nil

	gohelper.setActive(arg_52_0._gosetrepresshero, var_52_1)

	local var_52_2 = var_52_1 and var_0_2 or var_0_3

	recthelper.setAnchorX(arg_52_0._txtbtnrepress.transform, var_52_2)

	if not var_52_1 then
		return
	end

	local var_52_3 = var_52_0:getHeroIconUrl()

	arg_52_0._simagerepressheroicon:LoadImage(var_52_3)

	local var_52_4 = var_52_0:getHeroCarrer()

	UISpriteSetMgr.instance:setCommonSprite(arg_52_0._imagecareer, "lssx_" .. tostring(var_52_4))
end

function var_0_0.refreshRestartBtnSize(arg_53_0)
	local var_53_0 = arg_53_0:_getRestartBtnPos()

	recthelper.setSize(arg_53_0._btnrestart.transform, var_53_0[3], var_53_0[4])
	recthelper.setAnchor(arg_53_0._btnrestart.transform, var_53_0[1], var_53_0[2])
end

local var_0_6 = {
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

function var_0_0._getRestartBtnPos(arg_54_0)
	if arg_54_0._isCanReRepress then
		return var_0_6.CanRepress
	end

	return var_0_6.NotRepress
end

function var_0_0.onClose(arg_55_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(arg_55_0.switchEpisodeDetail, arg_55_0)
end

function var_0_0.onDestroyView(arg_56_0)
	arg_56_0:releaseBadgeItems()
	arg_56_0:releaseRewardItems()
	arg_56_0._simagerepressheroicon:UnLoadImage()
end

return var_0_0
