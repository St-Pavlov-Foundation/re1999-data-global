module("modules.logic.versionactivity1_3.versionactivity1_3dungeonbase.view.VersionActivity1_3DungeonBaseEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonBaseEpisodeItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscale = gohelper.findChild(arg_1_0.viewGO, "#go_scale")
	arg_1_0._txtsection = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/section/#txt_section")
	arg_1_0._gostaricon = gohelper.findChild(arg_1_0.viewGO, "#go_scale/star/#go_staricon")
	arg_1_0._txtsectionname = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname")
	arg_1_0._gotipcontent = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent")
	arg_1_0._gotipitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent/#go_tipitem")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_flag")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#image_normal")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#image_hard")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	arg_1_0._goraycast = gohelper.findChild(arg_1_0.viewGO, "#go_raycast")
	arg_1_0._goclickarea = gohelper.findChild(arg_1_0.viewGO, "#go_clickarea")
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_beselected")
	arg_1_0.txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "#txt_locktips")
	arg_1_0.imagesuo = gohelper.findChildImage(arg_1_0.viewGO, "#txt_locktips/#image_suo")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClick(arg_4_0)
	local var_4_0 = ViewMgr.instance:getContainer(ViewName.VersionActivity1_3DungeonMapLevelView)

	if var_4_0 then
		var_4_0:stopCloseViewTask()

		if arg_4_0._layout.selectedEpisodeItem == arg_4_0 then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)

			return
		end
	end

	if arg_4_0:isLock() then
		ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
		DungeonController.instance:openDungeonMapTaskView({
			viewParam = arg_4_0._config.preEpisode
		})

		return
	end

	arg_4_0.activityDungeonMo:changeEpisode(arg_4_0:getEpisodeId())
	arg_4_0._mapSceneView:refreshMap()
	arg_4_0._layout:updateFocusStatus(arg_4_0)
	arg_4_0._layout:setFocusEpisodeItem(arg_4_0, true)

	if GamepadController.instance:isOpen() then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, arg_4_0)
	end

	arg_4_0._needShowMapLevelView = true

	if arg_4_0:_promptlyShow() then
		arg_4_0:_showMapLevelView()
	else
		ViewMgr.instance:closeView(ViewName.VersionActivity1_3DungeonMapLevelView)
	end
end

function var_0_0.isLock(arg_5_0)
	return not DungeonModel.instance:isFinishElementList(arg_5_0._config)
end

function var_0_0._promptlyShow(arg_6_0)
	return true
end

function var_0_0._showMapLevelView(arg_7_0)
	arg_7_0._needShowMapLevelView = false

	ViewMgr.instance:openView(ViewName.VersionActivity1_3DungeonMapLevelView, {
		episodeId = arg_7_0._config.id
	})
	arg_7_0._layout:setSelectEpisodeItem(arg_7_0)
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.setActive(arg_8_0._gostaricon, false)
	gohelper.setActive(arg_8_0._goflag, false)
	gohelper.setActive(arg_8_0._gotipitem, false)
	gohelper.setActive(arg_8_0._gonormaleye, false)
	gohelper.setActive(arg_8_0._gohardeye, false)

	arg_8_0.starItemList = {}
	arg_8_0.elementItemList = {}

	table.insert(arg_8_0.starItemList, arg_8_0:createStarItem(arg_8_0._gostaricon))

	arg_8_0.animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0.goClick = gohelper.getClick(arg_8_0._goclickarea)

	arg_8_0.goClick:AddClickListener(arg_8_0.onClick, arg_8_0)
end

function var_0_0._showEye(arg_9_0)
	if not (arg_9_0._config.displayMark == 1) then
		gohelper.setActive(arg_9_0._gonormaleye, false)
		gohelper.setActive(arg_9_0._gohardeye, false)

		return
	end

	local var_9_0 = arg_9_0._config.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard

	gohelper.setActive(arg_9_0._gonormaleye, not var_9_0)
	gohelper.setActive(arg_9_0._gohardeye, var_9_0)
