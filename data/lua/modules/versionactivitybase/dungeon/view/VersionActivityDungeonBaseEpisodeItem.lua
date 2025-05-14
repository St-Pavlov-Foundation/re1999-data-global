module("modules.versionactivitybase.dungeon.view.VersionActivityDungeonBaseEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivityDungeonBaseEpisodeItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscale = gohelper.findChild(arg_1_0.viewGO, "#go_scale")
	arg_1_0._txtsection = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/section/#txt_section")
	arg_1_0._gostaricon = gohelper.findChild(arg_1_0.viewGO, "#go_scale/star/#go_staricon")
	arg_1_0._txtsectionname = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_flag")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	arg_1_0._gointeractcontent = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#go_interactContent")
	arg_1_0._gointeractitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#go_interactContent/#go_interact")
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
	local var_4_0 = ViewMgr.instance:getContainer(ViewName.VersionActivityDungeonMapLevelView)

	if var_4_0 then
		var_4_0:stopCloseViewTask()

		if var_4_0:getOpenedEpisodeId() == arg_4_0._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivityDungeonMapLevelView)

			return
		end
	end

	ViewMgr.instance:openView(ViewName.VersionActivityDungeonMapLevelView, {
		episodeId = arg_4_0._config.id
	})
	arg_4_0._layout:setFocusEpisodeItem(arg_4_0, true)
	arg_4_0._layout:setSelectEpisodeItem(arg_4_0)
	arg_4_0.activityDungeonMo:changeEpisode(arg_4_0:getEpisodeId())
	arg_4_0._mapSceneView:refreshMap()
	arg_4_0._layout:updateFocusStatus(arg_4_0)

	if GamepadController.instance:isOpen() then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeFocusEpisodeItem, arg_4_0)
	end
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gostaricon, false)
	gohelper.setActive(arg_5_0._goflag, false)
	gohelper.setActive(arg_5_0._gointeractitem, false)

	arg_5_0.starItemList = {}
	arg_5_0.elementItemList = {}

	table.insert(arg_5_0.starItemList, arg_5_0:createStarItem(arg_5_0._gostaricon))

	arg_5_0.animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0.goClick = gohelper.getClick(arg_5_0._goclickarea)

	arg_5_0.goClick:AddClickListener(arg_5_0.onClick, arg_5_0)
end

function var_0_0.initViewParam(arg_6_0)
	arg_6_0._contentTransform = arg_6_0.viewParam[1]
	arg_6_0._layout = arg_6_0.viewParam[2]
	arg_6_0._mapSceneView = arg_6_0.viewContainer.mapScene
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:initViewParam()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_8_0.refreshElements, arg_8_0)
	arg_8_0:initViewParam()
end

