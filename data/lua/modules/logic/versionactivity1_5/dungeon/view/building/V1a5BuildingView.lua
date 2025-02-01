module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingView", package.seeall)

slot0 = class("V1a5BuildingView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageRightMask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG/#simage_RightMask")
	slot0._simageRightMask2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG/#simage_RightMask2")
	slot0._simageUpMask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_UpMask")
	slot0._simageUpMask2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG/#simage_UpMask2")
	slot0._simageMask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Mask")
	slot0._gopointitem1 = gohelper.findChild(slot0.viewGO, "Left/point_container/#go_pointitem1")
	slot0._gopointitem2 = gohelper.findChild(slot0.viewGO, "Left/point_container/#go_pointitem2")
	slot0._gopointitem3 = gohelper.findChild(slot0.viewGO, "Left/point_container/#go_pointitem3")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_desc")
	slot0._gobuildskillitem = gohelper.findChild(slot0.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem")
	slot0._goArrow = gohelper.findChild(slot0.viewGO, "Left/#go_Arrow")
	slot0._gobuilditem = gohelper.findChild(slot0.viewGO, "Right/#go_builditem")
	slot0.slider = gohelper.findChildSlider(slot0.viewGO, "Right/Slider/Slider")
	slot0._txtSchedule = gohelper.findChildText(slot0.viewGO, "Right/Slider/Schedule/#txt_Schedule")
	slot0._simageIcon = gohelper.findChildSingleImage(slot0.viewGO, "Right/Slider/Prop/#simage_Icon")
	slot0.rewardEffect = gohelper.findChild(slot0.viewGO, "Right/Slider/Prop/#effect")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "Right/Slider/Prop/#txt_Num")
	slot0._goHasGainedReward = gohelper.findChild(slot0.viewGO, "Right/Slider/Prop/#go_hasget")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickReward(slot0)
	if VersionActivity1_5BuildModel.instance.hasGainedReward then
		MaterialTipController.instance:showMaterialInfo(slot0.rewardType, slot0.rewardId)

		return
	end

	if VersionActivity1_5BuildModel.instance:getHadBuildCount() < 6 then
		MaterialTipController.instance:showMaterialInfo(slot0.rewardType, slot0.rewardId)

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct140GainProgressRewardRequest()
end

function slot0.initBuildItem(slot0)
	slot0.buildItemList = {}

	for slot4 = 1, VersionActivity1_5DungeonEnum.BuildCount do
		slot0:createBuildItem(slot4)
	end
end

function slot0.initSliderPointItem(slot0)
	slot0.sliderPointItemList = {}

	for slot4 = 1, 5 do
		table.insert(slot0.sliderPointItemList, slot0:createSliderPointItem(slot4))
	end
end

function slot0.initBuildImageItem(slot0)
	slot0.buildImageList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		table.insert(slot0.buildImageList, gohelper.findChildImage(slot0.viewGO, "#simage_FullBG/#image_build" .. slot4))
	end
end

function slot0.initPointItem(slot0)
	slot0.pointItemList = {}

	table.insert(slot0.pointItemList, slot0:createPointItem(slot0._gopointitem1))
	table.insert(slot0.pointItemList, slot0:createPointItem(slot0._gopointitem2))
	table.insert(slot0.pointItemList, slot0:createPointItem(slot0._gopointitem3))
end

function slot0.createPointItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.image = slot1:GetComponent(gohelper.Type_Image)
	slot2.effectGo1 = gohelper.findChild(slot1, "#effect_green")
	slot2.effectGo2 = gohelper.findChild(slot1, "#effect_yellow")

	return slot2
end

