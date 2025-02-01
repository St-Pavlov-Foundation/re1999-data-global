module("modules.logic.meilanni.view.MeilanniView", package.seeall)

slot0 = class("MeilanniView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightbg")
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._goeventlist = gohelper.findChild(slot0.viewGO, "#go_eventlist")
	slot0._scrolldialog = gohelper.findChildScrollRect(slot0.viewGO, "top_right/#scroll_dialog")
	slot0._goscrollcontent = gohelper.findChild(slot0.viewGO, "top_right/#scroll_dialog/viewport/#go_scrollcontainer/#go_scrollcontent")
	slot0._goday = gohelper.findChild(slot0.viewGO, "top_right/#go_day")
	slot0._imageweather = gohelper.findChildImage(slot0.viewGO, "top_right/#go_day/#image_weather")
	slot0._imageweather1 = gohelper.findChildImage(slot0.viewGO, "top_right/#go_day/#image_weather1")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "top_right/#go_day/#txt_remaintime")
	slot0._gothreat = gohelper.findChild(slot0.viewGO, "#go_threat")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "#go_threat/root/horizontal/#go_item1")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "#go_threat/root/horizontal/#go_item2")
	slot0._goitem3 = gohelper.findChild(slot0.viewGO, "#go_threat/root/horizontal/#go_item3")
	slot0._goitem4 = gohelper.findChild(slot0.viewGO, "#go_threat/root/horizontal/#go_item4")
	slot0._goitem5 = gohelper.findChild(slot0.viewGO, "#go_threat/root/horizontal/#go_item5")
	slot0._imageenemyicon = gohelper.findChildImage(slot0.viewGO, "#go_threat/root/enemy/#image_enemyicon")
	slot0._btnenemydetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_threat/root/enemy/#btn_enemydetail")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "top_right/#go_day/action/actioncount/stars/#go_star")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")
	slot0._goexhibition = gohelper.findChild(slot0.viewGO, "#go_exhibition")
	slot0._imageexhibitionicon = gohelper.findChildImage(slot0.viewGO, "#go_exhibition/root/exhibition/#image_exhibitionicon")
	slot0._btnexhibitiondetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_exhibition/root/exhibition/#btn_exhibitiondetail")
	slot0._txtexhibitionname = gohelper.findChildText(slot0.viewGO, "#go_exhibition/root/#txt_exhibitionname")
	slot0._simageinfobg1 = gohelper.findChildSingleImage(slot0.viewGO, "top_right/#simage_infobg1")
	slot0._simageinfobg2 = gohelper.findChildSingleImage(slot0.viewGO, "top_right/#simage_infobg2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnenemydetail:AddClickListener(slot0._btnenemydetailOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnexhibitiondetail:AddClickListener(slot0._btnexhibitiondetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnenemydetail:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnexhibitiondetail:RemoveClickListener()
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.MeilanniReset, MsgBoxEnum.BoxType.Yes_No, function ()
		Activity108Rpc.instance:sendResetMapRequest(MeilanniEnum.activityId, uv0._mapId, function ()
			MeilanniController.instance:statEnd(StatEnum.Result.Reset)
			MeilanniController.instance:statStart()
		end)
	end)
end

function slot0._btnexhibitiondetailOnClick(slot0)
	MeilanniController.instance:openMeilanniEntrustView({
		showExhibits = true,
		mapId = slot0._mapId
	})
end

function slot0._btnenemydetailOnClick(slot0)
	MeilanniController.instance:openMeilanniBossInfoView({
		mapId = slot0._mapId
	})
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getMeilanniIcon("heidi_zhehzaoleft"))
	slot0._simagerightbg:LoadImage(ResUrl.getMeilanniIcon("heidi_zhehzaoright"))
	slot0._simageinfobg1:LoadImage(ResUrl.getMeilanniIcon("bg_diban"))
	slot0._simageinfobg2:LoadImage(ResUrl.getMeilanniIcon("bg_diban"))
	gohelper.addUIClickAudio(slot0._btnenemydetail.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(slot0._btnexhibitiondetail.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(slot0._btnreset.gameObject, AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function slot0._checkFinishMapStory(slot0)
	for slot5, slot6 in ipairs(MeilanniConfig.instance:getStoryList(MeilanniEnum.StoryType.finishMap)) do
		if slot6[2] == slot0._mapId and MeilanniModel.instance:getMapHighestScore(slot6[2]) > 0 and not StoryModel.instance:isStoryFinished(slot6[1].story) then
			StoryController.instance:playStory(slot8)

			return true
		end
	end
end

function slot0.onOpen(slot0)
	slot0._mapId = MeilanniModel.instance:getCurMapId()
	slot0._mapInfo = MeilanniModel.instance:getMapInfo(slot0._mapId)
	slot0._actPointItemList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gostar, false)

	slot0._dayAnimator = slot0._goday:GetComponent(typeof(UnityEngine.Animator))

	slot0:_updateInfo()
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, slot0._episodeInfoUpdate, slot0, LuaEventSystem.Low)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.getInfo, slot0._getInfo, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, slot0._resetMap, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.mapFail, slot0._onMapFail, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.mapSuccess, slot0._onMapSuccess, slot0)
	slot0:addEventCb(MeilanniController.instance, MeilanniEvent.updateExcludeRules, slot0._updateExcludeRules, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:_dimBgm(true)
end

function slot0._dimBgm(slot0, slot1)
	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_open)
	else
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_close)
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.MeilanniSettlementView then
		if not slot0:_checkFinishMapStory() then
			slot0:closeThis()
		else
			slot0._waitCloseStoryView = true
		end
	end

	if slot1 == ViewName.StoryView and slot0._waitCloseStoryView then
		slot0:closeThis()
	elseif slot1 == ViewName.MeilanniBossInfoView and slot0._oldThreat then
		TaskDispatcher.runDelay(slot0._closeThreatItemAnim, slot0, 0.8)
	end
