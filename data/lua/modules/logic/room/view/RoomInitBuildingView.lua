module("modules.logic.room.view.RoomInitBuildingView", package.seeall)

slot0 = class("RoomInitBuildingView", BaseView)
slot1 = 0.3
slot0.TabId = {
	ProductionLine = 1,
	BuildDegree = 2
}

function slot0.onInitView(slot0)
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._gocategoryItem = gohelper.findChild(slot0.viewGO, "left/#scroll_catagory/viewport/content/#go_catagoryItem")
	slot0._gotitle = gohelper.findChild(slot0.viewGO, "left/title")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "left/title/#image_icon")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "left/title/#txt_title")
	slot0._txttitleEn = gohelper.findChildText(slot0.viewGO, "left/title/#txt_title/#txt_titleEn")
	slot0._golevelitem = gohelper.findChild(slot0.viewGO, "left/title/activeLv/#go_levelitem")
	slot0._btnlevelup = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/title/layout/#btn_levelup")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "left/title/layout/#btn_levelup/txt/#go_reddot")
	slot0._btnskin = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/title/layout/#btn_skin")
	slot0._goskinreddot = gohelper.findChild(slot0.viewGO, "left/title/layout/#btn_skin/#go_reddot")
	slot0._gopart = gohelper.findChild(slot0.viewGO, "right/#go_part")
	slot0._goinit = gohelper.findChild(slot0.viewGO, "right/#go_init")
	slot0._goskin = gohelper.findChild(slot0.viewGO, "right/#go_skin")
	slot0._gohubList = gohelper.findChild(slot0.viewGO, "right/#go_init/#go_hubList")
	slot0._goactiveList = gohelper.findChild(slot0.viewGO, "right/#go_init/#go_activeList")
	slot0._btnbuildingHub = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_init/buildingLayout/#btn_buildingHub")
	slot0._btnbuildingActive = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#go_init/buildingLayout/#btn_buildingActive")
	slot0._gogatherpart = gohelper.findChild(slot0.viewGO, "right/#go_init/#go_hubList/#go_gatherpart")
	slot0._gochangepart = gohelper.findChild(slot0.viewGO, "right/#go_init/#go_hubList/#go_changepart")
	slot0._gogather = gohelper.findChild(slot0.viewGO, "right/#go_part/#go_gather")
	slot0._gochange = gohelper.findChild(slot0.viewGO, "right/#go_part/#go_change")
	slot0._simagecombinebg = gohelper.findChildSingleImage(slot0.viewGO, "right/#go_part/#go_change/combine/go_combine3/#simage_combinebg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnskin:AddClickListener(slot0._btnskinOnClick, slot0)
	slot0._btnlevelup:AddClickListener(slot0._btnlevelupOnClick, slot0)
	slot0._btnbuildingHub:AddClickListener(slot0._btnbuildingHubOnClick, slot0)
	slot0._btnbuildingActive:AddClickListener(slot0._btnbuildingActiveOnClick, slot0)
	slot0:addEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, slot0._onSkinListViewShowChange, slot0)
	slot0:addEventCb(RoomSkinController.instance, RoomSkinEvent.RoomSkinMarkUpdate, slot0._refreshSkinReddot, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnskin:RemoveClickListener()
	slot0._btnlevelup:RemoveClickListener()
	slot0._btnbuildingHub:RemoveClickListener()
	slot0._btnbuildingActive:RemoveClickListener()
	slot0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, slot0._onSkinListViewShowChange, slot0)
	slot0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.RoomSkinMarkUpdate, slot0._refreshSkinReddot, slot0)
end

function slot0._btnskinOnClick(slot0)
	RoomSkinController.instance:setRoomSkinListVisible(slot0._selectPartId)
end

function slot0._btnlevelupOnClick(slot0)
	RoomMapController.instance:openRoomLevelUpView()
end

function slot0._btnbuildingHubOnClick(slot0)
	slot0:_changeSelectTab(1)
end

function slot0._btnbuildingActiveOnClick(slot0)
	slot0:_changeSelectTab(2)
end

function slot0._categoryItemOnClick(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		return
	end

	slot0:_changeSelectPart(slot0._categoryItemList[slot1].partId, true)

	if slot0._lastItemIndex ~= slot1 then
		slot0._lastItemIndex = slot1

		if slot1 == 1 then
			slot0:_changeSelectTab(1)
		end
	end
end

function slot0._btninitpartproductOnClick(slot0, slot1)
	if #RoomProductionHelper.getCanGainLineIdList(slot1) > 0 then
		slot0._flyEffectRewardInfoList = {}

		for slot7, slot8 in ipairs(slot2) do
			slot10 = RoomProductionModel.instance:getLineMO(slot8):getReservePer()

			if not LuaUtil.tableNotEmpty(slot0._flyEffectRewardInfoList) then
				table.insert(slot0._flyEffectRewardInfoList, {
					rewardInfo = RoomProductionHelper.getFormulaRewardInfo(slot9.formulaId),
					position = slot0:_getPartItemByPartId(slot1).simagereward.gameObject.transform.position
				})
			end

			slot0._lineIdPerDict[slot8] = slot10
		end

		RoomRpc.instance:sendGainProductionLineRequest(slot2, true)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shop_collect)
	end
end

function slot0._btninitpartProductOnClick(slot0, slot1)
	slot0:_changeSelectPart(slot1)
end

function slot0._btninitpartChangeOnClick(slot0, slot1)
	slot0:_changeSelectPart(slot1, false, true)
end

function slot0._btnupgradeOnClick(slot0, slot1)
	ViewMgr.instance:openView(ViewName.RoomProductLineLevelUpView, {
		lineMO = RoomProductionModel.instance:getLineMO(slot0:_getLineItemByIndex(slot1).lineId),
		selectPartId = slot0._selectPartId
	})
end

function slot0._lineclickOnClick(slot0, slot1)
	if RoomProductionModel.instance:getLineMO(slot0:_getLineItemByIndex(slot1).lineId):isLock() then
		slot0:_hideExpandDetailUI()
		ToastController.instance:showToast(RoomEnum.Toast.RoomProductLineLockTips, slot3.config.needRoomLevel)
	elseif slot0._selectLineId == slot2.lineId then
		if slot0._expandDetailLineId == slot0._selectLineId then
			slot0._expandDetailLineId = nil
		else
			slot0._expandDetailLineId = slot0._selectLineId
		end

		slot0:_refreshDetailPartGather(slot0._selectPartId)
	else
		slot0._expandDetailLineId = slot2.lineId

		slot0:_changeSelectLine(slot2.lineId)
	end
end

function slot0._detailgathergetOnClick(slot0)
	if #RoomProductionHelper.getCanGainLineIdList(slot0._selectPartId) > 0 then
		slot0._flyEffectRewardInfoList = {}
		slot0._lineIdPerDict = {}

		for slot5, slot6 in ipairs(slot1) do
			slot8 = RoomProductionModel.instance:getLineMO(slot6):getReservePer()

			if not LuaUtil.tableNotEmpty(slot0._flyEffectRewardInfoList) then
				table.insert(slot0._flyEffectRewardInfoList, {
					rewardInfo = RoomProductionHelper.getFormulaRewardInfo(slot7.formulaId),
					position = slot0._gatherItem.btnget.gameObject.transform.position
				})
			end

			slot0._lineIdPerDict[slot6] = slot8
		end

		RoomRpc.instance:sendGainProductionLineRequest(slot1, true)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shop_collect)
	end

	slot0:_hideExpandDetailUI()
