module("modules.logic.room.view.critter.RoomCritterTrainViewSelect", package.seeall)

local var_0_0 = class("RoomCritterTrainViewSelect", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotrainselect = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_trainselect")
	arg_1_0._gohascritter = gohelper.findChild(arg_1_0._gotrainselect, "critter/#go_hascritter")
	arg_1_0._gocritterIcon = gohelper.findChild(arg_1_0._gotrainselect, "critter/#go_hascritter/#go_critterIcon")
	arg_1_0._gonocritter = gohelper.findChild(arg_1_0._gotrainselect, "critter/#go_nocritter")
	arg_1_0._gocritterselected = gohelper.findChild(arg_1_0._gotrainselect, "critter/#go_critter_selected")
	arg_1_0._btncritterselect = gohelper.findChildButtonWithAudio(arg_1_0._gotrainselect, "critter/#btn_critter_select")
	arg_1_0._gohashero = gohelper.findChild(arg_1_0._gotrainselect, "hero/#go_hashero")
	arg_1_0._goheroIcon = gohelper.findChild(arg_1_0._gotrainselect, "hero/#go_hashero/#go_heroIcon")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0._gotrainselect, "hero/#go_hashero/#simage_heroicon")
	arg_1_0._gonohero = gohelper.findChild(arg_1_0._gotrainselect, "hero/#go_nohero")
	arg_1_0._goheroselected = gohelper.findChild(arg_1_0._gotrainselect, "hero/#go_hero_selected")
	arg_1_0._btnheroselect = gohelper.findChildButtonWithAudio(arg_1_0._gotrainselect, "hero/#btn_hero_select")
	arg_1_0._gocritterinfo = gohelper.findChild(arg_1_0._gotrainselect, "#go_critter_info")
	arg_1_0._txtcrittername = gohelper.findChildText(arg_1_0._gotrainselect, "#go_critter_info/#txt_critter_name")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0._gotrainselect, "#go_critter_info/#btn_detail")
	arg_1_0._scrollcritterarr = gohelper.findChildScrollRect(arg_1_0._gotrainselect, "#go_critter_info/#scroll_critterarr")
	arg_1_0._gocritteritem = gohelper.findChild(arg_1_0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_name")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_name/#image_icon")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_num")
	arg_1_0._txtratio = gohelper.findChildText(arg_1_0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content/#go_critteritem/#txt_ratio")
	arg_1_0._scrollcritterpreview = gohelper.findChildScrollRect(arg_1_0._gotrainselect, "#go_critter_info/#scroll_critterpreview")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0._gotrainselect, "#go_critter_info/#scroll_critterpreview/viewport/content/#go_baseitem")
	arg_1_0._goheroinfo = gohelper.findChild(arg_1_0._gotrainselect, "#go_hero_info")
	arg_1_0._txtheroname = gohelper.findChildText(arg_1_0._gotrainselect, "#go_hero_info/#txt_hero_name")
	arg_1_0._txtheroinfo = gohelper.findChildText(arg_1_0._gotrainselect, "#go_hero_info/#txt_hero_info")
	arg_1_0._scrollheroarr = gohelper.findChildScrollRect(arg_1_0._gotrainselect, "#go_hero_info/#scroll_heroarr")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/#go_heroitem")
	arg_1_0._txtpreference = gohelper.findChildText(arg_1_0._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem/#txt_preference")
	arg_1_0._simagepreference = gohelper.findChildSingleImage(arg_1_0._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem/#simage_preference")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncritterselect:AddClickListener(arg_2_0._btncritterselectOnClick, arg_2_0)
	arg_2_0._btnheroselect:AddClickListener(arg_2_0._btnheroselectOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncritterselect:RemoveClickListener()
	arg_3_0._btnheroselect:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
end

function var_0_0._btncritterselectOnClick(arg_4_0)
	arg_4_0:setSelectCritter(true)
	arg_4_0.viewContainer:dispatchEvent(CritterEvent.UITrainSubTab, 2)
end

function var_0_0._btnheroselectOnClick(arg_5_0)
	arg_5_0:setSelectCritter(false)
	arg_5_0.viewContainer:dispatchEvent(CritterEvent.UITrainSubTab, 3)
end

function var_0_0._btndetailOnClick(arg_6_0)
	local var_6_0 = CritterModel.instance:getCritterMOByUid(arg_6_0._selectCritterUid)

	if var_6_0 then
		CritterController.instance:openRoomCritterDetailView(var_6_0.finishTrain ~= true, var_6_0, true)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._trainPreveSendDict = {}
	arg_7_0._attributeItems = {}
	arg_7_0._goCritterAttrContent = gohelper.findChild(arg_7_0._gotrainselect, "#go_critter_info/#scroll_critterarr/viewport/content")
	arg_7_0._gopreferenceitem = gohelper.findChild(arg_7_0._gotrainselect, "#go_hero_info/#scroll_heroarr/viewport/content/go_preferenceitem")
	arg_7_0._referenceCanvasGroup = gohelper.onceAddComponent(arg_7_0._gopreferenceitem, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(arg_7_0._gobaseitem, false)

	arg_7_0._heroAttrComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._goheroitem, RoomCritterAttrScrollCell)
	arg_7_0._heroAttrComp._view = arg_7_0
	arg_7_0._tempAttrList = {}

	local var_7_0 = {
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Patience,
		CritterEnum.AttributeType.Lucky
	}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = CritterAttributeInfoMO.New()

		var_7_1:init({
			attributeId = iter_7_1
		})
		table.insert(arg_7_0._tempAttrList, var_7_1)
	end

	arg_7_0._txtheroinfo.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.__isOpenFlage = true

	if arg_9_0.viewContainer then
		arg_9_0:addEventCb(arg_9_0.viewContainer, CritterEvent.UITrainSelectCritter, arg_9_0._onSelectCritterItem, arg_9_0)
		arg_9_0:addEventCb(arg_9_0.viewContainer, CritterEvent.UITrainSelectHero, arg_9_0._onSelectHeroItem, arg_9_0)
		arg_9_0:addEventCb(arg_9_0.viewContainer, CritterEvent.UITrainSelectSlot, arg_9_0._onSelectSlotItem, arg_9_0)
		arg_9_0:addEventCb(arg_9_0.viewContainer, CritterEvent.UIChangeTrainCritter, arg_9_0._onChangeTrainCritter, arg_9_0)
		arg_9_0:addEventCb(arg_9_0.viewContainer, CritterEvent.UITrainViewGoBack, arg_9_0._onTrainGoBack, arg_9_0)
	end

	arg_9_0:addEventCb(CritterController.instance, CritterEvent.CritterInfoPushUpdate, arg_9_0._onCritterInfoPushUpdate, arg_9_0)
	arg_9_0:addEventCb(CritterController.instance, CritterEvent.StartTrainCritterPreviewReply, arg_9_0._onTrainPreviewReplay, arg_9_0)
	arg_9_0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, arg_9_0.showSceneSpine, arg_9_0)
	arg_9_0:setSelectCritter(true)
	arg_9_0:refreshSelectCritterUI()
	arg_9_0:refreshSelectHeroUI()
end

function var_0_0.onClose(arg_10_0)
	arg_10_0.__isOpenFlage = false

	RoomCritterController.instance:showTrainSceneHero(nil)
	RoomCritterController.instance:showTrainSceneCritter(nil)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._heroAttrComp:onDestroy()

	if arg_11_0._attributeItems then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._attributeItems) do
			iter_11_1:destroy()
		end

		arg_11_0._attributeItems = nil
	end
end

function var_0_0._onSelectCritterItem(arg_12_0, arg_12_1)
	arg_12_0._selectCritterUid = arg_12_1.id

	arg_12_0:refreshSelectCritterUI()
end

function var_0_0._onSelectHeroItem(arg_13_0, arg_13_1)
	arg_13_0._selectHeroId = arg_13_1.id

	arg_13_0:refreshSelectHeroUI()
end

function var_0_0._onCritterInfoPushUpdate(arg_14_0)
	arg_14_0:refreshSelectCritterUI()
end

function var_0_0._onChangeTrainCritter(arg_15_0, arg_15_1)
	arg_15_0:_updateBySlotMO(arg_15_1)
	arg_15_0:setSelectCritter(true)
	arg_15_0:refreshSelectCritterUI()
	arg_15_0:refreshSelectHeroUI()
end

function var_0_0._onSelectSlotItem(arg_16_0, arg_16_1)
	arg_16_0:_updateBySlotMO(arg_16_1)
	arg_16_0:setSelectCritter(true)
	arg_16_0:refreshSelectCritterUI()
	arg_16_0:refreshSelectHeroUI()
end

function var_0_0._updateBySlotMO(arg_17_0, arg_17_1)
	arg_17_0._selectCritterUid = nil
	arg_17_0._selectHeroId = nil
	arg_17_0._selectSlotMO = arg_17_1
	arg_17_0._selectSiteId = arg_17_1 and arg_17_1.id

	local var_17_0 = arg_17_1 and arg_17_1.critterMO

	if var_17_0 then
		arg_17_0._selectCritterUid = var_17_0.id
		arg_17_0._selectHeroId = var_17_0.trainInfo.heroId
	end
end

function var_0_0._onTrainGoBack(arg_18_0)
	arg_18_0:_updateBySlotMO(arg_18_0._selectSlotMO)
	arg_18_0:showSceneSpine()
end

function var_0_0._onTrainPreviewReplay(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:refreshAttributeItem()
end

function var_0_0.setSelectCritter(arg_20_0, arg_20_1)
	arg_20_0._isSelectCritter = arg_20_1

	gohelper.setActive(arg_20_0._goheroinfo, not arg_20_1)
	gohelper.setActive(arg_20_0._goheroselected, not arg_20_1)
	gohelper.setActive(arg_20_0._gocritterinfo, arg_20_1)
	gohelper.setActive(arg_20_0._gocritterselected, arg_20_1)
	arg_20_0:showSceneSpine()
end

function var_0_0.refreshSelectCritterUI(arg_21_0)
	local var_21_0 = arg_21_0._selectCritterUid
	local var_21_1 = CritterModel.instance:getCritterMOByUid(var_21_0)
	local var_21_2 = var_21_1 ~= nil

	gohelper.setActive(arg_21_0._gohascritter, var_21_2)
	gohelper.setActive(arg_21_0._gonocritter, not var_21_2)

	local var_21_3 = arg_21_0._tempAttrList

	if var_21_2 then
		if not arg_21_0.critterIcon then
			arg_21_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_21_0._gocritterIcon)
		end

		arg_21_0.critterIcon:setMOValue(var_21_1:getId(), var_21_1:getDefineId())

		arg_21_0._txtcrittername.text = var_21_1:getName()
		var_21_3 = var_21_1:getAttributeInfos()
	else
		arg_21_0._txtcrittername.text = luaLang("critter_train_noselect_critter_text")
	end

	arg_21_0._isHasSelectCritter = var_21_2

	local var_21_4 = arg_21_0._goCritterAttrContent
	local var_21_5 = arg_21_0._gocritteritem

	gohelper.CreateObjList(arg_21_0, arg_21_0._onCritterArrComp, var_21_3, var_21_4, var_21_5, RoomCritterAttrScrollCell)
	arg_21_0:refreshAttributeItem()
	arg_21_0:showSceneSpine()
	arg_21_0:refreshReferenceUI()
end

function var_0_0.refreshReferenceUI(arg_22_0)
	local var_22_0 = arg_22_0:_isPreference() and 1 or 0.5

	arg_22_0._referenceCanvasGroup.alpha = var_22_0
end

function var_0_0._isPreference(arg_23_0)
	if arg_23_0._selectCritterUid and arg_23_0._selectHeroId then
		local var_23_0 = CritterModel.instance:getCritterMOByUid(arg_23_0._selectCritterUid)
		local var_23_1 = RoomTrainHeroListModel.instance:getById(arg_23_0._selectHeroId)

		if var_23_0 and var_23_1 and var_23_1:chcekPrefernectCritterId(var_23_0:getDefineId()) then
			return true
		end
	end

	return false
end

function var_0_0.refreshAttributeItem(arg_24_0)
	local var_24_0 = arg_24_0:_getTrainPreviewMO()
	local var_24_1 = true

	if var_24_0 then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._attributeItems) do
			iter_24_1:hideItem()
		end

		local var_24_2 = var_24_0:getAttributeInfos()

		for iter_24_2 = 1, #var_24_2 do
			if not arg_24_0._attributeItems[iter_24_2] then
				arg_24_0._attributeItems[iter_24_2] = RoomCritterTrainDetailItemAttributeItem.New()

				arg_24_0._attributeItems[iter_24_2]:init(arg_24_0._gobaseitem)
			end

			arg_24_0._attributeItems[iter_24_2]:setShowLv(arg_24_0._showLv)
			arg_24_0._attributeItems[iter_24_2]:refresh(var_24_2[iter_24_2], var_24_0)
		end
	elseif not arg_24_0._selectCritterUid or not arg_24_0._selectHeroId then
		var_24_1 = false
	end

	gohelper.setActive(arg_24_0._scrollcritterarr, not var_24_1)
	gohelper.setActive(arg_24_0._scrollcritterpreview, var_24_1)
