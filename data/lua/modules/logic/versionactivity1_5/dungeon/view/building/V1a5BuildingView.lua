module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingView", package.seeall)

local var_0_0 = class("V1a5BuildingView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageRightMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG/#simage_RightMask")
	arg_1_0._simageRightMask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG/#simage_RightMask2")
	arg_1_0._simageUpMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_UpMask")
	arg_1_0._simageUpMask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG/#simage_UpMask2")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._gopointitem1 = gohelper.findChild(arg_1_0.viewGO, "Left/point_container/#go_pointitem1")
	arg_1_0._gopointitem2 = gohelper.findChild(arg_1_0.viewGO, "Left/point_container/#go_pointitem2")
	arg_1_0._gopointitem3 = gohelper.findChild(arg_1_0.viewGO, "Left/point_container/#go_pointitem3")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_desc")
	arg_1_0._gobuildskillitem = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem")
	arg_1_0._goArrow = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Arrow")
	arg_1_0._gobuilditem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_builditem")
	arg_1_0.slider = gohelper.findChildSlider(arg_1_0.viewGO, "Right/Slider/Slider")
	arg_1_0._txtSchedule = gohelper.findChildText(arg_1_0.viewGO, "Right/Slider/Schedule/#txt_Schedule")
	arg_1_0._simageIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/Slider/Prop/#simage_Icon")
	arg_1_0.rewardEffect = gohelper.findChild(arg_1_0.viewGO, "Right/Slider/Prop/#effect")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Right/Slider/Prop/#txt_Num")
	arg_1_0._goHasGainedReward = gohelper.findChild(arg_1_0.viewGO, "Right/Slider/Prop/#go_hasget")

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

function var_0_0.onClickReward(arg_4_0)
	if VersionActivity1_5BuildModel.instance.hasGainedReward then
		MaterialTipController.instance:showMaterialInfo(arg_4_0.rewardType, arg_4_0.rewardId)

		return
	end

	if VersionActivity1_5BuildModel.instance:getHadBuildCount() < 6 then
		MaterialTipController.instance:showMaterialInfo(arg_4_0.rewardType, arg_4_0.rewardId)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct140GainProgressRewardRequest()
end

function var_0_0.initBuildItem(arg_5_0)
	arg_5_0.buildItemList = {}

	for iter_5_0 = 1, VersionActivity1_5DungeonEnum.BuildCount do
		arg_5_0:createBuildItem(iter_5_0)
	end
end

function var_0_0.initSliderPointItem(arg_6_0)
	arg_6_0.sliderPointItemList = {}

	for iter_6_0 = 1, 5 do
		table.insert(arg_6_0.sliderPointItemList, arg_6_0:createSliderPointItem(iter_6_0))
	end
end

function var_0_0.initBuildImageItem(arg_7_0)
	arg_7_0.buildImageList = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, 3 do
		table.insert(arg_7_0.buildImageList, gohelper.findChildImage(arg_7_0.viewGO, "#simage_FullBG/#image_build" .. iter_7_0))
	end
end

function var_0_0.initPointItem(arg_8_0)
	arg_8_0.pointItemList = {}

	table.insert(arg_8_0.pointItemList, arg_8_0:createPointItem(arg_8_0._gopointitem1))
	table.insert(arg_8_0.pointItemList, arg_8_0:createPointItem(arg_8_0._gopointitem2))
	table.insert(arg_8_0.pointItemList, arg_8_0:createPointItem(arg_8_0._gopointitem3))
end

function var_0_0.createPointItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.image = arg_9_1:GetComponent(gohelper.Type_Image)
	var_9_0.effectGo1 = gohelper.findChild(arg_9_1, "#effect_green")
	var_9_0.effectGo2 = gohelper.findChild(arg_9_1, "#effect_yellow")

	return var_9_0
end

