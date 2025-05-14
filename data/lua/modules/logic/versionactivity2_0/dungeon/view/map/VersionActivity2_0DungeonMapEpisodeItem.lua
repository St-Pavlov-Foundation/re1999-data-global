module("modules.logic.versionactivity2_0.dungeon.view.map.VersionActivity2_0DungeonMapEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonMapEpisodeItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goscale = gohelper.findChild(arg_1_0.viewGO, "#go_scale")
	arg_1_0._txtsection = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/section/#txt_section")
	arg_1_0._gostaricon = gohelper.findChild(arg_1_0.viewGO, "#go_scale/star/#go_staricon")
	arg_1_0._txtsectionname = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname")
	arg_1_0._gotipcontent = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent")
	arg_1_0._gotipitem = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#go_tipcontent/#go_tipitem")
	arg_1_0._goflag = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_flag")
	arg_1_0._gobgicon1 = gohelper.findChild(arg_1_0.viewGO, "#go_scale/section/#go_bgicon1")
	arg_1_0._gobgicon2 = gohelper.findChild(arg_1_0.viewGO, "#go_scale/section/#go_bgicon2")
	arg_1_0._gonormaleye = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#image_normal")
	arg_1_0._gohardeye = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#image_hard")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_scale/#txt_sectionname/#txt_nameen")
	arg_1_0._goraycast = gohelper.findChild(arg_1_0.viewGO, "#go_raycast")
	arg_1_0._goclickarea = gohelper.findChild(arg_1_0.viewGO, "#go_clickarea")
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_beselected")
	arg_1_0.txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "#txt_locktips")
	arg_1_0.imagesuo = gohelper.findChildImage(arg_1_0.viewGO, "#txt_locktips/#image_suo")
	arg_1_0.goLock = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_lock")
	arg_1_0.goLockAnimator = arg_1_0.goLock:GetComponent(gohelper.Type_Animator)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_2_0.beginShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_2_0.endShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0.onRemoveElement, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_3_0.beginShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_3_0.endShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_3_0.onRemoveElement, arg_3_0, LuaEventSystem.Low)
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0.isLock then
		ViewMgr.instance:openView(ViewName.DungeonMapTaskView, {
			viewParam = arg_4_0._config.preEpisode
		})

		return
	end

	local var_4_0 = ViewMgr.instance:getContainer(ViewName.VersionActivity2_0DungeonMapLevelView)

	if var_4_0 then
		var_4_0:stopCloseViewTask()

		if var_4_0:getOpenedEpisodeId() == arg_4_0._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapLevelView)

			return
		end
	end

	arg_4_0.activityDungeonMo:changeEpisode(arg_4_0:getEpisodeId())
	arg_4_0._layout:setSelectEpisodeItem(arg_4_0)
	ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
		episodeId = arg_4_0._config.id
	})
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gostaricon, false)
	gohelper.setActive(arg_5_0._goflag, false)
	gohelper.setActive(arg_5_0._gotipitem, false)
	gohelper.setActive(arg_5_0._gonormaleye, false)
	gohelper.setActive(arg_5_0._gohardeye, false)
	gohelper.setActive(arg_5_0._gobgicon1, true)
	gohelper.setActive(arg_5_0._gobgicon2, false)

	arg_5_0.starItemList = {}
	arg_5_0.elementItemList = {}

	table.insert(arg_5_0.starItemList, arg_5_0:createStarItem(arg_5_0._gostaricon))

	arg_5_0.animator = arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_5_0.goClick = gohelper.getClick(arg_5_0._goclickarea)

	arg_5_0.goClick:AddClickListener(arg_5_0.onClick, arg_5_0)
end

function var_0_0._showEye(arg_6_0)
	local var_6_0 = arg_6_0._config.displayMark == 1

	if not var_6_0 then
		gohelper.setActive(arg_6_0._gonormaleye, false)
		gohelper.setActive(arg_6_0._gohardeye, false)

		return
	end

	gohelper.setActive(arg_6_0._gobgicon1, not var_6_0)
	gohelper.setActive(arg_6_0._gobgicon2, var_6_0)

	local var_6_1 = arg_6_0._config.chapterId == VersionActivity2_0DungeonEnum.DungeonChapterId.Hard

	gohelper.setActive(arg_6_0._gonormaleye, not var_6_1)
	gohelper.setActive(arg_6_0._gohardeye, var_6_1)
end

function var_0_0.initViewParam(arg_7_0)
	arg_7_0._contentTransform = arg_7_0.viewParam[1]
	arg_7_0._layout = arg_7_0.viewParam[2]
	arg_7_0._mapSceneView = arg_7_0.viewContainer.mapScene
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:initViewParam()
	arg_8_0:_showAllElementTipView()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:initViewParam()
end

function var_0_0.getMapAllElementList(arg_10_0)
	return (VersionActivity2_0DungeonModel.instance:getElementCoList(arg_10_0._map.id))
end