end

function slot0._gainProductionLineCallback(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot0:_playLineAnimation()

	if not slot0._flyEffectRewardInfoList or #slot0._flyEffectRewardInfoList <= 0 then
		return
	end

	for slot6, slot7 in ipairs(slot0._flyEffectRewardInfoList) do
		RoomMapController.instance:dispatchEvent(RoomEvent.UIFlyEffect, {
			startPos = slot7.position,
			itemType = slot7.rewardInfo.type,
			itemId = slot7.rewardInfo.id,
			startQuantity = slot7.rewardInfo.quantity
		})
	end

	slot0._flyEffectRewardInfoList = nil
end

function slot0._playLineAnimation(slot0)
	if slot0._lineGetTweenId then
		if slot0._scene.tween then
			slot0._scene.tween:killById(slot0._lineGetTweenId)
		else
			ZProj.TweenHelper.KillById(slot0._lineGetTweenId)
		end

		slot0._lineGetTweenId = nil
	end

	if LuaUtil.tableNotEmpty(slot0._lineIdPerDict) then
		if slot0._scene.tween then
			slot0._lineGetTweenId = slot0._scene.tween:tweenFloat(1, 0, 0.5, slot0._lineAnimationFrame, slot0._lineAnimationFinish, slot0)
		else
			slot0._lineGetTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, slot0._lineAnimationFrame, slot0._lineAnimationFinish, slot0)
		end
	end
end

function slot0._lineAnimationFrame(slot0, slot1)
	if slot0._selectPartId == 0 then
		for slot5, slot6 in ipairs(slot0._initPartProductItemList) do
			for slot10, slot11 in ipairs(slot6.lineItemList) do
				if slot0._lineIdPerDict[slot11.lineId] then
					slot0:_refreshLineAnimationShow(slot12, slot1, slot11.imageprocess, slot11.txtprocess)
				end
			end
		end
	else
		for slot5, slot6 in ipairs(slot0._gatherItem.lineItemList) do
			if slot0._lineIdPerDict[slot6.lineId] then
				slot0:_refreshLineAnimationShow(slot7, slot1, slot6.imageprocess, slot6.txtprocess)
			end
		end

		if slot0._lineIdPerDict[slot0._selectLineId] then
			slot0:_refreshLineAnimationShow(slot2, slot1, nil, )
		end
	end
end

function slot0._refreshLineAnimationShow(slot0, slot1, slot2, slot3, slot4)
	if slot3 then
		slot3.fillAmount = slot1 * slot2
	end

	if slot4 then
		slot4.text = string.format("%d%%", math.max(0, math.floor(slot1 * 100)))
	end
end

function slot0._lineAnimationFinish(slot0)
	slot0:_lineAnimationFrame(0)

	slot0._lineIdPerDict = {}
end

function slot0._clearLineAnimation(slot0)
	if slot0._lineGetTweenId then
		if slot0._scene.tween then
			slot0._scene.tween:killById(slot0._lineGetTweenId)
		else
			ZProj.TweenHelper.KillById(slot0._lineGetTweenId)
		end

		slot0._lineGetTweenId = nil
	end

	slot0._lineIdPerDict = {}
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._selectPartId = 0
	slot0._selectTabId = uv0.TabId.ProductionLine
	slot0._selectLineId = 0

	slot0.viewContainer:setSelectLine(slot0._selectLineId)

	slot0._categoryItemList = {}

	gohelper.setActive(slot0._gocategoryItem, false)

	slot0._levelItemList = {}

	gohelper.setActive(slot0._golevelitem, false)

	slot0._buildingInfoItemList = {}
	slot0._detailInitTabHubItem = slot0:_getDetailInitItem(slot0._btnbuildingHub.gameObject)
	slot0._detailInitTabActiveItem = slot0:_getDetailInitItem(slot0._btnbuildingActive.gameObject)
	slot0._initPartProductItemList = {}
	slot0._initPartChangeItemList = {}

	gohelper.setActive(slot0._gogatherpart, false)
	gohelper.setActive(slot0._gochangepart, false)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._lineIdPerDict = {}

	gohelper.addUIClickAudio(slot0._btnlevelup.gameObject, AudioEnum.UI.UI_Rolesopen)
	slot0._simagecombinebg:LoadImage(ResUrl.getRoomImage("bg_hechengdiban"))
	slot0._simagemask:LoadImage(ResUrl.getRoomImage("full/bg_yinyingzhezhao"))

	slot0._expandDetailLineId = nil
	slot0._golevelupeffect = gohelper.findChild(slot0.viewGO, "left/title/layout/#btn_levelup/txt/#go_reddot/#leveup_effect")
end

function slot0._getLineItemByIndex(slot0, slot1)
	if slot1 == 0 then
		return slot0._changeItem.lineItem
	else
		return slot0._gatherItem.lineItemList[slot1]
	end
end

function slot0._getLineItemByLineId(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._gatherItem.lineItemList) do
		if slot6.lineId == slot1 then
			return slot6
		end
	end
end

function slot0._getPartItemByPartId(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._initPartProductItemList) do
		if slot6.partId == slot1 then
			return slot6
		end
	end

	for slot5, slot6 in ipairs(slot0._initPartChangeItemList) do
		if slot6.partId == slot1 then
			return slot6
		end
	end
end

function slot0._initChangeItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = slot0._gochange
	slot1.goline = gohelper.findChild(slot1.go, "productLineItem")
	slot1.gobgvx = gohelper.findChild(slot1.go, "combine/go_combine3/#bgvx")
	slot1.gohechengeffect = gohelper.findChild(slot1.go, "combine/#hechengeffect")
	slot1.lineItem = slot0:getUserDataTb_()

	slot0:_initLine(slot1.lineItem, slot1.goline, false, 0)
	gohelper.setActive(slot1.goline, true)

	return slot1
end

function slot0._initGatherItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = slot0._gogather
	slot1.txtname = gohelper.findChildText(slot1.go, "collect/txt_productLineName")
	slot1.txtprocess = gohelper.findChildText(slot1.go, "collect/txt_collectprocess")
	slot1.goarrow = gohelper.findChild(slot1.go, "collect/txt_collectprocess/go_arrow")
	slot1.gopause = gohelper.findChild(slot1.go, "collect/txt_collectprocess/go_pause")
	slot1.imagereward = gohelper.findChildImage(slot1.go, "collect/image_curcollectitem")
	slot1.goline = gohelper.findChild(slot1.go, "scroll_productLine/viewport/content/go_productLineItem")
	slot1.goinfo = gohelper.findChild(slot1.go, "go_gatherInfo")
	slot1.txtstore = gohelper.findChildText(slot1.go, "go_gatherInfo/collectinfo/right/txt_store")
	slot1.txttime = gohelper.findChildText(slot1.go, "go_gatherInfo/collectinfo/right/txt_expspeed")
	slot1.txtremain = gohelper.findChildText(slot1.go, "go_gatherInfo/collectinfo/right/txt_time")
	slot1.goget = gohelper.findChild(slot1.go, "btn_get/go_get")
	slot1.gonoget = gohelper.findChild(slot1.go, "btn_get/go_noget")
	slot1.btnget = gohelper.findChildButton(slot1.go, "btn_get")
	slot1.btnnewget = gohelper.findChildButton(slot1.go, "collect/btn_get")
	slot1.animatorcircle = gohelper.findChild(slot1.go, "collect/bg"):GetComponent(typeof(UnityEngine.Animator))
	slot1.animatorget = slot1.btnget.gameObject:GetComponent(typeof(UnityEngine.Animator))

	slot1.btnget:AddClickListener(slot0._detailgathergetOnClick, slot0)
	slot1.btnnewget:AddClickListener(slot0._detailgathergetOnClick, slot0)

	slot1.lineItemList = {}

	gohelper.setActive(slot1.goline, false)

	return slot1