function var_0_0.onScrollValueChanged(arg_10_0)
	gohelper.setActive(arg_10_0._goArrow, arg_10_0._scrolldesc.verticalNormalizedPosition >= 0.01)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._simageFullBG:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_fullbg"))
	arg_11_0._simageMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask"))
	arg_11_0._simageRightMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	arg_11_0._simageRightMask2:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	arg_11_0._simageUpMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	arg_11_0._simageUpMask2:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))

	arg_11_0.goLeft = gohelper.findChild(arg_11_0.viewGO, "Left")
	arg_11_0.goRight = gohelper.findChild(arg_11_0.viewGO, "Right")
	arg_11_0.goBackBtn = gohelper.findChild(arg_11_0.viewGO, "#go_BackBtns")
	arg_11_0.bgRectTr = gohelper.findChildComponent(arg_11_0.viewGO, "#simage_FullBG", gohelper.Type_RectTransform)
	arg_11_0.goMask = gohelper.findChild(arg_11_0.viewGO, "#simage_Mask")

	arg_11_0._scrolldesc:AddOnValueChanged(arg_11_0.onScrollValueChanged, arg_11_0)
	gohelper.setActive(arg_11_0._gobuilditem, false)

	arg_11_0.rewardClick = gohelper.findChildClickWithDefaultAudio(arg_11_0.viewGO, "Right/Slider/Prop/#simage_Icon")

	arg_11_0.rewardClick:AddClickListener(arg_11_0.onClickReward, arg_11_0)

	local var_11_0 = gohelper.findChildText(arg_11_0.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem/image_EffectBG/#txt_buildname")
	local var_11_1 = gohelper.findChildText(arg_11_0.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem/#txt_buildskilldesc")

	var_11_0.text = luaLang("p_versionactivity_1_5_build_base_skill_effect_name")
	var_11_1.text = luaLang("p_versionactivity_1_5_build_base_skill_effect_desc")
	arg_11_0.skillItemDict = {}

	arg_11_0:initPointItem()
	arg_11_0:initBuildItem()
	arg_11_0:initBuildImageItem()
	arg_11_0:initSliderPointItem()
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_11_0.onOpenView, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_11_0.onCloseView, arg_11_0)
	arg_11_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, arg_11_0.onUpdateBuildInfo, arg_11_0)
	arg_11_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, arg_11_0.onUpdateSelectBuild, arg_11_0)
	arg_11_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, arg_11_0.onSwitchSelectGroupBuild, arg_11_0)
	arg_11_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward, arg_11_0.onUpdateGainedBuildReward, arg_11_0)
	arg_11_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_11_0.closeThis, arg_11_0)
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0.selectTypeList = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	arg_13_0.slider:SetValue(VersionActivity1_5BuildModel.instance:getHadBuildCount())
	arg_13_0:showUI()
	arg_13_0:refreshUI()
	arg_13_0:onScrollValueChanged()
end

function var_0_0.onOpenFinish(arg_14_0)
	return
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:refreshLeft()
	arg_15_0:refreshRight()
end

function var_0_0.refreshLeft(arg_16_0)
	arg_16_0:refreshPoint()
	arg_16_0:refreshBuildSkill()
end

function var_0_0.refreshRight(arg_17_0)
	arg_17_0:refreshBuildIcon()
	arg_17_0:refreshSlider()
	arg_17_0:refreshReward()
	arg_17_0:refreshRewardEffect()
	arg_17_0:refreshBuildImage()
end

function var_0_0.refreshPoint(arg_18_0)
	for iter_18_0 = 1, VersionActivity1_5DungeonEnum.BuildCount do
		local var_18_0 = arg_18_0.selectTypeList[iter_18_0]

		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(arg_18_0.pointItemList[iter_18_0].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[var_18_0])
	end
end

