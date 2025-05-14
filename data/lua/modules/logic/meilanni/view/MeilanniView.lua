module("modules.logic.meilanni.view.MeilanniView", package.seeall)

local var_0_0 = class("MeilanniView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goeventlist = gohelper.findChild(arg_1_0.viewGO, "#go_eventlist")
	arg_1_0._scrolldialog = gohelper.findChildScrollRect(arg_1_0.viewGO, "top_right/#scroll_dialog")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer/#go_scrollcontent")
	arg_1_0._goday = gohelper.findChild(arg_1_0.viewGO, "top_right/#go_day")
	arg_1_0._imageweather = gohelper.findChildImage(arg_1_0.viewGO, "top_right/#go_day/#image_weather")
	arg_1_0._imageweather1 = gohelper.findChildImage(arg_1_0.viewGO, "top_right/#go_day/#image_weather1")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "top_right/#go_day/#txt_remaintime")
	arg_1_0._gothreat = gohelper.findChild(arg_1_0.viewGO, "#go_threat")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "#go_threat/root/horizontal/#go_item1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_threat/root/horizontal/#go_item2")
	arg_1_0._goitem3 = gohelper.findChild(arg_1_0.viewGO, "#go_threat/root/horizontal/#go_item3")
	arg_1_0._goitem4 = gohelper.findChild(arg_1_0.viewGO, "#go_threat/root/horizontal/#go_item4")
	arg_1_0._goitem5 = gohelper.findChild(arg_1_0.viewGO, "#go_threat/root/horizontal/#go_item5")
	arg_1_0._imageenemyicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_threat/root/enemy/#image_enemyicon")
	arg_1_0._btnenemydetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_threat/root/enemy/#btn_enemydetail")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "top_right/#go_day/action/actioncount/stars/#go_star")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")
	arg_1_0._goexhibition = gohelper.findChild(arg_1_0.viewGO, "#go_exhibition")
	arg_1_0._imageexhibitionicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_exhibition/root/exhibition/#image_exhibitionicon")
	arg_1_0._btnexhibitiondetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_exhibition/root/exhibition/#btn_exhibitiondetail")
	arg_1_0._txtexhibitionname = gohelper.findChildText(arg_1_0.viewGO, "#go_exhibition/root/#txt_exhibitionname")
	arg_1_0._simageinfobg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "top_right/#simage_infobg1")
	arg_1_0._simageinfobg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "top_right/#simage_infobg2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnenemydetail:AddClickListener(arg_2_0._btnenemydetailOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnexhibitiondetail:AddClickListener(arg_2_0._btnexhibitiondetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnenemydetail:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnexhibitiondetail:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MeilanniReset, MsgBoxEnum.BoxType.Yes_No, function()
		Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, arg_4_0._mapId, function()
			MeilanniController.instance:statEnd(StatEnum.Result.Reset)
			MeilanniController.instance:statStart()
		end)
	end)
end

function var_0_0._btnexhibitiondetailOnClick(arg_7_0)
	MeilanniController.instance:openMeilanniEntrustView({
		showExhibits = true,
		mapId = arg_7_0._mapId
	})
end

