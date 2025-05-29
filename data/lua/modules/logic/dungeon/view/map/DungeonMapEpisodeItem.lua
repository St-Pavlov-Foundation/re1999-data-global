module("modules.logic.dungeon.view.map.DungeonMapEpisodeItem", package.seeall)

local var_0_0 = class("DungeonMapEpisodeItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscale = gohelper.findChild(arg_1_0.viewGO, "#go_scale")
	arg_1_0._gostar = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_star")
	arg_1_0._imagemapstate = gohelper.findChildImage(arg_1_0.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate")
	arg_1_0._gomapstatescale = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale")
	arg_1_0._imagemapbeselectedbg = gohelper.findChildImage(arg_1_0.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale/#image_mapbeselectedbg")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_scale/#go_gray/#go_star/#image_mapstate/#go_mapstatescale/#btn_click")
	arg_1_0._txtsection = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#go_gray/#txt_section")
	arg_1_0._txtsectionname = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#go_gray/#txt_sectionname")
	arg_1_0._gotipcontent = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#txt_sectionname/#go_tipcontent")
	arg_1_0._gotipitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#txt_sectionname/#go_tipcontent/#go_tipitem")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#go_gray/#txt_sectionname/#txt_nameen")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_flag")
	arg_1_0._gofall = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_fall")
	arg_1_0._gofallbg = gohelper.findChild(arg_1_0._gofall, "#go_fallbg")
	arg_1_0._simagefall = gohelper.findChildSingleImage(arg_1_0._gofall, "#go_fallbg/#simage_fall")
	arg_1_0._goraycast = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_raycast")
	arg_1_0._gomaxpos = gohelper.findChild(arg_1_0.viewGO, "#go_maxpos")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#txt_time")
	arg_1_0._txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "#txt_locktips")
	arg_1_0._imagesuo = gohelper.findChildImage(arg_1_0.viewGO, "#txt_locktips/#image_suo")
	arg_1_0._gobeselected = gohelper.findChild(arg_1_0.viewGO, "#go_beselected")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_lock")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	arg_1_0._gosimplestarbg = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_star/#go_atorystarbg")
	arg_1_0._gonormalstarbg = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_star/#go_normalstarbg")
	arg_1_0._gohardstarbg = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_star/#go_hardstarbg")
	arg_1_0._gogray = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray")
	arg_1_0._goboss = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_boss")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_boss/#go_normaleye")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_gray/#go_boss/#go_hardeye")
	arg_1_0._imagedecorate = gohelper.findChildImage(arg_1_0.viewGO, "#go_scale/#go_gray/#image_decorate")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._onRefreshActivityState, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0._onRefreshActivityState, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	return
end

function var_0_0._changeMap(arg_5_0)
	if not arg_5_0._mapIsUnlock then
		return
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeMap, {
		arg_5_0._map,
		arg_5_0._config
	})
end

function var_0_0._btnraycastOnClick(arg_6_0)
	return
end

function var_0_0.showUnlockAnim(arg_7_0)
	if not arg_7_0._unlockAnimation then
		arg_7_0._unlockAnimation = arg_7_0._goscale:GetComponent(typeof(UnityEngine.Animation))
	end

	arg_7_0._unlockAnimation:Play()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_deblockingmap)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._click = gohelper.getClickWithAudio(arg_8_0._goraycast, AudioEnum.UI.play_ui_checkpoint_pagesopen)
	arg_8_0._lockClick = gohelper.getClick(gohelper.findChild(arg_8_0._golock, "raycast"))
	arg_8_0.elementItemList = {}

	arg_8_0:_initStar()
	arg_8_0:onUpdateParam()
	arg_8_0:calcPosInContent()

	arg_8_0._init = true

	gohelper.setActive(arg_8_0._gonormaleye, true)
	gohelper.setActive(arg_8_0._gohardeye, false)
	gohelper.setActive(arg_8_0._gotipitem, false)
end

function var_0_0.calcPosInContent(arg_9_0)
	recthelper.setAnchorX(arg_9_0._gomaxpos.transform, arg_9_0._maxWidth)

	arg_9_0.scrollVisiblePosX = -recthelper.rectToRelativeAnchorPos(arg_9_0._gomaxpos.transform.position, arg_9_0._contentTransform).x
	arg_9_0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(arg_9_0.viewGO.transform.position, arg_9_0._contentTransform).x
end

