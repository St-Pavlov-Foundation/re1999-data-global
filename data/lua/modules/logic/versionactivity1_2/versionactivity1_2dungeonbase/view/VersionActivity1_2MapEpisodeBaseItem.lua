module("modules.logic.versionactivity1_2.versionactivity1_2dungeonbase.view.VersionActivity1_2MapEpisodeBaseItem", package.seeall)

local var_0_0 = class("VersionActivity1_2MapEpisodeBaseItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscale = gohelper.findChild(arg_1_0.viewGO, "#go_scale")
	arg_1_0._txtsection = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/section/#txt_section")
	arg_1_0._gostaricon = gohelper.findChild(arg_1_0.viewGO, "#go_scale/star/#go_staricon")
	arg_1_0._txtsectionname = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_nameen")
	arg_1_0._goraycast = gohelper.findChild(arg_1_0.viewGO, "#go_raycast")
	arg_1_0._goclickarea = gohelper.findChild(arg_1_0.viewGO, "#go_clickarea")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_lock")
	arg_1_0.txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_locktips")
	arg_1_0.imagesuo = gohelper.findChildImage(arg_1_0.viewGO, "#go_scale/#txt_locktips/#image_suo")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_lock/interactiveprogress/#go_progressitem")
	arg_1_0._gobeselected = gohelper.findChild(arg_1_0.viewGO, "#go_beselected")
	arg_1_0._gointro = gohelper.findChild(arg_1_0.viewGO, "#go_Intro_section")
	arg_1_0._goclickintro = gohelper.findChild(arg_1_0.viewGO, "#go_Intro_section/#btn_intro_section")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_2_0._OnUpdateMapElementState, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.focusEpisodeItem, arg_2_0._focusEpisodeItem, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.afterCollectLastShow, arg_2_0._afterCollectLastShow, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.unlockEpisodeItemByGuide, arg_2_0._updateLock, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_2_0._beginShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_2_0._endShowRewardView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._focusEpisodeItem(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._gobeselected, arg_4_1 == arg_4_0._config.id and arg_4_0._index ~= 1)
end

function var_0_0.onClick(arg_5_0, arg_5_1)
	local var_5_0 = ViewMgr.instance:getContainer(arg_5_0:getDungeonMapLevelView())

	if var_5_0 then
		var_5_0:stopCloseViewTask()

		if arg_5_0._layout.selectedEpisodeItem == arg_5_0 then
			ViewMgr.instance:closeView(arg_5_0:getDungeonMapLevelView())

			return
		end
	end

	if arg_5_0:isLock() then
		ViewMgr.instance:closeView(arg_5_0:getDungeonMapLevelView())
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
		DungeonController.instance:openDungeonMapTaskView({
			viewParam = arg_5_0._config.preEpisode
		})

		return
	end

	ViewMgr.instance:openView(arg_5_0:getDungeonMapLevelView(), {
		episodeId = arg_5_1 or arg_5_0._config.id,
		isJump = arg_5_1 and true
	})
	arg_5_0._layout:setFocusEpisodeItem(arg_5_0, true)
	arg_5_0._layout:setSelectEpisodeItem(arg_5_0)
	arg_5_0._mapSceneView:changeMap(arg_5_0:getMapCfg())
	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.focusEpisodeItem, arg_5_0._config.id)
end

function var_0_0.getDungeonMapLevelView(arg_6_0)
	return ViewName.VersionActivityDungeonMapLevelView
end

function var_0_0._onIntroClick(arg_7_0)
	StoryController.instance:playStory(200201)
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.setActive(arg_8_0._gostaricon, false)

	arg_8_0.animator = arg_8_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0.goClick = gohelper.getClick(arg_8_0._goclickarea)

	arg_8_0.goClick:AddClickListener(arg_8_0.onClick, arg_8_0)

	arg_8_0.goIntroClick = gohelper.getClick(arg_8_0._goclickintro)

	arg_8_0.goIntroClick:AddClickListener(arg_8_0._onIntroClick, arg_8_0)
