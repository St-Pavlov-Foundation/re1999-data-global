module("modules.logic.versionactivity1_5.dungeon.view.building.V1a5BuildingDetailView", package.seeall)

slot0 = class("V1a5BuildingDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageMask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Mask")
	slot0._goItem = gohelper.findChild(slot0.viewGO, "#go_Item")
	slot0._btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Left")
	slot0._btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Right")
	slot0.goBuildEffect = gohelper.findChild(slot0.viewGO, "image_Select/leveup")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnLeft:AddClickListener(slot0._btnLeftOnClick, slot0)
	slot0._btnRight:AddClickListener(slot0._btnRightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnLeft:RemoveClickListener()
	slot0._btnRight:RemoveClickListener()
end

slot0.AnchorXList = {
	-15,
	570
}

function slot0._btnLeftOnClick(slot0)
	slot0.groupIndex = slot0.groupIndex - 1

	if slot0.groupIndex == 0 then
		slot0.groupIndex = VersionActivity1_5DungeonEnum.BuildCount
	end

	slot0:getBuildCoList()
	slot0:refreshUI()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, slot0.groupIndex)
end

function slot0._btnRightOnClick(slot0)
	slot0.groupIndex = slot0.groupIndex + 1

	if VersionActivity1_5DungeonEnum.BuildCount < slot0.groupIndex then
		slot0.groupIndex = 1
	end

	slot0:getBuildCoList()
	slot0:refreshUI()
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnSwitchSelectGroupBuild, slot0.groupIndex)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goItem, false)

	slot0.itemList = {}

	table.insert(slot0.itemList, slot0:createItem(1))
	table.insert(slot0.itemList, slot0:createItem(2))
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateBuildInfo, slot0.onUpdateBuildInfo, slot0)
	slot0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnUpdateSelectBuild, slot0.onUpdateSelectBuild, slot0)
	slot0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, slot0.closeThis, slot0)
end

function slot0.createItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = gohelper.cloneInPlace(slot0._goItem)

	gohelper.setActive(slot2.go, true)

	slot2.goTr = slot2.go:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchorX(slot2.goTr, uv0.AnchorXList[slot1])

	slot2.simageItemBG = gohelper.findChildSingleImage(slot2.go, "#simage_ItemBG")

	slot2.simageItemBG:LoadImage(ResUrl.getV1a5BuildSingleBg("v1a5_building_toteminfobg"))

	slot2.imageBuildBG = gohelper.findChildImage(slot2.go, "Totem/#image_BuildBG")
	slot2.imageTotemIcon = gohelper.findChildImage(slot2.go, "Totem/#image_BuildBG/#image_TotemIcon")
	slot2.imageBuildingPic = gohelper.findChildImage(slot2.go, "#image_BuildingPic")
	slot2.txtBuildName = gohelper.findChildText(slot2.go, "#txt_BuildName")
	slot2.txtBuildNameEn = gohelper.findChildText(slot2.go, "#txt_BuildNameEn")
	slot2.txtDesc = gohelper.findChildText(slot2.go, "Scroll View/Viewport/content/#txt_Desc")
	slot2.txtSkillDesc = gohelper.findChildText(slot2.go, "Scroll View/Viewport/content/#txt_skilldesc")
	slot2.goInEffect = gohelper.findChild(slot2.go, "#go_InEffect")
	slot2.goBuild = gohelper.findChild(slot2.go, "#go_Build")
	slot2.goUse = gohelper.findChild(slot2.go, "#go_use")
	slot2.txtPropNum = gohelper.findChildText(slot2.go, "#go_Build/#txt_PropNum")
	slot2.simageProp = gohelper.findChildSingleImage(slot2.go, "#go_Build/#txt_PropNum/#simage_Prop")
	slot2.btnBuild = gohelper.findChildButtonWithAudio(slot2.go, "#go_Build/#btn_Build")
	slot2.btnUse = gohelper.findChildButtonWithAudio(slot2.go, "#go_use/#btn_use")

	slot2.btnBuild:AddClickListener(slot0.onClickBuildBtn, slot0, slot1)
	slot2.btnUse:AddClickListener(slot0.onClickUseBtn, slot0, slot1)

	return slot2
end

