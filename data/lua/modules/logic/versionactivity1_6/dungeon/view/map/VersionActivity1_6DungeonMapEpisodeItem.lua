module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonMapEpisodeItem", BaseChildView)

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
	arg_1_0.goLock = gohelper.findChild(arg_1_0.viewGO, "#go_scale/#go_lock")
	arg_1_0.goLockAnimator = arg_1_0.goLock:GetComponent(gohelper.Type_Animator)

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
	if arg_4_0.isLock then
		ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapTaskView, {
			episodeId = arg_4_0:getEpisodeId()
		})

		return
	end

	local var_4_0 = ViewMgr.instance:getContainer(ViewName.VersionActivity1_6DungeonMapLevelView)

	if var_4_0 then
		var_4_0:stopCloseViewTask()

		if var_4_0:getOpenedEpisodeId() == arg_4_0._config.id then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_6DungeonMapLevelView)

			return
		end
	end

	arg_4_0.activityDungeonMo:changeEpisode(arg_4_0:getEpisodeId())
	arg_4_0._layout:setSelectEpisodeItem(arg_4_0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
		episodeId = arg_4_0._config.id
	})
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gostaricon, false)
	gohelper.setActive(arg_5_0._goflag, false)
	gohelper.setActive(arg_5_0._gotipitem, false)
	gohelper.setActive(arg_5_0._gonormaleye, false)
	gohelper.setActive(arg_5_0._gohardeye, false)

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
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_8_0.beginShowRewardView, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_8_0.endShowRewardView, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_8_0.onRemoveElement, arg_8_0, LuaEventSystem.Low)
	arg_8_0:initViewParam()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0.goClick:RemoveClickListener()
end

function var_0_0.refresh(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._config = arg_11_1
	arg_11_0._dungeonMo = arg_11_2
	arg_11_0._levelIndex = DungeonConfig.instance:getEpisodeLevelIndex(arg_11_0._config)
	arg_11_0.pass = DungeonModel.instance:hasPassLevelAndStory(arg_11_0._config.id)
	arg_11_0._map = VersionActivity1_6DungeonController.instance:getEpisodeMapConfig(arg_11_0._config.id)

	arg_11_0:refreshUI()
	arg_11_0:calculatePosInContent()
	arg_11_0:playAnimation("selected")

	arg_11_0.isSelected = false
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0._txtsection.text = string.format("%02d", arg_12_0._levelIndex)
	arg_12_0._txtsectionname.text = arg_12_0._config.name
	arg_12_0._txtnameen.text = arg_12_0._config.name_En

	arg_12_0:refreshStar()
	arg_12_0:refreshFlag()
	arg_12_0:refreshUnlockContent()
	arg_12_0:refreshFocusStatus()
	arg_12_0:_showEye()
	arg_12_0:refreshLock()
end

function var_0_0.refreshLock(arg_13_0)
	arg_13_0.isLock = arg_13_0:checkLock()

	gohelper.setActive(arg_13_0.goLock, arg_13_0.isLock)
end

function var_0_0.checkLock(arg_14_0)
	arg_14_0:initElementIdList()

	if not arg_14_0.elementIdList then
		return false
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.elementIdList) do
		if not DungeonMapModel.instance:elementIsFinished(iter_14_1) then
			return true
		end
	end

	return false
end

function var_0_0.refreshUnlockContent(arg_15_0)
	if arg_15_0.pass then
		gohelper.setActive(arg_15_0.txtlocktips.gameObject, false)

		return
	end

	local var_15_0 = OpenConfig.instance:getOpenShowInEpisode(arg_15_0._config.id)

	if var_15_0 and #var_15_0 > 0 then
		gohelper.setActive(arg_15_0.txtlocktips.gameObject, true)

		local var_15_1 = DungeonModel.instance:getUnlockContentList(arg_15_0._config.id)

		arg_15_0.txtlocktips.text = var_15_1 and #var_15_1 > 0 and var_15_1[1] or ""

		UISpriteSetMgr.instance:setUiFBSprite(arg_15_0.imagesuo, "unlock", true)
	else
		gohelper.setActive(arg_15_0.txtlocktips.gameObject, false)
	end
end

function var_0_0.playUnLockAnimation(arg_16_0)
	arg_16_0.goLock:GetComponent(typeof(UnityEngine.Animator)).enabled = true
end

function var_0_0.refreshStar(arg_17_0)
	if arg_17_0.activityDungeonMo:isHardMode() then
		arg_17_0:refreshHardModeStar()
	else
		arg_17_0:refreshStoryModeStar()
	end
end

function var_0_0.refreshHardModeStar(arg_18_0)
	arg_18_0:refreshEpisodeStar(arg_18_0.starItemList[1], arg_18_0._config.id)

	for iter_18_0 = 2, #arg_18_0.starItemList do
		gohelper.setActive(arg_18_0.starItemList[iter_18_0].goStar, false)
	end
end