end

function var_0_0.initViewParam(arg_9_0)
	arg_9_0._contentTransform = arg_9_0.viewParam[1]
	arg_9_0._layout = arg_9_0.viewParam[2]
	arg_9_0._mapSceneView = arg_9_0.viewContainer.mapScene
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:initViewParam()
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:initViewParam()
end

function var_0_0.refresh(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0._index = arg_12_3
	arg_12_0._config = arg_12_1
	arg_12_0._dungeonMo = arg_12_2
	arg_12_0._levelIndex = VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(arg_12_0._config.id)
	arg_12_0.pass = DungeonModel.instance:hasPassLevelAndStory(arg_12_0._config.id)

	arg_12_0:refreshUI()
	arg_12_0:calculatePosInContent()
	arg_12_0:playAnimation("selected")

	arg_12_0.isSelected = false

	arg_12_0:_updateLock()

	if arg_12_0._index == 1 then
		local var_12_0 = arg_12_0.viewGO.transform
		local var_12_1 = var_12_0.childCount

		for iter_12_0 = 0, var_12_1 - 1 do
			gohelper.setActive(var_12_0:GetChild(iter_12_0).gameObject, false)
		end

		gohelper.setActive(arg_12_0._gointro, true)
	end
end

function var_0_0._OnUpdateMapElementState(arg_13_0)
	arg_13_0:_updateLock()
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0._txtsection.text = string.format("%02d", arg_14_0._levelIndex)
	arg_14_0._txtsectionname.text = arg_14_0._config.name
	arg_14_0._txtnameen.text = arg_14_0._config.name_En

	arg_14_0:refreshStar()
	arg_14_0:refreshUnlockContent()
end

function var_0_0.refreshStar(arg_15_0)
	arg_15_0:refreshStoryModeStar()
end

function var_0_0.isDungeonHardModel(arg_16_0)
	return VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel[arg_16_0._config.chapterId] == VersionActivity1_2DungeonEnum.DungeonMode.Hard
end

function var_0_0.refreshStoryModeStar(arg_17_0)
	local var_17_0 = DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(arg_17_0._config.id)
	local var_17_1 = gohelper.findChild(arg_17_0.viewGO, "#go_scale/star")

	gohelper.CreateObjList(arg_17_0, arg_17_0._onStarItemShow, var_17_0, var_17_1, arg_17_0._gostaricon)
end

function var_0_0._onStarItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_2
	local var_18_1 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_18_0)
	local var_18_2 = DungeonModel.instance:getEpisodeInfo(var_18_0)
	local var_18_3 = gohelper.findChildImage(arg_18_1, "#image_star1")
	local var_18_4 = gohelper.findChildImage(arg_18_1, "#image_star2")
	local var_18_5 = DungeonModel.instance:hasPassLevelAndStory(var_18_0)

	arg_18_0:setImage(var_18_3, var_18_5, arg_18_0:isDungeonHardModel())

	if string.nilorempty(var_18_1) then
		gohelper.setActive(var_18_4.gameObject, false)
	else
		gohelper.setActive(var_18_4.gameObject, true)
		arg_18_0:setImage(var_18_4, var_18_5 and var_18_2 and var_18_2.star >= DungeonEnum.StarType.Advanced, arg_18_0:isDungeonHardModel())
	end
end

function var_0_0.refreshEpisodeStar(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	gohelper.setActive(arg_19_1.goStar, true)

	local var_19_0 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_19_2)
	local var_19_1 = DungeonModel.instance:getEpisodeInfo(arg_19_2)
	local var_19_2 = DungeonModel.instance:hasPassLevelAndStory(arg_19_2)

	arg_19_0:setImage(arg_19_1.imgStar1, var_19_2, arg_19_3)

	if string.nilorempty(var_19_0) then
		gohelper.setActive(arg_19_1.imgStar2.gameObject, false)
	else
		gohelper.setActive(arg_19_1.imgStar2.gameObject, true)
		arg_19_0:setImage(arg_19_1.imgStar2, var_19_2 and var_19_1 and var_19_1.star >= DungeonEnum.StarType.Advanced, arg_19_3)
	end