end

function var_0_0.initViewParam(arg_10_0)
	arg_10_0._contentTransform = arg_10_0.viewParam[1]
	arg_10_0._layout = arg_10_0.viewParam[2]
	arg_10_0._mapSceneView = arg_10_0.viewContainer.mapScene
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0:initViewParam()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_12_0.refreshElements, arg_12_0)
	arg_12_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_12_0._endShowRewardView, arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_12_0._onCloseViewFinish, arg_12_0)
	arg_12_0:initViewParam()
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1)
	return
end

function var_0_0.getMapAllElementList(arg_14_0)
	local var_14_0 = arg_14_0._map.id
	local var_14_1 = DungeonConfig.instance:getMapElements(var_14_0)

	if not var_14_1 then
		return
	end

	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1.type ~= DungeonEnum.ElementType.DailyEpisode then
			table.insert(var_14_2, iter_14_1)
		end
	end

	return var_14_2
end

function var_0_0._showAllElementTipView(arg_15_0)
	if not arg_15_0._map then
		gohelper.setActive(arg_15_0._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	arg_15_0._pass = DungeonModel.instance:hasPassLevelAndStory(arg_15_0._config.id)

	local var_15_0 = arg_15_0:getMapAllElementList()

	if not var_15_0 or #var_15_0 < 1 then
		gohelper.setActive(arg_15_0._gotipcontent, false)

		arg_15_0._showAllElementTip = false
	else
		local var_15_1 = 0

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if DungeonMapModel.instance:elementIsFinished(iter_15_1.id) then
				var_15_1 = var_15_1 + 1
			end
		end

		local var_15_2

		for iter_15_2, iter_15_3 in ipairs(var_15_0) do
			local var_15_3 = arg_15_0.elementItemList[iter_15_2]

			if not var_15_3 then
				var_15_3 = arg_15_0:getUserDataTb_()
				var_15_3.go = gohelper.cloneInPlace(arg_15_0._gotipitem)
				var_15_3.goNotFinish = gohelper.findChild(var_15_3.go, "type1")
				var_15_3.goFinish = gohelper.findChild(var_15_3.go, "type2")
				var_15_3.animator = var_15_3.go:GetComponent(typeof(UnityEngine.Animator))
				var_15_3.status = nil

				table.insert(arg_15_0.elementItemList, var_15_3)
			end

			gohelper.setActive(var_15_3.go, true)

			local var_15_4 = arg_15_0._pass and iter_15_2 <= var_15_1

			gohelper.setActive(var_15_3.goNotFinish, not var_15_4)
			gohelper.setActive(var_15_3.goFinish, var_15_4)

			if var_15_3.status == false and var_15_4 then
				gohelper.setActive(var_15_3.goNotFinish, true)
				var_15_3.animator:Play("switch", 0, 0)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			end

			var_15_3.status = var_15_4
		end

		local var_15_5 = arg_15_0._showAllElementTip

		arg_15_0._showAllElementTip = arg_15_0._pass and var_15_1 ~= #var_15_0

		if var_15_5 and not arg_15_0._showAllElementTip then
			TaskDispatcher.cancelTask(arg_15_0._hideAllElementTip, arg_15_0)
			TaskDispatcher.runDelay(arg_15_0._hideAllElementTip, arg_15_0, 0.8)
		else
			gohelper.setActive(arg_15_0._gotipcontent, arg_15_0._showAllElementTip)
		end
	end
end

function var_0_0._hideAllElementTip(arg_16_0)
	gohelper.setActive(arg_16_0._gotipcontent, false)
end

function var_0_0.refresh(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._config = arg_17_1
	arg_17_0._dungeonMo = arg_17_2

	if arg_17_0._config.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard then
		arg_17_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei, arg_17_0._config.id - 10000)
	else
		arg_17_0._levelIndex = DungeonConfig.instance:getChapterEpisodeIndexWithSP(arg_17_0._config.chapterId, arg_17_0._config.id)
	end

	arg_17_0.pass = DungeonModel.instance:hasPassLevelAndStory(arg_17_0._config.id)
	arg_17_0._map = DungeonMapEpisodeItem.getMap(arg_17_0._config)

	arg_17_0:refreshUI()
	arg_17_0:calculatePosInContent()
	arg_17_0:playAnimation("selected")

	arg_17_0.isSelected = false

	arg_17_0:_showEye()
end

function var_0_0.refreshUI(arg_18_0)
	arg_18_0._txtsection.text = string.format("%02d", arg_18_0._levelIndex)
	arg_18_0._txtsectionname.text = arg_18_0._config.name
	arg_18_0._txtnameen.text = arg_18_0._config.name_En

	arg_18_0:refreshStar()
	arg_18_0:refreshFlag()
	arg_18_0:refreshUnlockContent()
	arg_18_0:refreshFocusStatus()
	arg_18_0:refreshElements()
	arg_18_0:_showAllElementTipView()
end

function var_0_0.refreshStar(arg_19_0)
	if arg_19_0.activityDungeonMo:isHardMode() then
		arg_19_0:refreshHardModeStar()
	else
		arg_19_0:refreshStoryModeStar()
	end
end

function var_0_0.refreshFlag(arg_20_0)
	gohelper.setActive(arg_20_0._goflag, not arg_20_0.pass)
end

function var_0_0.refreshUnlockContent(arg_21_0)
	if arg_21_0.pass or DungeonModel.instance:isReactivityEpisode(arg_21_0._config.id) then
		gohelper.setActive(arg_21_0.txtlocktips.gameObject, false)

		return
	end

	local var_21_0 = OpenConfig.instance:getOpenShowInEpisode(arg_21_0._config.id)

	if var_21_0 and #var_21_0 > 0 then
		gohelper.setActive(arg_21_0.txtlocktips.gameObject, true)

		local var_21_1 = DungeonModel.instance:getUnlockContentList(arg_21_0._config.id)

		arg_21_0.txtlocktips.text = var_21_1 and #var_21_1 > 0 and var_21_1[1] or ""

		UISpriteSetMgr.instance:setUiFBSprite(arg_21_0.imagesuo, "unlock", true)
	else
		gohelper.setActive(arg_21_0.txtlocktips.gameObject, false)
	end
end

function var_0_0.refreshHardModeStar(arg_22_0)
	arg_22_0:refreshEpisodeStar(arg_22_0.starItemList[1], arg_22_0._config.id)

	for iter_22_0 = 2, #arg_22_0.starItemList do
		gohelper.setActive(arg_22_0.starItemList[iter_22_0].goStar, false)
	end
end

function var_0_0.refreshStoryModeStar(arg_23_0)
	local var_23_0

	for iter_23_0, iter_23_1 in ipairs(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_23_0._config)) do
		local var_23_1 = arg_23_0.starItemList[iter_23_0]

		if not var_23_1 then
			var_23_1 = arg_23_0:createStarItem(gohelper.cloneInPlace(arg_23_0._gostaricon))

			table.insert(arg_23_0.starItemList, var_23_1)
		end

		arg_23_0:refreshEpisodeStar(var_23_1, iter_23_1.id)
	end