function var_0_0.getEpisodeId(arg_10_0)
	return arg_10_0._config.id
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0._config = arg_11_0.viewParam[1]
	arg_11_0._info = arg_11_0.viewParam[2]
	arg_11_0._levelIndex = arg_11_0.viewParam[4]
	arg_11_0._contentTransform = arg_11_0.viewParam[3]

	local var_11_0 = SLFramework.UGUI.GuiHelper.GetPreferredWidth(arg_11_0._txtsectionname, arg_11_0._config.name)

	arg_11_0._txtsection.text = string.format("%02d", arg_11_0._levelIndex)
	arg_11_0._txtsectionname.text = arg_11_0._config.name
	arg_11_0._txtnameen.text = arg_11_0._config.name_En

	if LangSettings.instance:isJp() and arg_11_0._txtnameen.text == "Aleph" then
		arg_11_0._txtnameen.text = ""
	end

	local var_11_1 = arg_11_0._config.chainEpisode

	if var_11_1 ~= 0 then
		gohelper.setActive(arg_11_0._goflag, not DungeonModel.instance:hasPassLevelAndStory(var_11_1))
	else
		gohelper.setActive(arg_11_0._goflag, not DungeonModel.instance:hasPassLevelAndStory(arg_11_0._config.id))
	end

	local var_11_2 = DungeonConfig.instance:getChapterCO(arg_11_0._config.chapterId)

	arg_11_0:_updateLock()
	arg_11_0:_showMap()

	local var_11_3 = arg_11_0:refreshLockTip()
	local var_11_4 = DungeonModel.instance:chapterListIsResType(var_11_2.type)

	arg_11_0._isResourceTypeLock = var_11_4 and var_11_3

	arg_11_0:_refreshUI(var_11_4, var_11_3)
	arg_11_0:showStatus()
	arg_11_0:_showAllElementTipView()
	arg_11_0:refreshV1a7Fall()

	if DungeonModel.isBattleEpisode(arg_11_0._config) and var_11_2.type == DungeonEnum.ChapterType.Normal then
		local var_11_5 = string.splitToNumber(arg_11_0._config.icon, "#")
		local var_11_6 = var_11_5[1]
		local var_11_7 = var_11_5[2]
		local var_11_8
		local var_11_9

		if var_11_6 and var_11_7 then
			local var_11_10

			var_11_10, var_11_9 = ItemModel.instance:getItemConfigAndIcon(var_11_6, var_11_7)
		end

		gohelper.setActive(arg_11_0._gofallbg, true)
		arg_11_0:setFallIconPos(GameUtil.utf8len(arg_11_0._config.name))

		if not string.nilorempty(var_11_9) then
			arg_11_0._simagefall:LoadImage(var_11_9)
		end
	end

	if not arg_11_0._maxWidth then
		arg_11_0._maxWidth = recthelper.getAnchorX(arg_11_0._txtsectionname.transform) + arg_11_0._txtsectionname.preferredWidth + 30
	end

	local var_11_11 = recthelper.getWidth(arg_11_0._goraycast.transform)
	local var_11_12 = recthelper.getWidth(arg_11_0._simagefall.transform)

	if arg_11_0._gofallbg.activeInHierarchy then
		if var_11_11 < var_11_0 + var_11_12 then
			recthelper.setWidth(arg_11_0._goraycast.transform, var_11_0 + var_11_12)
		end
	elseif var_11_11 < var_11_0 then
		recthelper.setWidth(arg_11_0._goraycast.transform, var_11_0)
	end
end

function var_0_0.refreshLockTip(arg_12_0)
	local var_12_0 = arg_12_0:hasUnlockContent()

	if var_12_0 then
		arg_12_0:_showUnlockContent()
		arg_12_0:_showBeUnlockEpisode()

		local var_12_1 = arg_12_0.hasUnlockContentText or arg_12_0.hasUnlockEpisodeText

		gohelper.setActive(arg_12_0._txtlocktips.gameObject, var_12_1)
		gohelper.setActive(arg_12_0._txttime.gameObject, not var_12_1)
	else
		gohelper.setActive(arg_12_0._txtlocktips.gameObject, false)
		gohelper.setActive(arg_12_0._txttime.gameObject, true)
	end

	return var_12_0
end

function var_0_0.initV1a7Node(arg_13_0)
	arg_13_0.goV1a7Fall = arg_13_0.goV1a7Fall or gohelper.findChild(arg_13_0._gofall, "#go_v1a7fallbg")
	arg_13_0.simageV1a7Icon = arg_13_0.simageV1a7Icon or gohelper.findChildSingleImage(arg_13_0._gofall, "#go_v1a7fallbg/#simage_fall")
	arg_13_0.txtV1a7Time = arg_13_0.txtV1a7Time or gohelper.findChildTextMesh(arg_13_0._gofall, "#go_v1a7fallbg/#txt_time")
end