function var_0_0.refreshStoryModeStar(arg_19_0)
	local var_19_0
	local var_19_1 = DungeonConfig.instance:getVersionActivityBrotherEpisodeByEpisodeCo(arg_19_0._config)

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		local var_19_2 = arg_19_0.starItemList[iter_19_0]

		if not var_19_2 then
			var_19_2 = arg_19_0:createStarItem(gohelper.cloneInPlace(arg_19_0._gostaricon))

			table.insert(arg_19_0.starItemList, var_19_2)
		end

		arg_19_0:refreshEpisodeStar(var_19_2, iter_19_1.id)
	end
end

function var_0_0.refreshEpisodeStar(arg_20_0, arg_20_1, arg_20_2)
	gohelper.setActive(arg_20_1.goStar, true)

	local var_20_0 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_20_2)
	local var_20_1 = DungeonModel.instance:getEpisodeInfo(arg_20_2)

	arg_20_0:setStarImage(arg_20_1.imgStar1, arg_20_0.pass and var_20_1 and var_20_1.star > DungeonEnum.StarType.None, arg_20_2)

	if string.nilorempty(var_20_0) then
		gohelper.setActive(arg_20_1.imgStar2.gameObject, false)
	else
		gohelper.setActive(arg_20_1.imgStar2.gameObject, true)
		arg_20_0:setStarImage(arg_20_1.imgStar2, arg_20_0.pass and var_20_1 and var_20_1.star >= DungeonEnum.StarType.Advanced, arg_20_2)
	end
end

function var_0_0.createStarItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getUserDataTb_()

	var_21_0.goStar = arg_21_1
	var_21_0.imgStar1 = gohelper.findChildImage(arg_21_1, "starLayout/#image_star1")
	var_21_0.imgStar2 = gohelper.findChildImage(arg_21_1, "starLayout/#image_star2")

	return var_21_0
end

function var_0_0.setStarImage(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if arg_22_2 then
		local var_22_0 = DungeonConfig.instance:getEpisodeCO(arg_22_3)
		local var_22_1 = VersionActivity1_6DungeonEnum.EpisodeStarType[var_22_0.chapterId]

		UISpriteSetMgr.instance:setV1a6DungeonSprite(arg_22_1, var_22_1)
	else
		local var_22_2 = DungeonConfig.instance:getEpisodeCO(arg_22_3)
		local var_22_3 = VersionActivity1_6DungeonEnum.EpisodeStarEmptyType[var_22_2.chapterId]

		UISpriteSetMgr.instance:setV1a6DungeonSprite(arg_22_1, var_22_3)
	end
end

function var_0_0.refreshFlag(arg_23_0)
	gohelper.setActive(arg_23_0._goflag, false)
end

function var_0_0.initElementIdList(arg_24_0)
	if not arg_24_0.elementIdList then
		local var_24_0 = arg_24_0._config.elementList

		if not string.nilorempty(var_24_0) then
			arg_24_0.elementIdList = string.splitToNumber(var_24_0, "#")
		end
	end
end

function var_0_0.clearElementIdList(arg_25_0)
	arg_25_0.elementIdList = nil
end

function var_0_0.getMapAllElementList(arg_26_0)
	local var_26_0, var_26_1 = VersionActivity1_6DungeonModel.instance:getElementCoList(arg_26_0._map.id)

	return var_26_0
end

function var_0_0._showAllElementTipView(arg_27_0)
	if not arg_27_0._map then
		gohelper.setActive(arg_27_0._gotipcontent, false)

		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DungeonHideElementTip) then
		return
	end

	local var_27_0 = arg_27_0:getMapAllElementList()

	if not var_27_0 or #var_27_0 < 1 then
		gohelper.setActive(arg_27_0._gotipcontent, false)

		arg_27_0._showAllElementTip = false
	else
		local var_27_1 = 0

		for iter_27_0, iter_27_1 in ipairs(var_27_0) do
			if DungeonMapModel.instance:elementIsFinished(iter_27_1.id) then
				var_27_1 = var_27_1 + 1
			end
		end

		local var_27_2

		for iter_27_2, iter_27_3 in ipairs(var_27_0) do
			local var_27_3 = arg_27_0.elementItemList[iter_27_2]

			if not var_27_3 then
				var_27_3 = arg_27_0:getUserDataTb_()
				var_27_3.go = gohelper.cloneInPlace(arg_27_0._gotipitem)
				var_27_3.goNotFinish = gohelper.findChild(var_27_3.go, "type1")
				var_27_3.goFinish = gohelper.findChild(var_27_3.go, "type2")
				var_27_3.animator = var_27_3.go:GetComponent(typeof(UnityEngine.Animator))
				var_27_3.status = nil

				table.insert(arg_27_0.elementItemList, var_27_3)
			end

			gohelper.setActive(var_27_3.go, true)

			local var_27_4 = arg_27_0.pass and iter_27_2 <= var_27_1

			gohelper.setActive(var_27_3.goNotFinish, not var_27_4)
			gohelper.setActive(var_27_3.goFinish, var_27_4)

			if var_27_3.status == false and var_27_4 then
				gohelper.setActive(var_27_3.goNotFinish, true)
				var_27_3.animator:Play("switch", 0, 0)
				AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_light_up)
			end

			var_27_3.status = var_27_4
		end

		local var_27_5 = arg_27_0._showAllElementTip

		arg_27_0._showAllElementTip = arg_27_0.pass and var_27_1 ~= #var_27_0

		if var_27_5 and not arg_27_0._showAllElementTip then
			TaskDispatcher.cancelTask(arg_27_0._hideAllElementTip, arg_27_0)
			TaskDispatcher.runDelay(arg_27_0._hideAllElementTip, arg_27_0, 0.8)
		else
			gohelper.setActive(arg_27_0._gotipcontent, arg_27_0._showAllElementTip)
		end
	end