function var_0_0.refreshBuildSkill(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.selectTypeList) do
		if iter_19_1 ~= VersionActivity1_5DungeonEnum.BuildType.None then
			local var_19_0 = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(iter_19_0, iter_19_1)
			local var_19_1 = arg_19_0.skillItemDict[iter_19_0] or arg_19_0:createSkillItem(iter_19_0)

			var_19_1.txtbuildname.text = VersionActivity1_5BuildModel.getTextByType(iter_19_1, var_19_0.name)
			var_19_1.txtbuildnameEn.text = var_19_0.nameEn
			var_19_1.txtbuildskilldesc.text = VersionActivity1_5BuildModel.getTextByType(iter_19_1, var_19_0.skilldesc)

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(var_19_1.imagebuildnamebg, VersionActivity1_5DungeonEnum.BuildType2TitleBgImage[iter_19_1])
		end
	end
end

function var_0_0.createSkillItem(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:getUserDataTb_()

	var_20_0.go = gohelper.cloneInPlace(arg_20_0._gobuildskillitem)
	var_20_0.imagebuildnamebg = gohelper.findChildImage(var_20_0.go, "image_EffectBG/")
	var_20_0.txtbuildname = gohelper.findChildText(var_20_0.go, "image_EffectBG/#txt_buildname")
	var_20_0.txtbuildnameEn = gohelper.findChildText(var_20_0.go, "Line/#txt_En")
	var_20_0.txtbuildskilldesc = gohelper.findChildText(var_20_0.go, "#txt_buildskilldesc")
	arg_20_0.skillItemDict[arg_20_1] = var_20_0

	return var_20_0
end

function var_0_0.refreshBuildIcon(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.buildItemList) do
		local var_21_0 = VersionActivity1_5BuildModel.instance:getBuildCoByGroupIndex(iter_21_0) or VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(iter_21_0, 1)
		local var_21_1 = string.splitToNumber(var_21_0.pos, "#")

		recthelper.setAnchor(iter_21_1.rectTr, var_21_1[1], var_21_1[2])

		local var_21_2 = VersionActivity1_5BuildModel.instance:getCanBuildCount(var_21_0.group)
		local var_21_3 = var_21_2 > 0

		gohelper.setActive(iter_21_1.goTips, not var_21_3)
		gohelper.setActive(iter_21_1.goBuildName, var_21_3)

		local var_21_4 = 2 - var_21_2

		iter_21_1.txtCanBuild.text = string.format(luaLang("v1a5_builde_can_build"), var_21_4)

		gohelper.setActive(iter_21_1.goCanBuild, var_21_4 > 0)

		local var_21_5 = VersionActivity1_5BuildModel.instance:getSelectType(iter_21_0)

		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(iter_21_1.bgImage, VersionActivity1_5DungeonEnum.BuildType2Image[var_21_5])
		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(iter_21_1.buildIconImage, var_21_0.icon)

		if var_21_3 then
			iter_21_1.txtBuildName.text = var_21_0.name
		end
	end
end

function var_0_0.createBuildItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getUserDataTb_()

	var_22_0.groupIndex = arg_22_1
	var_22_0.go = gohelper.cloneInPlace(arg_22_0._gobuilditem)

	gohelper.setActive(var_22_0.go, true)

	var_22_0.rectTr = var_22_0.go:GetComponent(gohelper.Type_RectTransform)
	var_22_0.bgImage = gohelper.findChildImage(var_22_0.go, "Totem/#image_TotemBG")
	var_22_0.buildIconImage = gohelper.findChildImage(var_22_0.go, "Totem/#image_TotemBG/#image_TotemIcon")
	var_22_0.goCanBuild = gohelper.findChild(var_22_0.go, "#go_CanBuild")
	var_22_0.txtCanBuild = gohelper.findChildText(var_22_0.go, "#go_CanBuild/#txt_CanBuild")
	var_22_0.goBuildName = gohelper.findChild(var_22_0.go, "#go_Name")
	var_22_0.txtBuildName = gohelper.findChildText(var_22_0.go, "#go_Name/#txt_BuildName")
	var_22_0.goTips = gohelper.findChild(var_22_0.go, "#go_Tips")
	var_22_0.goClick = gohelper.findChildClickWithDefaultAudio(var_22_0.go, "clickarea")

	var_22_0.goClick:AddClickListener(arg_22_0.onClickBuild, arg_22_0, var_22_0)
	table.insert(arg_22_0.buildItemList, var_22_0)

	return var_22_0
end

function var_0_0.createSliderPointItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:getUserDataTb_()

	var_23_0.go = gohelper.findChild(arg_23_0.viewGO, "Right/Slider/Layout/Point" .. arg_23_1)
	var_23_0.goNormal = gohelper.findChild(var_23_0.go, "image_PointBG")
	var_23_0.goFinish = gohelper.findChild(var_23_0.go, "image_PointFG")

	return var_23_0
end

function var_0_0.refreshReward(arg_24_0)
	local var_24_0, var_24_1, var_24_2 = VersionActivity1_5DungeonConfig.instance:getBuildReward()
	local var_24_3, var_24_4 = ItemModel.instance:getItemConfigAndIcon(var_24_0, var_24_1)

	arg_24_0._simageIcon:LoadImage(var_24_4)

	arg_24_0._txtNum.text = var_24_2
	arg_24_0.rewardType, arg_24_0.rewardId = var_24_0, var_24_1

	gohelper.setActive(arg_24_0._goHasGainedReward, VersionActivity1_5BuildModel.instance.hasGainedReward)
end

function var_0_0.refreshRewardEffect(arg_25_0)
	if VersionActivity1_5BuildModel.instance.hasGainedReward then
		gohelper.setActive(arg_25_0.rewardEffect, false)

		return
	end

	local var_25_0 = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	gohelper.setActive(arg_25_0.rewardEffect, var_25_0 == 6)
end

function var_0_0.refreshSlider(arg_26_0)
	local var_26_0 = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	for iter_26_0 = 1, 5 do
		local var_26_1 = arg_26_0.sliderPointItemList[iter_26_0]
		local var_26_2 = iter_26_0 <= var_26_0

		gohelper.setActive(var_26_1.goNormal, not var_26_2)
		gohelper.setActive(var_26_1.goFinish, var_26_2)
	end

	arg_26_0._txtSchedule.text = Mathf.Ceil(var_26_0 / 6 * 100) .. "%"
end

function var_0_0.refreshBuildImage(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.buildImageList) do
		local var_27_0 = VersionActivity1_5BuildModel.instance:getSelectType(iter_27_0)

		if VersionActivity1_5DungeonEnum.BuildType.None == var_27_0 then
			gohelper.setActive(iter_27_1.gameObject, false)
		else
			local var_27_1 = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(iter_27_0, var_27_0)

			gohelper.setActive(iter_27_1.gameObject, true)
			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(iter_27_1, var_27_1.previewImg)
		end
	end
end

function var_0_0.onUpdateGainedBuildReward(arg_28_0)
	gohelper.setActive(arg_28_0._goHasGainedReward, VersionActivity1_5BuildModel.instance.hasGainedReward)
	arg_28_0:refreshRewardEffect()
end

function var_0_0.onClickBuild(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0.pointItemList) do
		gohelper.setActive(iter_29_1.effectGo1, false)
		gohelper.setActive(iter_29_1.effectGo2, false)
	end

	arg_29_0.focusBuildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(arg_29_1.groupIndex, 1)
	arg_29_0.preSelectTypeList = tabletool.copy(VersionActivity1_5BuildModel.instance:getSelectTypeList())
	arg_29_0.preHadBuildCount = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	ViewMgr.instance:openView(ViewName.V1a5BuildingDetailView, {
		groupIndex = arg_29_1.groupIndex
	})
end

function var_0_0.onOpenView(arg_30_0, arg_30_1)
	if arg_30_1 ~= ViewName.V1a5BuildingDetailView then
		return
	end

	arg_30_0:hideUI()
	arg_30_0:playFocusAnim()
end

function var_0_0.onCloseView(arg_31_0, arg_31_1)
	if arg_31_1 ~= ViewName.V1a5BuildingDetailView then
		return
	end

	arg_31_0:playRevertAnim(arg_31_0.onRevertAnimDone)
end

function var_0_0.showUI(arg_32_0)
	gohelper.setActive(arg_32_0.goLeft, true)
	gohelper.setActive(arg_32_0.goRight, true)
	gohelper.setActive(arg_32_0.goBackBtn, true)
	gohelper.setActive(arg_32_0.goMask, true)
end

function var_0_0.hideUI(arg_33_0)
	gohelper.setActive(arg_33_0.goLeft, false)
	gohelper.setActive(arg_33_0.goRight, false)
	gohelper.setActive(arg_33_0.goBackBtn, false)
	gohelper.setActive(arg_33_0.goMask, false)
end

function var_0_0.playFocusAnim(arg_34_0, arg_34_1)
	arg_34_0:killAnim()

	arg_34_0.finishCallback = arg_34_1
	arg_34_0.startAnchorX = 0
	arg_34_0.startAnchorY = 0
	arg_34_0.targetAnchorX = arg_34_0.focusBuildCo.focusPosX
	arg_34_0.targetAnchorY = arg_34_0.focusBuildCo.focusPosY
	arg_34_0.startScale = 1
	arg_34_0.targetScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	arg_34_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, arg_34_0.frameCall, arg_34_0.finishCall, arg_34_0)