function slot0.onScrollValueChanged(slot0)
	gohelper.setActive(slot0._goArrow, slot0._scrolldesc.verticalNormalizedPosition >= 0.01)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_fullbg"))
	slot0._simageMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask"))
	slot0._simageRightMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	slot0._simageRightMask2:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	slot0._simageUpMask:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))
	slot0._simageUpMask2:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_mask4"))

	slot0.goLeft = gohelper.findChild(slot0.viewGO, "Left")
	slot0.goRight = gohelper.findChild(slot0.viewGO, "Right")
	slot0.goBackBtn = gohelper.findChild(slot0.viewGO, "#go_BackBtns")
	slot0.bgRectTr = gohelper.findChildComponent(slot0.viewGO, "#simage_FullBG", gohelper.Type_RectTransform)
	slot0.goMask = gohelper.findChild(slot0.viewGO, "#simage_Mask")

	slot0._scrolldesc:AddOnValueChanged(slot0.onScrollValueChanged, slot0)
	gohelper.setActive(slot0._gobuilditem, false)

	slot0.rewardClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "Right/Slider/Prop/#simage_Icon")

	slot0.rewardClick:AddClickListener(slot0.onClickReward, slot0)

	gohelper.findChildText(slot0.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem/image_EffectBG/#txt_buildname").text = luaLang("p_versionactivity_1_5_build_base_skill_effect_name")
	gohelper.findChildText(slot0.viewGO, "Left/#scroll_desc/Viewport/Content/#go_buildskillitem/#txt_buildskilldesc").text = luaLang("p_versionactivity_1_5_build_base_skill_effect_desc")
	slot0.skillItemDict = {}

	slot0:initPointItem()
	slot0:initBuildItem()
	slot0:initBuildImageItem()
	slot0:initSliderPointItem()
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, slot0.onUpdateBuildInfo, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, slot0.onUpdateSelectBuild, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, slot0.onSwitchSelectGroupBuild, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward, slot0.onUpdateGainedBuildReward, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.selectTypeList = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	slot0.slider:SetValue(VersionActivity1_5BuildModel.instance:getHadBuildCount())
	slot0:showUI()
	slot0:refreshUI()
	slot0:onScrollValueChanged()
end

function slot0.onOpenFinish(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshLeft()
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshPoint()
	slot0:refreshBuildSkill()
end

function slot0.refreshRight(slot0)
	slot0:refreshBuildIcon()
	slot0:refreshSlider()
	slot0:refreshReward()
	slot0:refreshRewardEffect()
	slot0:refreshBuildImage()
end

function slot0.refreshPoint(slot0)
	for slot4 = 1, VersionActivity1_5DungeonEnum.BuildCount do
		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot0.pointItemList[slot4].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[slot0.selectTypeList[slot4]])
	end
end

function slot0.refreshBuildSkill(slot0)
	for slot4, slot5 in ipairs(slot0.selectTypeList) do
		if slot5 ~= VersionActivity1_5DungeonEnum.BuildType.None then
			slot6 = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot4, slot5)
			slot7 = slot0.skillItemDict[slot4] or slot0:createSkillItem(slot4)
			slot7.txtbuildname.text = VersionActivity1_5BuildModel.getTextByType(slot5, slot6.name)
			slot7.txtbuildnameEn.text = slot6.nameEn
			slot7.txtbuildskilldesc.text = VersionActivity1_5BuildModel.getTextByType(slot5, slot6.skilldesc)

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot7.imagebuildnamebg, VersionActivity1_5DungeonEnum.BuildType2TitleBgImage[slot5])
		end
	end
end

function slot0.createSkillItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gobuildskillitem)
	slot2.imagebuildnamebg = gohelper.findChildImage(slot2.go, "image_EffectBG/")
	slot2.txtbuildname = gohelper.findChildText(slot2.go, "image_EffectBG/#txt_buildname")
	slot2.txtbuildnameEn = gohelper.findChildText(slot2.go, "Line/#txt_En")
	slot2.txtbuildskilldesc = gohelper.findChildText(slot2.go, "#txt_buildskilldesc")
	slot0.skillItemDict[slot1] = slot2

	return slot2
end