function var_0_0.refreshV1a7Fall(arg_14_0)
	gohelper.setActive(arg_14_0.goV1a7Fall, false)

	do return end

	TaskDispatcher.cancelTask(arg_14_0.refreshV1a7Fall, arg_14_0)

	local var_14_0 = arg_14_0:_getDropActId()

	if not var_14_0 then
		gohelper.setActive(arg_14_0.goV1a7Fall, false)

		return
	end

	local var_14_1 = string.splitToNumber(arg_14_0._config.cost, "#")[3]

	if not var_14_1 or var_14_1 <= 0 then
		gohelper.setActive(arg_14_0.goV1a7Fall, false)

		return
	end

	arg_14_0:initV1a7Node()
	gohelper.setActive(arg_14_0.goV1a7Fall, true)
	TaskDispatcher.runDelay(arg_14_0.refreshV1a7Fall, arg_14_0, TimeUtil.OneMinuteSecond)

	local var_14_2 = ActivityModel.instance:getActMO(var_14_0)

	if var_14_2 then
		local var_14_3 = var_14_2:getRealEndTimeStamp() - ServerTime.now()
		local var_14_4, var_14_5 = TimeUtil.secondToRoughTime(var_14_3, true)

		arg_14_0.txtV1a7Time.text = string.format(var_14_4 .. var_14_5)
	end

	local var_14_6, var_14_7 = CommonConfig.instance:getAct155EpisodeDisplay()
	local var_14_8, var_14_9 = ItemModel.instance:getItemConfigAndIcon(var_14_6, var_14_7)

	if not string.nilorempty(var_14_9) then
		arg_14_0.simageV1a7Icon:LoadImage(var_14_9)
	end
end

function var_0_0._getDropActId(arg_15_0)
	local var_15_0 = arg_15_0._config.chapterId

	for iter_15_0, iter_15_1 in ipairs(lua_activity155_drop.configList) do
		if var_15_0 == iter_15_1.chapterId then
			local var_15_1 = iter_15_1.activityId

			if ActivityHelper.getActivityStatus(var_15_1, true) == ActivityEnum.ActivityStatus.Normal then
				return var_15_1
			end
		end
	end
end

function var_0_0._showAllElementTipView(arg_16_0)
	if not arg_16_0._map then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	local var_16_0 = arg_16_0._config.chainEpisode ~= 0 and arg_16_0._config.chainEpisode or arg_16_0._config.id

	arg_16_0._pass = DungeonModel.instance:hasPassLevelAndStory(var_16_0)

	local var_16_1 = arg_16_0._map.id
	local var_16_2 = DungeonConfig.instance:getMapElements(var_16_1)

	if not var_16_2 or #var_16_2 < 1 then
		gohelper.setActive(arg_16_0._gotipcontent, false)

		arg_16_0._showAllElementTip = false
	else
		local var_16_3 = 0
		local var_16_4

		for iter_16_0, iter_16_1 in ipairs(var_16_2) do
			if DungeonMapModel.instance:elementIsFinished(iter_16_1.id) then
				var_16_3 = var_16_3 + 1
			end

			if ToughBattleConfig.instance:isActEleCo(iter_16_1) then
				var_16_4 = iter_16_1
			end
		end

		if var_16_4 then
			var_16_2 = tabletool.copy(var_16_2)

			tabletool.removeValue(var_16_2, var_16_4)
		end

		local var_16_5

		for iter_16_2, iter_16_3 in ipairs(var_16_2) do
			local var_16_6 = arg_16_0.elementItemList[iter_16_2]

			if not var_16_6 then
				var_16_6 = arg_16_0:getUserDataTb_()
				var_16_6.go = gohelper.cloneInPlace(arg_16_0._gotipitem)
				var_16_6.goNotFinish = gohelper.findChild(var_16_6.go, "type1")
				var_16_6.goFinish = gohelper.findChild(var_16_6.go, "type2")
				var_16_6.animator = var_16_6.go:GetComponent(typeof(UnityEngine.Animator))
				var_16_6.status = nil

				table.insert(arg_16_0.elementItemList, var_16_6)
			end

			gohelper.setActive(var_16_6.go, true)

			local var_16_7 = arg_16_0._pass and iter_16_2 <= var_16_3

			gohelper.setActive(var_16_6.goNotFinish, not var_16_7)
			gohelper.setActive(var_16_6.goFinish, var_16_7)

			if var_16_6.status == false and var_16_7 then
				gohelper.setActive(var_16_6.goNotFinish, true)
				var_16_6.animator:Play("switch", 0, 0)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			end

			var_16_6.status = var_16_7
		end

		local var_16_8 = arg_16_0._showAllElementTip

		arg_16_0._showAllElementTip = arg_16_0._pass and var_16_3 ~= #var_16_2

		if var_16_8 and not arg_16_0._showAllElementTip then
			TaskDispatcher.cancelTask(arg_16_0._hideAllElementTip, arg_16_0)
			TaskDispatcher.runDelay(arg_16_0._hideAllElementTip, arg_16_0, 0.8)
		else
			gohelper.setActive(arg_16_0._gotipcontent, arg_16_0._showAllElementTip)
		end
	end