end

function slot0._updateExcludeRules(slot0, slot1)
	slot0._oldThreat = slot1[3]

	MeilanniAnimationController.instance:addDelayCall(slot0._openMeilanniBossInfoView, slot0, {
		showExcludeRules = true,
		mapId = slot0._mapId,
		rulesInfo = slot1
	}, MeilanniEnum.showExcludeRulesTime, MeilanniAnimationController.excludeRulesLayer)
end

function slot0._openMeilanniBossInfoView(slot0, slot1)
	MeilanniController.instance:openMeilanniBossInfoView(slot1)
end

function slot0._resetMap(slot0)
	slot0:_updateInfo()
end

function slot0._getInfo(slot0)
	if slot0._mapInfo:checkFinish() then
		MeilanniController.instance:openMeilanniSettlementView(slot0._mapId)
	end
end

function slot0._episodeInfoUpdate(slot0)
	slot0:_updateInfo()
end

function slot0._updateInfo(slot0)
	MeilanniAnimationController.instance:addDelayCall(slot0._changeDay, slot0, nil, MeilanniEnum.changeWeatherTime, MeilanniAnimationController.changeWeatherLayer)

	if MeilanniAnimationController.instance:isPlaying() and slot0:_checkUpdateEnemy() then
		MeilanniAnimationController.instance:addDelayCall(slot0._updateEnemy, slot0, nil, MeilanniEnum.showEnemyTime, MeilanniAnimationController.enemyLayer)
	elseif not slot0._oldThreat then
		slot0:_updateEnemy()
	end
end

function slot0._changeDay(slot0)
	slot0:_updateDayInfo()
	slot0:_updateStars()
	slot0:_updateExhibits()
end

function slot0._updateExhibits(slot0)
	slot2 = slot0._mapInfo:getCurEpisodeInfo().episodeConfig.showExhibits == 1

	gohelper.setActive(slot0._goexhibition, slot2)

	if not slot2 then
		return
	end

	slot0._mapConfig = lua_activity108_map.configDict[slot0._mapId]
	slot0._txtexhibitionname.text = slot0._mapConfig.title

	UISpriteSetMgr.instance:setMeilanniSprite(slot0._imageexhibitionicon, slot0._mapConfig.exhibits)
end

