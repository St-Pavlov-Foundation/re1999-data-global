module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingSkillView", package.seeall)

local var_0_0 = class("V1a5BuildingSkillView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "left/#scroll_desc")
	arg_1_0._gobuildskillitem = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem")
	arg_1_0.goBuildItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_builditem")
	arg_1_0._goArrow = gohelper.findChild(arg_1_0.viewGO, "left/#go_Arrow")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

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

var_0_0.BuildItemAnchorList = {
	220,
	-60,
	-340
}

function var_0_0.onScrollValueChanged(arg_4_0)
	gohelper.setActive(arg_4_0._goArrow, arg_4_0._scrolldesc.verticalNormalizedPosition >= 0.01)
end

function var_0_0.initPointItem(arg_5_0)
	arg_5_0.pointItemList = {}

	table.insert(arg_5_0.pointItemList, arg_5_0:createPointItem(gohelper.findChild(arg_5_0.viewGO, "left/point_container/#go_pointitem1")))
	table.insert(arg_5_0.pointItemList, arg_5_0:createPointItem(gohelper.findChild(arg_5_0.viewGO, "left/point_container/#go_pointitem2")))
	table.insert(arg_5_0.pointItemList, arg_5_0:createPointItem(gohelper.findChild(arg_5_0.viewGO, "left/point_container/#go_pointitem3")))
end

function var_0_0.createPointItem(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getUserDataTb_()

	var_6_0.image = arg_6_1:GetComponent(gohelper.Type_Image)
	var_6_0.effectGo1 = gohelper.findChild(arg_6_1, "#effect_green")
	var_6_0.effectGo2 = gohelper.findChild(arg_6_1, "#effect_yellow")

	return var_6_0
end

function var_0_0.initBuildItem(arg_7_0)
	arg_7_0.buildItemList = {}

	for iter_7_0 = 1, VersionActivity1_5DungeonEnum.BuildCount do
		table.insert(arg_7_0.buildItemList, arg_7_0:createBuildItem(iter_7_0))
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.skillContentRectTr = gohelper.findChildComponent(arg_8_0.viewGO, "left/#scroll_desc/Viewport/Content", gohelper.Type_RectTransform)

	local var_8_0 = gohelper.findChildComponent(arg_8_0.viewGO, "left/#scroll_desc/Viewport", gohelper.Type_RectTransform)

	arg_8_0.viewPortHeight = recthelper.getHeight(var_8_0)

	gohelper.setActive(arg_8_0.goBuildItem, false)

	arg_8_0.singleImageBg = gohelper.findChildSingleImage(arg_8_0.viewGO, "bg")

	local var_8_1 = gohelper.findChildText(arg_8_0.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem/ani/image_EffectBG/#txt_buildname")
	local var_8_2 = gohelper.findChildText(arg_8_0.viewGO, "left/#scroll_desc/Viewport/Content/#go_buildskillitem/ani/#txt_buildskilldesc")

	var_8_1.text = luaLang("p_versionactivity_1_5_build_base_skill_effect_name")
	var_8_2.text = luaLang("p_versionactivity_1_5_build_base_skill_effect_desc")

	arg_8_0._scrolldesc:AddOnValueChanged(arg_8_0.onScrollValueChanged, arg_8_0)

	arg_8_0.labelList = {
		luaLang("p_versionactivity_1_5_build1_label"),
		luaLang("p_versionactivity_1_5_build2_label"),
		luaLang("p_versionactivity_1_5_build3_label")
	}
	arg_8_0.skillItemDict = {}

	arg_8_0:initPointItem()
	arg_8_0:initBuildItem()
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, arg_8_0.onUpdateSelectBuild, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0:refreshPointImage()
	arg_11_0:refreshBuildSkill()
	arg_11_0:refreshBuildIcon()
	arg_11_0:onScrollValueChanged()
end

function var_0_0.refreshPointImage(arg_12_0)
	for iter_12_0 = 1, VersionActivity1_5DungeonEnum.BuildCount do
		local var_12_0 = VersionActivity1_5BuildModel.instance:getSelectType(iter_12_0)

		UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(arg_12_0.pointItemList[iter_12_0].image, VersionActivity1_5DungeonEnum.BuildType2SmallImage[var_12_0])
	end
end

function var_0_0.refreshBuildSkill(arg_13_0)
	local var_13_0 = VersionActivity1_5BuildModel.instance:getSelectTypeList()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1 ~= VersionActivity1_5DungeonEnum.BuildType.None then
			local var_13_1 = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(iter_13_0, iter_13_1)
			local var_13_2 = arg_13_0.skillItemDict[iter_13_0] or arg_13_0:createSkillItem(iter_13_0)

			var_13_2.txtbuildname.text = VersionActivity1_5BuildModel.getTextByType(iter_13_1, var_13_1.name)
			var_13_2.txtbuildnameEn.text = var_13_1.nameEn
			var_13_2.txtbuildskilldesc.text = VersionActivity1_5BuildModel.getTextByType(iter_13_1, var_13_1.skilldesc)

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(var_13_2.imagebuildnamebg, VersionActivity1_5DungeonEnum.BuildType2TitleBgImage[iter_13_1])
		end
	end
end

function var_0_0.refreshBuildIcon(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.buildItemList) do
		iter_14_1.txtLabel.text = arg_14_0.labelList[iter_14_0]

		for iter_14_2, iter_14_3 in ipairs(iter_14_1.subBuildList) do
			local var_14_0 = iter_14_3.buildCo
			local var_14_1 = var_14_0.id

			iter_14_3.txtBuildName.text = var_14_0.name

			UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(iter_14_3.icon, var_14_0.icon)

			local var_14_2 = VersionActivity1_5BuildModel.instance:checkBuildIsHad(var_14_1)

			if var_14_2 then
				UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(iter_14_3.iconBg, VersionActivity1_5DungeonEnum.BuildType2Image[var_14_0.type])
			else
				UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(iter_14_3.iconBg, VersionActivity1_5DungeonEnum.BuildType2Image[VersionActivity1_5DungeonEnum.BuildType.None])
			end

			local var_14_3 = VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(var_14_1)

			gohelper.setActive(iter_14_3.goSelect, var_14_3)

			if var_14_3 and var_14_2 then
				iter_14_3.canvasGroup.alpha = 1
			else
				iter_14_3.canvasGroup.alpha = 0.5
			end
		end
	end
end

function var_0_0.createSkillItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = gohelper.cloneInPlace(arg_15_0._gobuildskillitem)
	var_15_0.aniGo = gohelper.findChild(var_15_0.go, "ani")
	var_15_0.rectTr = var_15_0.go:GetComponent(gohelper.Type_RectTransform)
	var_15_0.imagebuildnamebg = gohelper.findChildImage(var_15_0.aniGo, "image_EffectBG")
	var_15_0.txtbuildname = gohelper.findChildText(var_15_0.aniGo, "image_EffectBG/#txt_buildname")
	var_15_0.txtbuildnameEn = gohelper.findChildText(var_15_0.aniGo, "Line/#txt_En")
	var_15_0.txtbuildskilldesc = gohelper.findChildText(var_15_0.aniGo, "#txt_buildskilldesc")
	var_15_0.animator = var_15_0.go:GetComponent(gohelper.Type_Animator)
	arg_15_0.skillItemDict[arg_15_1] = var_15_0

	return var_15_0
end

function var_0_0.createBuildItem(arg_16_0, arg_16_1)
	local var_16_0 = gohelper.cloneInPlace(arg_16_0.goBuildItem)

	gohelper.setActive(var_16_0, true)

	local var_16_1 = arg_16_0:getUserDataTb_()

	var_16_1.go = var_16_0
	var_16_1.rectTr = var_16_1.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorY(var_16_1.rectTr, var_0_0.BuildItemAnchorList[arg_16_1])

	var_16_1.txtLabel = gohelper.findChildText(var_16_1.go, "header/#txt_buildlabel")
	var_16_1.subBuildList = {}

	local var_16_2 = gohelper.findChild(var_16_1.go, "content/build1")
	local var_16_3 = gohelper.findChild(var_16_1.go, "content/build2")

	table.insert(var_16_1.subBuildList, arg_16_0:createBuildSubItem(var_16_2, arg_16_1, 1))
	table.insert(var_16_1.subBuildList, arg_16_0:createBuildSubItem(var_16_3, arg_16_1, 2))

	return var_16_1
end

function var_0_0.createBuildSubItem(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = arg_17_0:getUserDataTb_()

	var_17_0.go = arg_17_1
	var_17_0.canvasGroup = var_17_0.go:GetComponent(gohelper.Type_CanvasGroup)
	var_17_0.iconBg = gohelper.findChildImage(var_17_0.go, "#image_BuildBG")
	var_17_0.goSelect = gohelper.findChild(var_17_0.go, "#image_BuildBG/#go_select")
	var_17_0.icon = gohelper.findChildImage(var_17_0.go, "#image_BuildBG/#image_TotemIcon")
	var_17_0.txtBuildName = gohelper.findChildText(var_17_0.go, "txt_buildname")
	var_17_0.click = gohelper.findChildClickWithDefaultAudio(var_17_0.go, "clickarea")
	var_17_0.buildCo = VersionActivity1_5DungeonConfig.instance:getBuildCoByGroupAndType(arg_17_2, arg_17_3)

	var_17_0.click:AddClickListener(arg_17_0.onClickBuildSubItem, arg_17_0, var_17_0)

	return var_17_0
end

function var_0_0.onClickBuildSubItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.buildCo
	local var_18_1 = var_18_0.id

	if not VersionActivity1_5BuildModel.instance:checkBuildIsHad(var_18_1) then
		GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

		return
	end

	if VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(var_18_1) then
		return
	end

	arg_18_0.changeGroupIndex = var_18_0.group

	VersionActivity1_5BuildModel.instance:setSelectBuildId(var_18_0)
	VersionActivity1_5DungeonRpc.instance:sendAct140SelectBuildRequest(VersionActivity1_5BuildModel.instance.selectBuildList)
end

function var_0_0.onUpdateSelectBuild(arg_19_0)
	arg_19_0:setSkillContainerAnchorY()
	arg_19_0:refreshPointImage()
	arg_19_0:playPointAnimation()
	arg_19_0:refreshBuildSkill()
	arg_19_0:playBuildSkillAnimation()
	arg_19_0:refreshBuildIcon()

	arg_19_0.changeGroupIndex = nil
end

function var_0_0.setSkillContainerAnchorY(arg_20_0)
	local var_20_0 = arg_20_0.skillItemDict[arg_20_0.changeGroupIndex]

	if not var_20_0 then
		return
	end

	if not arg_20_0.maxAnchorY then
		arg_20_0.maxAnchorY = recthelper.getHeight(arg_20_0.skillContentRectTr) - arg_20_0.viewPortHeight
	end

	local var_20_1 = recthelper.getAnchorY(var_20_0.rectTr)

	recthelper.setAnchorY(arg_20_0.skillContentRectTr, Mathf.Min(-var_20_1, arg_20_0.maxAnchorY))
end

function var_0_0.playPointAnimation(arg_21_0)
	if not arg_21_0.changeGroupIndex then
		return
	end

	local var_21_0 = VersionActivity1_5BuildModel.instance:getSelectType(arg_21_0.changeGroupIndex)
	local var_21_1 = arg_21_0.pointItemList[arg_21_0.changeGroupIndex]

	gohelper.setActive(var_21_1.effectGo1, false)
	gohelper.setActive(var_21_1.effectGo2, false)

	if var_21_0 == VersionActivity1_5DungeonEnum.BuildType.First then
		gohelper.setActive(var_21_1.effectGo1, true)
	else
		gohelper.setActive(var_21_1.effectGo2, true)
	end
end

function var_0_0.playBuildSkillAnimation(arg_22_0)
	if not arg_22_0.changeGroupIndex then
		return
	end

	local var_22_0 = VersionActivity1_5BuildModel.instance:getSelectType(arg_22_0.changeGroupIndex)

	arg_22_0.skillItemDict[arg_22_0.changeGroupIndex].animator:Play(var_22_0 == VersionActivity1_5DungeonEnum.BuildType.First and "switch_green" or "switch_orange", 0, 0)
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0.singleImageBg:UnLoadImage()
	arg_24_0._scrolldesc:RemoveOnValueChanged()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0.buildItemList) do
		for iter_24_2, iter_24_3 in ipairs(iter_24_1.subBuildList) do
			iter_24_3.click:RemoveClickListener()
		end
	end
end

return var_0_0