end

function var_0_0._hideAllElementTip(arg_17_0)
	gohelper.setActive(arg_17_0._gotipcontent, false)

	if arg_17_0._tweenId then
		ZProj.TweenHelper.KillById(arg_17_0._tweenId)

		arg_17_0._tweenId = nil
	end

	local var_17_0 = arg_17_0:_getFallIconTargetPos(GameUtil.utf8len(arg_17_0._config.name))

	if var_17_0 then
		arg_17_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_17_0._gofall.transform, var_17_0, 0.26, arg_17_0._tweenEnd, arg_17_0)
	else
		arg_17_0:_tweenEnd()
	end
end

function var_0_0._tweenEnd(arg_18_0)
	arg_18_0:setFallIconPos(GameUtil.utf8len(arg_18_0._config.name))
end

function var_0_0._getElementTipWidth(arg_19_0, arg_19_1)
	if arg_19_0._map then
		local var_19_0 = DungeonConfig.instance:getMapElements(arg_19_0._map.id)

		if arg_19_0._showAllElementTip then
			if arg_19_1 > 3 then
				return 20 * #var_19_0 + 2 * (#var_19_0 - 1) - 12
			elseif #var_19_0 < 3 then
				return 43
			else
				return 20 * #var_19_0 + 2 * (#var_19_0 - 1) - 12
			end
		end
	end

	return 0
end

function var_0_0._refreshUI(arg_20_0, arg_20_1, arg_20_2)
	UISpriteSetMgr.instance:setUiFBSprite(arg_20_0._imagesuo, arg_20_1 and arg_20_2 and "bg_suo_fuben" or "bg_kaisuo_fuben", true)
	SLFramework.UGUI.GuiHelper.SetColor(arg_20_0._txtlocktips, arg_20_1 and arg_20_2 and "#A64B47" or "#D88147")
	UISpriteSetMgr.instance:setUiFBSprite(arg_20_0._imagedecorate, arg_20_1 and arg_20_2 and "bg_fenge" or "zhangjiefenge_005")
	ZProj.UGUIHelper.SetColorAlpha(arg_20_0._txtsection, arg_20_1 and arg_20_2 and 0.65 or 1)
	ZProj.UGUIHelper.SetColorAlpha(arg_20_0._txtsectionname, arg_20_1 and arg_20_2 and 0.65 or 1)
end

function var_0_0._updateLock(arg_21_0)
	local var_21_0 = not DungeonModel.instance:isFinishElementList(arg_21_0._config)
	local var_21_1 = arg_21_0._isLock

	if var_21_0 ~= var_21_1 then
		var_21_1 = nil
	end

	arg_21_0:_updateInteractiveProgress()

	if var_21_1 == false then
		return
	end

	local var_21_2 = arg_21_0._isLock

	arg_21_0._isLock = not DungeonModel.instance:isFinishElementList(arg_21_0._config)

	if var_21_2 and not arg_21_0._isLock then
		local var_21_3 = arg_21_0._golock:GetComponent(typeof(UnityEngine.Animator))

		if var_21_3 then
			var_21_3.enabled = true
		end

		local var_21_4 = gohelper.findChild(arg_21_0._golock, "raycast")

		gohelper.setActive(var_21_4, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	else
		gohelper.setActive(arg_21_0._golock, arg_21_0._isLock)
	end

	if not arg_21_0._graphics then
		local var_21_5 = arg_21_0._gogray:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic))

		arg_21_0._graphics = arg_21_0:getUserDataTb_()

		local var_21_6 = var_21_5:GetEnumerator()

		while var_21_6:MoveNext() do
			table.insert(arg_21_0._graphics, var_21_6.Current.gameObject)
		end
	end

	if arg_21_0._graphics then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._graphics) do
			ZProj.UGUIHelper.SetGrayscale(iter_21_1, arg_21_0._isLock)
		end
	end
end

function var_0_0._updateInteractiveProgress(arg_22_0)
	return
end