end

function var_0_0._getTrainPreviewMO(arg_25_0)
	if arg_25_0._selectCritterUid and arg_25_0._selectHeroId then
		local var_25_0 = CritterModel.instance:getCritterMOByUid(arg_25_0._selectCritterUid)

		if var_25_0 and var_25_0:isCultivating() and var_25_0.trainInfo.heroId == arg_25_0._selectHeroId then
			return var_25_0
		end

		if var_25_0 and var_25_0:isMaturity() then
			return nil
		end

		local var_25_1 = CritterModel.instance:getTrainPreviewMO(arg_25_0._selectCritterUid, arg_25_0._selectHeroId)

		if var_25_1 then
			return var_25_1
		end

		local var_25_2 = RoomHelper.get2KeyValue(arg_25_0._trainPreveSendDict, arg_25_0._selectCritterUid, arg_25_0._selectHeroId)

		if var_25_2 == nil or var_25_2 < Time.time then
			RoomHelper.add2KeyValue(arg_25_0._trainPreveSendDict, arg_25_0._selectCritterUid, arg_25_0._selectHeroId, Time.time + 2)
			CritterRpc.instance:sendStartTrainCritterPreviewRequest(arg_25_0._selectCritterUid, arg_25_0._selectHeroId)
		end
	end

	return nil