function slot0.refreshBuildIcon(slot0)
	for slot4, slot5 in ipairs(slot0.buildItemList) do
		slot6 = VersionActivity1_5BuildModel.instance:getBuildCoByGroupIndex(slot4) or VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot4, 1)
		slot7 = string.splitToNumber(slot6.pos, "#")

		recthelper.setAnchor(slot5.rectTr, slot7[1], slot7[2])

		slot9 = VersionActivity1_5BuildModel.instance:getCanBuildCount(slot6.group) > 0

		gohelper.setActive(slot5.goTips, not slot9)
		gohelper.setActive(slot5.goBuildName, slot9)

		slot10 = 2 - slot8
		slot5.txtCanBuild.text = string.format(luaLang("v1a5_builde_can_build"), slot10)

		gohelper.setActive(slot5.goCanBuild, slot10 > 0)
		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot5.bgImage, VersionActivity1_5DungeonEnum.BuildType2Image[VersionActivity1_5BuildModel.instance:getSelectType(slot4)])
		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot5.buildIconImage, slot6.icon)

		if slot9 then
			slot5.txtBuildName.text = slot6.name
		end
	end
end

function slot0.createBuildItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.groupIndex = slot1
	slot2.go = gohelper.cloneInPlace(slot0._gobuilditem)

	gohelper.setActive(slot2.go, true)

	slot2.rectTr = slot2.go:GetComponent(gohelper.Type_RectTransform)
	slot2.bgImage = gohelper.findChildImage(slot2.go, "Totem/#image_TotemBG")
	slot2.buildIconImage = gohelper.findChildImage(slot2.go, "Totem/#image_TotemBG/#image_TotemIcon")
	slot2.goCanBuild = gohelper.findChild(slot2.go, "#go_CanBuild")
	slot2.txtCanBuild = gohelper.findChildText(slot2.go, "#go_CanBuild/#txt_CanBuild")
	slot2.goBuildName = gohelper.findChild(slot2.go, "#go_Name")
	slot2.txtBuildName = gohelper.findChildText(slot2.go, "#go_Name/#txt_BuildName")
	slot2.goTips = gohelper.findChild(slot2.go, "#go_Tips")
	slot2.goClick = gohelper.findChildClickWithDefaultAudio(slot2.go, "clickarea")

	slot2.goClick:AddClickListener(slot0.onClickBuild, slot0, slot2)
	table.insert(slot0.buildItemList, slot2)

	return slot2
end

function slot0.createSliderPointItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.findChild(slot0.viewGO, "Right/Slider/Layout/Point" .. slot1)
	slot2.goNormal = gohelper.findChild(slot2.go, "image_PointBG")
	slot2.goFinish = gohelper.findChild(slot2.go, "image_PointFG")

	return slot2
end

function slot0.refreshReward(slot0)
	slot1, slot2, slot0._txtNum.text = VersionActivity1_5DungeonConfig.instance:getBuildReward()
	slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot1, slot2)

	slot0._simageIcon:LoadImage(slot5)

	slot0.rewardId = slot2
	slot0.rewardType = slot1

	gohelper.setActive(slot0._goHasGainedReward, VersionActivity1_5BuildModel.instance.hasGainedReward)
end

function slot0.refreshRewardEffect(slot0)
	if VersionActivity1_5BuildModel.instance.hasGainedReward then
		gohelper.setActive(slot0.rewardEffect, false)

		return
	end

	gohelper.setActive(slot0.rewardEffect, VersionActivity1_5BuildModel.instance:getHadBuildCount() == 6)
end

function slot0.refreshSlider(slot0)
	slot1 = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	for slot5 = 1, 5 do
		slot6 = slot0.sliderPointItemList[slot5]
		slot7 = slot5 <= slot1

		gohelper.setActive(slot6.goNormal, not slot7)
		gohelper.setActive(slot6.goFinish, slot7)
	end

	slot0._txtSchedule.text = Mathf.Ceil(slot1 / 6 * 100) .. "%"
end