function var_0_0._updateProgressUI(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._progressItemTab = arg_23_0._progressItemTab or arg_23_0:getUserDataTb_()

	for iter_23_0 = 1, #arg_23_1 do
		local var_23_0 = arg_23_0._progressItemTab[iter_23_0]

		if not var_23_0 then
			var_23_0 = gohelper.cloneInPlace(arg_23_0._goprogressitem, "progress_" .. iter_23_0)

			table.insert(arg_23_0._progressItemTab, var_23_0)
		end

		local var_23_1 = arg_23_1[iter_23_0]

		gohelper.setActive(var_23_0, var_23_1)

		if var_23_1 then
			local var_23_2 = iter_23_0 <= arg_23_2

			gohelper.setActive(gohelper.findChild(var_23_0, "finish"), var_23_2)
			gohelper.setActive(gohelper.findChild(var_23_0, "unfinish"), not var_23_2)
		end
	end

	local var_23_3 = #arg_23_0._progressItemTab

	if arg_23_0._progressItemTab and var_23_3 > #arg_23_1 then
		for iter_23_1 = #arg_23_1 + 1, var_23_3 do
			gohelper.setActive(arg_23_0._progressItemTab[iter_23_1], false)
		end
	end
end

function var_0_0.isLock(arg_24_0)
	return arg_24_0._isLock
end

function var_0_0.getMap(arg_25_0)
	if not arg_25_0 then
		return nil
	end

	local var_25_0 = arg_25_0.preEpisode

	if var_25_0 > 0 and DungeonConfig.instance:getEpisodeCO(var_25_0).chapterId ~= arg_25_0.chapterId then
		var_25_0 = 0
	end

	return (DungeonConfig.instance:getChapterMapCfg(arg_25_0.chapterId, var_25_0))
end

function var_0_0._showMap(arg_26_0)
	arg_26_0._map = var_0_0.getMap(arg_26_0._config)

	local var_26_0 = arg_26_0._mapIsUnlock

	arg_26_0._mapIsUnlock = arg_26_0._map and DungeonMapModel.instance:mapIsUnlock(arg_26_0._map.id)

	if arg_26_0._init and not var_26_0 and arg_26_0._mapIsUnlock and not arg_26_0._isLock then
		arg_26_0:_changeMap()
	end

	if not arg_26_0._mapIsUnlock then
		arg_26_0._txttime.text = ""

		gohelper.setActive(arg_26_0._imagemapstate.gameObject, false)

		return
	end

	arg_26_0._txttime.text = arg_26_0._map.desc

	arg_26_0:_updateMapElementState()
end

function var_0_0._updateMapElementState(arg_27_0)
	local var_27_0 = DungeonMapModel.instance:getElements(arg_27_0._map.id)

	arg_27_0.unfinishedMap = false

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		if iter_27_1.hidden == 0 then
			arg_27_0.unfinishedMap = true

			break
		end
	end

	gohelper.setActive(arg_27_0._imagemapstate.gameObject, false)
end

function var_0_0._initStar(arg_28_0)
	gohelper.setActive(arg_28_0._gostar, true)

	arg_28_0._starImgList = arg_28_0:getUserDataTb_()

	table.insert(arg_28_0._starImgList, gohelper.findChildImage(arg_28_0._gosimplestarbg, "0"))
	table.insert(arg_28_0._starImgList, gohelper.findChildImage(arg_28_0._gonormalstarbg, "1"))
	table.insert(arg_28_0._starImgList, gohelper.findChildImage(arg_28_0._gonormalstarbg, "2"))
	table.insert(arg_28_0._starImgList, gohelper.findChildImage(arg_28_0._gohardstarbg, "3"))
	table.insert(arg_28_0._starImgList, gohelper.findChildImage(arg_28_0._gohardstarbg, "4"))
end

function var_0_0.showStatus(arg_29_0)
	local var_29_0 = arg_29_0._config.id
	local var_29_1 = DungeonModel.instance:isOpenHardDungeon(arg_29_0._config.chapterId)
	local var_29_2 = var_29_0 and DungeonModel.instance:hasPassLevelAndStory(var_29_0)
	local var_29_3 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_29_0)
	local var_29_4 = arg_29_0._info
	local var_29_5 = DungeonConfig.instance:getHardEpisode(arg_29_0._config.id)
	local var_29_6 = var_29_5 and DungeonModel.instance:getEpisodeInfo(var_29_5.id)
	local var_29_7 = arg_29_0._starImgList[5]
	local var_29_8 = arg_29_0._starImgList[4]
	local var_29_9 = arg_29_0._starImgList[3]

	arg_29_0:_setStar(arg_29_0._starImgList[2], var_29_4.star >= DungeonEnum.StarType.Normal and var_29_2, 1)
	gohelper.setActive(var_29_9, false)
	gohelper.setActive(var_29_8, false)
	gohelper.setActive(var_29_7, false)
	gohelper.setActive(arg_29_0._gonormalstarbg, true)
	gohelper.setActive(arg_29_0._gohardstarbg, false)

	arg_29_0.starNum2 = nil
	arg_29_0.starNum3 = nil
	arg_29_0.starNum4 = nil

	gohelper.setActive(arg_29_0._goboss, arg_29_0._config.displayMark == 1)

	if not string.nilorempty(var_29_3) then
		local var_29_10 = var_29_4.star >= DungeonEnum.StarType.Advanced and var_29_2

		arg_29_0.starNum2 = var_29_10

		arg_29_0:_setStar(var_29_9, var_29_10, 2)
		gohelper.setActive(var_29_9.gameObject, true)

		if var_29_6 and var_29_4.star >= DungeonEnum.StarType.Advanced and var_29_1 and var_29_2 then
			local var_29_11 = var_29_6.star >= DungeonEnum.StarType.Normal

			arg_29_0.starNum3 = var_29_11

			arg_29_0:_setStar(var_29_8, var_29_11, 3)
			gohelper.setActive(var_29_8.gameObject, true)

			arg_29_0.starNum4 = var_29_6.star >= DungeonEnum.StarType.Advanced

			arg_29_0:_setStar(var_29_7, arg_29_0.starNum4, 4)
			gohelper.setActive(var_29_7.gameObject, true)
			gohelper.setActive(arg_29_0._gohardstarbg, true)
		end
	end

	local var_29_12 = DungeonConfig.instance:getSimpleEpisode(arg_29_0._config)

	gohelper.setActive(arg_29_0._gosimplestarbg, var_29_12)

	if var_29_12 then
		if DungeonModel.instance:hasPassLevelAndStory(var_29_12.id) then
			SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._starImgList[1], "#efb974")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._starImgList[1], "#87898C")
		end
	end
