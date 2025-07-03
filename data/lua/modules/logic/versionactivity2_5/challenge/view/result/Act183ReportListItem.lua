module("modules.logic.versionactivity2_5.challenge.view.result.Act183ReportListItem", package.seeall)

local var_0_0 = class("Act183ReportListItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_time")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_time/#txt_time")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._gohard = gohelper.findChild(arg_1_0.viewGO, "#go_hard")
	arg_1_0._goepisodes = gohelper.findChild(arg_1_0.viewGO, "#go_episodes")
	arg_1_0._goepisodeitem = gohelper.findChild(arg_1_0.viewGO, "#go_episodes/#go_episodeitem")
	arg_1_0._goherogroup = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item2")
	arg_1_0._goitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item3")
	arg_1_0._goitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item4")
	arg_1_0._goitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_item5")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "#go_herogroup/#go_heroitem")
	arg_1_0._imagebossicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_boss/#image_bossicon")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_detail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
end

function var_0_0._btndetailOnClick(arg_4_0)
	local var_4_0 = Act183ReportListModel.instance:getActivityId()
	local var_4_1 = {
		activityId = var_4_0,
		groupRecordMo = arg_4_0._mo
	}

	Act183Controller.instance:openAct183SettlementView(var_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._heroItemTab = arg_5_0:getUserDataTb_()
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._txttime.text = TimeUtil.timestampToString(arg_8_0._mo:getFinishedTime() / 1000)
	arg_8_0._type = arg_8_0._mo:getGroupType()

	gohelper.setActive(arg_8_0._gonormal, arg_8_0._type == Act183Enum.GroupType.NormalMain)
	gohelper.setActive(arg_8_0._gohard, arg_8_0._type == Act183Enum.GroupType.HardMain)

	local var_8_0 = arg_8_0._mo:getEpusideListByTypeAndPassOrder(Act183Enum.EpisodeType.Sub)

	gohelper.CreateObjList(arg_8_0, arg_8_0.refreshSingleSubEpisodeItem, var_8_0 or {}, arg_8_0._goepisodes, arg_8_0._goepisodeitem)

	local var_8_1 = arg_8_0._mo:getBossEpisode()
	local var_8_2 = var_8_1 and var_8_1:getEpisodeId()

	Act183Helper.setEpisodeReportIcon(var_8_2, arg_8_0._imagebossicon)
	arg_8_0:refreshBossEpisodeHeros()
end

function var_0_0.refreshSingleSubEpisodeItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2:getEpisodeId()
	local var_9_1 = arg_9_2:getPassOrder()
	local var_9_2 = gohelper.findChildImage(arg_9_1, "image_index")
	local var_9_3 = gohelper.findChildImage(arg_9_1, "image_icon")

	UISpriteSetMgr.instance:setChallengeSprite(var_9_2, "v2a5_challenge_result_level_" .. var_9_1)
	Act183Helper.setEpisodeReportIcon(var_9_0, var_9_3)
end

function var_0_0.refreshBossEpisodeHeros(arg_10_0)
	local var_10_0 = arg_10_0._mo:getEpisodeListByType(Act183Enum.EpisodeType.Boss)
	local var_10_1 = var_10_0 and var_10_0[1]

	if not var_10_1 then
		return
	end

	local var_10_2 = var_10_1:getHeroMos()

	for iter_10_0 = 1, Act183Enum.BossEpisodeMaxHeroNum do
		local var_10_3 = arg_10_0:_getOrCreateHeroItem(iter_10_0)
		local var_10_4 = var_10_2 and var_10_2[iter_10_0]
		local var_10_5 = var_10_4 ~= nil

		gohelper.setActive(var_10_3.viewGO, true)
		gohelper.setActive(var_10_3.gohas, var_10_5)
		gohelper.setActive(var_10_3.goempty, not var_10_5)

		if var_10_5 then
			local var_10_6 = var_10_4:getHeroIconUrl()

			var_10_3.simageheroicon:LoadImage(var_10_6)
		end
	end
end

function var_0_0._getOrCreateHeroItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._heroItemTab[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()

		local var_11_1 = arg_11_0["_goitem" .. arg_11_1]

		if gohelper.isNil(var_11_1) then
			logError("缺少挂点 : " .. arg_11_1)
		end

		var_11_0.viewGO = gohelper.clone(arg_11_0._goheroitem, var_11_1, "hero")
		var_11_0.gohas = gohelper.findChild(var_11_0.viewGO, "go_has")
		var_11_0.goempty = gohelper.findChild(var_11_0.viewGO, "go_empty")
		var_11_0.simageheroicon = gohelper.findChildSingleImage(var_11_0.viewGO, "go_has/bg/simage_heroicon")
		arg_11_0._heroItemTab[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.releaseAllHeroItems(arg_12_0)
	if arg_12_0._heroItemTab then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._heroItemTab) do
			iter_12_1.simageheroicon:UnLoadImage()
		end
	end
end

function var_0_0.onSelect(arg_13_0, arg_13_1)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0:releaseAllHeroItems()
end

return var_0_0