function var_0_0._btnenemydetailOnClick(arg_8_0)
	MeilanniController.instance:openMeilanniBossInfoView({
		mapId = arg_8_0._mapId
	})
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._simageleftbg:LoadImage(ResUrl.getMeilanniIcon("heidi_zhehzaoleft"))
	arg_9_0._simagerightbg:LoadImage(ResUrl.getMeilanniIcon("heidi_zhehzaoright"))
	arg_9_0._simageinfobg1:LoadImage(ResUrl.getMeilanniIcon("bg_diban"))
	arg_9_0._simageinfobg2:LoadImage(ResUrl.getMeilanniIcon("bg_diban"))
	gohelper.addUIClickAudio(arg_9_0._btnenemydetail.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(arg_9_0._btnexhibitiondetail.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(arg_9_0._btnreset.gameObject, AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function var_0_0._checkFinishMapStory(arg_10_0)
	local var_10_0 = MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.finishMap)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1[2] == arg_10_0._mapId and MeilanniModel.instance:getMapHighestScore(iter_10_1[2]) > 0 then
			local var_10_1 = iter_10_1[1].story

			if not StoryModel.instance:isStoryFinished(var_10_1) then
				StoryController.instance:playStory(var_10_1)

				return true
			end
		end
	end
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._mapId = MeilanniModel.instance:getCurMapId()
	arg_11_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_11_0._mapId)
	arg_11_0._actPointItemList = arg_11_0:getUserDataTb_()

	gohelper.setActive(arg_11_0._gostar, false)

	arg_11_0._dayAnimator = arg_11_0._goday:GetComponent(typeof(UnityEngine.Animator))

	arg_11_0:_updateInfo()
	arg_11_0:addEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, arg_11_0._episodeInfoUpdate, arg_11_0, LuaEventSystem.Low)
	arg_11_0:addEventCb(MeilanniController.instance, MeilanniEvent.getInfo, arg_11_0._getInfo, arg_11_0)
	arg_11_0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, arg_11_0._resetMap, arg_11_0)
	arg_11_0:addEventCb(MeilanniController.instance, MeilanniEvent.mapFail, arg_11_0._onMapFail, arg_11_0)
	arg_11_0:addEventCb(MeilanniController.instance, MeilanniEvent.mapSuccess, arg_11_0._onMapSuccess, arg_11_0)
	arg_11_0:addEventCb(MeilanniController.instance, MeilanniEvent.updateExcludeRules, arg_11_0._updateExcludeRules, arg_11_0, LuaEventSystem.Low)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_11_0._onCloseViewFinish, arg_11_0)
	arg_11_0:_dimBgm(true)
end

function var_0_0._dimBgm(arg_12_0, arg_12_1)
	if arg_12_1 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_open)
	else
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_close)
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.MeilanniSettlementView then
		if not arg_13_0:_checkFinishMapStory() then
			arg_13_0:closeThis()
		else
			arg_13_0._waitCloseStoryView = true
		end
	end

	if arg_13_1 == ViewName.StoryView and arg_13_0._waitCloseStoryView then
		arg_13_0:closeThis()
	elseif arg_13_1 == ViewName.MeilanniBossInfoView and arg_13_0._oldThreat then
		TaskDispatcher.runDelay(arg_13_0._closeThreatItemAnim, arg_13_0, 0.8)
	end
end

function var_0_0._updateExcludeRules(arg_14_0, arg_14_1)
	arg_14_0._oldThreat = arg_14_1[3]

	MeilanniAnimationController.instance:addDelayCall(arg_14_0._openMeilanniBossInfoView, arg_14_0, {
		showExcludeRules = true,
		mapId = arg_14_0._mapId,
		rulesInfo = arg_14_1
	}, MeilanniEnum.showExcludeRulesTime, MeilanniAnimationController.excludeRulesLayer)
end

function var_0_0._openMeilanniBossInfoView(arg_15_0, arg_15_1)
	MeilanniController.instance:openMeilanniBossInfoView(arg_15_1)
end

function var_0_0._resetMap(arg_16_0)
	arg_16_0:_updateInfo()
end

function var_0_0._getInfo(arg_17_0)
	if arg_17_0._mapInfo:checkFinish() then
		MeilanniController.instance:openMeilanniSettlementView(arg_17_0._mapId)
	end
end

function var_0_0._episodeInfoUpdate(arg_18_0)
	arg_18_0:_updateInfo()
end

function var_0_0._updateInfo(arg_19_0)
	MeilanniAnimationController.instance:addDelayCall(arg_19_0._changeDay, arg_19_0, nil, MeilanniEnum.changeWeatherTime, MeilanniAnimationController.changeWeatherLayer)

	if MeilanniAnimationController.instance:isPlaying() and arg_19_0:_checkUpdateEnemy() then
		MeilanniAnimationController.instance:addDelayCall(arg_19_0._updateEnemy, arg_19_0, nil, MeilanniEnum.showEnemyTime, MeilanniAnimationController.enemyLayer)
	elseif not arg_19_0._oldThreat then
		arg_19_0:_updateEnemy()
	end
end

function var_0_0._changeDay(arg_20_0)
	arg_20_0:_updateDayInfo()
	arg_20_0:_updateStars()
	arg_20_0:_updateExhibits()
end