function slot0.onClickBuildBtn(slot0, slot1)
	if VersionActivity1_5BuildModel.instance:checkBuildIsHad(slot0.buildCoList[slot1].id) then
		return
	end

	slot4 = slot2.costList[1]
	slot5 = slot2.costList[2]

	if ItemModel.instance:getItemQuantity(slot4, slot5) < slot2.costList[3] then
		GameFacade.showToastString(string.format(luaLang("store_currency_limit"), ItemConfig.instance:getItemConfig(slot4, slot5).name))

		return
	end

	VersionActivity1_5DungeonRpc.instance:sendAct140BuildRequest(slot2.id)
end

function slot0.onClickUseBtn(slot0, slot1)
	if not VersionActivity1_5BuildModel.instance:checkBuildIsHad(slot0.buildCoList[slot1].id) then
		return
	end

	if VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(slot2.id) then
		return
	end

	VersionActivity1_5BuildModel.instance:setSelectBuildId(slot2)
	VersionActivity1_5DungeonRpc.instance:sendAct140SelectBuildRequest(VersionActivity1_5BuildModel.instance.selectBuildList)
end

function slot0.onOpen(slot0)
	slot0.groupIndex = slot0.viewParam.groupIndex

	slot0:getBuildCoList()
	slot0:refreshUI()
end

function slot0.getBuildCoList(slot0)
	slot0.buildCoList = VersionActivity1_5DungeonConfig.instance:getBuildCoList(slot0.groupIndex)
end

function slot0.refreshUI(slot0)
	for slot4 = 1, 2 do
		slot0:refreshItem(slot4)
	end
end

function slot0.refreshItem(slot0, slot1)
	slot2 = slot0.buildCoList[slot1]
	slot3 = slot0.itemList[slot1]

	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot3.imageBuildBG, VersionActivity1_5DungeonEnum.BuildType2Image[slot2.type])
	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot3.imageTotemIcon, slot2.icon)
	UISpriteSetMgr.instance:setV1a5DungeonBuildSprite(slot3.imageBuildingPic, slot2.previewImg)

	slot3.txtBuildName.text = slot2.name
	slot3.txtBuildNameEn.text = slot2.nameEn
	slot3.txtDesc.text = slot2.desc
	slot3.txtSkillDesc.text = slot2.skilldesc

	slot0:refreshBtnStatus(slot1)

	if not VersionActivity1_5BuildModel.instance:checkBuildIsHad(slot2.id) then
		slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot2.costList[1], slot2.costList[2])

		slot3.simageProp:LoadImage(slot6)

		slot3.txtPropNum.text = slot2.costList[3]
	end
end

function slot0.refreshBtnStatus(slot0, slot1)
	slot3 = slot0.itemList[slot1]
	slot4 = slot0.buildCoList[slot1].id
	slot5 = VersionActivity1_5BuildModel.instance:checkBuildIsHad(slot4)

	if VersionActivity1_5BuildModel.instance:checkBuildIdIsSelect(slot4) then
		gohelper.setActive(slot3.goInEffect, true)
		gohelper.setActive(slot3.goBuild, false)
		gohelper.setActive(slot3.goUse, false)
	elseif slot5 then
		gohelper.setActive(slot3.goInEffect, false)
		gohelper.setActive(slot3.goBuild, false)
		gohelper.setActive(slot3.goUse, true)
	else
		gohelper.setActive(slot3.goInEffect, false)
		gohelper.setActive(slot3.goBuild, true)
		gohelper.setActive(slot3.goUse, false)
	end
end

function slot0.onUpdateBuildInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.buildCoList) do
		if slot6.id == slot1 then
			slot0:refreshItem(slot5)

			break
		end
	end

	for slot5 = 1, 2 do
		slot0:refreshBtnStatus(slot5)
	end

	gohelper.setActive(slot0.goBuildEffect, false)
	gohelper.setActive(slot0.goBuildEffect, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_build)
end

function slot0.onUpdateSelectBuild(slot0)
	for slot4 = 1, 2 do
		slot0:refreshBtnStatus(slot4)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageMask:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5.simageItemBG:UnLoadImage()
		slot5.simageProp:UnLoadImage()
		slot5.btnBuild:RemoveClickListener()
		slot5.btnUse:RemoveClickListener()
	end
end

return slot0