end

function var_0_0.refreshEpisodeStar(arg_24_0, arg_24_1, arg_24_2)
	gohelper.setActive(arg_24_1.goStar, true)

	local var_24_0 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_24_2)
	local var_24_1 = DungeonModel.instance:getEpisodeInfo(arg_24_2)

	arg_24_0:setImage(arg_24_1.imgStar1, arg_24_0.pass and var_24_1 and var_24_1.star > DungeonEnum.StarType.None, arg_24_2)

	if string.nilorempty(var_24_0) then
		gohelper.setActive(arg_24_1.imgStar2.gameObject, false)
	else
		gohelper.setActive(arg_24_1.imgStar2.gameObject, true)
		arg_24_0:setImage(arg_24_1.imgStar2, arg_24_0.pass and var_24_1 and var_24_1.star >= DungeonEnum.StarType.Advanced, arg_24_2)
	end
end

function var_0_0.refreshFocusStatus(arg_25_0)
	gohelper.setActive(arg_25_0.goSelected, arg_25_0._config.id == arg_25_0.activityDungeonMo.episodeId)
end

function var_0_0.refreshElements(arg_26_0)
	arg_26_0:_showAllElementTipView()
end

function var_0_0._endShowRewardView(arg_27_0)
	arg_27_0:_showAllElementTipView()