function slot0.refreshBuildImage(slot0)
	for slot4, slot5 in ipairs(slot0.buildImageList) do
		if VersionActivity1_5DungeonEnum.BuildType.None == VersionActivity1_5BuildModel.instance:getSelectType(slot4) then
			gohelper.setActive(slot5.gameObject, false)
		else
			gohelper.setActive(slot5.gameObject, true)
			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot5, VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot4, slot6).previewImg)
		end
	end
end

function slot0.onUpdateGainedBuildReward(slot0)
	gohelper.setActive(slot0._goHasGainedReward, VersionActivity1_5BuildModel.instance.hasGainedReward)
	slot0:refreshRewardEffect()
end

function slot0.onClickBuild(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.pointItemList) do
		gohelper.setActive(slot6.effectGo1, false)
		gohelper.setActive(slot6.effectGo2, false)
	end

	slot0.focusBuildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot1.groupIndex, 1)
	slot0.preSelectTypeList = tabletool.copy(VersionActivity1_5BuildModel.instance:getSelectTypeList())
	slot0.preHadBuildCount = VersionActivity1_5BuildModel.instance:getHadBuildCount()

	ViewMgr.instance:openView(ViewName.V1a5BuildingDetailView, {
		groupIndex = slot1.groupIndex
	})
end

function slot0.onOpenView(slot0, slot1)
	if slot1 ~= ViewName.V1a5BuildingDetailView then
		return
	end

	slot0:hideUI()
	slot0:playFocusAnim()
end

function slot0.onCloseView(slot0, slot1)
	if slot1 ~= ViewName.V1a5BuildingDetailView then
		return
	end

	slot0:playRevertAnim(slot0.onRevertAnimDone)
end

function slot0.showUI(slot0)
	gohelper.setActive(slot0.goLeft, true)
	gohelper.setActive(slot0.goRight, true)
	gohelper.setActive(slot0.goBackBtn, true)
	gohelper.setActive(slot0.goMask, true)
end

function slot0.hideUI(slot0)
	gohelper.setActive(slot0.goLeft, false)
	gohelper.setActive(slot0.goRight, false)
	gohelper.setActive(slot0.goBackBtn, false)
	gohelper.setActive(slot0.goMask, false)
end

function slot0.playFocusAnim(slot0, slot1)
	slot0:killAnim()

	slot0.finishCallback = slot1
	slot0.startAnchorX = 0
	slot0.startAnchorY = 0
	slot0.targetAnchorX = slot0.focusBuildCo.focusPosX
	slot0.targetAnchorY = slot0.focusBuildCo.focusPosY
	slot0.startScale = 1
	slot0.targetScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, slot0.frameCall, slot0.finishCall, slot0)
end

function slot0.playRevertAnim(slot0, slot1)
	slot0:killAnim()

	slot0.finishCallback = slot1
	slot0.startAnchorX = slot0.focusBuildCo.focusPosX
	slot0.startAnchorY = slot0.focusBuildCo.focusPosY
	slot0.targetAnchorX = 0
	slot0.targetAnchorY = 0
	slot0.startScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	slot0.targetScale = 1
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, slot0.frameCall, slot0.finishCall, slot0)
end

function slot0.frameCall(slot0, slot1)
	slot4 = Mathf.Lerp(slot0.startScale, slot0.targetScale, slot1)

	recthelper.setAnchor(slot0.bgRectTr, Mathf.Lerp(slot0.startAnchorX, slot0.targetAnchorX, slot1), Mathf.Lerp(slot0.startAnchorY, slot0.targetAnchorY, slot1))
	transformhelper.setLocalScale(slot0.bgRectTr, slot4, slot4, slot4)
end

function slot0.finishCall(slot0)
	recthelper.setAnchor(slot0.bgRectTr, slot0.targetAnchorX, slot0.targetAnchorY)
	transformhelper.setLocalScale(slot0.bgRectTr, slot0.targetScale, slot0.targetScale, slot0.targetScale)

	if slot0.finishCallback then
		slot0:finishCallback()

		slot0.finishCallback = nil
	end