end

function slot0._initLine(slot0, slot1, slot2, slot3, slot4)
	slot1.go = slot2
	slot1.index = slot4
	slot1.isGather = slot3
	slot1.txtname = gohelper.findChildText(slot1.go, "name")
	slot1.goshowprocess = gohelper.findChild(slot1.go, "go_process")
	slot1.golevelitem = gohelper.findChild(slot1.go, "name/go_activeLv/go_normalitem")
	slot1.imageprocess = gohelper.findChildImage(slot1.go, "go_process/go_process/processbar")
	slot1.txtprocess = gohelper.findChildText(slot1.go, "go_process/go_process/num")
	slot1.goprocess = gohelper.findChild(slot1.go, "go_process/go_process")
	slot1.btnupgrade = gohelper.findChildButtonWithAudio(slot1.go, "btn_upgrade")
	slot1.reddot = gohelper.findChild(slot1.go, "btn_upgrade/reddot")

	slot1.btnupgrade:AddClickListener(slot0._btnupgradeOnClick, slot0, slot1.index)
	gohelper.addUIClickAudio(slot1.btnupgrade.gameObject, AudioEnum.UI.UI_Rolesopen)

	slot1.levelItemList = slot0:getUserDataTb_()

	if slot3 then
		slot1.gofull = gohelper.findChild(slot1.go, "go_process/go_full")
		slot1.gonormalbg = gohelper.findChild(slot1.go, "go_normalbg")
		slot1.gofullbg = gohelper.findChild(slot1.go, "go_fullbg")
		slot1.goselectbg = gohelper.findChild(slot1.go, "go_selectbg")
		slot1.golock = gohelper.findChild(slot1.go, "go_lock")
		slot1.txtlock = gohelper.findChildText(slot1.go, "go_lock/txt_lock")
		slot1.btnclick = gohelper.findChildButtonWithAudio(slot1.go, "btn_click")

		slot1.btnclick:AddClickListener(slot0._lineclickOnClick, slot0, slot1.index)

		slot1.gatherAnimator = slot1.go:GetComponent(typeof(UnityEngine.Animator))
	else
		slot1.goselectbg = gohelper.findChild(slot1.go, "selectbg")
		slot1.animator = slot1.goprocess:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(slot1.golevelitem, false)
end

function slot0._getDetailInitItem(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2.gonormal = gohelper.findChild(slot2.go, "go_normalbg")
	slot2.goselect = gohelper.findChild(slot2.go, "go_selectbg")

	return slot2
end

function slot0._changeSelectPart(slot0, slot1, slot2, slot3)
	if slot1 ~= 0 and not RoomProductionHelper.hasUnlockLine(slot1) then
		if RoomProductionHelper.getPartType(slot1) == RoomProductLineEnum.ProductType.Change then
			GameFacade.showToast(ToastEnum.MaterialItemLockOnClick2)
		end

		return
	end

	if slot0._selectPartId == slot1 then
		return
	end

	slot0._expandDetailLineId = nil
	slot0._waitChangeSelectPartId = slot1

	slot0:_refreshCategory()
	slot0:_refreshCamera()

	slot0._keepOpenSkinListAfterChange = RoomSkinModel.instance:getIsShowRoomSkinList()

	RoomSkinController.instance:clearPreviewRoomSkin()

	slot0._animator.enabled = true

	slot0._animator:Play("swicth", 0, 0)
	TaskDispatcher.cancelTask(slot0._realChangeSelectPart, slot0)
	TaskDispatcher.runDelay(slot0._realChangeSelectPart, slot0, uv0)

	if slot2 then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	end

	if slot3 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)
	end
end

function slot0._realChangeSelectPart(slot0)
	if not slot0._waitChangeSelectPartId then
		return
	end

	slot0._selectPartId = slot0._waitChangeSelectPartId

	slot0.viewContainer:setSelectPartId(slot0._selectPartId)
	RoomController.instance:dispatchEvent(RoomEvent["GuideOpenInitBuilding" .. slot0._selectPartId])

	slot0._waitChangeSelectPartId = nil

	slot0:_refreshSelectPart(false, true)

	if slot0._keepOpenSkinListAfterChange then
		slot0:_btnskinOnClick()

		slot0._keepOpenSkinListAfterChange = false
	end
end

function slot0._changeSelectTab(slot0, slot1)
	if slot0._selectTabId == slot1 then
		return
	end

	slot0._selectTabId = slot1

	slot0:_refreshSelectTab()
end

function slot0._changeSelectLine(slot0, slot1)
	if slot0._selectLineId == slot1 then
		return
	end

	slot0._selectLineId = slot1

	slot0.viewContainer:setSelectLine(slot0._selectLineId)
	slot0:_refreshDetailPartGather(slot0._selectPartId)
end

function slot0._refreshUI(slot0, slot1)
	slot0._selectPartId = slot0.viewParam and slot2.partId or 0
	slot0._selectLineId = slot2 and slot2.lineId or 0

	slot0.viewContainer:setSelectLine(slot0._selectLineId)
	slot0.viewContainer:setSelectPartId(slot0._selectPartId)
	RoomController.instance:dispatchEvent(RoomEvent["GuideOpenInitBuilding" .. slot0._selectPartId])
	slot0:_refreshSelectPart(slot1)
end

function slot0._refreshSelectPart(slot0, slot1, slot2)
	slot0:_clearLineAnimation()

	if not slot1 and not slot2 then
		slot0:_refreshCamera()
	end

	slot0:_refreshCategory()
	slot0:_refreshTitle()
	slot0:_refreshLevel()
	slot0:_realChangeShowSkinList()
	slot0:_refreshSkinReddot()
	RoomSkinController.instance:clearInitBuildingEntranceReddot(slot0._selectPartId)
end

function slot0._refreshCamera(slot0)
	RoomBuildingController.instance:tweenCameraFocusPart(slot0._waitChangeSelectPartId or slot0._selectPartId, RoomEnum.CameraState.Normal, 0)
end