end

function var_0_0.refreshSelectHeroUI(arg_26_0)
	local var_26_0 = RoomTrainHeroListModel.instance:getById(arg_26_0._selectHeroId)
	local var_26_1 = var_26_0 ~= nil

	gohelper.setActive(arg_26_0._gohashero, var_26_1)
	gohelper.setActive(arg_26_0._gonohero, not var_26_1)
	gohelper.setActive(arg_26_0._txtheroinfo, var_26_1)
	gohelper.setActive(arg_26_0._scrollheroarr, var_26_1)

	if var_26_1 then
		arg_26_0._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(var_26_0.skinConfig.headIcon))

		arg_26_0._txtheroname.text = var_26_0.heroConfig and var_26_0.heroConfig.name

		arg_26_0._heroAttrComp:onUpdateMO(var_26_0:getAttributeInfoMO())

		arg_26_0._txtpreference.text = var_26_0:getPrefernectName()

		if var_26_0.critterHeroConfig then
			arg_26_0._simagepreference:LoadImage(ResUrl.getCritterHedaIcon(var_26_0.critterHeroConfig.critterIcon))
		end
	else
		arg_26_0._txtheroname.text = luaLang("critter_train_noselect_hero_text")
	end

	arg_26_0:refreshAttributeItem()
	arg_26_0:showSceneSpine()
	arg_26_0:refreshReferenceUI()