function var_0_0.refresh(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._config = arg_9_1
	arg_9_0._dungeonMo = arg_9_2
	arg_9_0._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(arg_9_0._config)
	arg_9_0.pass = DungeonModel.instance:hasPassLevelAndStory(arg_9_0._config.id)

	arg_9_0:refreshUI()
	arg_9_0:calculatePosInContent()
	arg_9_0:playAnimation("selected")

	arg_9_0.isSelected = false
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0._txtsection.text = string.format("%02d", arg_10_0._levelIndex)
	arg_10_0._txtsectionname.text = arg_10_0._config.name
	arg_10_0._txtnameen.text = arg_10_0._config.name_En

	arg_10_0:refreshStar()
	arg_10_0:refreshFlag()
	arg_10_0:refreshUnlockContent()
	arg_10_0:refreshFocusStatus()
	arg_10_0:refreshElements()
end

function var_0_0.refreshStar(arg_11_0)
	if arg_11_0.activityDungeonMo:isHardMode() then
		arg_11_0:refreshHardModeStar()
	else
		arg_11_0:refreshStoryModeStar()
	end
end

function var_0_0.refreshFlag(arg_12_0)
	gohelper.setActive(arg_12_0._goflag, not arg_12_0.pass)
end

function var_0_0.refreshUnlockContent(arg_13_0)
	if arg_13_0.pass then
		gohelper.setActive(arg_13_0.txtlocktips.gameObject, false)

		return
	end

	if DungeonModel.instance:isReactivityEpisode(arg_13_0._config.id) then
		gohelper.setActive(arg_13_0.txtlocktips, false)

		return
	end

	local var_13_0 = OpenConfig.instance:getOpenShowInEpisode(arg_13_0._config.id)

	if var_13_0 and #var_13_0 > 0 then
		gohelper.setActive(arg_13_0.txtlocktips.gameObject, true)

		local var_13_1 = DungeonModel.instance:getUnlockContentList(arg_13_0._config.id)

		arg_13_0.txtlocktips.text = var_13_1 and #var_13_1 > 0 and var_13_1[1] or ""

		UISpriteSetMgr.instance:setUiFBSprite(arg_13_0.imagesuo, "unlock", true)
	else
		gohelper.setActive(arg_13_0.txtlocktips.gameObject, false)
	end
end

function var_0_0.refreshHardModeStar(arg_14_0)
	arg_14_0:refreshEpisodeStar(arg_14_0.starItemList[1], arg_14_0._config.id, true)

	for iter_14_0 = 2, #arg_14_0.starItemList do
		gohelper.setActive(arg_14_0.starItemList[iter_14_0].goStar, false)
	end
end

function var_0_0.refreshStoryModeStar(arg_15_0)
	local var_15_0

	for iter_15_0, iter_15_1 in ipairs(DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_15_0._config)) do
		local var_15_1 = arg_15_0.starItemList[iter_15_0]

		if not var_15_1 then
			var_15_1 = arg_15_0:createStarItem(gohelper.cloneInPlace(arg_15_0._gostaricon))

			table.insert(arg_15_0.starItemList, var_15_1)
		end

		arg_15_0:refreshEpisodeStar(var_15_1, iter_15_1.id)
	end
end

function var_0_0.refreshEpisodeStar(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	gohelper.setActive(arg_16_1.goStar, true)

	local var_16_0 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_16_2)
	local var_16_1 = DungeonModel.instance:getEpisodeInfo(arg_16_2)

	arg_16_0:setImage(arg_16_1.imgStar1, arg_16_0.pass and var_16_1 and var_16_1.star > DungeonEnum.StarType.None, arg_16_3)

	if string.nilorempty(var_16_0) then
		gohelper.setActive(arg_16_1.imgStar2.gameObject, false)
	else
		gohelper.setActive(arg_16_1.imgStar2.gameObject, true)
		arg_16_0:setImage(arg_16_1.imgStar2, arg_16_0.pass and var_16_1 and var_16_1.star >= DungeonEnum.StarType.Advanced, arg_16_3)
	end
end

function var_0_0.refreshFocusStatus(arg_17_0)
	gohelper.setActive(arg_17_0.goSelected, arg_17_0._config.id == arg_17_0.activityDungeonMo.episodeId)
end

