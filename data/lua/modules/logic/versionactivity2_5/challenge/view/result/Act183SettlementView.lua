module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementView", package.seeall)

local var_0_0 = class("Act183SettlementView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonormalbg = gohelper.findChild(arg_1_0.viewGO, "root/bg")
	arg_1_0._gohardbg = gohelper.findChild(arg_1_0.viewGO, "root/hardbg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._scrollbadge = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/left/#scroll_badge")
	arg_1_0._goepisodeitem = gohelper.findChild(arg_1_0.viewGO, "root/left/#scroll_badge/Viewport/Content/#go_episodeitem")
	arg_1_0._simageplayericon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/left/player/icon/#simage_playericon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/left/player/#txt_name")
	arg_1_0._txtdate = gohelper.findChildText(arg_1_0.viewGO, "root/left/player/#txt_date")
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

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = gohelper.cloneInPlace(arg_9_0._goepisodeitem, "episode_" .. iter_9_0)
		local var_9_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_9_1, Act183SettlementSubEpisodeItem)

		var_9_2:setHeroTemplate(arg_9_0._goheroitem)
		var_9_2:onUpdateMO(arg_9_0._groupRecordMo, iter_9_1)
	end
end

function var_0_0.refreshBossEpisodeItem(arg_10_0)
	local var_10_0 = arg_10_0._groupRecordMo:getEpisodeListByType(Act183Enum.EpisodeType.Boss)
	local var_10_1 = var_10_0 and var_10_0[1]
	local var_10_2 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0.viewGO, Act183SettlementBossEpisodeItem)

	var_10_2:setHeroTemplate(arg_10_0._goheroitem)
	var_10_2:onUpdateMO(arg_10_0._groupRecordMo, var_10_1)
end

function var_0_0.refreshPlayerInfo(arg_11_0)
	arg_11_0._txtname.text = arg_11_0._groupRecordMo:getUserName()
	arg_11_0._portraitId = arg_11_0._groupRecordMo:getPortrait()

	if not arg_11_0._liveHeadIcon then
		arg_11_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_11_0._simageplayericon)
	end

	arg_11_0._liveHeadIcon:setLiveHead(arg_11_0._portraitId)

	arg_11_0._txtdate.text = TimeUtil.timestampToString(arg_11_0._groupRecordMo:getFinishedTime() / 1000)
end

function var_0_0.refreshOtherInfo(arg_12_0)
	local var_12_0 = arg_12_0._groupRecordMo:getGroupType()

	gohelper.setActive(arg_12_0._gohardbg, var_12_0 == Act183Enum.GroupType.HardMain)
	gohelper.setActive(arg_12_0._gonormalbg, var_12_0 ~= Act183Enum.GroupType.HardMain)
end

function var_0_0.releaseAllSingleImage(arg_13_0)
	if arg_13_0._heroIconTab then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._heroIconTab) do
			iter_13_0:UnLoadImage()
		end
	end
end

function var_0_0.onClose(arg_14_0)
	arg_14_0:releaseAllSingleImage()
	arg_14_0._simageplayericon:UnLoadImage()
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
