module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingDetailView", package.seeall)

local var_0_0 = class("V1a5BuildingDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._goItem = gohelper.findChild(arg_1_0.viewGO, "#go_Item")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Left")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Right")
	arg_1_0.goBuildEffect = gohelper.findChild(arg_1_0.viewGO, "image_Select/leveup")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnLeft:RemoveClickListener()
	arg_3_0._btnRight:RemoveClickListener()
end

var_0_0.AnchorXList = {
	-15,
	570
}

function var_0_0._btnLeftOnClick(arg_4_0)
	arg_4_0.groupIndex = arg_4_0.groupIndex - 1

	if arg_4_0.groupIndex == 0 then
		arg_4_0.groupIndex = VersionActivity1_5DungeonEnum.BuildCount
	end

	arg_4_0:getBuildCoList()
	arg_4_0:refreshUI()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, arg_4_0.groupIndex)
end

function var_0_0._btnRightOnClick(arg_5_0)
	arg_5_0.groupIndex = arg_5_0.groupIndex + 1

	if arg_5_0.groupIndex > VersionActivity1_5DungeonEnum.BuildCount then
		arg_5_0.groupIndex = 1
	end

	arg_5_0:getBuildCoList()
	arg_5_0:refreshUI()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, arg_5_0.groupIndex)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._goItem, false)

	arg_6_0.itemList = {}

	table.insert(arg_6_0.itemList, arg_6_0:createItem(1))
	table.insert(arg_6_0.itemList, arg_6_0:createItem(2))
	arg_6_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, arg_6_0.onUpdateBuildInfo, arg_6_0)
	arg_6_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, arg_6_0.onUpdateSelectBuild, arg_6_0)
	arg_6_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_6_0.closeThis, arg_6_0)
end

function var_0_0.createItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getUserDataTb_()

	var_7_0.go = gohelper.cloneInPlace(arg_7_0._goItem)

	gohelper.setActive(var_7_0.go, true)

	var_7_0.goTr = var_7_0.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorX(var_7_0.goTr, var_0_0.AnchorXList[arg_7_1])

	var_7_0.simageItemBG = gohelper.findChildSingleImage(var_7_0.go, "#simage_ItemBG")

	var_7_0.simageItemBG:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_toteminfobg"))

	var_7_0.imageBuildBG = gohelper.findChildImage(var_7_0.go, "Totem/#image_BuildBG")
	var_7_0.imageTotemIcon = gohelper.findChildImage(var_7_0.go, "Totem/#image_BuildBG/#image_TotemIcon")
	var_7_0.imageBuildingPic = gohelper.findChildImage(var_7_0.go, "#image_BuildingPic")
	var_7_0.txtBuildName = gohelper.findChildText(var_7_0.go, "#txt_BuildName")
	var_7_0.txtBuildNameEn = gohelper.findChildText(var_7_0.go, "#txt_BuildNameEn")
	var_7_0.txtDesc = gohelper.findChildText(var_7_0.go, "Scroll View/Viewport/content/#txt_Desc")
	var_7_0.txtSkillDesc = gohelper.findChildText(var_7_0.go, "Scroll View/Viewport/content/#txt_skilldesc")
	var_7_0.goInEffect = gohelper.findChild(var_7_0.go, "#go_InEffect")
	var_7_0.goBuild = gohelper.findChild(var_7_0.go, "#go_Build")
	var_7_0.goUse = gohelper.findChild(var_7_0.go, "#go_use")
	var_7_0.txtPropNum = gohelper.findChildText(var_7_0.go, "#go_Build/#txt_PropNum")
	var_7_0.simageProp = gohelper.findChildSingleImage(var_7_0.go, "#go_Build/#txt_PropNum/#simage_Prop")
	var_7_0.btnBuild = gohelper.findChildButtonWithAudio(var_7_0.go, "#go_Build/#btn_Build")
	var_7_0.btnUse = gohelper.findChildButtonWithAudio(var_7_0.go, "#go_use/#btn_use")

	var_7_0.btnBuild:AddClickListener(arg_7_0.onClickBuildBtn, arg_7_0, arg_7_1)
	var_7_0.btnUse:AddClickListener(arg_7_0.onClickUseBtn, arg_7_0, arg_7_1)

	return var_7_0
end