end

function var_0_0.showSceneSpine(arg_27_0)
	arg_27_0._lastHeroId = arg_27_0._selectHeroId
	arg_27_0._lastCritterUiId = arg_27_0._selectCritterUid

	if arg_27_0:_isHideSpine() then
		arg_27_0._lastHeroId = nil
		arg_27_0._lastCritterUiId = nil
	end

	local var_27_0 = RoomTrainHeroListModel.instance:getById(arg_27_0._lastHeroId)
	local var_27_1 = CritterModel.instance:getCritterMOByUid(arg_27_0._lastCritterUiId)
	local var_27_2 = arg_27_0.viewContainer:getContainerViewBuildingUid()
	local var_27_3 = 7
	local var_27_4 = 6

	RoomCritterController.instance:showTrainSceneHero(var_27_0, var_27_2, var_27_3)
	RoomCritterController.instance:showTrainSceneCritter(var_27_1, var_27_2, var_27_4)
end

function var_0_0._isHideSpine(arg_28_0)
	if not arg_28_0.__isOpenFlage then
		return true
	end

	if arg_28_0.viewContainer:getContainerCurSelectTab() ~= RoomCritterBuildingViewContainer.SubViewTabId.Training then
		return true
	end

	local var_28_0 = RoomCameraController.instance:getRoomScene()

	if not var_28_0 then
		return true
	end

	return var_28_0.camera:getCameraState() == RoomEnum.CameraState.ThirdPerson
end

function var_0_0._onCritterArrComp(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_1:onUpdateMO(arg_29_2)

	if not arg_29_1._view then
		arg_29_1._view = arg_29_0
	end

	if not arg_29_0._isHasSelectCritter then
		arg_29_1._txtratio.text = "--"
		arg_29_1._txtnum.text = "--"
	end
end

return var_0_0