function var_0_0.refreshElements(arg_18_0)
	if arg_18_0.activityDungeonMo:isHardMode() then
		gohelper.setActive(arg_18_0._gointeractcontent, false)

		return
	end

	local var_18_0 = DungeonConfig.instance:getChapterMapCfg(arg_18_0._config.chapterId, arg_18_0._config.preEpisode)

	if not var_18_0 then
		gohelper.setActive(arg_18_0._gointeractcontent, false)

		return
	end

	local var_18_1 = DungeonConfig.instance:getMapElements(var_18_0.id)

	if not var_18_1 or #var_18_1 < 1 then
		gohelper.setActive(arg_18_0._gointeractcontent, false)
	else
		gohelper.setActive(arg_18_0._gointeractcontent, true)

		local var_18_2 = DungeonMapModel.instance:getElements(var_18_0.id)
		local var_18_3 = #var_18_1 - (var_18_2 and #var_18_2 or 0)
		local var_18_4

		for iter_18_0, iter_18_1 in ipairs(var_18_1) do
			local var_18_5 = arg_18_0.elementItemList[iter_18_0]

			if not var_18_5 then
				var_18_5 = arg_18_0:getUserDataTb_()
				var_18_5.go = gohelper.cloneInPlace(arg_18_0._gointeractitem)
				var_18_5.goNotFinish = gohelper.findChild(var_18_5.go, "go_notfinish")
				var_18_5.goFinish = gohelper.findChild(var_18_5.go, "go_finish")

				table.insert(arg_18_0.elementItemList, var_18_5)
			end

			gohelper.setActive(var_18_5.go, true)
			gohelper.setActive(var_18_5.goNotFinish, not arg_18_0.pass or var_18_3 < iter_18_0)
			gohelper.setActive(var_18_5.goFinish, arg_18_0.pass and iter_18_0 <= var_18_3)
		end

		for iter_18_2 = #var_18_1 + 1, #arg_18_0.elementItemList do
			gohelper.setActive(arg_18_0.elementItemList[iter_18_2].go, false)
		end
	end
end

function var_0_0.calculatePosInContent(arg_19_0)
	local var_19_0 = recthelper.getAnchorX(arg_19_0._txtsectionname.transform)
	local var_19_1 = recthelper.getAnchorX(arg_19_0._txtnameen.transform)
	local var_19_2 = var_19_0 + arg_19_0._txtsectionname.preferredWidth, var_19_1 + arg_19_0._txtnameen.preferredWidth

	arg_19_0._maxWidth = math.max(var_19_2, VersionActivityEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(arg_19_0._goclickarea.transform, arg_19_0._maxWidth)
	recthelper.setWidth(arg_19_0._goraycast.transform, arg_19_0._maxWidth + arg_19_0._layout._constDungeonNormalDeltaX)

	arg_19_0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(arg_19_0.viewGO.transform.position, arg_19_0._contentTransform).x
end

function var_0_0.setImage(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 then
		if arg_20_3 then
			UISpriteSetMgr.instance:setVersionActivitySprite(arg_20_1, "star_0_4")
		else
			UISpriteSetMgr.instance:setVersionActivitySprite(arg_20_1, "star_0_3")
		end
	else
		UISpriteSetMgr.instance:setVersionActivitySprite(arg_20_1, "star_0_1")
	end
end

function var_0_0.getMaxWidth(arg_21_0)
	return arg_21_0._maxWidth
end

function var_0_0.updateSelectStatus(arg_22_0, arg_22_1)
	if not arg_22_1 then
		if not arg_22_0.isSelected and arg_22_0.playLeftAnimation then
			arg_22_0:playAnimation("restore")
		end

		arg_22_0.isSelected = false

		return
	end

	arg_22_0.isSelected = arg_22_1._config.id == arg_22_0._config.id

	if arg_22_1._config.id == arg_22_0._config.id then
		arg_22_0:playAnimation("selected")
	else
		arg_22_0.playLeftAnimation = true

		arg_22_0:playAnimation("notselected")
	end
end

function var_0_0.playAnimation(arg_23_0, arg_23_1)
	arg_23_0.animator:Play(arg_23_1)
end

function var_0_0.getEpisodeId(arg_24_0)
	return arg_24_0._config and arg_24_0._config.id
end

function var_0_0.createStarItem(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0:getUserDataTb_()

	var_25_0.goStar = arg_25_1
	var_25_0.imgStar1 = gohelper.findChildImage(arg_25_1, "starLayout/#image_star1")
	var_25_0.imgStar2 = gohelper.findChildImage(arg_25_1, "starLayout/#image_star2")

	return var_25_0
end

function var_0_0.onClose(arg_26_0)
	return
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0.goClick:RemoveClickListener()
end

return var_0_0
