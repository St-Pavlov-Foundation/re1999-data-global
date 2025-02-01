module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingSkillView", package.seeall)

slot0 = class("V1a5BuildingSkillView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "left/#scroll_desc")
	slot0._gobuildskillitem = gohelper.findChild(slot0.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem")
	slot0.goBuildItem = gohelper.findChild(slot0.viewGO, "right/#go_builditem")
	slot0._goArrow = gohelper.findChild(slot0.viewGO, "left/#go_Arrow")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot0.BuildItemAnchorList = {
	220,
	-60,
	-340
}

function slot0.onScrollValueChanged(slot0)
	gohelper.setActive(slot0._goArrow, slot0._scrolldesc.verticalNormalizedPosition >= 0.01)
end

function slot0.initPointItem(slot0)
	slot0.pointItemList = {}

	table.insert(slot0.pointItemList, slot0:createPointItem(gohelper.findChild(slot0.viewGO, "left/point_container/#go_pointitem1")))
	table.insert(slot0.pointItemList, slot0:createPointItem(gohelper.findChild(slot0.viewGO, "left/point_container/#go_pointitem2")))
	table.insert(slot0.pointItemList, slot0:createPointItem(gohelper.findChild(slot0.viewGO, "left/point_container/#go_pointitem3")))
end

function slot0.createPointItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.image = slot1:GetComponent(gohelper.Type_Image)
	slot2.effectGo1 = gohelper.findChild(slot1, "#effect_green")
	slot2.effectGo2 = gohelper.findChild(slot1, "#effect_yellow")

	return slot2
end

function slot0.initBuildItem(slot0)
	slot0.buildItemList = {}

	for slot4 = 1, VersionActivity1_5DungeonEnum.BuildCount do
		table.insert(slot0.buildItemList, slot0:createBuildItem(slot4))
	end
end

function slot0._editableInitView(slot0)
	slot0.skillContentRectTr = gohelper.findChildComponent(slot0.viewGO, "left/#scroll_desc/Viewport/Content", gohelper.Type_RectTransform)
	slot0.viewPortHeight = recthelper.getHeight(gohelper.findChildComponent(slot0.viewGO, "left/#scroll_desc/Viewport", gohelper.Type_RectTransform))

	gohelper.setActive(slot0.goBuildItem, false)

	slot0.singleImageBg = gohelper.findChildSingleImage(slot0.viewGO, "bg")
	gohelper.findChildText(slot0.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem/ani/image_EffectBG/#txt_buildname").text = luaLang("p_versionactivity_1_5_build_base_skill_effect_name")
	gohelper.findChildText(slot0.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem/ani/#txt_buildskilldesc").text = luaLang("p_versionactivity_1_5_build_base_skill_effect_desc")

	slot0._scrolldesc:AddOnValueChanged(slot0.onScrollValueChanged, slot0)

	slot0.labelList = {
		luaLang("p_versionactivity_1_5_build1_label"),
		luaLang("p_versionactivity_1_5_build2_label"),
		luaLang("p_versionactivity_1_5_build3_label")
	}
	slot0.skillItemDict = {}

	slot0:initPointItem()
	slot0:initBuildItem()
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, slot0.onUpdateSelectBuild, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshPointImage()
	slot0:refreshBuildSkill()
	slot0:refreshBuildIcon()
	slot0:onScrollValueChanged()
end

function slot0.refreshPointImage(slot0)
	for slot4 = 1, VersionActivity1_5DungeonEnum.BuildCount do
		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot0.pointItemList[slot4].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[VersionActivity1_5BuildModel.instance:getSelectType(slot4)])
	end
end

function slot0.refreshBuildSkill(slot0)
	for slot5, slot6 in ipairs(VersionActivity1_5BuildModel.instance:getSelectTypeList()) do
		if slot6 ~= VersionActivity1_5DungeonEnum.BuildType.None then
			slot7 = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot5, slot6)
			slot8 = slot0.skillItemDict[slot5] or slot0:createSkillItem(slot5)
			slot8.txtbuildname.text = VersionActivity1_5BuildModel.getTextByType(slot6, slot7.name)
			slot8.txtbuildnameEn.text = slot7.nameEn
			slot8.txtbuildskilldesc.text = VersionActivity1_5BuildModel.getTextByType(slot6, slot7.skilldesc)

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot8.imagebuildnamebg, VersionActivity1_5DungeonEnum.BuildType2TitleBgImage[slot6])
		end
	end
end

function slot0.refreshBuildIcon(slot0)
	for slot4, slot5 in ipairs(slot0.buildItemList) do
		slot5.txtLabel.text = slot0.labelList[slot4]

		for slot9, slot10 in ipairs(slot5.subBuildList) do
			slot11 = slot10.buildCo
			slot10.txtBuildName.text = slot11.name

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot10.icon, slot11.icon)

			if VersionActivity1_5BuildModel.instance:checkBuildIsHad(slot11.id) then
				UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot10.iconBg, VersionActivity1_5DungeonEnum.BuildType2Image[slot11.type])
			else
				UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot10.iconBg, VersionActivity1_5DungeonEnum.BuildType2Image[VersionActivity1_5DungeonEnum.BuildType.None])
			end

			slot14 = VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(slot12)

			gohelper.setActive(slot10.goSelect, slot14)

			if slot14 and slot13 then
				slot10.canvasGroup.alpha = 1
			else
				slot10.canvasGroup.alpha = 0.5
			end
		end
	end