end

function var_0_0._setHardModeState(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1.index
	local var_30_1 = arg_30_1.isHardMode

	if arg_30_0._levelIndex == var_30_0 then
		gohelper.setActive(arg_30_0._gonormaleye, not var_30_1)
		gohelper.setActive(arg_30_0._gohardeye, var_30_1)
	end
end

function var_0_0._setStar(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	if arg_31_0._isResourceTypeLock then
		SLFramework.UGUI.GuiHelper.SetColor(arg_31_1, "#e5e5e5")
		ZProj.UGUIHelper.SetColorAlpha(arg_31_1, 0.75)
	else
		if arg_31_2 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_31_1, arg_31_3 < 3 and "#F77040" or "#FF4343")
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_31_1, "#87898C")
		end

		ZProj.UGUIHelper.SetColorAlpha(arg_31_1, 1)
	end
end

function var_0_0._onLockClickHandler(arg_32_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
	DungeonController.instance:openDungeonMapTaskView({
		viewParam = arg_32_0._config.preEpisode
	})
end

function var_0_0.onClickHandler(arg_33_0)
	arg_33_0:_onClickHandler()
end

function var_0_0._onClickHandler(arg_34_0)
	if arg_34_0._isLock then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) and arg_34_0._isSelected then
		return
	end

	if not DungeonModel.isBattleEpisode(arg_34_0._config) then
		local var_34_0 = DungeonModel.instance:getCantChallengeToast(arg_34_0._config)

		if var_34_0 then
			GameFacade.showToast(ToastEnum.CantChallengeToast, var_34_0)

			return
		end
	end

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, arg_34_0)

	if not ViewMgr.instance:isOpen(ViewName.DungeonChangeMapStatusView) then
		arg_34_0:_showMapLevelView(true)
	else
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, arg_34_0)
	end
end

function var_0_0._showMapLevelView(arg_35_0, arg_35_1)
	DungeonController.instance:enterLevelView(arg_35_0.viewParam)

	if arg_35_1 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, arg_35_0)
	end
end