end

function var_0_0.calculatePosInContent(arg_20_0)
	local var_20_0 = recthelper.getAnchorX(arg_20_0._txtsectionname.transform)
	local var_20_1 = recthelper.getAnchorX(arg_20_0._txtnameen.transform)
	local var_20_2 = var_20_0 + arg_20_0._txtsectionname.preferredWidth
	local var_20_3 = var_20_1 + arg_20_0._txtsectionname.preferredWidth
	local var_20_4 = math.max(var_20_2, var_20_3)

	arg_20_0._maxWidth = math.max(var_20_4 * 2, VersionActivityEnum.EpisodeItemMinWidth) + 100

	recthelper.setWidth(arg_20_0._goclickarea.transform, arg_20_0._maxWidth)
	gohelper.setActive(arg_20_0._goraycast, false)

	arg_20_0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(arg_20_0.viewGO.transform.position, arg_20_0._contentTransform).x
end

function var_0_0.setImage(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_2 then
		if arg_21_3 then
			UISpriteSetMgr.instance:setVersionActivitySprite(arg_21_1, "star_0_4")
		else
			UISpriteSetMgr.instance:setVersionActivitySprite(arg_21_1, "star_0_3")
		end
	else
		UISpriteSetMgr.instance:setVersionActivitySprite(arg_21_1, "star_0_1")
	end
end

function var_0_0.refreshUnlockContent(arg_22_0)
	if arg_22_0.pass or DungeonModel.instance:isReactivityEpisode(arg_22_0._config.id) or DungeonModel.instance:isPermanentEpisode(arg_22_0._config.id) then
		gohelper.setActive(arg_22_0.txtlocktips.gameObject, false)

		return
	end

	local var_22_0 = OpenConfig.instance:getOpenShowInEpisode(arg_22_0._config.id)

	if var_22_0 and #var_22_0 > 0 then
		gohelper.setActive(arg_22_0.txtlocktips.gameObject, true)

		local var_22_1 = DungeonModel.instance:getUnlockContentList(arg_22_0._config.id)

		arg_22_0.txtlocktips.text = var_22_1 and #var_22_1 > 0 and var_22_1[1] or ""

		UISpriteSetMgr.instance:setUiFBSprite(arg_22_0.imagesuo, "unlock", true)
	else
		gohelper.setActive(arg_22_0.txtlocktips.gameObject, false)
	end
end

function var_0_0._beginShowRewardView(arg_23_0)
	arg_23_0._showRewardView = true
end

function var_0_0._endShowRewardView(arg_24_0)
	arg_24_0._showRewardView = false

	arg_24_0:_updateLock()
end

function var_0_0._afterCollectLastShow(arg_25_0)
	if arg_25_0._config.id == 1210113 then
		arg_25_0:_updateLock()
	end
end

function var_0_0._updateLock(arg_26_0)
	if arg_26_0._showRewardView then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.KeepEpisodeItemLock) then
		return
	end

	local var_26_0 = not DungeonModel.instance:isFinishElementList(arg_26_0._config)
	local var_26_1 = arg_26_0._lastLockState

	if var_26_0 ~= var_26_1 then
		var_26_1 = nil
	end

	arg_26_0:_updateInteractiveProgress()

	if var_26_1 == false then
		return
	end

	local var_26_2 = arg_26_0._lastLockState

	arg_26_0._lastLockState = not DungeonModel.instance:isFinishElementList(arg_26_0._config)

	if arg_26_0._config.id == 1210113 and not DungeonMapModel.instance:elementIsFinished(12101091) then
		arg_26_0._lastLockState = true
	end

	if var_26_2 and not arg_26_0._lastLockState then
		local var_26_3 = arg_26_0._golock:GetComponent(typeof(UnityEngine.Animator))

		if var_26_3 then
			var_26_3.enabled = true
		end

		local var_26_4 = gohelper.findChild(arg_26_0._golock, "raycast")

		gohelper.setActive(var_26_4, false)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	else
		gohelper.setActive(arg_26_0._golock, arg_26_0._lastLockState)
	end