function slot0._refreshCategory(slot0)
	table.insert({}, 0)

	for slot6, slot7 in ipairs(RoomConfig.instance:getProductionPartConfigList()) do
		table.insert(slot1, slot7.id)
	end

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]

		if not slot0._categoryItemList[slot6] then
			slot8 = slot0:getUserDataTb_()
			slot8.index = slot6
			slot8.go = gohelper.cloneInPlace(slot0._gocategoryItem, "categoryItem" .. slot6)
			slot8.gonormal = gohelper.findChild(slot8.go, "go_normal")
			slot8.imageiconnormal = gohelper.findChildImage(slot8.go, "go_normal/icon")
			slot8.goselect = gohelper.findChild(slot8.go, "go_select")
			slot8.imageiconselect = gohelper.findChildImage(slot8.go, "go_select/icon")
			slot8.goreddot = gohelper.findChild(slot8.go, "reddot")
			slot8.gosubLine = gohelper.findChild(slot8.go, "go_subLine")
			slot8.btnclick = gohelper.findChildButtonWithAudio(slot8.go, "btn_click")

			slot8.btnclick:AddClickListener(slot0._categoryItemOnClick, slot0, slot8.index)
			table.insert(slot0._categoryItemList, slot8)
		end

		slot8.partId = slot7

		gohelper.setActive(slot8.gosubLine, slot7 == 0)

		if slot7 == 0 then
			if (slot0._waitChangeSelectPartId or slot0._selectPartId) ~= slot7 then
				UISpriteSetMgr.instance:setRoomSprite(slot8.imageiconnormal, "bg_init")
			else
				UISpriteSetMgr.instance:setRoomSprite(slot8.imageiconselect, "bg_init_ovr")
			end
		elseif slot9 ~= slot7 then
			UISpriteSetMgr.instance:setRoomSprite(slot8.imageiconnormal, "bg_part" .. slot7)
		else
			UISpriteSetMgr.instance:setRoomSprite(slot8.imageiconselect, "bg_part" .. slot7 .. "_ovr")
		end

		gohelper.setActive(slot8.gonormal, slot9 ~= slot7)
		gohelper.setActive(slot8.goselect, slot9 == slot7)
		gohelper.setActive(slot8.goreddot, false)
		gohelper.setActive(slot8.go, slot7 == 0 or RoomProductionHelper.hasUnlockLine(slot7))
	end

	for slot6 = #slot1 + 1, #slot0._categoryItemList do
		gohelper.setActive(slot0._categoryItemList[slot6].go, false)
	end
end

function slot0._refreshTitle(slot0)
	if slot0._selectPartId == 0 then
		UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "bg_init")

		slot0._txttitle.text = luaLang("room_initbuilding_title")
		slot0._txttitleEn.text = "Paleohall"
	else
		UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "bg_part" .. slot0._selectPartId)

		slot1 = RoomConfig.instance:getProductionPartConfig(slot0._selectPartId)
		slot0._txttitle.text = slot1.name
		slot0._txttitleEn.text = slot1.nameEn
	end
end

function slot0._refreshLevel(slot0)
	slot1 = 0
	slot2 = 0

	if slot0._selectPartId == 0 then
		slot1 = RoomConfig.instance:getMaxRoomLevel()
		slot2 = RoomMapModel.instance:getRoomLevel()
	end

	for slot6 = 1, slot1 do
		if not slot0._levelItemList[slot6] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._golevelitem, "levelitem" .. slot6)
			slot7.golight = gohelper.findChild(slot7.go, "go_light")

			table.insert(slot0._levelItemList, slot7)
		end

		gohelper.setActive(slot7.golight, slot6 <= slot2)
		gohelper.setActive(slot7.go, true)
	end

	for slot6 = slot1 + 1, #slot0._levelItemList do
		gohelper.setActive(slot0._levelItemList[slot6].go, false)
	end

	slot3 = slot0._selectPartId == 0 and slot2 < slot1

	gohelper.setActive(slot0._btnlevelup.gameObject, slot3)

	if slot3 then
		RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomInitBuildingLevel)
		slot0:_refreshRoomLevelUpEffect()
	end
end

function slot0._refreshSkinReddot(slot0)
	if not slot0.skinRedDot then
		slot0.skinRedDot = RedDotController.instance:addNotEventRedDot(slot0._goskinreddot, slot0._checkNewSkinReddot, slot0)

		return
	end

	slot0.skinRedDot:refreshRedDot()
end

function slot0._checkNewSkinReddot(slot0)
	return RoomSkinModel.instance:isHasNewRoomSkin(slot0._selectPartId)
end

function slot0._onSkinListViewShowChange(slot0, slot1)
	slot0._animator.enabled = true

	if slot1 then
		slot0._animator:Play("swicth", 0, 0)
	end

	TaskDispatcher.cancelTask(slot0._realChangeShowSkinList, slot0)
	TaskDispatcher.runDelay(slot0._realChangeShowSkinList, slot0, uv0)
end

function slot0._realChangeShowSkinList(slot0)
	if RoomSkinModel.instance:getIsShowRoomSkinList() then
		gohelper.setActive(slot0._goinit, false)
		gohelper.setActive(slot0._gopart, false)
	else
		slot0:_refreshDetail(true)
	end

	slot0:setTitleShow(not slot1)
	gohelper.setActive(slot0._goskin, slot1)
end

function slot0.setTitleShow(slot0, slot1)
	gohelper.setActive(slot0._gotitle, slot1)
end

function slot0._refreshRoomLevelUpEffect(slot0)
	gohelper.setActive(slot0._golevelupeffect, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomInitBuildingLevel, 0))
end

function slot0._refreshDetail(slot0, slot1)
	gohelper.setActive(slot0._goinit, slot0._selectPartId == 0)
	gohelper.setActive(slot0._gopart, slot0._selectPartId ~= 0)

	if slot0._selectPartId == 0 then
		slot0:_refreshDetailInit()
	else
		slot0:_refreshDetailPart(slot1)
	end
end

function slot0._refreshDetailInit(slot0)
	slot0:_refreshSelectTab()
end

function slot0._refreshSelectTab(slot0)
	gohelper.setActive(slot0._detailInitTabHubItem.gonormal, slot0._selectTabId ~= uv0.TabId.ProductionLine)
	gohelper.setActive(slot0._detailInitTabHubItem.goselect, slot0._selectTabId == uv0.TabId.ProductionLine)
	gohelper.setActive(slot0._detailInitTabActiveItem.gonormal, slot0._selectTabId ~= uv0.TabId.BuildDegree)
	gohelper.setActive(slot0._detailInitTabActiveItem.goselect, slot0._selectTabId == uv0.TabId.BuildDegree)
	gohelper.setActive(slot0._gohubList, slot0._selectTabId == uv0.TabId.ProductionLine)
	gohelper.setActive(slot0._goactiveList, slot0._selectTabId == 2)

	if slot0._selectTabId == uv0.TabId.ProductionLine then
		slot0:_refreshInitPart()
	elseif slot0._selectTabId == uv0.TabId.BuildDegree then
		slot0:_refreshBuildDegree()
	end
end

function slot0._refreshTabCountText(slot0)
	slot0._detailInitTabHubItem.txtcount.text = #RoomConfig.instance:getProductionPartConfigList()
	slot0._detailInitTabActiveItem.txtcount.text = RoomMapModel.instance:getAllBuildDegree()
end

function slot0._refreshBuildDegree(slot0)
	RoomShowDegreeListModel.instance:setShowDegreeList()
end

function slot0._refreshInitPart(slot0)
	if slot0._selectPartId ~= 0 then
		return
	end

	slot2 = 0
	slot3 = 0

	for slot7, slot8 in ipairs(RoomConfig.instance:getProductionPartConfigList()) do
		slot9, slot10 = RoomProductionHelper.getPartType(slot8.id)

		if slot9 == RoomProductLineEnum.ProductType.Product then
			slot0:_refreshInitPartProduct(slot8, slot2 + 1)
		elseif slot9 == RoomProductLineEnum.ProductType.Change then
			slot0:_refreshInitPartChange(slot8, slot3 + 1)
		end
	end

	for slot7 = slot2 + 1, #slot0._initPartProductItemList do
		gohelper.setActive(slot0._initPartProductItemList[slot7].go, false)
	end

	for slot7 = slot3 + 1, #slot0._initPartChangeItemList do
		gohelper.setActive(slot0._initPartChangeItemList[slot7].go, false)
	end

	slot0:_refreshInitPartProductGet()