function var_0_0._updateExhibits(arg_21_0)
	local var_21_0 = arg_21_0._mapInfo:getCurEpisodeInfo().episodeConfig.showExhibits == 1

	gohelper.setActive(arg_21_0._goexhibition, var_21_0)

	if not var_21_0 then
		return
	end

	arg_21_0._mapConfig = lua_activity108_map.configDict[arg_21_0._mapId]
	arg_21_0._txtexhibitionname.text = arg_21_0._mapConfig.title

	UISpriteSetMgr.instance:setMeilanniSprite(arg_21_0._imageexhibitionicon, arg_21_0._mapConfig.exhibits)
end

function var_0_0._updateDayInfo(arg_22_0)
	local var_22_0 = arg_22_0._mapInfo:getCurEpisodeInfo().episodeConfig
	local var_22_1 = MeilanniConfig.instance:getLastEpisode(var_22_0.mapId)

	if var_22_0.mapId <= 102 then
		arg_22_0._txtremaintime.text = formatLuaLang("meilannidialogitem_countdown", var_22_1.day - var_22_0.day + 1)
	else
		arg_22_0._txtremaintime.text = formatLuaLang("meilannidialogitem_countdown2", var_22_0.day)
	end

	if arg_22_0._prevEpisodeConfig == var_22_0 then
		return
	end

	local var_22_2 = var_22_0.period == 2

	UISpriteSetMgr.instance:setMeilanniSprite(arg_22_0._imageweather1, var_22_2 and "icon_ws" or "icon_bt")

	if not var_22_2 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_noise_exhibition_hall)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if arg_22_0._prevEpisodeConfig then
		gohelper.setActive(arg_22_0._imageweather, true)
		UISpriteSetMgr.instance:setMeilanniSprite(arg_22_0._imageweather, arg_22_0._prevEpisodeConfig.period == 2 and "icon_ws" or "icon_bt")
		arg_22_0._dayAnimator:Play("switch", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
	else
		gohelper.setActive(arg_22_0._imageweather, false)
	end

	arg_22_0._prevEpisodeConfig = var_22_0
end

function var_0_0._updateStars(arg_23_0)
	local var_23_0 = arg_23_0._mapInfo:getCurEpisodeInfo()
	local var_23_1

	var_23_1 = var_23_0 ~= arg_23_0._curEpisodeInfo
	arg_23_0._curEpisodeInfo = var_23_0

	local var_23_2 = var_23_0.episodeConfig

	for iter_23_0 = 1, var_23_2.actpoint do
		local var_23_3 = arg_23_0:_getActItem(iter_23_0)

		gohelper.setActive(var_23_3.go, true)
		gohelper.setActive(var_23_3.emptyGo, iter_23_0 > var_23_0.leftActPoint)

		if not (iter_23_0 <= var_23_0.leftActPoint) then
			var_23_3.animator:Play(UIAnimationName.Close)
		else
			var_23_3.animator:Play(UIAnimationName.Idle)
		end
	end

	for iter_23_1 = var_23_2.actpoint + 1, #arg_23_0._actPointItemList do
		local var_23_4 = arg_23_0:_getActItem(iter_23_1)

		gohelper.setActive(var_23_4.go, false)
	end
end

function var_0_0._getActItem(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._actPointItemList[arg_24_1]

	if not var_24_0 then
		var_24_0 = arg_24_0:getUserDataTb_()
		var_24_0.go = gohelper.cloneInPlace(arg_24_0._gostar)
		var_24_0.animator = var_24_0.go:GetComponent(typeof(UnityEngine.Animator))
		var_24_0.fillGo = gohelper.findChild(var_24_0.go, "fill")

		gohelper.setActive(var_24_0.fillGo, true)

		var_24_0.emptyGo = gohelper.findChild(var_24_0.go, "empty")
		arg_24_0._actPointItemList[arg_24_1] = var_24_0
	end

	return var_24_0
end

function var_0_0._getConfigBattleId(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		if iter_25_1[1] == MeilanniEnum.ElementType.Battle then
			local var_25_0 = iter_25_1[2]

			return tonumber(var_25_0)
		end
	end
end

function var_0_0.getMonsterId(arg_26_0)
	local var_26_0 = lua_battle.configDict[arg_26_0]
	local var_26_1 = string.splitToNumber(var_26_0.monsterGroupIds, "#")
	local var_26_2

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		local var_26_3 = lua_monster_group.configDict[iter_26_1]
		local var_26_4 = string.splitToNumber(var_26_3.monster, "#")

		for iter_26_2, iter_26_3 in ipairs(var_26_4) do
			var_26_2 = iter_26_3

			if FightHelper.isBossId(var_26_3.bossId, iter_26_3) then
				return iter_26_3
			end
		end
	end

	return var_26_2
end

function var_0_0._updateEnemy(arg_27_0)
	local var_27_0 = MeilanniConfig.instance:getLastEvent(arg_27_0._mapId)
	local var_27_1 = GameUtil.splitString2(var_27_0.interactParam, true, "|", "#")
	local var_27_2 = arg_27_0:_getConfigBattleId(var_27_1)
	local var_27_3 = arg_27_0._mapInfo:getCurEpisodeInfo()
	local var_27_4 = var_27_3.episodeConfig.showBoss == 1
	local var_27_5 = MeilanniConfig.instance:getLastEpisode(arg_27_0._mapId)
	local var_27_6 = var_27_3.episodeConfig

	if var_27_4 and arg_27_0._mapInfo.score > 0 and var_27_6.day == var_27_5.day and var_27_3.isFinish then
		var_27_4 = false
	end

	gohelper.setActive(arg_27_0._gothreat, var_27_4)

	if var_27_4 and arg_27_0._showEmeny == false then
		arg_27_0._gothreat:GetComponent(typeof(UnityEngine.Animator)):Play("open")
	end

	arg_27_0._showEmeny = var_27_4

	if not var_27_4 then
		return
	end

	local var_27_7 = arg_27_0._mapInfo:getThreat()

	arg_27_0:_showThreatItems(var_27_4, var_27_7)

	local var_27_8 = var_0_0.getMonsterId(var_27_2)

	if not var_27_8 then
		return
	end

	local var_27_9 = lua_monster.configDict[var_27_8]
	local var_27_10 = lua_monster_skin.configDict[var_27_9.skinId]

	gohelper.getSingleImage(arg_27_0._imageenemyicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_27_10.headIcon))
end

function var_0_0._checkUpdateEnemy(arg_28_0)
	local var_28_0 = MeilanniConfig.instance:getLastEvent(arg_28_0._mapId)
	local var_28_1 = GameUtil.splitString2(var_28_0.interactParam, true, "|", "#")
	local var_28_2 = arg_28_0:_getConfigBattleId(var_28_1)

	if not (arg_28_0._mapInfo:getCurEpisodeInfo().episodeConfig.showBoss == 1) then
		return
	end

	if not var_0_0.getMonsterId(var_28_2) then
		return
	end

	return not arg_28_0._showEmeny
end

function var_0_0._showThreatItems(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_1 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.MeilanniBossInfoView) then
		return
	end

	for iter_29_0 = 1, MeilanniEnum.threatNum do
		local var_29_0 = arg_29_0["_goitem" .. iter_29_0]

		gohelper.setActive(var_29_0, iter_29_0 <= arg_29_2)
	end
end

function var_0_0._closeThreatItemAnim(arg_30_0)
	local var_30_0 = arg_30_0._mapInfo:getThreat() + 1
	local var_30_1 = arg_30_0._oldThreat or var_30_0

	arg_30_0._oldThreat = nil

	for iter_30_0 = var_30_0, var_30_1 do
		local var_30_2 = arg_30_0["_goitem" .. iter_30_0]

		if var_30_2 then
			gohelper.setActive(var_30_2, true)

			local var_30_3 = var_30_2:GetComponent(typeof(UnityEngine.Animator))

			var_30_3.enabled = true

			var_30_3:Play("close", 0, 0)
		end
	end
end

function var_0_0._onMapFail(arg_31_0)
	MeilanniController.instance:statEnd(StatEnum.Result.Fail)
end

function var_0_0._onMapSuccess(arg_32_0)
	MeilanniController.instance:statEnd(StatEnum.Result.Success)
end

function var_0_0.onClose(arg_33_0)
	if arg_33_0.viewContainer:isManualClose() then
		MeilanniController.instance:statEnd(StatEnum.Result.Abort)
	end

	TaskDispatcher.cancelTask(arg_33_0._closeThreatItemAnim, arg_33_0)
	arg_33_0:_dimBgm(false)
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simagerightbg:UnLoadImage()
	arg_34_0._simageleftbg:UnLoadImage()
	arg_34_0._simageinfobg1:UnLoadImage()
	arg_34_0._simageinfobg2:UnLoadImage()
end

return var_0_0