function var_0_0.onClickBuildBtn(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.buildCoList[arg_8_1]

	if VersionActivity1_5BuildModel.instance:checkBuildIsHad(var_8_0.id) then
		return
	end

	local var_8_1 = var_8_0.costList[1]
	local var_8_2 = var_8_0.costList[2]
	local var_8_3 = var_8_0.costList[3]
	local var_8_4 = ItemModel.instance:getItemQuantity(var_8_1, var_8_2)
	local var_8_5 = ItemConfig.instance:getItemConfig(var_8_1, var_8_2)

	if var_8_4 < var_8_3 then
		GameFacade.showToastString(string.format(luaLang("store_currency_limit"), var_8_5.name))

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct140BuildRequest(var_8_0.id)
end

function var_0_0.onClickUseBtn(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.buildCoList[arg_9_1]

	if not VersionActivity1_5BuildModel.instance:checkBuildIsHad(var_9_0.id) then
		return
	end

	if VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(var_9_0.id) then
		return
	end

	VersionActivity1_5BuildModel.instance:setSelectBuildId(var_9_0)
	VersionActivity1_5DungeonRpc.instance:sendAct140SelectBuildRequest(VersionActivity1_5BuildModel.instance.selectBuildList)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.groupIndex = arg_10_0.viewParam.groupIndex

	arg_10_0:getBuildCoList()
	arg_10_0:refreshUI()
end

function var_0_0.getBuildCoList(arg_11_0)
	arg_11_0.buildCoList = VersionActivity1_5DungeonConfig.instance:getBuildCoList(arg_11_0.groupIndex)
end

function var_0_0.refreshUI(arg_12_0)
	for iter_12_0 = 1, 2 do
		arg_12_0:refreshItem(iter_12_0)
	end
end

function var_0_0.refreshItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.buildCoList[arg_13_1]
	local var_13_1 = arg_13_0.itemList[arg_13_1]

	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(var_13_1.imageBuildBG, VersionActivity1_5DungeonEnum.BuildType2Image[var_13_0.type])
	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(var_13_1.imageTotemIcon, var_13_0.icon)
	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(var_13_1.imageBuildingPic, var_13_0.previewImg)

	var_13_1.txtBuildName.text = var_13_0.name
	var_13_1.txtBuildNameEn.text = var_13_0.nameEn
	var_13_1.txtDesc.text = var_13_0.desc
	var_13_1.txtSkillDesc.text = var_13_0.skilldesc

	arg_13_0:refreshBtnStatus(arg_13_1)

	if not VersionActivity1_5BuildModel.instance:checkBuildIsHad(var_13_0.id) then
		local var_13_2, var_13_3 = ItemModel.instance:getItemConfigAndIcon(var_13_0.costList[1], var_13_0.costList[2])

		var_13_1.simageProp:LoadImage(var_13_3)

		var_13_1.txtPropNum.text = var_13_0.costList[3]
	end
end

function var_0_0.refreshBtnStatus(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.buildCoList[arg_14_1]
	local var_14_1 = arg_14_0.itemList[arg_14_1]
	local var_14_2 = var_14_0.id
	local var_14_3 = VersionActivity1_5BuildModel.instance:checkBuildIsHad(var_14_2)

	if VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(var_14_2) then
		gohelper.setActive(var_14_1.goInEffect, true)
		gohelper.setActive(var_14_1.goBuild, false)
		gohelper.setActive(var_14_1.goUse, false)
	elseif var_14_3 then
		gohelper.setActive(var_14_1.goInEffect, false)
		gohelper.setActive(var_14_1.goBuild, false)
		gohelper.setActive(var_14_1.goUse, true)
	else
		gohelper.setActive(var_14_1.goInEffect, false)
		gohelper.setActive(var_14_1.goBuild, true)
		gohelper.setActive(var_14_1.goUse, false)
	end
end

function var_0_0.onUpdateBuildInfo(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.buildCoList) do
		if iter_15_1.id == arg_15_1 then
			arg_15_0:refreshItem(iter_15_0)

			break
		end
	end

	for iter_15_2 = 1, 2 do
		arg_15_0:refreshBtnStatus(iter_15_2)
	end

	gohelper.setActive(arg_15_0.goBuildEffect, false)
	gohelper.setActive(arg_15_0.goBuildEffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_build)
end

function var_0_0.onUpdateSelectBuild(arg_16_0)
	for iter_16_0 = 1, 2 do
		arg_16_0:refreshBtnStatus(iter_16_0)
	end
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simageMask:UnLoadImage()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.itemList) do
		iter_18_1.simageItemBG:UnLoadImage()
		iter_18_1.simageProp:UnLoadImage()
		iter_18_1.btnBuild:RemoveClickListener()
		iter_18_1.btnUse:RemoveClickListener()
	end
end

return var_0_0