end

function slot0._refreshInitPartProduct(slot0, slot1, slot2)
	if not slot0._initPartProductItemList[slot2] then
		slot3 = slot0:getUserDataTb_()
		slot3.partId = slot1.id
		slot3.go = gohelper.cloneInPlace(slot0._gogatherpart, "gatheritem" .. slot2)
		slot3.txtname = gohelper.findChildText(slot3.go, "title/txt")
		slot3.txtnameen = gohelper.findChildText(slot3.go, "title/txt/txtEn")
		slot3.golineitem = gohelper.findChild(slot3.go, "scroll_productline/viewport/content/go_productLineItem")
		slot3.simagereward = gohelper.findChildSingleImage(slot3.go, "reward/simage_reward")
		slot3.animator = gohelper.findChild(slot3.go, "reward/circle"):GetComponent(typeof(UnityEngine.Animator))
		slot3.btnget = gohelper.findChildButton(slot3.go, "reward/btn_get")
		slot3.btnjumpclick = gohelper.findChildButtonWithAudio(slot3.go, "btn_jumpclick")

		slot3.btnget:AddClickListener(slot0._btninitpartproductOnClick, slot0, slot3.partId)
		slot3.btnjumpclick:AddClickListener(slot0._btninitpartProductOnClick, slot0, slot3.partId)

		slot3.lineItemList = {}

		gohelper.setActive(slot3.golineitem, false)
		table.insert(slot0._initPartProductItemList, slot3)
	end

	gohelper.setActive(slot3.go, true)

	slot4, slot5 = RoomProductionHelper.getPartType(slot1.id)
	slot3.txtname.text = slot1.name
	slot3.txtnameen.text = slot1.nameEn

	if slot5 == RoomProductLineEnum.ProductItemType.ProductExp then
		slot3.simagereward:LoadImage(ResUrl.getPropItemIcon("5"))
		transformhelper.setLocalPosXY(slot3.simagereward.gameObject.transform, -11, 5.45)

		slot3.simagereward.gameObject.transform.rotation = Quaternion.Euler(0, 0, -7)
	elseif slot5 == RoomProductLineEnum.ProductItemType.ProductGold then
		slot3.simagereward:LoadImage(ResUrl.getPropItemIcon("3"))
	end

	slot0:_refreshInitPartProductLine(slot3, slot1)
end

function slot0._refreshInitPartProductLine(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot2.productionLines) do
		if not slot1.lineItemList[slot7] then
			slot9 = slot0:getUserDataTb_()
			slot9.lineId = slot8
			slot9.go = gohelper.cloneInPlace(slot1.golineitem, "item" .. slot7)
			slot9.gonormal = gohelper.findChild(slot9.go, "go_normal")
			slot9.txtname = gohelper.findChildText(slot9.go, "go_normal/name")
			slot9.golevel = gohelper.findChild(slot9.go, "go_normal/name/go_activeLv/go_normalitem")
			slot9.gofull = gohelper.findChild(slot9.go, "go_normal/go_process/go_full")
			slot9.goprocess = gohelper.findChild(slot9.go, "go_normal/go_process/go_process")
			slot9.imageprocess = gohelper.findChildImage(slot9.go, "go_normal/go_process/go_process/processbar")
			slot9.txtprocess = gohelper.findChildText(slot9.go, "go_normal/go_process/go_process/num")
			slot9.golock = gohelper.findChild(slot9.go, "go_lock")
			slot9.lockdesc = gohelper.findChildText(slot9.go, "go_lock/txt_lockdesc")
			slot9.levelItemList = {}

			gohelper.setActive(slot9.golevel, false)

			slot9.animator = slot9.go:GetComponent(typeof(UnityEngine.Animator))

			table.insert(slot1.lineItemList, slot9)
		end

		gohelper.setActive(slot9.go, true)

		slot10 = RoomProductionModel.instance:getLineMO(slot8)
		slot9.lockdesc.text = string.format(luaLang("room_initbuilding_linelock"), slot10.config.needRoomLevel)
		slot9.txtname.text = slot10.config.name

		if slot10:isLock() or slot10:isIdle() then
			gohelper.setActive(slot9.gofull, false)
			gohelper.setActive(slot9.goprocess, false)
		elseif slot10:isFull() then
			gohelper.setActive(slot9.gofull, true)
			gohelper.setActive(slot9.goprocess, false)
		else
			gohelper.setActive(slot9.gofull, false)
			gohelper.setActive(slot9.goprocess, true)

			slot9.imageprocess.fillAmount, slot12 = slot10:getReservePer()

			if not slot0._lineIdPerDict[slot9.lineId] then
				slot9.txtprocess.text = string.format("%d%%", slot12)
			end
		end

		slot11 = slot10.level or 0
		slot12 = slot10.maxLevel or 0

		if slot10:isLock() then
			slot12 = 0
		end

		for slot16 = 1, slot12 do
			if not slot9.levelItemList[slot16] then
				slot17 = slot0:getUserDataTb_()
				slot17.go = gohelper.cloneInPlace(slot9.golevel, "item" .. slot16)
				slot17.golight = gohelper.findChild(slot17.go, "go_light")

				table.insert(slot9.levelItemList, slot17)
			end

			gohelper.setActive(slot17.golight, slot16 <= slot11)
			gohelper.setActive(slot17.go, true)
		end

		for slot16 = slot12 + 1, #slot9.levelItemList do
			gohelper.setActive(slot9.levelItemList[slot16].go, false)
		end

		if slot10:isLock() then
			slot9.animator.speed = 0

			slot9.animator:Play("unlock", 0, 0)
			slot9.animator:Update(0)
		elseif RoomProductionModel.instance:shouldPlayLineUnlock(slot8) then
			slot9.animator.speed = 0

			slot9.animator:Play("unlock", 0, 0)
			slot9.animator:Update(0)

			if not RoomMapModel.instance:isRoomLeveling() and not ViewMgr.instance:isOpen(ViewName.RoomLevelUpTipsView) then
				RoomProductionModel.instance:setPlayLineUnlock(slot8, nil)
				TaskDispatcher.runDelay(slot0._playLineUnlock, slot9, 0.4)
			end
		else
			slot9.animator.speed = 0

			slot9.animator:Play(UIAnimationName.Idle, 0, 0)
			slot9.animator:Update(0)
		end
	end

	for slot7 = #slot3 + 1, #slot1.lineItemList do
		gohelper.setActive(slot1.lineItemList[slot7].go, false)
	end
end

function slot0._playLineUnlock(slot0)
	slot0.animator.speed = 1

	slot0.animator:Play("unlock", 0, 0)
end