function var_0_0.setFallIconPos(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:_getFallIconTargetPos(arg_36_1)

	if var_36_0 then
		recthelper.setAnchorX(arg_36_0._gofall.transform, var_36_0)
	end

	local var_36_1 = recthelper.getAnchorX(arg_36_0._gofall.transform)
	local var_36_2 = 0
	local var_36_3 = arg_36_0:_getElementTipWidth(arg_36_1)

	if arg_36_0.goV1a7Fall and arg_36_0.goV1a7Fall.activeSelf then
		var_36_2 = var_36_2 + recthelper.getWidth(arg_36_0.goV1a7Fall.transform)
	end

	if arg_36_0._gofallbg.activeSelf then
		var_36_2 = var_36_2 + recthelper.getWidth(arg_36_0._gofallbg.transform)
	end

	arg_36_0._maxWidth = var_36_1 + var_36_2 + var_36_3
end

function var_0_0._getFallIconTargetPos(arg_37_0, arg_37_1)
	if arg_37_1 >= 4 then
		local var_37_0 = arg_37_0._txtsectionname.preferredWidth

		return recthelper.getAnchorX(arg_37_0._txtsectionname.transform) + var_37_0 + 70 + arg_37_0:_getElementTipWidth(arg_37_1)
	end
end

function var_0_0.getMaxWidth(arg_38_0)
	return arg_38_0._maxWidth
end

function var_0_0.hasUnlockContent(arg_39_0)
	local var_39_0 = OpenConfig.instance:getOpenShowInEpisode(arg_39_0._config.id)
	local var_39_1 = DungeonConfig.instance:getUnlockEpisodeList(arg_39_0._config.id)
	local var_39_2 = OpenConfig.instance:getOpenGroupShowInEpisode(arg_39_0._config.id)
	local var_39_3 = (var_39_0 or var_39_1 or var_39_2) and not DungeonModel.instance:hasPassLevelAndStory(arg_39_0._config.id)
	local var_39_4 = arg_39_0._config.unlockEpisode > 0 and not DungeonModel.instance:hasPassLevelAndStory(arg_39_0._config.unlockEpisode)

	return var_39_3 or var_39_4
end

function var_0_0._showUnlockContent(arg_40_0)
	local var_40_0 = DungeonModel.instance:getUnlockContentList(arg_40_0._config.id)

	for iter_40_0, iter_40_1 in ipairs(var_40_0) do
		UISpriteSetMgr.instance:setUiFBSprite(arg_40_0._imagesuo, "unlock", true)

		arg_40_0._txtlocktips.text = iter_40_1
		arg_40_0.hasUnlockContentText = true

		return
	end

	arg_40_0.hasUnlockContentText = false
end

function var_0_0._showBeUnlockEpisode(arg_41_0)
	if arg_41_0._config.unlockEpisode <= 0 or DungeonModel.instance:hasPassLevelAndStory(arg_41_0._config.unlockEpisode) then
		arg_41_0.hasUnlockEpisodeText = false

		return
	end

	UISpriteSetMgr.instance:setUiFBSprite(arg_41_0._imagesuo, "lock", true)

	local var_41_0 = DungeonModel.instance:getChallengeUnlockText(arg_41_0._config)

	if arg_41_0._config.unlockEpisode == 9999 then
		var_41_0 = var_41_0 or luaLang("level_limit_4RD_unlock")
	end

	if string.nilorempty(var_41_0) then
		arg_41_0.hasUnlockEpisodeText = false
		arg_41_0._txtlocktips.text = ""

		return
	end

	arg_41_0.hasUnlockEpisodeText = true
	arg_41_0._txtlocktips.text = formatLuaLang("dungeon_unlock_episode_mode", var_41_0)
end

function var_0_0.onOpen(arg_42_0)
	arg_42_0._click:AddClickListener(arg_42_0._onClickHandler, arg_42_0)
	arg_42_0._lockClick:AddClickListener(arg_42_0._onLockClickHandler, arg_42_0)
	arg_42_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeFocusEpisodeItem, arg_42_0._onChangeFocusEpisodeItem, arg_42_0)
	arg_42_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_42_0._OnUpdateMapElementState, arg_42_0)
	arg_42_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_42_0._beginShowRewardView, arg_42_0)
	arg_42_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_42_0._endShowRewardView, arg_42_0)
	arg_42_0:addEventCb(DungeonController.instance, DungeonEvent.SwitchHardMode, arg_42_0._setHardModeState, arg_42_0)
	arg_42_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_42_0._onCloseView, arg_42_0)
	arg_42_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_42_0._onCloseViewFinish, arg_42_0)
end

function var_0_0._OnChangeMap(arg_43_0, arg_43_1)
	return
end

function var_0_0._beginShowRewardView(arg_44_0)
	arg_44_0._showRewardView = true
end