end

function var_0_0.playRevertAnim(arg_35_0, arg_35_1)
	arg_35_0:killAnim()

	arg_35_0.finishCallback = arg_35_1
	arg_35_0.startAnchorX = arg_35_0.focusBuildCo.focusPosX
	arg_35_0.startAnchorY = arg_35_0.focusBuildCo.focusPosY
	arg_35_0.targetAnchorX = 0
	arg_35_0.targetAnchorY = 0
	arg_35_0.startScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	arg_35_0.targetScale = 1
	arg_35_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, arg_35_0.frameCall, arg_35_0.finishCall, arg_35_0)
end

function var_0_0.frameCall(arg_36_0, arg_36_1)
	local var_36_0 = Mathf.Lerp(arg_36_0.startAnchorX, arg_36_0.targetAnchorX, arg_36_1)
	local var_36_1 = Mathf.Lerp(arg_36_0.startAnchorY, arg_36_0.targetAnchorY, arg_36_1)
	local var_36_2 = Mathf.Lerp(arg_36_0.startScale, arg_36_0.targetScale, arg_36_1)

	recthelper.setAnchor(arg_36_0.bgRectTr, var_36_0, var_36_1)
	transformhelper.setLocalScale(arg_36_0.bgRectTr, var_36_2, var_36_2, var_36_2)
