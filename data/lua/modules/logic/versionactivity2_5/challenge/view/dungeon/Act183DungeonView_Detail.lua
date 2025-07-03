module("modules.logic.versionactivity2_5.challenge.view.dungeon.Act183DungeonView_Detail", package.seeall)

local var_0_0 = class("Act183DungeonView_Detail", BaseView)
local var_0_1 = 0.1

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
	arg_1_0._goleadertips = gohelper.findChild(arg_1_0.viewGO, "root/right/#go_detail/#go_LeaderTips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosedetail:AddClickListener(arg_2_0._btnclosedetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosedetail:RemoveClickListener()
end

function var_0_0._btnclosedetailOnClick(arg_4_0)
	arg_4_0:setDetailVisible(false)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(Act183Controller.instance, Act183Event.OnClickEpisode, arg_5_0._onClickEpisode, arg_5_0)
	arg_5_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateRepressInfo, arg_5_0._onUpdateRepressInfo, arg_5_0)
	arg_5_0:addEventCb(Act183Controller.instance, Act183Event.OnUpdateGroupInfo, arg_5_0._onUpdateGroupInfo, arg_5_0)

	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0.viewGO, gohelper.Type_Animator)
	arg_5_0._compMgr = MonoHelper.addLuaComOnceToGo(arg_5_0._godetail, Act183DungeonCompMgr)

	arg_5_0._compMgr:addComp(arg_5_0._godetail, Act183DungeonDescComp, true)
	arg_5_0._compMgr:addComp(arg_5_0._goconditions, Act183DungeonConditionComp, true)
	arg_5_0._compMgr:addComp(arg_5_0._gobaserulecontainer, Act183DungeonBaseAndBadgeRuleComp, true)
	arg_5_0._compMgr:addComp(arg_5_0._gorewardcontainer, Act183DungeonRewardRuleComp, true)
	arg_5_0._compMgr:addComp(arg_5_0._goescaperulecontainer, Act183DungeonEscapeRuleComp, true)
	arg_5_0._compMgr:addComp(arg_5_0._gorepressresult, Act183DungeonRepressResultComp, true)
	arg_5_0._compMgr:addComp(arg_5_0._btnstart.gameObject, Act183DungeonStartBtnComp, true)
	arg_5_0._compMgr:addComp(arg_5_0._gobadgedetail, Act183DungeonSelectBadgeComp, true)
	arg_5_0._compMgr:addComp(arg_5_0._btnrepress.gameObject, Act183DungeonRepressBtnComp, false)
	arg_5_0._compMgr:addComp(arg_5_0._btnrestart.gameObject, Act183DungeonRestartBtnComp, false)
	arg_5_0._compMgr:addComp(arg_5_0._btnresetepisode.gameObject, Act183DungeonResetBtnComp, false)
	arg_5_0._compMgr:addComp(arg_5_0._golock, Act183DungeonLockBtnComp, false)
	arg_5_0._compMgr:addComp(arg_5_0._btnbadge.gameObject, Act183DungeonBadgeBtnComp, false)
	arg_5_0._compMgr:addComp(arg_5_0._goleadertips, Act183DungeonTeamLeaderTipsComp, false)
	arg_5_0:setDetailVisible(false)
end

function var_0_0._onClickEpisode(arg_6_0, arg_6_1)
	if not arg_6_1 then
		return
	end

	if arg_6_0._expand and arg_6_0._episodeId ~= arg_6_1 then
		arg_6_0._animator:Play("rightswitch", 0, 0)
	end

	arg_6_0._nextEpisodeMo = Act183Model.instance:getEpisodeMoById(arg_6_1)

	if not arg_6_0._nextEpisodeMo then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(arg_6_0.switchEpisodeDetail, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.switchEpisodeDetail, arg_6_0, var_0_1)
end

function var_0_0.switchEpisodeDetail(arg_7_0)
	arg_7_0:refreshEpisodeDetail(arg_7_0._nextEpisodeMo)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
end

function var_0_0._onUpdateRepressInfo(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._expand or arg_8_0._episodeId ~= arg_8_1 then
		return
	end

	arg_8_0:refreshEpisodeDetail(arg_8_2)
end

function var_0_0._onUpdateGroupInfo(arg_9_0)
	if not arg_9_0._expand or not arg_9_0._episodeId then
		return
	end

	local var_9_0 = Act183Model.instance:getEpisodeMoById(arg_9_0._episodeId)

	arg_9_0:refreshEpisodeDetail(var_9_0)
end

function var_0_0.refreshEpisodeDetail(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 ~= nil

	arg_10_0:setDetailVisible(var_10_0)

	if not var_10_0 then
		return
	end

	arg_10_0._episodeId = arg_10_1:getEpisodeId()

	arg_10_0._compMgr:onUpdateMO(arg_10_1)
end

function var_0_0.setDetailVisible(arg_11_0, arg_11_1)
	if arg_11_0._expand and not arg_11_1 then
		arg_11_0._animator:Play("rightclose", 0, 0)
	elseif not arg_11_0._expand and arg_11_1 then
		arg_11_0._animator:Play("rightopen", 0, 0)
	end

	arg_11_0._expand = arg_11_1

	gohelper.setActive(arg_11_0._godetail, arg_11_0._expand)
	gohelper.setActive(arg_11_0._btnclosedetail.gameObject, arg_11_0._expand)

	if not arg_11_1 then
		arg_11_0._episodeId = nil
	end
end

function var_0_0.onClose(arg_12_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Act183DungeonView_Detail_SwitchEpisode")
	TaskDispatcher.cancelTask(arg_12_0.switchEpisodeDetail, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