function var_0_0._showAllElementTipView(arg_11_0)
	if not arg_11_0._map then
		gohelper.setActive(arg_11_0._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	local var_11_0, var_11_1 = VersionActivity2_0DungeonModel.instance:getElementCoListWithFinish(arg_11_0._map.id)

	if not var_11_1 or #var_11_1 < 1 then
		gohelper.setActive(arg_11_0._gotipcontent, false)

		arg_11_0._showAllElementTip = false
	else
		local var_11_2 = GameUtil.getTabLen(var_11_0)
		local var_11_3

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			local var_11_4 = arg_11_0.elementItemList[iter_11_0]

			if not var_11_4 then
				var_11_4 = arg_11_0:getUserDataTb_()
				var_11_4.go = gohelper.cloneInPlace(arg_11_0._gotipitem)
				var_11_4.goNotFinish = gohelper.findChild(var_11_4.go, "type1")
				var_11_4.goFinish = gohelper.findChild(var_11_4.go, "type2")
				var_11_4.animator = var_11_4.go:GetComponent(typeof(UnityEngine.Animator))
				var_11_4.status = nil

				table.insert(arg_11_0.elementItemList, var_11_4)
			end

			gohelper.setActive(var_11_4.go, true)

			local var_11_5 = arg_11_0.pass and iter_11_0 <= var_11_2

			gohelper.setActive(var_11_4.goNotFinish, not var_11_5)
			gohelper.setActive(var_11_4.goFinish, var_11_5)

			if var_11_4.status == false and var_11_5 then
				gohelper.setActive(var_11_4.goNotFinish, true)
				var_11_4.animator:Play("switch", 0, 0)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			end

			var_11_4.status = var_11_5
		end

		local var_11_6 = arg_11_0._showAllElementTip

		arg_11_0._showAllElementTip = arg_11_0.pass and var_11_2 ~= #var_11_1

		if var_11_6 and not arg_11_0._showAllElementTip then
			TaskDispatcher.cancelTask(arg_11_0._hideAllElementTip, arg_11_0)
			TaskDispatcher.runDelay(arg_11_0._hideAllElementTip, arg_11_0, 0.8)
		else
			gohelper.setActive(arg_11_0._gotipcontent, arg_11_0._showAllElementTip)
		end
	end
end

function var_0_0._hideAllElementTip(arg_12_0)
	gohelper.setActive(arg_12_0._gotipcontent, false)
end

function var_0_0.refresh(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._config = arg_13_1
	arg_13_0._dungeonMo = arg_13_2
	arg_13_0._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(arg_13_0._config)
	arg_13_0.pass = DungeonModel.instance:hasPassLevelAndStory(arg_13_0._config.id)
	arg_13_0._map = VersionActivity2_0DungeonConfig.instance:getEpisodeMapConfig(arg_13_0._config.id)

	arg_13_0:refreshUI()
	arg_13_0:calculatePosInContent()
	arg_13_0:playAnimation("selected")

	arg_13_0.isSelected = false
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0._txtsection.text = string.format("%02d", arg_14_0._levelIndex)
	arg_14_0._txtsectionname.text = arg_14_0._config.name
	arg_14_0._txtnameen.text = arg_14_0._config.name_En

	arg_14_0:refreshStar()
	arg_14_0:refreshFlag()
	arg_14_0:refreshUnlockContent()
	arg_14_0:refreshFocusStatus()
	arg_14_0:_showAllElementTipView()
	arg_14_0:_showEye()
	arg_14_0:refreshLock()
end

function var_0_0.refreshLock(arg_15_0)
	arg_15_0.isLock = arg_15_0:checkLock()

	gohelper.setActive(arg_15_0.goLock, arg_15_0:checkLock())
end

function var_0_0.initElementIdList(arg_16_0)
	if not arg_16_0.elementIdList then
		local var_16_0 = arg_16_0._config.elementList

		if not string.nilorempty(var_16_0) then
			arg_16_0.elementIdList = string.splitToNumber(var_16_0, "#")
		end
	end
end

function var_0_0.clearElementIdList(arg_17_0)
	arg_17_0.elementIdList = nil
end

function var_0_0.checkLock(arg_18_0)
	arg_18_0:initElementIdList()

	if not arg_18_0.elementIdList then
		return false
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.elementIdList) do
		if not DungeonMapModel.instance:elementIsFinished(iter_18_1) then
			return true
		end
	end

	return false
end

function var_0_0.refreshStar(arg_19_0)
	if arg_19_0.activityDungeonMo:isHardMode() then
		arg_19_0:refreshHardModeStar()
	else
		arg_19_0:refreshStoryModeStar()
	end
end

function var_0_0.refreshFlag(arg_20_0)
	gohelper.setActive(arg_20_0._goflag, false)
end

function var_0_0.refreshUnlockContent(arg_21_0)
	if arg_21_0.pass then
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
	local var_23_1 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_23_0._config)

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		local var_23_2 = arg_23_0.starItemList[iter_23_0]

		if not var_23_2 then
			var_23_2 = arg_23_0:createStarItem(gohelper.cloneInPlace(arg_23_0._gostaricon))

			table.insert(arg_23_0.starItemList, var_23_2)
		end

		arg_23_0:refreshEpisodeStar(var_23_2, iter_23_1.id)
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