end

function slot0.createSkillItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._gobuildskillitem)
	slot2.aniGo = gohelper.findChild(slot2.go, "ani")
	slot2.rectTr = slot2.go:GetComponent(gohelper.Type_RectTransform)
	slot2.imagebuildnamebg = gohelper.findChildImage(slot2.aniGo, "image_EffectBG")
	slot2.txtbuildname = gohelper.findChildText(slot2.aniGo, "image_EffectBG/#txt_buildname")
	slot2.txtbuildnameEn = gohelper.findChildText(slot2.aniGo, "Line/#txt_En")
	slot2.txtbuildskilldesc = gohelper.findChildText(slot2.aniGo, "#txt_buildskilldesc")
	slot2.animator = slot2.go:GetComponent(gohelper.Type_Animator)
	slot0.skillItemDict[slot1] = slot2

	return slot2
end

function slot0.createBuildItem(slot0, slot1)
	slot2 = gohelper.cloneInPlace(slot0.goBuildItem)

	gohelper.setActive(slot2, true)

	slot3 = slot0:getUserDataTb_()
	slot3.go = slot2
	slot3.rectTr = slot3.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorY(slot3.rectTr, uv0.BuildItemAnchorList[slot1])

	slot3.txtLabel = gohelper.findChildText(slot3.go, "header/#txt_buildlabel")
	slot3.subBuildList = {}

	table.insert(slot3.subBuildList, slot0:createBuildSubItem(gohelper.findChild(slot3.go, "content/build1"), slot1, 1))
	table.insert(slot3.subBuildList, slot0:createBuildSubItem(gohelper.findChild(slot3.go, "content/build2"), slot1, 2))

	return slot3
end

function slot0.createBuildSubItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.canvasGroup = slot4.go:GetComponent(gohelper.Type_CanvasGroup)
	slot4.iconBg = gohelper.findChildImage(slot4.go, "#image_BuildBG")
	slot4.goSelect = gohelper.findChild(slot4.go, "#image_BuildBG/#go_select")
	slot4.icon = gohelper.findChildImage(slot4.go, "#image_BuildBG/#image_TotemIcon")
	slot4.txtBuildName = gohelper.findChildText(slot4.go, "txt_buildname")
	slot4.click = gohelper.findChildClickWithDefaultAudio(slot4.go, "clickarea")
	slot4.buildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(slot2, slot3)

	slot4.click:AddClickListener(slot0.onClickBuildSubItem, slot0, slot4)

	return slot4
end

function slot0.onClickBuildSubItem(slot0, slot1)
	if not VersionActivity1_5BuildModel.instance:checkBuildIsHad(slot1.buildCo.id) then
		GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

		return
	end

	if VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(slot3) then
		return
	end

	slot0.changeGroupIndex = slot2.group

	VersionActivity1_5BuildModel.instance:setSelectBuildId(slot2)
	VersionActivity1_5DungeonRpc.instance:sendAct140SelectBuildRequest(VersionActivity1_5BuildModel.instance.selectBuildList)
end

function slot0.onUpdateSelectBuild(slot0)
	slot0:setSkillContainerAnchorY()
	slot0:refreshPointImage()
	slot0:playPointAnimation()
	slot0:refreshBuildSkill()
	slot0:playBuildSkillAnimation()
	slot0:refreshBuildIcon()

	slot0.changeGroupIndex = nil
end

function slot0.setSkillContainerAnchorY(slot0)
	if not slot0.skillItemDict[slot0.changeGroupIndex] then
		return
	end

	if not slot0.maxAnchorY then
		slot0.maxAnchorY = recthelper.getHeight(slot0.skillContentRectTr) - slot0.viewPortHeight
	end

	recthelper.setAnchorY(slot0.skillContentRectTr, Mathf.Min(-recthelper.getAnchorY(slot1.rectTr), slot0.maxAnchorY))
end

function slot0.playPointAnimation(slot0)
	if not slot0.changeGroupIndex then
		return
	end

	slot2 = slot0.pointItemList[slot0.changeGroupIndex]

	gohelper.setActive(slot2.effectGo1, false)
	gohelper.setActive(slot2.effectGo2, false)

	if VersionActivity1_5BuildModel.instance:getSelectType(slot0.changeGroupIndex) == VersionActivity1_5DungeonEnum.BuildType.First then
		gohelper.setActive(slot2.effectGo1, true)
	else
		gohelper.setActive(slot2.effectGo2, true)
	end
end

function slot0.playBuildSkillAnimation(slot0)
	if not slot0.changeGroupIndex then
		return
	end

	slot0.skillItemDict[slot0.changeGroupIndex].animator:Play(VersionActivity1_5BuildModel.instance:getSelectType(slot0.changeGroupIndex) == VersionActivity1_5DungeonEnum.BuildType.First and "switch_green" or "switch_orange", 0, 0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0.singleImageBg:UnLoadImage()
	slot0._scrolldesc:RemoveOnValueChanged()

	for slot4, slot5 in ipairs(slot0.buildItemList) do
		for slot9, slot10 in ipairs(slot5.subBuildList) do
			slot10.click:RemoveClickListener()
		end
	end
end

return slot0