function slot0._refreshInitPartProductGet(slot0)
	for slot4, slot5 in ipairs(slot0._initPartProductItemList) do
		slot8 = false
		slot9 = false

		for slot13, slot14 in ipairs(RoomConfig.instance:getProductionPartConfig(slot5.partId).productionLines) do
			if RoomProductionModel.instance:getLineMO(slot14) and not slot15:isLock() then
				slot8 = true

				if not slot15:isIdle() and not slot15:isFull() then
					slot9 = true
				end
			end
		end

		gohelper.setActive(slot5.btnget.gameObject, #RoomProductionHelper.getCanGainLineIdList(slot5.partId) > 0 and slot8)
		slot5.animator:Play(slot9 and UIAnimationName.Loop or "idle")
	end
end

function slot0._refreshInitPartChange(slot0, slot1, slot2)
	if not slot0._initPartChangeItemList[slot2] then
		slot3 = slot0:getUserDataTb_()
		slot3.partId = slot1.id
		slot3.go = gohelper.cloneInPlace(slot0._gochangepart, "changeitem" .. slot2)
		slot3.txtname = gohelper.findChildText(slot3.go, "title/txt")
		slot3.txtnameen = gohelper.findChildText(slot3.go, "title/txt/txtEn")
		slot3.goformulaitem = gohelper.findChild(slot3.go, "scroll_productline/viewport/content/go_materialItem")
		slot3.simagedoor = gohelper.findChildSingleImage(slot3.go, "reward/simage_door")
		slot3.btncombine = gohelper.findChildButton(slot3.go, "reward/btn_combine")

		slot3.btncombine:AddClickListener(slot0._btninitpartChangeOnClick, slot0, slot3.partId)

		slot3.formulaItemList = {}

		gohelper.setActive(slot3.goformulaitem, false)
		table.insert(slot0._initPartChangeItemList, slot3)
	end

	gohelper.setActive(slot3.go, true)

	slot3.txtname.text = slot1.name
	slot3.txtnameen.text = slot1.nameEn

	slot3.simagedoor:LoadImage(ResUrl.getCurrencyItemIcon("door_room"))
	slot0:_refreshInitPartChangeFormula(slot3, slot1, RoomProductionHelper.getPartMaxLineLevel(slot1.id))
end

function slot0._refreshInitPartChangeFormula(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in ipairs(lua_formula_showtype.configList) do
		table.insert(slot4, slot9)
	end

	table.sort(slot4, function (slot0, slot1)
		if RoomProductionHelper.isFormulaShowTypeUnlock(slot0.id) <= uv0 and not (RoomProductionHelper.isFormulaShowTypeUnlock(slot1.id) <= uv0) then
			return true
		elseif slot3 and not slot2 then
			return false
		else
			return slot0.id < slot1.id
		end
	end)

	for slot9, slot10 in ipairs(slot4) do
		slot13 = RoomProductionHelper.isFormulaShowTypeUnlock(slot10.id) <= slot3 and RoomProductionHelper.hasUnlockLine(slot2.id)

		if not slot1.formulaItemList[slot9] then
			slot11 = slot0:getUserDataTb_()
			slot11.go = gohelper.cloneInPlace(slot1.goformulaitem, "item" .. slot9)
			slot11.gonormal = gohelper.findChild(slot11.go, "go_normal")
			slot11.txtnamenormal = gohelper.findChildText(slot11.go, "go_normal/txt_name")
			slot11.golock = gohelper.findChild(slot11.go, "go_lock")
			slot11.txtnamelock = gohelper.findChildText(slot11.go, "go_lock/txt_name")
			slot11.btnlockclick = gohelper.findChildButtonWithAudio(slot11.go, "go_lock/btn_lockclick")
			slot11.param = {}

			table.insert(slot1.formulaItemList, slot11)
		end

		slot11.btnlockclick:RemoveClickListener()

		slot11.param.partConfig = slot2
		slot11.param.unlockLevel = slot12
		slot11.param.unlockLevel = slot12

		if not slot13 then
			if slot5 then
				slot11.btnlockclick:AddClickListener(slot0._btnMaterialItemLockOnClick, slot0, slot11.param)
			else
				slot11.btnlockclick:AddClickListener(slot0._btnMaterialItemLockOnClick2, slot0)
			end
		end

		gohelper.setActive(slot11.gonormal, slot13)
		gohelper.setActive(slot11.golock, not slot13)

		if slot13 then
			slot11.txtnamenormal.text = slot10.name
		else
			slot11.txtnamelock.text = slot10.name
		end

		gohelper.setActive(slot11.go, true)
	end

	for slot9 = #slot4 + 1, #slot1.formulaItemList do
		gohelper.setActive(slot1.formulaItemList[slot9].go, false)
	end
end

function slot0._btnMaterialItemLockOnClick(slot0, slot1)
	GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, slot1.partConfig.name, slot1.unlockLevel)
end

function slot0._btnMaterialItemLockOnClick2(slot0)
	GameFacade.showToast(ToastEnum.MaterialItemLockOnClick2)
end

function slot0._refreshDetailPart(slot0, slot1)
	if slot0._selectPartId == 0 then
		return
	end

	slot3 = RoomConfig.instance:getProductionPartConfig(slot0._selectPartId).productionLines

	if slot0._selectLineId == 0 or not LuaUtil.tableContains(slot3, slot0._selectLineId) then
		slot0._selectLineId = slot3[1]

		slot0.viewContainer:setSelectLine(slot0._selectLineId)
	end

	gohelper.setActive(slot0._gogather, RoomProductionHelper.getPartType(slot0._selectPartId) == RoomProductLineEnum.ProductType.Product)
	gohelper.setActive(slot0._gochange, slot4 == RoomProductLineEnum.ProductType.Change)

	if slot4 == RoomProductLineEnum.ProductType.Product then
		slot0:_refreshDetailPartGather(slot0._selectPartId, not slot1)
	elseif slot4 == RoomProductLineEnum.ProductType.Change then
		slot0:_refreshDetailPartChange(slot0._selectPartId)
	end
end

function slot0._refreshDetailPartGather(slot0, slot1, slot2)
	if slot1 == 0 then
		return
	end

	if not slot0._gatherItem then
		slot0._gatherItem = slot0:_initGatherItem()
	end

	slot4 = RoomConfig.instance:getProductionPartConfig(slot1).productionLines

	gohelper.setActive(slot0._gatherItem.btnget.gameObject, false)

	slot7 = false
	slot8 = 0
	slot9 = nil
	slot0._lastDetailPartGatherCanGet = #RoomProductionHelper.getCanGainLineIdList(slot1) > 0

	for slot13, slot14 in ipairs(slot4) do
		if not slot0._gatherItem.lineItemList[slot13] then
			slot15 = slot0:getUserDataTb_()
			slot15.lineId = slot14
			slot15.go = gohelper.cloneInPlace(slot0._gatherItem.goline, "item" .. slot13)

			slot0:_initLine(slot15, slot15.go, true, slot13)
			table.insert(slot0._gatherItem.lineItemList, slot15)
		end

		slot16 = RoomProductionModel.instance:getLineMO(slot14)

		gohelper.setActive(slot15.go, true)
		slot0:_refreshLine(slot15, slot16, true)

		if not slot16:isLock() and not slot16:isIdle() and not slot16:isFull() then
			slot8 = slot8 + 1
			slot7 = true
		end

		if not slot9 then
			if slot16.config.type == RoomProductLineEnum.ProductItemType.ProductExp then
				slot9 = "1_huibiao"
			elseif slot16.config.type == RoomProductLineEnum.ProductItemType.ProductGold then
				slot9 = "2_huibiao"
			end
		end
	end

	for slot13 = #slot4 + 1, #slot0._gatherItem.lineItemList do
		gohelper.setActive(slot0._gatherItem.lineItemList[slot13].go, false)
	end

	gohelper.setActive(slot0._gatherItem.btnnewget.gameObject, slot6)

	slot0._gatherItem.txtname.text = slot3.name
	slot0._gatherItem.txtprocess.text = string.format("%s/%s", slot8, RoomProductionHelper.getUnlockLineCount(slot1))

	slot0._gatherItem.animatorcircle:Play(slot7 and UIAnimationName.Loop or "idle")
	UISpriteSetMgr.instance:setRoomSprite(slot0._gatherItem.imagereward, slot9 or "2_huibiao")

	slot11 = slot8 == 0 and slot10 > 0

	gohelper.setActive(slot0._gatherItem.gopause, slot11)
	gohelper.setActive(slot0._gatherItem.goarrow, not slot11)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._gatherItem.txtprocess, slot11 and "#D97373" or "#999999")
	slot0:_refreshDetailPartGatherSelectLine()