end

function var_0_0.calculatePosInContent(arg_28_0)
	local var_28_0 = recthelper.getAnchorX(arg_28_0._txtsectionname.transform)
	local var_28_1 = recthelper.getAnchorX(arg_28_0._txtnameen.transform)
	local var_28_2 = var_28_0 + arg_28_0._txtsectionname.preferredWidth, var_28_1 + arg_28_0._txtnameen.preferredWidth

	arg_28_0._maxWidth = math.max(var_28_2, VersionActivity1_3DungeonEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(arg_28_0._goclickarea.transform, arg_28_0._maxWidth)
	recthelper.setWidth(arg_28_0._goraycast.transform, arg_28_0._maxWidth + arg_28_0._layout._constDungeonNormalDeltaX)

	arg_28_0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(arg_28_0.viewGO.transform.position, arg_28_0._contentTransform).x
end

function var_0_0.setImage(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_2 then
		local var_29_0 = DungeonConfig.instance:getEpisodeCO(arg_29_3)
		local var_29_1 = VersionActivity1_3DungeonEnum.EpisodeStarType[var_29_0.chapterId]

		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(arg_29_1, var_29_1)
	else
		local var_29_2 = DungeonConfig.instance:getEpisodeCO(arg_29_3)
		local var_29_3 = VersionActivity1_3DungeonEnum.EpisodeStarEmptyType[var_29_2.chapterId]

		UISpriteSetMgr.instance:setVersionActivity1_3Sprite(arg_29_1, var_29_3)
	end
end

function var_0_0.getMaxWidth(arg_30_0)
	return arg_30_0._maxWidth
end

function var_0_0.updateSelectStatus(arg_31_0, arg_31_1)
	if not arg_31_1 then
		if not arg_31_0.isSelected and arg_31_0.playLeftAnimation then
			arg_31_0:playAnimation("restore")
		end

		arg_31_0.isSelected = false

		return
	end

	arg_31_0.isSelected = arg_31_1._config.id == arg_31_0._config.id

	if arg_31_1._config.id == arg_31_0._config.id then
		arg_31_0:playAnimation("selected")
	else
		arg_31_0.playLeftAnimation = true

		arg_31_0:playAnimation("notselected")
	end
end

function var_0_0.playAnimation(arg_32_0, arg_32_1)
	arg_32_0.animator:Play(arg_32_1, 0, 0)
end

function var_0_0.getEpisodeId(arg_33_0)
	return arg_33_0._config and arg_33_0._config.id
end

function var_0_0.createStarItem(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getUserDataTb_()

	var_34_0.goStar = arg_34_1
	var_34_0.imgStar1 = gohelper.findChildImage(arg_34_1, "starLayout/#image_star1")
	var_34_0.imgStar2 = gohelper.findChildImage(arg_34_1, "starLayout/#image_star2")

	return var_34_0
end

function var_0_0.onClose(arg_35_0)
	return
end

function var_0_0.onDestroyView(arg_36_0)
	arg_36_0.goClick:RemoveClickListener()
end

return var_0_0