end

function slot0.killAnim(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)
	end

	slot0.finishCallback = nil
end

function slot0.onRevertAnimDone(slot0)
	slot0:showUI()
	slot0:playPointAnimation()
	slot0:playSliderAnimation()
end

function slot0.onUpdateBuildInfo(slot0)
	slot0:refreshLeft()
	slot0:playPointAnimation()
	slot0:playSliderAnimation()
	slot0:refreshBuildImage()
	slot0:refreshSlider()
	slot0:refreshRewardEffect()
	slot0:refreshBuildIcon()
end

function slot0.onUpdateSelectBuild(slot0)
	slot0:refreshLeft()
	slot0:playPointAnimation()
	slot0:refreshBuildIcon()
	slot0:refreshBuildImage()
end

function slot0.playPointAnimation(slot0)
	if ViewMgr.instance:isOpen(ViewName.V1a5BuildingDetailView) then
		return
	end

	if not slot0.preSelectTypeList then
		return
	end

	for slot5, slot6 in ipairs(VersionActivity1_5BuildModel.instance:getSelectTypeList()) do
		if slot6 ~= slot0.preSelectTypeList[slot5] then
			if slot6 == VersionActivity1_5DungeonEnum.BuildType.First then
				gohelper.setActive(slot0.pointItemList[slot5].effectGo1, true)
			else
				gohelper.setActive(slot7.effectGo2, true)
			end
		end
	end

	slot0.preSelectTypeList = nil
end

function slot0.playSliderAnimation(slot0)
	if ViewMgr.instance:isOpen(ViewName.V1a5BuildingDetailView) then
		return
	end

	if slot0.preHadBuildCount == VersionActivity1_5BuildModel.instance:getHadBuildCount() then
		return
	end

	if slot0.sliderTweenId then
		ZProj.TweenHelper.KillById(slot0.sliderTweenId)
	end

	slot0.sliderTweenId = ZProj.TweenHelper.DOTweenFloat(slot0.preHadBuildCount, slot1, VersionActivity1_5DungeonEnum.SliderAnimTime, slot0.sliderFrameCall, nil, slot0)
end

function slot0.sliderFrameCall(slot0, slot1)
	slot0.slider:SetValue(slot1)
end

function slot0.onSwitchSelectGroupBuild(slot0, slot1)
	slot0:killAnim()

	slot0.focusBuildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot1, 1)
	slot0.startAnchorX, slot0.startAnchorY = recthelper.getAnchor(slot0.bgRectTr)
	slot0.targetAnchorX = slot0.focusBuildCo.focusPosX
	slot0.targetAnchorY = slot0.focusBuildCo.focusPosY
	slot0.startScale = transformhelper.getLocalScale(slot0.bgRectTr)
	slot0.targetScale = VersionActivity1_5DungeonEnum.BuildMaxScale
	slot0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, VersionActivity1_5DungeonEnum.BuildFocusAnimTime, slot0.frameCall, slot0.finishCall, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, slot0.onUpdateBuildInfo, slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, slot0.onUpdateSelectBuild, slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, slot0.onSwitchSelectGroupBuild, slot0)
	slot0:removeEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateGainedBuildReward, slot0.onUpdateGainedBuildReward, slot0)
	slot0:killAnim()

	if slot0.sliderTweenId then
		ZProj.TweenHelper.KillById(slot0.sliderTweenId)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageMask:UnLoadImage()
	slot0._simageRightMask:UnLoadImage()
	slot0._simageRightMask2:UnLoadImage()
	slot0._simageUpMask:UnLoadImage()
	slot0._simageUpMask2:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.buildItemList) do
		slot5.goClick:RemoveClickListener()
	end

	slot0._scrolldesc:RemoveOnValueChanged()
	slot0.rewardClick:RemoveClickListener()
end

return slot0