end

function slot0._hideExpandDetailUI(slot0)
	if slot0._expandDetailLineId then
		slot0._expandDetailLineId = nil

		slot0:_refreshDetailPartGather(slot0._selectPartId)
	end
end

function slot0._refreshDetailPartGatherSelectLine(slot0)
	TaskDispatcher.cancelTask(slot0._updateDetailPartGatherSelectLineTime, slot0)

	if slot0._selectPartId == 0 then
		gohelper.setActive(slot0._gatherItem.goinfo, false)

		return
	end

	gohelper.setActive(slot0._gatherItem.goinfo, slot0._expandDetailLineId == slot0._selectLineId)

	if slot0._expandDetailLineId == slot0._selectLineId then
		slot2 = ""

		if RoomProductionModel.instance:getLineMO(slot0._selectLineId).config.type == RoomProductLineEnum.ProductItemType.ProductExp then
			slot2 = luaLang("roominitbuildingview_dust")
		elseif slot1.config.type == RoomProductLineEnum.ProductItemType.ProductGold then
			slot2 = luaLang("roominitbuildingview_coin")
		end

		slot0._gatherItem.txtstore.text = string.format("<color=#65b96f>%s</color>/%s", slot1.useReserve, slot1.reserve)
		slot3, slot4, slot5 = TimeUtil.secondToHMS(slot1.costTime)

		if slot4 + slot3 * 60 > 0 then
			if slot5 > 0 then
				slot0._gatherItem.txttime.text = string.format("<color=#65b96f>%d </color>%s/<color=#65b96f>%d</color>%s<color=#65b96f>%d</color>%s", slot1.produceSpeed, slot2, slot6, luaLang("time_minute"), slot5, luaLang("time_second"))
			else
				slot0._gatherItem.txttime.text = string.format("<color=#65b96f>%d </color>%s/<color=#65b96f>%d</color>%s", slot1.produceSpeed, slot2, slot6, luaLang("time_minute"))
			end
		else
			slot0._gatherItem.txttime.text = string.format("<color=#65b96f>%d </color>%s/<color=#65b96f>%d</color>%s", slot1.produceSpeed, slot2, slot5, luaLang("time_second"))
		end

		slot0:_updateDetailPartGatherSelectLineTime()
		TaskDispatcher.runRepeat(slot0._updateDetailPartGatherSelectLineTime, slot0, 1)
		gohelper.addChild(slot0:_getLineItemByLineId(slot0._selectLineId).go, slot0._gatherItem.goinfo)

		slot8, slot9, slot10 = transformhelper.getLocalPos(slot0._gatherItem.goinfo.transform)

		transformhelper.setLocalPos(slot0._gatherItem.goinfo.transform, slot8, 0, slot10)
	end
end

function slot0._updateDetailPartGatherSelectLineTime(slot0)
	if slot0._selectPartId == 0 then
		TaskDispatcher.cancelTask(slot0._updateDetailPartGatherSelectLineTime, slot0)

		return
	end

	if slot0._selectLineId == 0 then
		TaskDispatcher.cancelTask(slot0._updateDetailPartGatherSelectLineTime, slot0)

		return
	end

	if RoomProductionModel.instance:getLineMO(slot0._selectLineId).config.logic ~= RoomProductLineEnum.ProductType.Product then
		TaskDispatcher.cancelTask(slot0._updateDetailPartGatherSelectLineTime, slot0)

		return
	end

	slot2 = math.floor(slot1.allFinishTime - ServerTime.now())

	if not slot1:isIdle() and slot1:isFull() then
		slot0._gatherItem.txtremain.text = luaLang("roominitbuildingview_fullpro")
	else
		slot0._gatherItem.txtremain.text = string.format("<color=#65B96F>%s </color>%s", TimeUtil.second2TimeString(math.max(0, slot2), true), luaLang("roominitbuildingview_stopproduct"))
	end
end

function slot0._refreshDetailPartChange(slot0, slot1)
	if not slot0._changeItem then
		slot0._changeItem = slot0:_initChangeItem()
	end

	slot0:_refreshDetailPartChangeTitle(slot1)
	gohelper.setActive(slot0._changeItem.gobgvx, false)
	gohelper.setActive(slot0._changeItem.gohechengeffect, false)
end

function slot0._refreshDetailPartChangeTitle(slot0, slot1)
	slot0:_refreshLine(slot0._changeItem.lineItem, RoomProductionHelper.getChangePartLineMO(slot1), false)
end

function slot0._refreshLine(slot0, slot1, slot2, slot3)
	slot1.lineId = slot2.id
	slot1.txtname.text = slot2.config.name

	gohelper.setActive(slot1.btnupgrade.gameObject, slot2.level < slot2.maxConfigLevel)

	if slot3 then
		gohelper.setActive(slot1.txtname.gameObject, not slot2:isLock())

		slot1.txtlock.text = string.format(luaLang("room_initbuilding_linelock"), slot2.config.needRoomLevel)

		if slot2:isLock() then
			gohelper.setActive(slot1.gonormalbg, true)
			gohelper.setActive(slot1.gofullbg, false)
			gohelper.setActive(slot1.goshowprocess, false)
			gohelper.setActive(slot1.btnupgrade.gameObject, false)
			gohelper.setActive(slot1.goselectbg, false)
		else
			gohelper.setActive(slot1.gonormalbg, slot2:isIdle() or not slot2:isFull())
			gohelper.setActive(slot1.gofullbg, not slot2:isIdle() and slot2:isFull())
			gohelper.setActive(slot1.goshowprocess, not slot2:isIdle())
			gohelper.setActive(slot1.goselectbg, slot0._expandDetailLineId == slot2.id)

			if slot2:isIdle() then
				gohelper.setActive(slot1.gofull, false)
				gohelper.setActive(slot1.goprocess, false)
			elseif slot2:isFull() then
				gohelper.setActive(slot1.gofull, true)
				gohelper.setActive(slot1.goprocess, false)
			else
				gohelper.setActive(slot1.gofull, false)
				gohelper.setActive(slot1.goprocess, true)

				slot1.imageprocess.fillAmount, slot6 = slot2:getReservePer()

				if not slot0._lineIdPerDict[slot1.lineId] then
					slot1.txtprocess.text = string.format("%d%%", slot6)
				end
			end
		end

		if slot2:isLock() then
			slot1.gatherAnimator.speed = 0

			slot1.gatherAnimator:Play("unlock", 0, 0)
			slot1.gatherAnimator:Update(0)
		elseif RoomProductionModel.instance:shouldPlayLineUnlockDetail(slot1.lineId) then
			RoomProductionModel.instance:setPlayLineUnlockDetail(slot1.lineId, nil)

			slot1.gatherAnimator.speed = 0

			slot1.gatherAnimator:Play("unlock", 0, 0)
			slot1.gatherAnimator:Update(0)
			TaskDispatcher.runDelay(slot0._playLineUnlockDetail, slot1, 0.4)
		else
			slot1.gatherAnimator.speed = 0

			slot1.gatherAnimator:Play(UIAnimationName.Idle, 0, 0)
			slot1.gatherAnimator:Update(0)
		end
	else
		gohelper.setActive(slot1.goselectbg, false)
		gohelper.setActive(slot1.goshowprocess, true)

		slot1.imageprocess.fillAmount = 0
		slot1.txtprocess.text = string.format("%d%%", 0)
	end

	slot4 = slot2.level or 0
	slot5 = slot2.maxLevel or 0

	for slot9 = 1, slot5 do
		if not slot1.levelItemList[slot9] then
			slot10 = slot0:getUserDataTb_()
			slot10.go = gohelper.cloneInPlace(slot1.golevelitem, "item" .. slot9)
			slot10.golight = gohelper.findChild(slot10.go, "go_light")

			table.insert(slot1.levelItemList, slot10)
		end

		gohelper.setActive(slot10.golight, slot9 <= slot4)
		gohelper.setActive(slot10.go, true)
	end

	for slot9 = slot5 + 1, #slot1.levelItemList do
		gohelper.setActive(slot1.levelItemList[slot9].go, false)
	end

	RedDotController.instance:addRedDot(slot1.reddot, RedDotEnum.DotNode.RoomProductionLevel, slot1.lineId)