function var_0_0.beginShowRewardView(arg_26_0)
	arg_26_0.beginReward = true
end

function var_0_0.endShowRewardView(arg_27_0)
	arg_27_0.beginReward = false

	if arg_27_0.needPlayUnLockAnimation then
		arg_27_0:playUnLockAnimation()

		arg_27_0.needPlayUnLockAnimation = nil
	end

	arg_27_0:_showAllElementTipView()
end

function var_0_0.calculatePosInContent(arg_28_0)
	local var_28_0 = recthelper.getAnchorX(arg_28_0._txtsectionname.transform)
	local var_28_1 = recthelper.getAnchorX(arg_28_0._txtnameen.transform)
	local var_28_2 = var_28_0 + arg_28_0._txtsectionname.preferredWidth
	local var_28_3 = var_28_1 + arg_28_0._txtsectionname.preferredWidth
	local var_28_4 = math.max(var_28_2, var_28_3)

	arg_28_0._maxWidth = math.max(var_28_4 * 2, VersionActivity2_0DungeonEnum.EpisodeItemMinWidth) + 30

	recthelper.setWidth(arg_28_0._goclickarea.transform, arg_28_0._maxWidth)
	recthelper.setWidth(arg_28_0._goraycast.transform, arg_28_0._maxWidth + arg_28_0._layout._constDungeonNormalDeltaX)

	arg_28_0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(arg_28_0.viewGO.transform.position, arg_28_0._contentTransform).x
end

function var_0_0.setImage(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = DungeonConfig.instance:getEpisodeCO(arg_29_3)
	local var_29_1 = VersionActivity2_0DungeonEnum.EpisodeStarType[var_29_0.chapterId]
	local var_29_2 = arg_29_2 and var_29_1.light or var_29_1.empty

	UISpriteSetMgr.instance:setV2a0DungeonSprite(arg_29_1, var_29_2)
end

function var_0_0.getMaxWidth(arg_30_0)
	return arg_30_0._maxWidth
end

function var_0_0.updateSelectStatus(arg_31_0, arg_31_1, arg_31_2)
	if not arg_31_1 then
		if not arg_31_0.isSelected and arg_31_0.playLeftAnimation then
			arg_31_0:playAnimation("restore")
		end

		arg_31_0.isSelected = false

		return
	end

	arg_31_0.isSelected = arg_31_1._config.id == arg_31_0._config.id

	if arg_31_2 then
		return
	end

	if arg_31_1._config.id == arg_31_0._config.id then
		arg_31_0:playAnimation("selected")
	else
		arg_31_0.playLeftAnimation = true

		arg_31_0:playAnimation("notselected")
	end
end

function var_0_0.onRemoveElement(arg_32_0, arg_32_1)
	if not arg_32_0.beginReward then
		arg_32_0:_showAllElementTipView()
	end

	arg_32_0:initElementIdList()

	if not arg_32_0.elementIdList then
		return
	end

	for iter_32_0, iter_32_1 in ipairs(arg_32_0.elementIdList) do
		if iter_32_1 == arg_32_1 then
			local var_32_0 = arg_32_0:checkLock()

			if var_32_0 == arg_32_0.isLock then
				break
			end

			if var_32_0 then
				arg_32_0:refreshLock()

				break
			else
				arg_32_0.isLock = var_32_0

				if arg_32_0.beginReward then
					arg_32_0.needPlayUnLockAnimation = true
				else
					arg_32_0:playUnLockAnimation()
				end
			end
		end
	end
end

function var_0_0.playUnLockAnimation(arg_33_0)
	arg_33_0.goLock:GetComponent(typeof(UnityEngine.Animator)).enabled = true
end

function var_0_0.playAnimation(arg_34_0, arg_34_1)
	if arg_34_0.prePlayAnimName == arg_34_1 then
		return
	end

	arg_34_0.prePlayAnimName = arg_34_1

	arg_34_0.animator:Play(arg_34_1, 0, 0)
end

function var_0_0.getEpisodeId(arg_35_0)
	return arg_35_0._config and arg_35_0._config.id
end

function var_0_0.createStarItem(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:getUserDataTb_()

	var_36_0.goStar = arg_36_1
	var_36_0.imgStar1 = gohelper.findChildImage(arg_36_1, "starLayout/#image_star1")
	var_36_0.imgStar2 = gohelper.findChildImage(arg_36_1, "starLayout/#image_star2")

	return var_36_0
end

function var_0_0.onClose(arg_37_0)
	TaskDispatcher.cancelTask(arg_37_0._hideAllElementTip, arg_37_0)
end

function var_0_0.onDestroyView(arg_38_0)
	arg_38_0.goClick:RemoveClickListener()
end

return var_0_0