end

function var_0_0.finishCall(arg_37_0)
	recthelper.setAnchor(arg_37_0.bgRectTr, arg_37_0.targetAnchorX, arg_37_0.targetAnchorY)
	transformhelper.setLocalScale(arg_37_0.bgRectTr, arg_37_0.targetScale, arg_37_0.targetScale, arg_37_0.targetScale)

	if arg_37_0.finishCallback then
		arg_37_0:finishCallback()

		arg_37_0.finishCallback = nil
	end
end

function var_0_0.killAnim(arg_38_0)
	if arg_38_0.tweenId then
		ZProj.TweenHelper.KillById(arg_38_0.tweenId)
	end

	arg_38_0.finishCallback = nil
end

function var_0_0.onRevertAnimDone(arg_39_0)
	arg_39_0:showUI()
	arg_39_0:playPointAnimation()
	arg_39_0:playSliderAnimation()
end

function var_0_0.onUpdateBuildInfo(arg_40_0)
	arg_40_0:refreshLeft()
	arg_40_0:playPointAnimation()
	arg_40_0:playSliderAnimation()
	arg_40_0:refreshBuildImage()
	arg_40_0:refreshSlider()
	arg_40_0:refreshRewardEffect()
	arg_40_0:refreshBuildIcon()
end

function var_0_0.onUpdateSelectBuild(arg_41_0)
	arg_41_0:refreshLeft()
	arg_41_0:playPointAnimation()
	arg_41_0:refreshBuildIcon()
	arg_41_0:refreshBuildImage()