end

function slot0._playLineUnlockDetail(slot0)
	slot0.gatherAnimator.speed = 1

	slot0.gatherAnimator:Play("unlock", 0, 0)
end

function slot0._onChangePartStart(slot0)
	PopupController.instance:setPause("roominitbuildingview_changeeffect", true)
	UIBlockMgr.instance:startBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.cancelTask(slot0._resetChangeProcessText, slot0)
	slot0._changeItem.lineItem.animator:Play(UIAnimationName.Open, 0, 0)

	if slot0._changeItem.lineItem.tweenId then
		if slot0._scene.tween then
			slot0._scene.tween:killById(slot0._changeItem.lineItem.tweenId)
		else
			ZProj.TweenHelper.KillById(slot0._changeItem.lineItem.tweenId)
		end

		slot0._changeItem.lineItem.tweenId = nil
	end

	if slot0._scene.tween then
		slot0._changeItem.lineItem.tweenId = slot0._scene.tween:tweenFloat(0, 1, 1.3, slot0._changeEffectFrame, slot0._changeEffectFinish, slot0)
	else
		slot0._changeItem.lineItem.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.3, slot0._changeEffectFrame, slot0._changeEffectFinish, slot0)
	end
end

function slot0._changeEffectFrame(slot0, slot1)
	slot0._changeItem.lineItem.txtprocess.text = string.format("%d%%", math.ceil(slot1 * 100))
end

function slot0._changeEffectFinish(slot0)
	slot0._changeItem.lineItem.txtprocess.text = "100%"

	PopupController.instance:setPause("roominitbuildingview_changeeffect", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.runDelay(slot0._resetChangeProcessText, slot0, 1)
end

function slot0._resetChangeProcessText(slot0)
	if slot0._changeItem then
		slot0._changeItem.lineItem.txtprocess.text = "0%"
	end
end

function slot0._onCloseView(slot0, slot1)
	slot0:_resetChangeProcessText()

	if slot1 == ViewName.RoomLevelUpTipsView and slot0._selectTabId == uv0.TabId.ProductionLine then
		slot0:_refreshInitPart()
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI(true)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI(true)

	if slot0.viewParam and slot0.viewParam.showFormulaView then
		slot0:_changeSelectPart(3)
	end

	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, slot0._refreshLevel, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, slot0._refreshCategory, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.UpdateProduceLineData, slot0._refreshInitPart, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.UpdateProduceLineData, slot0._refreshDetailPart, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.GainProductionLineReply, slot0._gainProductionLineCallback, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.OnChangePartStart, slot0._onChangePartStart, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, slot0._refreshRoomLevelUpEffect, slot0)
	NavigateMgr.instance:addEscape(ViewName.RoomInitBuildingView, slot0._onEscape, slot0)
end

function slot0.onClose(slot0)
	if slot0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_close)
	end
end

function slot0._onEscape(slot0)
	ViewMgr.instance:closeView(ViewName.RoomInitBuildingView, false, true)
	RoomMapController.instance:onCloseRoomInitBuildingView()
end

function slot0.onDestroyView(slot0)
	slot5 = false

	PopupController.instance:setPause("roominitbuildingview_changeeffect", slot5)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.cancelTask(slot0._resetChangeProcessText, slot0)
	TaskDispatcher.cancelTask(slot0._realChangeSelectPart, slot0)
	TaskDispatcher.cancelTask(slot0._changeShowSkinList, slot0)

	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._updateDetailPartGatherSelectLineTime, slot4)

	slot0._keepOpenSkinListAfterChange = false

	for slot4, slot5 in ipairs(slot0._categoryItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0._initPartProductItemList) do
		slot5.simagereward:UnLoadImage()
		slot5.btnget:RemoveClickListener()
		slot5.btnjumpclick:RemoveClickListener()

		for slot9, slot10 in ipairs(slot5.lineItemList) do
			TaskDispatcher.cancelTask(slot0._playLineUnlock, slot10)
		end
	end

	for slot4, slot5 in ipairs(slot0._initPartChangeItemList) do
		slot5.simagedoor:UnLoadImage()
		slot5.btncombine:RemoveClickListener()

		for slot9, slot10 in ipairs(slot5.formulaItemList) do
			slot10.btnlockclick:RemoveClickListener()
		end
	end

	if slot0._changeItem then
		slot0._changeItem.lineItem.btnupgrade:RemoveClickListener()

		if slot0._changeItem.lineItem.tweenId then
			if slot0._scene.tween then
				slot0._scene.tween:killById(slot0._changeItem.lineItem.tweenId)
			else
				ZProj.TweenHelper.KillById(slot0._changeItem.lineItem.tweenId)
			end

			slot0._changeItem.lineItem.tweenId = nil
		end

		slot0._changeItem = nil
	end

	if slot0._gatherItem then
		slot0._gatherItem.btnget:RemoveClickListener()
		slot0._gatherItem.btnnewget:RemoveClickListener()

		for slot4, slot5 in ipairs(slot0._gatherItem.lineItemList) do
			slot5.btnupgrade:RemoveClickListener()
			slot5.btnclick:RemoveClickListener()
		end

		for slot4, slot5 in ipairs(slot0._gatherItem.lineItemList) do
			TaskDispatcher.cancelTask(slot0._playLineUnlockDetail, slot5)
		end

		slot0._gatherItem = nil
	end

	slot0._flyEffectRewardInfoList = nil

	slot0:_clearLineAnimation()
	slot0._simagecombinebg:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	RoomSkinController.instance:setRoomSkinListVisible()
end

return slot0
