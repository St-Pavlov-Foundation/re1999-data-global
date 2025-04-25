module("modules.logic.room.view.critter.RoomCritterTrainViewSelect", package.seeall)

slot0 = class("RoomCritterTrainViewSelect", BaseView)

function slot0.onInitView(slot0)
	slot0._gotrainselect = gohelper.findChild(slot0.viewGO, "bottom/#go_trainselect")
	slot0._gohascritter = gohelper.findChild(slot0._gotrainselect, "critter/#go_hascritter")
	slot0._gocritterIcon = gohelper.findChild(slot0._gotrainselect, "critter/#go_hascritter/#go_critterIcon")
	slot0._gonocritter = gohelper.findChild(slot0._gotrainselect, "critter/#go_nocritter")
	slot0._gocritterselected = gohelper.findChild(slot0._gotrainselect, "critter/#go_critter_selected")
	slot0._btncritterselect = gohelper.findChildButtonWithAudio(slot0._gotrainselect, "critter/#btn_critter_select")
	slot0._gohashero = gohelper.findChild(slot0._gotrainselect, "hero/#go_hashero")
	slot0._goheroIcon = gohelper.findChild(slot0._gotrainselect, "hero/#go_hashero/#go_heroIcon")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot0._gotrainselect, "hero/#go_hashero/#simage_heroicon")
	slot0._gonohero = gohelper.findChild(slot0._gotrainselect, "hero/#go_nohero")
	slot0._goheroselected = gohelper.findChild(slot0._gotrainselect, "hero/#go_hero_selected")
	slot0._btnheroselect = gohelper.findChildButtonWithAudio(slot0._gotrainselect, "hero/#btn_hero_select")
	slot0._gocritterinfo = gohelper.findChild(slot0._gotrainselect, "#go_critter_info")
	slot0._txtcrittername = gohelper.findChildText(slot0._gotrainselect, "#go_critter_info/#txt_critter_name")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0._gotrainselect, "#go_critter_info/#btn_detail")
	slot0._scrollcritterarr = gohelper.findChildScrollRect(slot0._gotrainselect, "#go_critter_info/#scroll_critterarr")
	slot0._gocritteritem = gohelper.findChild(slot0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem")
	slot0._txtname = gohelper.findChildText(slot0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_name")
	slot0._imageicon = gohelper.findChildImage(slot0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_name/#image_icon")
	slot0._txtnum = gohelper.findChildText(slot0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_num")
	slot0._txtratio = gohelper.findChildText(slot0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_ratio")
	slot0._scrollcritterpreview = gohelper.findChildScrollRect(slot0._gotrainselect, "#go_critter_info/#scroll_critterpreview")
	slot0._gobaseitem = gohelper.findChild(slot0._gotrainselect, "#go_critter_info/#scroll_critterpreview/viewport/content/#go_baseitem")
	slot0._goheroinfo = gohelper.findChild(slot0._gotrainselect, "#go_hero_info")
	slot0._txtheroname = gohelper.findChildText(slot0._gotrainselect, "#go_hero_info/#txt_hero_name")
	slot0._txtheroinfo = gohelper.findChildText(slot0._gotrainselect, "#go_hero_info/#txt_hero_info")
	slot0._scrollheroarr = gohelper.findChildScrollRect(slot0._gotrainselect, "#go_hero_info/#scroll_heroarr")
	slot0._goheroitem = gohelper.findChild(slot0._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/#go_heroitem")
	slot0._txtpreference = gohelper.findChildText(slot0._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem/#txt_preference")
	slot0._simagepreference = gohelper.findChildSingleImage(slot0._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem/#simage_preference")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncritterselect:AddClickListener(slot0._btncritterselectOnClick, slot0)
	slot0._btnheroselect:AddClickListener(slot0._btnheroselectOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncritterselect:RemoveClickListener()
	slot0._btnheroselect:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
end

function slot0._btncritterselectOnClick(slot0)
	slot0:setSelectCritter(true)
	slot0.viewContainer:dispatchEvent(CritterEvent.UITrainSubTab, 2)
end

function slot0._btnheroselectOnClick(slot0)
	slot0:setSelectCritter(false)
	slot0.viewContainer:dispatchEvent(CritterEvent.UITrainSubTab, 3)
end

function slot0._btndetailOnClick(slot0)
	if CritterModel.instance:getCritterMOByUid(slot0._selectCritterUid) then
		CritterController.instance:openRoomCritterDetailView(slot1.finishTrain ~= true, slot1, true)
	end
end

function slot0._editableInitView(slot0)
	slot0._trainPreveSendDict = {}
	slot0._attributeItems = {}
	slot0._goCritterAttrContent = gohelper.findChild(slot0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content")
	slot0._gopreferenceitem = gohelper.findChild(slot0._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem")
	slot0._referenceCanvasGroup = gohelper.onceAddComponent(slot0._gopreferenceitem, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(slot0._gobaseitem, false)

	slot0._heroAttrComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goheroitem, RoomCritterAttrScrollCell)
	slot0._heroAttrComp._view = slot0
	slot0._tempAttrList = {}

	for slot5, slot6 in ipairs({
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Patience,
		CritterEnum.AttributeType.Lucky
	}) do
		slot7 = CritterAttributeInfoMO.New()

		slot7:init({
			attributeId = slot6
		})
		table.insert(slot0._tempAttrList, slot7)
	end

	slot0._txtheroinfo.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.__isOpenFlage = true

	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainSelectCritter, slot0._onSelectCritterItem, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainSelectHero, slot0._onSelectHeroItem, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainSelectSlot, slot0._onSelectSlotItem, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UIChangeTrainCritter, slot0._onChangeTrainCritter, slot0)
		slot0:addEventCb(slot0.viewContainer, CritterEvent.UITrainViewGoBack, slot0._onTrainGoBack, slot0)
	end

	slot0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, slot0._onCritterInfoPushUpdate, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.StartTrainCritterPreviewReply, slot0._onTrainPreviewReplay, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, slot0.showSceneSpine, slot0)
	slot0:setSelectCritter(true)
	slot0:refreshSelectCritterUI()
	slot0:refreshSelectHeroUI()
end

function slot0.onClose(slot0)
	slot0.__isOpenFlage = false

	RoomCritterController.instance:showTrainSceneHero(nil)
	RoomCritterController.instance:showTrainSceneCritter(nil)
end

function slot0.onDestroyView(slot0)
	slot0._heroAttrComp:onDestroy()

	if slot0._attributeItems then
		for slot4, slot5 in pairs(slot0._attributeItems) do
			slot5:destroy()
		end

		slot0._attributeItems = nil
	end
end

function slot0._onSelectCritterItem(slot0, slot1)
	slot0._selectCritterUid = slot1.id

	slot0:refreshSelectCritterUI()
end

function slot0._onSelectHeroItem(slot0, slot1)
	slot0._selectHeroId = slot1.id

	slot0:refreshSelectHeroUI()
end

function slot0._onCritterInfoPushUpdate(slot0)
	slot0:refreshSelectCritterUI()
end

function slot0._onChangeTrainCritter(slot0, slot1)
	slot0:_updateBySlotMO(slot1)
	slot0:setSelectCritter(true)
	slot0:refreshSelectCritterUI()
	slot0:refreshSelectHeroUI()
end

function slot0._onSelectSlotItem(slot0, slot1)
	slot0:_updateBySlotMO(slot1)
	slot0:setSelectCritter(true)
	slot0:refreshSelectCritterUI()
	slot0:refreshSelectHeroUI()
end

function slot0._updateBySlotMO(slot0, slot1)
	slot0._selectCritterUid = nil
	slot0._selectHeroId = nil
	slot0._selectSlotMO = slot1
	slot0._selectSiteId = slot1 and slot1.id

	if slot1 and slot1.critterMO then
		slot0._selectCritterUid = slot2.id
		slot0._selectHeroId = slot2.trainInfo.heroId
	end
end

function slot0._onTrainGoBack(slot0)
	slot0:_updateBySlotMO(slot0._selectSlotMO)
	slot0:showSceneSpine()
end

function slot0._onTrainPreviewReplay(slot0, slot1, slot2)
	slot0:refreshAttributeItem()
end

function slot0.setSelectCritter(slot0, slot1)
	slot0._isSelectCritter = slot1

	gohelper.setActive(slot0._goheroinfo, not slot1)
	gohelper.setActive(slot0._goheroselected, not slot1)
	gohelper.setActive(slot0._gocritterinfo, slot1)
	gohelper.setActive(slot0._gocritterselected, slot1)
	slot0:showSceneSpine()
end

function slot0.refreshSelectCritterUI(slot0)
	slot3 = CritterModel.instance:getCritterMOByUid(slot0._selectCritterUid) ~= nil

	gohelper.setActive(slot0._gohascritter, slot3)
	gohelper.setActive(slot0._gonocritter, not slot3)

	slot4 = slot0._tempAttrList

	if slot3 then
		if not slot0.critterIcon then
			slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocritterIcon)
		end

		slot0.critterIcon:setMOValue(slot2:getId(), slot2:getDefineId())

		slot0._txtcrittername.text = slot2:getName()
		slot4 = slot2:getAttributeInfos()
	else
		slot0._txtcrittername.text = luaLang("critter_train_noselect_critter_text")
	end

	slot0._isHasSelectCritter = slot3

	gohelper.CreateObjList(slot0, slot0._onCritterArrComp, slot4, slot0._goCritterAttrContent, slot0._gocritteritem, RoomCritterAttrScrollCell)
	slot0:refreshAttributeItem()
	slot0:showSceneSpine()
	slot0:refreshReferenceUI()
end

function slot0.refreshReferenceUI(slot0)
	slot0._referenceCanvasGroup.alpha = slot0:_isPreference() and 1 or 0.5
end

function slot0._isPreference(slot0)
	if slot0._selectCritterUid and slot0._selectHeroId then
		slot2 = RoomTrainHeroListModel.instance:getById(slot0._selectHeroId)

		if CritterModel.instance:getCritterMOByUid(slot0._selectCritterUid) and slot2 and slot2:chcekPrefernectCritterId(slot1:getDefineId()) then
			return true
		end
	end

	return false
end

function slot0.refreshAttributeItem(slot0)
	slot2 = true

	if slot0:_getTrainPreviewMO() then
		for slot6, slot7 in pairs(slot0._attributeItems) do
			slot7:hideItem()
		end

		for slot7 = 1, #slot1:getAttributeInfos() do
			if not slot0._attributeItems[slot7] then
				slot0._attributeItems[slot7] = RoomCritterTrainDetailItemAttributeItem.New()

				slot0._attributeItems[slot7]:init(slot0._gobaseitem)
			end

			slot0._attributeItems[slot7]:setShowLv(slot0._showLv)
			slot0._attributeItems[slot7]:refresh(slot3[slot7], slot1)
		end
	elseif not slot0._selectCritterUid or not slot0._selectHeroId then
		slot2 = false
	end

	gohelper.setActive(slot0._scrollcritterarr, not slot2)
	gohelper.setActive(slot0._scrollcritterpreview, slot2)
end

function slot0._getTrainPreviewMO(slot0)
	if slot0._selectCritterUid and slot0._selectHeroId then
		if CritterModel.instance:getCritterMOByUid(slot0._selectCritterUid) and slot1:isCultivating() and slot1.trainInfo.heroId == slot0._selectHeroId then
			return slot1
		end

		if slot1 and slot1:isMaturity() then
			return nil
		end

		if CritterModel.instance:getTrainPreviewMO(slot0._selectCritterUid, slot0._selectHeroId) then
			return slot2
		end

		if RoomHelper.get2KeyValue(slot0._trainPreveSendDict, slot0._selectCritterUid, slot0._selectHeroId) == nil or slot3 < Time.time then
			RoomHelper.add2KeyValue(slot0._trainPreveSendDict, slot0._selectCritterUid, slot0._selectHeroId, Time.time + 2)
			CritterRpc.instance:sendStartTrainCritterPreviewRequest(slot0._selectCritterUid, slot0._selectHeroId)
		end
	end

	return nil
end

function slot0.refreshSelectHeroUI(slot0)
	slot2 = RoomTrainHeroListModel.instance:getById(slot0._selectHeroId) ~= nil

	gohelper.setActive(slot0._gohashero, slot2)
	gohelper.setActive(slot0._gonohero, not slot2)
	gohelper.setActive(slot0._txtheroinfo, slot2)
	gohelper.setActive(slot0._scrollheroarr, slot2)

	if slot2 then
		slot0._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(slot1.skinConfig.headIcon))

		slot0._txtheroname.text = slot1.heroConfig and slot1.heroConfig.name

		slot0._heroAttrComp:onUpdateMO(slot1:getAttributeInfoMO())

		slot0._txtpreference.text = slot1:getPrefernectName()

		if slot1.critterHeroConfig then
			slot0._simagepreference:LoadImage(ResUrl.getCritterHedaIcon(slot1.critterHeroConfig.critterIcon))
		end
	else
		slot0._txtheroname.text = luaLang("critter_train_noselect_hero_text")
	end

	slot0:refreshAttributeItem()
	slot0:showSceneSpine()
	slot0:refreshReferenceUI()
end

function slot0.showSceneSpine(slot0)
	slot0._lastHeroId = slot0._selectHeroId
	slot0._lastCritterUiId = slot0._selectCritterUid

	if slot0:_isHideSpine() then
		slot0._lastHeroId = nil
		slot0._lastCritterUiId = nil
	end

	slot3 = slot0.viewContainer:getContainerViewBuildingUid()

	RoomCritterController.instance:showTrainSceneHero(RoomTrainHeroListModel.instance:getById(slot0._lastHeroId), slot3, 7)
	RoomCritterController.instance:showTrainSceneCritter(CritterModel.instance:getCritterMOByUid(slot0._lastCritterUiId), slot3, 6)
end

function slot0._isHideSpine(slot0)
	if not slot0.__isOpenFlage then
		return true
	end

	if slot0.viewContainer:getContainerCurSelectTab() ~= RoomCritterBuildingViewContainer.SubViewTabId.Training then
		return true
	end

	if not RoomCameraController.instance:getRoomScene() then
		return true
	end

	return slot1.camera:getCameraState() == RoomEnum.CameraState.ThirdPerson
end

function slot0._onCritterArrComp(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)

	if not slot1._view then
		slot1._view = slot0
	end

	if not slot0._isHasSelectCritter then
		slot1._txtratio.text = "--"
		slot1._txtnum.text = "--"
	end
end

return slot0