function slot0._updateDayInfo(slot0)
	slot2 = slot0._mapInfo:getCurEpisodeInfo().episodeConfig

	if slot2.mapId <= 102 then
		slot0._txtremaintime.text = formatLuaLang("meilannidialogitem_countdown", MeilanniConfig.instance:getLastEpisode(slot2.mapId).day - slot2.day + 1)
	else
		slot0._txtremaintime.text = formatLuaLang("meilannidialogitem_countdown2", slot2.day)
	end

	if slot0._prevEpisodeConfig == slot2 then
		return
	end

	slot4 = slot2.period == 2

	UISpriteSetMgr.instance:setMeilanniSprite(slot0._imageweather1, slot4 and "icon_ws" or "icon_bt")

	if not slot4 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_noise_exhibition_hall)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	end

	if slot0._prevEpisodeConfig then
		gohelper.setActive(slot0._imageweather, true)
		UISpriteSetMgr.instance:setMeilanniSprite(slot0._imageweather, slot0._prevEpisodeConfig.period == 2 and "icon_ws" or "icon_bt")
		slot0._dayAnimator:Play("switch", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
	else
		gohelper.setActive(slot0._imageweather, false)
	end

	slot0._prevEpisodeConfig = slot2
end

function slot0._updateStars(slot0)
	slot2 = slot0._mapInfo:getCurEpisodeInfo() ~= slot0._curEpisodeInfo
	slot0._curEpisodeInfo = slot1

	for slot7 = 1, slot1.episodeConfig.actpoint do
		slot8 = slot0:_getActItem(slot7)

		gohelper.setActive(slot8.go, true)
		gohelper.setActive(slot8.emptyGo, slot1.leftActPoint < slot7)

		if not (slot7 <= slot1.leftActPoint) then
			slot8.animator:Play(UIAnimationName.Close)
		else
			slot8.animator:Play(UIAnimationName.Idle)
		end
	end

	for slot7 = slot3.actpoint + 1, #slot0._actPointItemList do
		gohelper.setActive(slot0:_getActItem(slot7).go, false)
	end
end

function slot0._getActItem(slot0, slot1)
	if not slot0._actPointItemList[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gostar)
		slot2.animator = slot2.go:GetComponent(typeof(UnityEngine.Animator))
		slot2.fillGo = gohelper.findChild(slot2.go, "fill")

		gohelper.setActive(slot2.fillGo, true)

		slot2.emptyGo = gohelper.findChild(slot2.go, "empty")
		slot0._actPointItemList[slot1] = slot2
	end

	return slot2
end

function slot0._getConfigBattleId(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot6[1] == MeilanniEnum.ElementType.Battle then
			return tonumber(slot6[2])
		end
	end
end

function slot0.getMonsterId(slot0)
	slot3 = nil

	for slot7, slot8 in ipairs(string.splitToNumber(lua_battle.configDict[slot0].monsterGroupIds, "#")) do
		for slot14, slot15 in ipairs(string.splitToNumber(lua_monster_group.configDict[slot8].monster, "#")) do
			slot3 = slot15

			if FightHelper.isBossId(slot9.bossId, slot15) then
				return slot15
			end
		end
	end

	return slot3
end

function slot0._updateEnemy(slot0)
	slot3 = slot0:_getConfigBattleId(GameUtil.splitString2(MeilanniConfig.instance:getLastEvent(slot0._mapId).interactParam, true, "|", "#"))

	if slot0._mapInfo:getCurEpisodeInfo().episodeConfig.showBoss == 1 and slot0._mapInfo.score > 0 and slot4.episodeConfig.day == MeilanniConfig.instance:getLastEpisode(slot0._mapId).day and slot4.isFinish then
		slot5 = false
	end

	gohelper.setActive(slot0._gothreat, slot5)

	if slot5 and slot0._showEmeny == false then
		slot0._gothreat:GetComponent(typeof(UnityEngine.Animator)):Play("open")
	end

	slot0._showEmeny = slot5

	if not slot5 then
		return
	end

	slot0:_showThreatItems(slot5, slot0._mapInfo:getThreat())

	if not uv0.getMonsterId(slot3) then
		return
	end

	gohelper.getSingleImage(slot0._imageenemyicon.gameObject):LoadImage(ResUrl.monsterHeadIcon(lua_monster_skin.configDict[lua_monster.configDict[slot9].skinId].headIcon))
end

function slot0._checkUpdateEnemy(slot0)
	slot3 = slot0:_getConfigBattleId(GameUtil.splitString2(MeilanniConfig.instance:getLastEvent(slot0._mapId).interactParam, true, "|", "#"))

	if not (slot0._mapInfo:getCurEpisodeInfo().episodeConfig.showBoss == 1) then
		return
	end

	if not uv0.getMonsterId(slot3) then
		return
	end

	return not slot0._showEmeny
end

function slot0._showThreatItems(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.MeilanniBossInfoView) then
		return
	end

	for slot6 = 1, MeilanniEnum.threatNum do
		gohelper.setActive(slot0["_goitem" .. slot6], slot6 <= slot2)
	end
end

function slot0._closeThreatItemAnim(slot0)
	slot0._oldThreat = nil

	for slot6 = slot1, slot0._oldThreat or slot0._mapInfo:getThreat() + 1 do
		if slot0["_goitem" .. slot6] then
			gohelper.setActive(slot7, true)

			slot8 = slot7:GetComponent(typeof(UnityEngine.Animator))
			slot8.enabled = true

			slot8:Play("close", 0, 0)
		end
	end
end

function slot0._onMapFail(slot0)
	MeilanniController.instance:statEnd(StatEnum.Result.Fail)
end

function slot0._onMapSuccess(slot0)
	MeilanniController.instance:statEnd(StatEnum.Result.Success)
end

function slot0.onClose(slot0)
	if slot0.viewContainer:isManualClose() then
		MeilanniController.instance:statEnd(StatEnum.Result.Abort)
	end

	TaskDispatcher.cancelTask(slot0._closeThreatItemAnim, slot0)
	slot0:_dimBgm(false)
end

function slot0.onDestroyView(slot0)
	slot0._simagerightbg:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
	slot0._simageinfobg1:UnLoadImage()
	slot0._simageinfobg2:UnLoadImage()
end

return slot0