end

function var_0_0._hideAllElementTip(arg_28_0)
	gohelper.setActive(arg_28_0._gotipcontent, false)
end

function var_0_0.onRemoveElement(arg_29_0, arg_29_1)
	if not arg_29_0.isLock then
		return
	end

	arg_29_0:initElementIdList()

	if not arg_29_0.elementIdList then
		return
	end

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.elementIdList) do
		if iter_29_1 == arg_29_1 then
			arg_29_0.isLock = arg_29_0:checkLock()

			if not arg_29_0.isLock then
				if arg_29_0.beginReward then
					arg_29_0.needPlayUnLockAnimation = true

					break
				end

				arg_29_0:playUnLockAnimation()
			end

			break
		end
	end
end

function var_0_0._showEye(arg_30_0)
	if not (arg_30_0._config.displayMark == 1) then
		gohelper.setActive(arg_30_0._gonormaleye, false)
		gohelper.setActive(arg_30_0._gohardeye, false)

		return
	end

	local var_30_0 = arg_30_0._config.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard

	gohelper.setActive(arg_30_0._gonormaleye, not var_30_0)
	gohelper.setActive(arg_30_0._gohardeye, var_30_0)
end

function var_0_0.refreshFocusStatus(arg_31_0)
	gohelper.setActive(arg_31_0.goSelected, arg_31_0._config.id == arg_31_0.activityDungeonMo.episodeId)
end

function var_0_0.beginShowRewardView(arg_32_0)
	arg_32_0.beginReward = true
end

function var_0_0.endShowRewardView(arg_33_0)
	arg_33_0.beginReward = false

	if arg_33_0.needPlayUnLockAnimation then
		arg_33_0:playUnLockAnimation()

		arg_33_0.needPlayUnLockAnimation = nil
	end
end

function var_0_0.calculatePosInContent(arg_34_0)
	local var_34_0 = recthelper.getAnchorX(arg_34_0._txtsectionname.transform)
	local var_34_1 = recthelper.getAnchorX(arg_34_0._txtnameen.transform)
	local var_34_2 = var_34_0 + arg_34_0._txtsectionname.preferredWidth
	local var_34_3 = arg_34_0._txtnameen.gameObject.activeSelf

	arg_34_0._maxWidth = var_34_2

	if var_34_3 then
		local var_34_4 = var_34_1 + arg_34_0._txtsectionname.preferredWidth
		local var_34_5 = math.max(var_34_2, var_34_4)

		arg_34_0._maxWidth = math.max(var_34_5 * 2, VersionActivity1_3DungeonEnum.EpisodeItemMinWidth) + 30
	else
		arg_34_0._maxWidth = math.max(var_34_2, 220) + 250
	end

	recthelper.setWidth(arg_34_0._goclickarea.transform, arg_34_0._maxWidth)
	recthelper.setWidth(arg_34_0._goraycast.transform, arg_34_0._maxWidth + arg_34_0._layout._constDungeonNormalDeltaX)

	arg_34_0.scrollContentPosX = recthelper.rectToRelativeAnchorPos(arg_34_0.viewGO.transform.position, arg_34_0._contentTransform).x
end

function var_0_0.getMaxWidth(arg_35_0)
	return arg_35_0._maxWidth
end

function var_0_0.updateSelectStatus(arg_36_0, arg_36_1, arg_36_2)
	if not arg_36_1 then
		if not arg_36_0.isSelected and arg_36_0.playLeftAnimation then
			arg_36_0:playAnimation("restore")
		end

		arg_36_0.isSelected = false

		return
	end

	arg_36_0.isSelected = arg_36_1._config.id == arg_36_0._config.id

	if arg_36_2 then
		return
	end

	if arg_36_1._config.id == arg_36_0._config.id then
		arg_36_0:playAnimation("selected")
	else
		arg_36_0.playLeftAnimation = true

		arg_36_0:playAnimation("notselected")
	end
end

function var_0_0.playAnimation(arg_37_0, arg_37_1)
	if arg_37_0.prePlayAnimName == arg_37_1 then
		return
	end

	arg_37_0.prePlayAnimName = arg_37_1

	arg_37_0.animator:Play(arg_37_1, 0, 0)
end

function var_0_0.getEpisodeId(arg_38_0)
	return arg_38_0._config and arg_38_0._config.id
end

return var_0_0