end

function var_0_0.playPointAnimation(arg_42_0)
	if ViewMgr.instance:isOpen(ViewName.V1a5BuildingDetailView) then
		return
	end

	if not arg_42_0.preSelectTypeList then
		return
	end

	local var_42_0 = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if iter_42_1 ~= arg_42_0.preSelectTypeList[iter_42_0] then
			local var_42_1 = arg_42_0.pointItemList[iter_42_0]

			if iter_42_1 == VersionActivity1_5DungeonEnum.BuildType.First then
				gohelper.setActive(var_42_1.effectGo1, true)
			else
				gohelper.setActive(var_42_1.effectGo2, true)
			end
		end
	end

	arg_42_0.preSelectTypeList = nil
end

function var_0_0.playSliderAnimation(arg_43_0)
	if ViewMgr.instance:isOpen(ViewName.V1a5BuildingDetailView) then
		return
	end

	local var_43_0 = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	if arg_43_0.preHadBuildCount == var_43_0 then
		return
	end

	if arg_43_0.sliderTweenId then
		ZProj.TweenHelper.KillById(arg_43_0.sliderTweenId)
	end

	arg_43_0.sliderTweenId = ZProj.TweenHelper.DOTweenFloat(arg_43_0.preHadBuildCount, var_43_0, VersionActivity1_5DungeonEnum.SliderAnimTime, arg_43_0.sliderFrameCall, nil, arg_43_0)
end

function var_0_0.sliderFrameCall(arg_44_0, arg_44_1)
	arg_44_0.slider:SetValue(arg_44_1)
end

function var_0_0.onSwitchSelectGroupBuild(arg_45_0, arg_45_1)
	arg_45_0:killAnim()

	arg_45_0.focusBuildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(arg_45_1, 1)
	arg_45_0.startAnchorX, arg_45_0.startAnchorY = recthelper.getAnchor(arg_45_0.bgRectTr)
	arg_45_0.targetAnchorX = arg_45_0.focusBuildCo.focusPosX
	arg_45_0.targetAnchorY = arg_45_0.focusBuildCo.focusPosY
	arg_45_0.startScale = transformhelper.getLocalScale(arg_45_0.bgRectTr)
	arg_45_0.targetScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	arg_45_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, arg_45_0.frameCall, arg_45_0.finishCall, arg_45_0)
end

function var_0_0.onClose(arg_46_0)
	arg_46_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_46_0.onOpenView, arg_46_0)
	arg_46_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_46_0.onCloseView, arg_46_0)
	arg_46_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, arg_46_0.onUpdateBuildInfo, arg_46_0)
	arg_46_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, arg_46_0.onUpdateSelectBuild, arg_46_0)
	arg_46_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, arg_46_0.onSwitchSelectGroupBuild, arg_46_0)
	arg_46_0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward, arg_46_0.onUpdateGainedBuildReward, arg_46_0)
	arg_46_0:killAnim()

	if arg_46_0.sliderTweenId then
		ZProj.TweenHelper.KillById(arg_46_0.sliderTweenId)
	end
end

function var_0_0.onDestroyView(arg_47_0)
	arg_47_0._simageFullBG:UnLoadImage()
	arg_47_0._simageMask:UnLoadImage()
	arg_47_0._simageRightMask:UnLoadImage()
	arg_47_0._simageRightMask2:UnLoadImage()
	arg_47_0._simageUpMask:UnLoadImage()
	arg_47_0._simageUpMask2:UnLoadImage()

	for iter_47_0, iter_47_1 in ipairs(arg_47_0.buildItemList) do
		iter_47_1.goClick:RemoveClickListener()
	end

	arg_47_0._scrolldesc:RemoveOnValueChanged()
	arg_47_0.rewardClick:RemoveClickListener()
end

return var_0_0