function var_0_0._endShowRewardView(arg_45_0)
	arg_45_0._showRewardView = false

	arg_45_0:_showAllElementTipView()

	local var_45_0 = arg_45_0._isLock
	local var_45_1 = not DungeonModel.instance:isFinishElementList(arg_45_0._config)

	if var_45_0 and not var_45_1 then
		arg_45_0._startBlock = true

		UIBlockMgr.instance:endAll()
		UIBlockMgrExtend.setNeedCircleMv(false)
		UIBlockMgr.instance:startBlock("DungeonMapEpisodeItem showUnlock")
		TaskDispatcher.runDelay(arg_45_0._moveEpisode, arg_45_0, DungeonEnum.MoveEpisodeTimeAfterShowReward)
		TaskDispatcher.runDelay(arg_45_0._updateLock, arg_45_0, DungeonEnum.UpdateLockTimeAfterShowReward)
		TaskDispatcher.runDelay(arg_45_0._changeEpisodeMap, arg_45_0, DungeonEnum.UpdateLockTimeAfterShowReward)

		return
	end

	arg_45_0:_updateInteractiveProgress()
end

function var_0_0._moveEpisode(arg_46_0)
	DungeonMapModel.instance.focusEpisodeTweenDuration = 0.8

	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickFocusEpisode, arg_46_0)
end

function var_0_0._changeEpisodeMap(arg_47_0)
	arg_47_0._startBlock = false

	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("DungeonMapEpisodeItem showUnlock")
end

function var_0_0._OnUpdateMapElementState(arg_48_0, arg_48_1)
	if arg_48_1 == arg_48_0._map.id then
		arg_48_0:_updateMapElementState()
	end

	if not arg_48_0._showRewardView then
		arg_48_0:_updateLock()
	end
end

function var_0_0._onChangeFocusEpisodeItem(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_1.viewGO
	local var_49_1 = arg_49_0._isSelected

	arg_49_0._isSelected = var_49_0 == arg_49_0.viewGO

	if arg_49_0._isSelected then
		if not var_49_1 then
			arg_49_0:_changeMap()
		end

		gohelper.setActive(arg_49_0._gobeselected, true)
		arg_49_0._animator:Play(UIAnimationName.Selected)
	else
		gohelper.setActive(arg_49_0._gobeselected, false)

		if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
			arg_49_0:_setUnselectedState(arg_49_1)
		else
			arg_49_0:_resetUnselectedState()
		end
	end
end

function var_0_0._onCloseView(arg_50_0, arg_50_1)
	if arg_50_1 == ViewName.DungeonMapLevelView and not arg_50_0._isSelected then
		arg_50_0:_resetUnselectedState()

		return
	end

	if arg_50_1 == ViewName.DungeonChangeMapStatusView and arg_50_0._needShowMapLevelView then
		arg_50_0:_showMapLevelView()
	end
end

function var_0_0._onCloseViewFinish(arg_51_0, arg_51_1)
	return
end

function var_0_0._setUnselectedState(arg_52_0, arg_52_1)
	local var_52_0 = false

	if arg_52_1._info.star == DungeonEnum.StarType.Advanced then
		local var_52_1 = DungeonConfig.instance:getHardEpisode(arg_52_1._config.id)
		local var_52_2 = DungeonModel.instance:isOpenHardDungeon(arg_52_0._config.chapterId)
		local var_52_3

		var_52_3 = var_52_1 ~= nil and var_52_2
	end

	local var_52_4 = true

	if var_52_4 then
		arg_52_0._animator:Play("notselected")

		arg_52_0._resetName = "restore"

		return
	end

	arg_52_0._animator:Play("right")

	arg_52_0._resetName = "right_reset"
end

function var_0_0._resetUnselectedState(arg_53_0)
	arg_53_0._animator:Play(arg_53_0._resetName or "restore")
end

function var_0_0.getIndex(arg_54_0)
	return arg_54_0._levelIndex
end

function var_0_0.onClose(arg_55_0)
	arg_55_0._click:RemoveClickListener()
	arg_55_0._lockClick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_55_0._moveEpisode, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._updateLock, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._changeEpisodeMap, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._hideAllElementTip, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0.refreshV1a7Fall, arg_55_0)

	if arg_55_0._startBlock then
		arg_55_0._startBlock = false

		UIBlockMgr.instance:endBlock("DungeonMapEpisodeItem showUnlock")
	end
end

function var_0_0._onRefreshActivityState(arg_56_0, arg_56_1)
	arg_56_0:refreshLockTip()
	arg_56_0:refreshV1a7Fall()
end

function var_0_0.onDestroyView(arg_57_0)
	if arg_57_0._graphics then
		for iter_57_0, iter_57_1 in ipairs(arg_57_0._graphics) do
			ZProj.UGUIHelper.DisableGrayKey(iter_57_1)
		end
	end

	if arg_57_0._tweenId then
		ZProj.TweenHelper.KillById(arg_57_0._tweenId)

		arg_57_0._tweenId = nil
	end

	if arg_57_0.simageV1a7Icon then
		arg_57_0.simageV1a7Icon:UnLoadImage()
	end
end

return var_0_0