end

function var_0_0._updateInteractiveProgress(arg_27_0)
	if arg_27_0._lastLockState == false then
		return
	end

	local var_27_0 = arg_27_0._config.elementList
	local var_27_1 = string.splitToNumber(var_27_0, "#")
	local var_27_2 = 0

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		if DungeonMapModel.instance:elementIsFinished(iter_27_1) then
			var_27_2 = var_27_2 + 1
		end
	end

	arg_27_0:_updateProgressUI(var_27_1, var_27_2)
end

function var_0_0._updateProgressUI(arg_28_0, arg_28_1, arg_28_2)
	gohelper.setActive(arg_28_0._goprogressitem, false)

	arg_28_0._progressItemTab = arg_28_0._progressItemTab or arg_28_0:getUserDataTb_()

	for iter_28_0 = 1, #arg_28_1 do
		local var_28_0 = arg_28_0._progressItemTab[iter_28_0]

		if not var_28_0 then
			var_28_0 = gohelper.cloneInPlace(arg_28_0._goprogressitem, "progress_" .. iter_28_0)

			table.insert(arg_28_0._progressItemTab, var_28_0)
		end

		local var_28_1 = arg_28_1[iter_28_0]

		gohelper.setActive(var_28_0, var_28_1)

		if var_28_1 then
			local var_28_2 = iter_28_0 <= arg_28_2

			gohelper.setActive(gohelper.findChild(var_28_0, "finish"), var_28_2)
			gohelper.setActive(gohelper.findChild(var_28_0, "unfinish"), not var_28_2)
		end
	end

	local var_28_3 = #arg_28_0._progressItemTab

	if arg_28_0._progressItemTab and var_28_3 > #arg_28_1 then
		for iter_28_1 = #arg_28_1 + 1, var_28_3 do
			gohelper.setActive(arg_28_0._progressItemTab[iter_28_1], false)
		end
	end
end

function var_0_0.isLock(arg_29_0)
	if arg_29_0._config.id == 1210113 and not DungeonMapModel.instance:elementIsFinished(12101091) then
		return true
	end

	return not DungeonModel.instance:isFinishElementList(arg_29_0._config)
end

function var_0_0.getMaxWidth(arg_30_0)
	return arg_30_0._maxWidth
end

function var_0_0.showUnlockAnim(arg_31_0)
	logWarn("episode item play unlock animation")
end

function var_0_0.getMapCfg(arg_32_0)
	return VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(arg_32_0._config.id)
end

function var_0_0.updateSelectStatus(arg_33_0, arg_33_1)
	if not arg_33_1 then
		if not arg_33_0.isSelected and arg_33_0.playLeftAnimation then
			arg_33_0:playAnimation("restore")
		end

		arg_33_0.isSelected = false

		return
	end

	arg_33_0.isSelected = arg_33_1._config.id == arg_33_0._config.id

	if arg_33_1._config.id == arg_33_0._config.id then
		arg_33_0:playAnimation("selected")
	else
		arg_33_0.playLeftAnimation = true

		arg_33_0:playAnimation("notselected")
	end
end

function var_0_0.playAnimation(arg_34_0, arg_34_1)
	arg_34_0.animator:Play(arg_34_1, 0, 0)
end

function var_0_0.getEpisodeId(arg_35_0)
	return arg_35_0._config and arg_35_0._config.id
end

function var_0_0.onClose(arg_36_0)
	arg_36_0.goClick:RemoveClickListener()
	arg_36_0.goIntroClick:RemoveClickListener()
end

function var_0_0.onDestroyView(arg_37_0)
	return
end

return var_0_0
