module("modules.logic.room.view.RoomInitBuildingView", package.seeall)

local var_0_0 = class("RoomInitBuildingView", BaseView)
local var_0_1 = 0.3

var_0_0.TabId = {
	ProductionLine = 1,
	BuildDegree = 2
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._gocategoryItem = gohelper.findChild(arg_1_0.viewGO, "left/#scroll_catagory/viewport/content/#go_catagoryItem")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "left/title")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "left/title/#image_icon")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "left/title/#txt_title")
	arg_1_0._txttitleEn = gohelper.findChildText(arg_1_0.viewGO, "left/title/#txt_title/#txt_titleEn")
	arg_1_0._golevelitem = gohelper.findChild(arg_1_0.viewGO, "left/title/activeLv/#go_levelitem")
	arg_1_0._btnlevelup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/title/layout/#btn_levelup")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "left/title/layout/#btn_levelup/txt/#go_reddot")
	arg_1_0._btnskin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/title/layout/#btn_skin")
	arg_1_0._goskinreddot = gohelper.findChild(arg_1_0.viewGO, "left/title/layout/#btn_skin/#go_reddot")
	arg_1_0._gopart = gohelper.findChild(arg_1_0.viewGO, "right/#go_part")
	arg_1_0._goinit = gohelper.findChild(arg_1_0.viewGO, "right/#go_init")
	arg_1_0._goskin = gohelper.findChild(arg_1_0.viewGO, "right/#go_skin")
	arg_1_0._gohubList = gohelper.findChild(arg_1_0.viewGO, "right/#go_init/#go_hubList")
	arg_1_0._goactiveList = gohelper.findChild(arg_1_0.viewGO, "right/#go_init/#go_activeList")
	arg_1_0._btnbuildingHub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_init/buildingLayout/#btn_buildingHub")
	arg_1_0._btnbuildingActive = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_init/buildingLayout/#btn_buildingActive")
	arg_1_0._gogatherpart = gohelper.findChild(arg_1_0.viewGO, "right/#go_init/#go_hubList/#go_gatherpart")
	arg_1_0._gochangepart = gohelper.findChild(arg_1_0.viewGO, "right/#go_init/#go_hubList/#go_changepart")
	arg_1_0._gogather = gohelper.findChild(arg_1_0.viewGO, "right/#go_part/#go_gather")
	arg_1_0._gochange = gohelper.findChild(arg_1_0.viewGO, "right/#go_part/#go_change")
	arg_1_0._simagecombinebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_part/#go_change/combine/go_combine3/#simage_combinebg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskin:AddClickListener(arg_2_0._btnskinOnClick, arg_2_0)
	arg_2_0._btnlevelup:AddClickListener(arg_2_0._btnlevelupOnClick, arg_2_0)
	arg_2_0._btnbuildingHub:AddClickListener(arg_2_0._btnbuildingHubOnClick, arg_2_0)
	arg_2_0._btnbuildingActive:AddClickListener(arg_2_0._btnbuildingActiveOnClick, arg_2_0)
	arg_2_0:addEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, arg_2_0._onSkinListViewShowChange, arg_2_0)
	arg_2_0:addEventCb(RoomSkinController.instance, RoomSkinEvent.RoomSkinMarkUpdate, arg_2_0._refreshSkinReddot, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskin:RemoveClickListener()
	arg_3_0._btnlevelup:RemoveClickListener()
	arg_3_0._btnbuildingHub:RemoveClickListener()
	arg_3_0._btnbuildingActive:RemoveClickListener()
	arg_3_0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.SkinListViewShowChange, arg_3_0._onSkinListViewShowChange, arg_3_0)
	arg_3_0:removeEventCb(RoomSkinController.instance, RoomSkinEvent.RoomSkinMarkUpdate, arg_3_0._refreshSkinReddot, arg_3_0)
end

function var_0_0._btnskinOnClick(arg_4_0)
	RoomSkinController.instance:setRoomSkinListVisible(arg_4_0._selectPartId)
end

function var_0_0._btnlevelupOnClick(arg_5_0)
	RoomMapController.instance:openRoomLevelUpView()
end

function var_0_0._btnbuildingHubOnClick(arg_6_0)
	arg_6_0:_changeSelectTab(1)
end

function var_0_0._btnbuildingActiveOnClick(arg_7_0)
	arg_7_0:_changeSelectTab(2)
end

function var_0_0._categoryItemOnClick(arg_8_0, arg_8_1)
	if ViewMgr.instance:isOpen(ViewName.RoomFormulaView) then
		return
	end

	local var_8_0 = arg_8_0._categoryItemList[arg_8_1]

	arg_8_0:_changeSelectPart(var_8_0.partId, true)

	if arg_8_0._lastItemIndex ~= arg_8_1 then
		arg_8_0._lastItemIndex = arg_8_1

		if arg_8_1 == 1 then
			arg_8_0:_changeSelectTab(1)
		end
	end
end

function var_0_0._btninitpartproductOnClick(arg_9_0, arg_9_1)
	local var_9_0 = RoomProductionHelper.getCanGainLineIdList(arg_9_1)

	if #var_9_0 > 0 then
		arg_9_0._flyEffectRewardInfoList = {}

		local var_9_1 = arg_9_0:_getPartItemByPartId(arg_9_1)

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_2 = RoomProductionModel.instance:getLineMO(iter_9_1)
			local var_9_3 = var_9_2:getReservePer()

			if not LuaUtil.tableNotEmpty(arg_9_0._flyEffectRewardInfoList) then
				table.insert(arg_9_0._flyEffectRewardInfoList, {
					rewardInfo = RoomProductionHelper.getFormulaRewardInfo(var_9_2.formulaId),
					position = var_9_1.simagereward.gameObject.transform.position
				})
			end

			arg_9_0._lineIdPerDict[iter_9_1] = var_9_3
		end

		RoomRpc.instance:sendGainProductionLineRequest(var_9_0, true)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shop_collect)
	end
end

function var_0_0._btninitpartProductOnClick(arg_10_0, arg_10_1)
	arg_10_0:_changeSelectPart(arg_10_1)
end

function var_0_0._btninitpartChangeOnClick(arg_11_0, arg_11_1)
	arg_11_0:_changeSelectPart(arg_11_1, false, true)
end

function var_0_0._btnupgradeOnClick(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:_getLineItemByIndex(arg_12_1)
	local var_12_1 = RoomProductionModel.instance:getLineMO(var_12_0.lineId)

	ViewMgr.instance:openView(ViewName.RoomProductLineLevelUpView, {
		lineMO = var_12_1,
		selectPartId = arg_12_0._selectPartId
	})
end

function var_0_0._lineclickOnClick(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:_getLineItemByIndex(arg_13_1)
	local var_13_1 = RoomProductionModel.instance:getLineMO(var_13_0.lineId)

	if var_13_1:isLock() then
		arg_13_0:_hideExpandDetailUI()
		ToastController.instance:showToast(RoomEnum.Toast.RoomProductLineLockTips, var_13_1.config.needRoomLevel)
	elseif arg_13_0._selectLineId == var_13_0.lineId then
		if arg_13_0._expandDetailLineId == arg_13_0._selectLineId then
			arg_13_0._expandDetailLineId = nil
		else
			arg_13_0._expandDetailLineId = arg_13_0._selectLineId
		end

		arg_13_0:_refreshDetailPartGather(arg_13_0._selectPartId)
	else
		arg_13_0._expandDetailLineId = var_13_0.lineId

		arg_13_0:_changeSelectLine(var_13_0.lineId)
	end
end

function var_0_0._detailgathergetOnClick(arg_14_0)
	local var_14_0 = RoomProductionHelper.getCanGainLineIdList(arg_14_0._selectPartId)

	if #var_14_0 > 0 then
		arg_14_0._flyEffectRewardInfoList = {}
		arg_14_0._lineIdPerDict = {}

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_1 = RoomProductionModel.instance:getLineMO(iter_14_1)
			local var_14_2 = var_14_1:getReservePer()

			if not LuaUtil.tableNotEmpty(arg_14_0._flyEffectRewardInfoList) then
				table.insert(arg_14_0._flyEffectRewardInfoList, {
					rewardInfo = RoomProductionHelper.getFormulaRewardInfo(var_14_1.formulaId),
					position = arg_14_0._gatherItem.btnget.gameObject.transform.position
				})
			end

			arg_14_0._lineIdPerDict[iter_14_1] = var_14_2
		end

		RoomRpc.instance:sendGainProductionLineRequest(var_14_0, true)
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shop_collect)
	end

	arg_14_0:_hideExpandDetailUI()
end

function var_0_0._gainProductionLineCallback(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 ~= 0 then
		return
	end

	arg_15_0:_playLineAnimation()

	if not arg_15_0._flyEffectRewardInfoList or #arg_15_0._flyEffectRewardInfoList <= 0 then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._flyEffectRewardInfoList) do
		RoomMapController.instance:dispatchEvent(RoomEvent.UIFlyEffect, {
			startPos = iter_15_1.position,
			itemType = iter_15_1.rewardInfo.type,
			itemId = iter_15_1.rewardInfo.id,
			startQuantity = iter_15_1.rewardInfo.quantity
		})
	end

	arg_15_0._flyEffectRewardInfoList = nil
end

function var_0_0._playLineAnimation(arg_16_0)
	if arg_16_0._lineGetTweenId then
		if arg_16_0._scene.tween then
			arg_16_0._scene.tween:killById(arg_16_0._lineGetTweenId)
		else
			ZProj.TweenHelper.KillById(arg_16_0._lineGetTweenId)
		end

		arg_16_0._lineGetTweenId = nil
	end

	if LuaUtil.tableNotEmpty(arg_16_0._lineIdPerDict) then
		if arg_16_0._scene.tween then
			arg_16_0._lineGetTweenId = arg_16_0._scene.tween:tweenFloat(1, 0, 0.5, arg_16_0._lineAnimationFrame, arg_16_0._lineAnimationFinish, arg_16_0)
		else
			arg_16_0._lineGetTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, arg_16_0._lineAnimationFrame, arg_16_0._lineAnimationFinish, arg_16_0)
		end
	end
end

function var_0_0._lineAnimationFrame(arg_17_0, arg_17_1)
	if arg_17_0._selectPartId == 0 then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._initPartProductItemList) do
			for iter_17_2, iter_17_3 in ipairs(iter_17_1.lineItemList) do
				local var_17_0 = arg_17_0._lineIdPerDict[iter_17_3.lineId]

				if var_17_0 then
					arg_17_0:_refreshLineAnimationShow(var_17_0, arg_17_1, iter_17_3.imageprocess, iter_17_3.txtprocess)
				end
			end
		end
	else
		for iter_17_4, iter_17_5 in ipairs(arg_17_0._gatherItem.lineItemList) do
			local var_17_1 = arg_17_0._lineIdPerDict[iter_17_5.lineId]

			if var_17_1 then
				arg_17_0:_refreshLineAnimationShow(var_17_1, arg_17_1, iter_17_5.imageprocess, iter_17_5.txtprocess)
			end
		end

		local var_17_2 = arg_17_0._lineIdPerDict[arg_17_0._selectLineId]

		if var_17_2 then
			arg_17_0:_refreshLineAnimationShow(var_17_2, arg_17_1, nil, nil)
		end
	end
end

function var_0_0._refreshLineAnimationShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_1 = arg_18_1 * arg_18_2

	if arg_18_3 then
		arg_18_3.fillAmount = arg_18_1
	end

	if arg_18_4 then
		local var_18_0 = math.max(0, math.floor(arg_18_1 * 100))

		arg_18_4.text = string.format("%d%%", var_18_0)
	end
end

function var_0_0._lineAnimationFinish(arg_19_0)
	arg_19_0:_lineAnimationFrame(0)

	arg_19_0._lineIdPerDict = {}
end

function var_0_0._clearLineAnimation(arg_20_0)
	if arg_20_0._lineGetTweenId then
		if arg_20_0._scene.tween then
			arg_20_0._scene.tween:killById(arg_20_0._lineGetTweenId)
		else
			ZProj.TweenHelper.KillById(arg_20_0._lineGetTweenId)
		end

		arg_20_0._lineGetTweenId = nil
	end

	arg_20_0._lineIdPerDict = {}
end

function var_0_0._editableInitView(arg_21_0)
	arg_21_0._scene = GameSceneMgr.instance:getCurScene()
	arg_21_0._selectPartId = 0
	arg_21_0._selectTabId = var_0_0.TabId.ProductionLine
	arg_21_0._selectLineId = 0

	arg_21_0.viewContainer:setSelectLine(arg_21_0._selectLineId)

	arg_21_0._categoryItemList = {}

	gohelper.setActive(arg_21_0._gocategoryItem, false)

	arg_21_0._levelItemList = {}

	gohelper.setActive(arg_21_0._golevelitem, false)

	arg_21_0._buildingInfoItemList = {}
	arg_21_0._detailInitTabHubItem = arg_21_0:_getDetailInitItem(arg_21_0._btnbuildingHub.gameObject)
	arg_21_0._detailInitTabActiveItem = arg_21_0:_getDetailInitItem(arg_21_0._btnbuildingActive.gameObject)
	arg_21_0._initPartProductItemList = {}
	arg_21_0._initPartChangeItemList = {}

	gohelper.setActive(arg_21_0._gogatherpart, false)
	gohelper.setActive(arg_21_0._gochangepart, false)

	arg_21_0._animator = arg_21_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_21_0._lineIdPerDict = {}

	gohelper.addUIClickAudio(arg_21_0._btnlevelup.gameObject, AudioEnum.UI.UI_Rolesopen)
	arg_21_0._simagecombinebg:LoadImage(ResUrl.getRoomImage("bg_hechengdiban"))
	arg_21_0._simagemask:LoadImage(ResUrl.getRoomImage("full/bg_yinyingzhezhao"))

	arg_21_0._expandDetailLineId = nil
	arg_21_0._golevelupeffect = gohelper.findChild(arg_21_0.viewGO, "left/title/layout/#btn_levelup/txt/#go_reddot/#leveup_effect")
end

function var_0_0._getLineItemByIndex(arg_22_0, arg_22_1)
	if arg_22_1 == 0 then
		return arg_22_0._changeItem.lineItem
	else
		return arg_22_0._gatherItem.lineItemList[arg_22_1]
	end
end

function var_0_0._getLineItemByLineId(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0._gatherItem.lineItemList) do
		if iter_23_1.lineId == arg_23_1 then
			return iter_23_1
		end
	end
end

function var_0_0._getPartItemByPartId(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0._initPartProductItemList) do
		if iter_24_1.partId == arg_24_1 then
			return iter_24_1
		end
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_0._initPartChangeItemList) do
		if iter_24_3.partId == arg_24_1 then
			return iter_24_3
		end
	end
end

function var_0_0._initChangeItem(arg_25_0)
	local var_25_0 = arg_25_0:getUserDataTb_()

	var_25_0.go = arg_25_0._gochange
	var_25_0.goline = gohelper.findChild(var_25_0.go, "productLineItem")
	var_25_0.gobgvx = gohelper.findChild(var_25_0.go, "combine/go_combine3/#bgvx")
	var_25_0.gohechengeffect = gohelper.findChild(var_25_0.go, "combine/#hechengeffect")
	var_25_0.lineItem = arg_25_0:getUserDataTb_()

	arg_25_0:_initLine(var_25_0.lineItem, var_25_0.goline, false, 0)
	gohelper.setActive(var_25_0.goline, true)

	return var_25_0
end

function var_0_0._initGatherItem(arg_26_0)
	local var_26_0 = arg_26_0:getUserDataTb_()

	var_26_0.go = arg_26_0._gogather
	var_26_0.txtname = gohelper.findChildText(var_26_0.go, "collect/txt_productLineName")
	var_26_0.txtprocess = gohelper.findChildText(var_26_0.go, "collect/txt_collectprocess")
	var_26_0.goarrow = gohelper.findChild(var_26_0.go, "collect/txt_collectprocess/go_arrow")
	var_26_0.gopause = gohelper.findChild(var_26_0.go, "collect/txt_collectprocess/go_pause")
	var_26_0.imagereward = gohelper.findChildImage(var_26_0.go, "collect/image_curcollectitem")
	var_26_0.goline = gohelper.findChild(var_26_0.go, "scroll_productLine/viewport/content/go_productLineItem")
	var_26_0.goinfo = gohelper.findChild(var_26_0.go, "go_gatherInfo")
	var_26_0.txtstore = gohelper.findChildText(var_26_0.go, "go_gatherInfo/collectinfo/right/txt_store")
	var_26_0.txttime = gohelper.findChildText(var_26_0.go, "go_gatherInfo/collectinfo/right/txt_expspeed")
	var_26_0.txtremain = gohelper.findChildText(var_26_0.go, "go_gatherInfo/collectinfo/right/txt_time")
	var_26_0.goget = gohelper.findChild(var_26_0.go, "btn_get/go_get")
	var_26_0.gonoget = gohelper.findChild(var_26_0.go, "btn_get/go_noget")
	var_26_0.btnget = gohelper.findChildButton(var_26_0.go, "btn_get")
	var_26_0.btnnewget = gohelper.findChildButton(var_26_0.go, "collect/btn_get")
	var_26_0.animatorcircle = gohelper.findChild(var_26_0.go, "collect/bg"):GetComponent(typeof(UnityEngine.Animator))
	var_26_0.animatorget = var_26_0.btnget.gameObject:GetComponent(typeof(UnityEngine.Animator))

	var_26_0.btnget:AddClickListener(arg_26_0._detailgathergetOnClick, arg_26_0)
	var_26_0.btnnewget:AddClickListener(arg_26_0._detailgathergetOnClick, arg_26_0)

	var_26_0.lineItemList = {}

	gohelper.setActive(var_26_0.goline, false)

	return var_26_0
end

function var_0_0._initLine(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	arg_27_1.go = arg_27_2
	arg_27_1.index = arg_27_4
	arg_27_1.isGather = arg_27_3
	arg_27_1.txtname = gohelper.findChildText(arg_27_1.go, "name")
	arg_27_1.goshowprocess = gohelper.findChild(arg_27_1.go, "go_process")
	arg_27_1.golevelitem = gohelper.findChild(arg_27_1.go, "name/go_activeLv/go_normalitem")
	arg_27_1.imageprocess = gohelper.findChildImage(arg_27_1.go, "go_process/go_process/processbar")
	arg_27_1.txtprocess = gohelper.findChildText(arg_27_1.go, "go_process/go_process/num")
	arg_27_1.goprocess = gohelper.findChild(arg_27_1.go, "go_process/go_process")
	arg_27_1.btnupgrade = gohelper.findChildButtonWithAudio(arg_27_1.go, "btn_upgrade")
	arg_27_1.reddot = gohelper.findChild(arg_27_1.go, "btn_upgrade/reddot")

	arg_27_1.btnupgrade:AddClickListener(arg_27_0._btnupgradeOnClick, arg_27_0, arg_27_1.index)
	gohelper.addUIClickAudio(arg_27_1.btnupgrade.gameObject, AudioEnum.UI.UI_Rolesopen)

	arg_27_1.levelItemList = arg_27_0:getUserDataTb_()

	if arg_27_3 then
		arg_27_1.gofull = gohelper.findChild(arg_27_1.go, "go_process/go_full")
		arg_27_1.gonormalbg = gohelper.findChild(arg_27_1.go, "go_normalbg")
		arg_27_1.gofullbg = gohelper.findChild(arg_27_1.go, "go_fullbg")
		arg_27_1.goselectbg = gohelper.findChild(arg_27_1.go, "go_selectbg")
		arg_27_1.golock = gohelper.findChild(arg_27_1.go, "go_lock")
		arg_27_1.txtlock = gohelper.findChildText(arg_27_1.go, "go_lock/txt_lock")
		arg_27_1.btnclick = gohelper.findChildButtonWithAudio(arg_27_1.go, "btn_click")

		arg_27_1.btnclick:AddClickListener(arg_27_0._lineclickOnClick, arg_27_0, arg_27_1.index)

		arg_27_1.gatherAnimator = arg_27_1.go:GetComponent(typeof(UnityEngine.Animator))
	else
		arg_27_1.goselectbg = gohelper.findChild(arg_27_1.go, "selectbg")
		arg_27_1.animator = arg_27_1.goprocess:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(arg_27_1.golevelitem, false)
end

function var_0_0._getDetailInitItem(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:getUserDataTb_()

	var_28_0.go = arg_28_1
	var_28_0.gonormal = gohelper.findChild(var_28_0.go, "go_normalbg")
	var_28_0.goselect = gohelper.findChild(var_28_0.go, "go_selectbg")

	return var_28_0
end

function var_0_0._changeSelectPart(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if arg_29_1 ~= 0 and not RoomProductionHelper.hasUnlockLine(arg_29_1) then
		if RoomProductionHelper.getPartType(arg_29_1) == RoomProductLineEnum.ProductType.Change then
			GameFacade.showToast(ToastEnum.MaterialItemLockOnClick2)
		end

		return
	end

	if arg_29_0._selectPartId == arg_29_1 then
		return
	end

	arg_29_0._expandDetailLineId = nil
	arg_29_0._waitChangeSelectPartId = arg_29_1

	arg_29_0:_refreshCategory()
	arg_29_0:_refreshCamera()

	arg_29_0._keepOpenSkinListAfterChange = RoomSkinModel.instance:getIsShowRoomSkinList()

	RoomSkinController.instance:clearPreviewRoomSkin()

	arg_29_0._animator.enabled = true

	arg_29_0._animator:Play("swicth", 0, 0)
	TaskDispatcher.cancelTask(arg_29_0._realChangeSelectPart, arg_29_0)
	TaskDispatcher.runDelay(arg_29_0._realChangeSelectPart, arg_29_0, var_0_1)

	if arg_29_2 then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	end

	if arg_29_3 then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)
	end
end

function var_0_0._realChangeSelectPart(arg_30_0)
	if not arg_30_0._waitChangeSelectPartId then
		return
	end

	arg_30_0._selectPartId = arg_30_0._waitChangeSelectPartId

	arg_30_0.viewContainer:setSelectPartId(arg_30_0._selectPartId)
	RoomController.instance:dispatchEvent(RoomEvent["GuideOpenInitBuilding" .. arg_30_0._selectPartId])

	arg_30_0._waitChangeSelectPartId = nil

	arg_30_0:_refreshSelectPart(false, true)

	if arg_30_0._keepOpenSkinListAfterChange then
		arg_30_0:_btnskinOnClick()

		arg_30_0._keepOpenSkinListAfterChange = false
	end
end

function var_0_0._changeSelectTab(arg_31_0, arg_31_1)
	if arg_31_0._selectTabId == arg_31_1 then
		return
	end

	arg_31_0._selectTabId = arg_31_1

	arg_31_0:_refreshSelectTab()
end

function var_0_0._changeSelectLine(arg_32_0, arg_32_1)
	if arg_32_0._selectLineId == arg_32_1 then
		return
	end

	arg_32_0._selectLineId = arg_32_1

	arg_32_0.viewContainer:setSelectLine(arg_32_0._selectLineId)
	arg_32_0:_refreshDetailPartGather(arg_32_0._selectPartId)
end

function var_0_0._refreshUI(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.viewParam

	arg_33_0._selectPartId = var_33_0 and var_33_0.partId or 0
	arg_33_0._selectLineId = var_33_0 and var_33_0.lineId or 0

	arg_33_0.viewContainer:setSelectLine(arg_33_0._selectLineId)
	arg_33_0.viewContainer:setSelectPartId(arg_33_0._selectPartId)
	RoomController.instance:dispatchEvent(RoomEvent["GuideOpenInitBuilding" .. arg_33_0._selectPartId])
	arg_33_0:_refreshSelectPart(arg_33_1)
end

function var_0_0._refreshSelectPart(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0:_clearLineAnimation()

	if not arg_34_1 and not arg_34_2 then
		arg_34_0:_refreshCamera()
	end

	arg_34_0:_refreshCategory()
	arg_34_0:_refreshTitle()
	arg_34_0:_refreshLevel()
	arg_34_0:_realChangeShowSkinList()
	arg_34_0:_refreshSkinReddot()
	RoomSkinController.instance:clearInitBuildingEntranceReddot(arg_34_0._selectPartId)
end

function var_0_0._refreshCamera(arg_35_0)
	local var_35_0 = arg_35_0._waitChangeSelectPartId or arg_35_0._selectPartId

	RoomBuildingController.instance:tweenCameraFocusPart(var_35_0, RoomEnum.CameraState.Normal, 0)
end

function var_0_0._refreshCategory(arg_36_0)
	local var_36_0 = {}

	table.insert(var_36_0, 0)

	local var_36_1 = RoomConfig.instance:getProductionPartConfigList()

	for iter_36_0, iter_36_1 in ipairs(var_36_1) do
		table.insert(var_36_0, iter_36_1.id)
	end

	for iter_36_2 = 1, #var_36_0 do
		local var_36_2 = var_36_0[iter_36_2]
		local var_36_3 = arg_36_0._categoryItemList[iter_36_2]

		if not var_36_3 then
			var_36_3 = arg_36_0:getUserDataTb_()
			var_36_3.index = iter_36_2
			var_36_3.go = gohelper.cloneInPlace(arg_36_0._gocategoryItem, "categoryItem" .. iter_36_2)
			var_36_3.gonormal = gohelper.findChild(var_36_3.go, "go_normal")
			var_36_3.imageiconnormal = gohelper.findChildImage(var_36_3.go, "go_normal/icon")
			var_36_3.goselect = gohelper.findChild(var_36_3.go, "go_select")
			var_36_3.imageiconselect = gohelper.findChildImage(var_36_3.go, "go_select/icon")
			var_36_3.goreddot = gohelper.findChild(var_36_3.go, "reddot")
			var_36_3.gosubLine = gohelper.findChild(var_36_3.go, "go_subLine")
			var_36_3.btnclick = gohelper.findChildButtonWithAudio(var_36_3.go, "btn_click")

			var_36_3.btnclick:AddClickListener(arg_36_0._categoryItemOnClick, arg_36_0, var_36_3.index)
			table.insert(arg_36_0._categoryItemList, var_36_3)
		end

		var_36_3.partId = var_36_2

		local var_36_4 = arg_36_0._waitChangeSelectPartId or arg_36_0._selectPartId

		gohelper.setActive(var_36_3.gosubLine, var_36_2 == 0)

		if var_36_2 == 0 then
			if var_36_4 ~= var_36_2 then
				UISpriteSetMgr.instance:setRoomSprite(var_36_3.imageiconnormal, "bg_init")
			else
				UISpriteSetMgr.instance:setRoomSprite(var_36_3.imageiconselect, "bg_init_ovr")
			end
		elseif var_36_4 ~= var_36_2 then
			UISpriteSetMgr.instance:setRoomSprite(var_36_3.imageiconnormal, "bg_part" .. var_36_2)
		else
			UISpriteSetMgr.instance:setRoomSprite(var_36_3.imageiconselect, "bg_part" .. var_36_2 .. "_ovr")
		end

		gohelper.setActive(var_36_3.gonormal, var_36_4 ~= var_36_2)
		gohelper.setActive(var_36_3.goselect, var_36_4 == var_36_2)
		gohelper.setActive(var_36_3.goreddot, false)
		gohelper.setActive(var_36_3.go, var_36_2 == 0 or RoomProductionHelper.hasUnlockLine(var_36_2))
	end

	for iter_36_3 = #var_36_0 + 1, #arg_36_0._categoryItemList do
		local var_36_5 = arg_36_0._categoryItemList[iter_36_3]

		gohelper.setActive(var_36_5.go, false)
	end
end

function var_0_0._refreshTitle(arg_37_0)
	if arg_37_0._selectPartId == 0 then
		UISpriteSetMgr.instance:setRoomSprite(arg_37_0._imageicon, "bg_init")

		arg_37_0._txttitle.text = luaLang("room_initbuilding_title")
		arg_37_0._txttitleEn.text = "Paleohall"
	else
		UISpriteSetMgr.instance:setRoomSprite(arg_37_0._imageicon, "bg_part" .. arg_37_0._selectPartId)

		local var_37_0 = RoomConfig.instance:getProductionPartConfig(arg_37_0._selectPartId)

		arg_37_0._txttitle.text = var_37_0.name
		arg_37_0._txttitleEn.text = var_37_0.nameEn
	end
end

function var_0_0._refreshLevel(arg_38_0)
	local var_38_0 = 0
	local var_38_1 = 0

	if arg_38_0._selectPartId == 0 then
		var_38_0 = RoomConfig.instance:getMaxRoomLevel()
		var_38_1 = RoomMapModel.instance:getRoomLevel()
	end

	for iter_38_0 = 1, var_38_0 do
		local var_38_2 = arg_38_0._levelItemList[iter_38_0]

		if not var_38_2 then
			var_38_2 = arg_38_0:getUserDataTb_()
			var_38_2.go = gohelper.cloneInPlace(arg_38_0._golevelitem, "levelitem" .. iter_38_0)
			var_38_2.golight = gohelper.findChild(var_38_2.go, "go_light")

			table.insert(arg_38_0._levelItemList, var_38_2)
		end

		gohelper.setActive(var_38_2.golight, iter_38_0 <= var_38_1)
		gohelper.setActive(var_38_2.go, true)
	end

	for iter_38_1 = var_38_0 + 1, #arg_38_0._levelItemList do
		local var_38_3 = arg_38_0._levelItemList[iter_38_1]

		gohelper.setActive(var_38_3.go, false)
	end

	local var_38_4 = arg_38_0._selectPartId == 0 and var_38_1 < var_38_0

	gohelper.setActive(arg_38_0._btnlevelup.gameObject, var_38_4)

	if var_38_4 then
		RedDotController.instance:addRedDot(arg_38_0._goreddot, RedDotEnum.DotNode.RoomInitBuildingLevel)
		arg_38_0:_refreshRoomLevelUpEffect()
	end
end

function var_0_0._refreshSkinReddot(arg_39_0)
	if not arg_39_0.skinRedDot then
		arg_39_0.skinRedDot = RedDotController.instance:addNotEventRedDot(arg_39_0._goskinreddot, arg_39_0._checkNewSkinReddot, arg_39_0)

		return
	end

	arg_39_0.skinRedDot:refreshRedDot()
end

function var_0_0._checkNewSkinReddot(arg_40_0)
	return (RoomSkinModel.instance:isHasNewRoomSkin(arg_40_0._selectPartId))
end

function var_0_0._onSkinListViewShowChange(arg_41_0, arg_41_1)
	arg_41_0._animator.enabled = true

	if arg_41_1 then
		arg_41_0._animator:Play("swicth", 0, 0)
	end

	TaskDispatcher.cancelTask(arg_41_0._realChangeShowSkinList, arg_41_0)
	TaskDispatcher.runDelay(arg_41_0._realChangeShowSkinList, arg_41_0, var_0_1)
end

function var_0_0._realChangeShowSkinList(arg_42_0)
	local var_42_0 = RoomSkinModel.instance:getIsShowRoomSkinList()

	if var_42_0 then
		gohelper.setActive(arg_42_0._goinit, false)
		gohelper.setActive(arg_42_0._gopart, false)
	else
		arg_42_0:_refreshDetail(true)
	end

	arg_42_0:setTitleShow(not var_42_0)
	gohelper.setActive(arg_42_0._goskin, var_42_0)
end

function var_0_0.setTitleShow(arg_43_0, arg_43_1)
	gohelper.setActive(arg_43_0._gotitle, arg_43_1)
end

function var_0_0._refreshRoomLevelUpEffect(arg_44_0)
	gohelper.setActive(arg_44_0._golevelupeffect, RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomInitBuildingLevel, 0))
end

function var_0_0._refreshDetail(arg_45_0, arg_45_1)
	gohelper.setActive(arg_45_0._goinit, arg_45_0._selectPartId == 0)
	gohelper.setActive(arg_45_0._gopart, arg_45_0._selectPartId ~= 0)

	if arg_45_0._selectPartId == 0 then
		arg_45_0:_refreshDetailInit()
	else
		arg_45_0:_refreshDetailPart(arg_45_1)
	end
end

function var_0_0._refreshDetailInit(arg_46_0)
	arg_46_0:_refreshSelectTab()
end

function var_0_0._refreshSelectTab(arg_47_0)
	gohelper.setActive(arg_47_0._detailInitTabHubItem.gonormal, arg_47_0._selectTabId ~= var_0_0.TabId.ProductionLine)
	gohelper.setActive(arg_47_0._detailInitTabHubItem.goselect, arg_47_0._selectTabId == var_0_0.TabId.ProductionLine)
	gohelper.setActive(arg_47_0._detailInitTabActiveItem.gonormal, arg_47_0._selectTabId ~= var_0_0.TabId.BuildDegree)
	gohelper.setActive(arg_47_0._detailInitTabActiveItem.goselect, arg_47_0._selectTabId == var_0_0.TabId.BuildDegree)
	gohelper.setActive(arg_47_0._gohubList, arg_47_0._selectTabId == var_0_0.TabId.ProductionLine)
	gohelper.setActive(arg_47_0._goactiveList, arg_47_0._selectTabId == 2)

	if arg_47_0._selectTabId == var_0_0.TabId.ProductionLine then
		arg_47_0:_refreshInitPart()
	elseif arg_47_0._selectTabId == var_0_0.TabId.BuildDegree then
		arg_47_0:_refreshBuildDegree()
	end
end

function var_0_0._refreshTabCountText(arg_48_0)
	local var_48_0 = RoomConfig.instance:getProductionPartConfigList()

	arg_48_0._detailInitTabHubItem.txtcount.text = #var_48_0

	local var_48_1 = RoomMapModel.instance:getAllBuildDegree()

	arg_48_0._detailInitTabActiveItem.txtcount.text = var_48_1
end

function var_0_0._refreshBuildDegree(arg_49_0)
	RoomShowDegreeListModel.instance:setShowDegreeList()
end

function var_0_0._refreshInitPart(arg_50_0)
	if arg_50_0._selectPartId ~= 0 then
		return
	end

	local var_50_0 = RoomConfig.instance:getProductionPartConfigList()
	local var_50_1 = 0
	local var_50_2 = 0

	for iter_50_0, iter_50_1 in ipairs(var_50_0) do
		local var_50_3, var_50_4 = RoomProductionHelper.getPartType(iter_50_1.id)

		if var_50_3 == RoomProductLineEnum.ProductType.Product then
			var_50_1 = var_50_1 + 1

			arg_50_0:_refreshInitPartProduct(iter_50_1, var_50_1)
		elseif var_50_3 == RoomProductLineEnum.ProductType.Change then
			var_50_2 = var_50_2 + 1

			arg_50_0:_refreshInitPartChange(iter_50_1, var_50_2)
		end
	end

	for iter_50_2 = var_50_1 + 1, #arg_50_0._initPartProductItemList do
		local var_50_5 = arg_50_0._initPartProductItemList[iter_50_2]

		gohelper.setActive(var_50_5.go, false)
	end

	for iter_50_3 = var_50_2 + 1, #arg_50_0._initPartChangeItemList do
		local var_50_6 = arg_50_0._initPartChangeItemList[iter_50_3]

		gohelper.setActive(var_50_6.go, false)
	end

	arg_50_0:_refreshInitPartProductGet()
end

function var_0_0._refreshInitPartProduct(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = arg_51_0._initPartProductItemList[arg_51_2]

	if not var_51_0 then
		var_51_0 = arg_51_0:getUserDataTb_()
		var_51_0.partId = arg_51_1.id
		var_51_0.go = gohelper.cloneInPlace(arg_51_0._gogatherpart, "gatheritem" .. arg_51_2)
		var_51_0.txtname = gohelper.findChildText(var_51_0.go, "title/txt")
		var_51_0.txtnameen = gohelper.findChildText(var_51_0.go, "title/txt/txtEn")
		var_51_0.golineitem = gohelper.findChild(var_51_0.go, "scroll_productline/viewport/content/go_productLineItem")
		var_51_0.simagereward = gohelper.findChildSingleImage(var_51_0.go, "reward/simage_reward")
		var_51_0.animator = gohelper.findChild(var_51_0.go, "reward/circle"):GetComponent(typeof(UnityEngine.Animator))
		var_51_0.btnget = gohelper.findChildButton(var_51_0.go, "reward/btn_get")
		var_51_0.btnjumpclick = gohelper.findChildButtonWithAudio(var_51_0.go, "btn_jumpclick")

		var_51_0.btnget:AddClickListener(arg_51_0._btninitpartproductOnClick, arg_51_0, var_51_0.partId)
		var_51_0.btnjumpclick:AddClickListener(arg_51_0._btninitpartProductOnClick, arg_51_0, var_51_0.partId)

		var_51_0.lineItemList = {}

		gohelper.setActive(var_51_0.golineitem, false)
		table.insert(arg_51_0._initPartProductItemList, var_51_0)
	end

	gohelper.setActive(var_51_0.go, true)

	local var_51_1, var_51_2 = RoomProductionHelper.getPartType(arg_51_1.id)

	var_51_0.txtname.text = arg_51_1.name
	var_51_0.txtnameen.text = arg_51_1.nameEn

	if var_51_2 == RoomProductLineEnum.ProductItemType.ProductExp then
		var_51_0.simagereward:LoadImage(ResUrl.getPropItemIcon("5"))
		transformhelper.setLocalPosXY(var_51_0.simagereward.gameObject.transform, -11, 5.45)

		var_51_0.simagereward.gameObject.transform.rotation = Quaternion.Euler(0, 0, -7)
	elseif var_51_2 == RoomProductLineEnum.ProductItemType.ProductGold then
		var_51_0.simagereward:LoadImage(ResUrl.getPropItemIcon("3"))
	end

	arg_51_0:_refreshInitPartProductLine(var_51_0, arg_51_1)
end

function var_0_0._refreshInitPartProductLine(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_2.productionLines

	for iter_52_0, iter_52_1 in ipairs(var_52_0) do
		local var_52_1 = arg_52_1.lineItemList[iter_52_0]

		if not var_52_1 then
			var_52_1 = arg_52_0:getUserDataTb_()
			var_52_1.lineId = iter_52_1
			var_52_1.go = gohelper.cloneInPlace(arg_52_1.golineitem, "item" .. iter_52_0)
			var_52_1.gonormal = gohelper.findChild(var_52_1.go, "go_normal")
			var_52_1.txtname = gohelper.findChildText(var_52_1.go, "go_normal/name")
			var_52_1.golevel = gohelper.findChild(var_52_1.go, "go_normal/name/go_activeLv/go_normalitem")
			var_52_1.gofull = gohelper.findChild(var_52_1.go, "go_normal/go_process/go_full")
			var_52_1.goprocess = gohelper.findChild(var_52_1.go, "go_normal/go_process/go_process")
			var_52_1.imageprocess = gohelper.findChildImage(var_52_1.go, "go_normal/go_process/go_process/processbar")
			var_52_1.txtprocess = gohelper.findChildText(var_52_1.go, "go_normal/go_process/go_process/num")
			var_52_1.golock = gohelper.findChild(var_52_1.go, "go_lock")
			var_52_1.lockdesc = gohelper.findChildText(var_52_1.go, "go_lock/txt_lockdesc")
			var_52_1.levelItemList = {}

			gohelper.setActive(var_52_1.golevel, false)

			var_52_1.animator = var_52_1.go:GetComponent(typeof(UnityEngine.Animator))

			table.insert(arg_52_1.lineItemList, var_52_1)
		end

		gohelper.setActive(var_52_1.go, true)

		local var_52_2 = RoomProductionModel.instance:getLineMO(iter_52_1)

		var_52_1.lockdesc.text = string.format(luaLang("room_initbuilding_linelock"), var_52_2.config.needRoomLevel)
		var_52_1.txtname.text = var_52_2.config.name

		if var_52_2:isLock() or var_52_2:isIdle() then
			gohelper.setActive(var_52_1.gofull, false)
			gohelper.setActive(var_52_1.goprocess, false)
		elseif var_52_2:isFull() then
			gohelper.setActive(var_52_1.gofull, true)
			gohelper.setActive(var_52_1.goprocess, false)
		else
			gohelper.setActive(var_52_1.gofull, false)
			gohelper.setActive(var_52_1.goprocess, true)

			local var_52_3, var_52_4 = var_52_2:getReservePer()

			if not arg_52_0._lineIdPerDict[var_52_1.lineId] then
				var_52_1.imageprocess.fillAmount = var_52_3
				var_52_1.txtprocess.text = string.format("%d%%", var_52_4)
			end
		end

		local var_52_5 = var_52_2.level or 0
		local var_52_6 = var_52_2.maxLevel or 0

		if var_52_2:isLock() then
			var_52_6 = 0
		end

		for iter_52_2 = 1, var_52_6 do
			local var_52_7 = var_52_1.levelItemList[iter_52_2]

			if not var_52_7 then
				var_52_7 = arg_52_0:getUserDataTb_()
				var_52_7.go = gohelper.cloneInPlace(var_52_1.golevel, "item" .. iter_52_2)
				var_52_7.golight = gohelper.findChild(var_52_7.go, "go_light")

				table.insert(var_52_1.levelItemList, var_52_7)
			end

			gohelper.setActive(var_52_7.golight, iter_52_2 <= var_52_5)
			gohelper.setActive(var_52_7.go, true)
		end

		for iter_52_3 = var_52_6 + 1, #var_52_1.levelItemList do
			local var_52_8 = var_52_1.levelItemList[iter_52_3]

			gohelper.setActive(var_52_8.go, false)
		end

		if var_52_2:isLock() then
			var_52_1.animator.speed = 0

			var_52_1.animator:Play("unlock", 0, 0)
			var_52_1.animator:Update(0)
		elseif RoomProductionModel.instance:shouldPlayLineUnlock(iter_52_1) then
			var_52_1.animator.speed = 0

			var_52_1.animator:Play("unlock", 0, 0)
			var_52_1.animator:Update(0)

			if not RoomMapModel.instance:isRoomLeveling() and not ViewMgr.instance:isOpen(ViewName.RoomLevelUpTipsView) then
				RoomProductionModel.instance:setPlayLineUnlock(iter_52_1, nil)
				TaskDispatcher.runDelay(arg_52_0._playLineUnlock, var_52_1, 0.4)
			end
		else
			var_52_1.animator.speed = 0

			var_52_1.animator:Play(UIAnimationName.Idle, 0, 0)
			var_52_1.animator:Update(0)
		end
	end

	for iter_52_4 = #var_52_0 + 1, #arg_52_1.lineItemList do
		local var_52_9 = arg_52_1.lineItemList[iter_52_4]

		gohelper.setActive(var_52_9.go, false)
	end
end

function var_0_0._playLineUnlock(arg_53_0)
	arg_53_0.animator.speed = 1

	arg_53_0.animator:Play("unlock", 0, 0)
end

function var_0_0._refreshInitPartProductGet(arg_54_0)
	for iter_54_0, iter_54_1 in ipairs(arg_54_0._initPartProductItemList) do
		local var_54_0 = RoomConfig.instance:getProductionPartConfig(iter_54_1.partId).productionLines
		local var_54_1 = false
		local var_54_2 = false

		for iter_54_2, iter_54_3 in ipairs(var_54_0) do
			local var_54_3 = RoomProductionModel.instance:getLineMO(iter_54_3)

			if var_54_3 and not var_54_3:isLock() then
				var_54_1 = true

				if not var_54_3:isIdle() and not var_54_3:isFull() then
					var_54_2 = true
				end
			end
		end

		local var_54_4 = #RoomProductionHelper.getCanGainLineIdList(iter_54_1.partId) > 0 and var_54_1

		gohelper.setActive(iter_54_1.btnget.gameObject, var_54_4)
		iter_54_1.animator:Play(var_54_2 and UIAnimationName.Loop or "idle")
	end
end

function var_0_0._refreshInitPartChange(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = arg_55_0._initPartChangeItemList[arg_55_2]

	if not var_55_0 then
		var_55_0 = arg_55_0:getUserDataTb_()
		var_55_0.partId = arg_55_1.id
		var_55_0.go = gohelper.cloneInPlace(arg_55_0._gochangepart, "changeitem" .. arg_55_2)
		var_55_0.txtname = gohelper.findChildText(var_55_0.go, "title/txt")
		var_55_0.txtnameen = gohelper.findChildText(var_55_0.go, "title/txt/txtEn")
		var_55_0.goformulaitem = gohelper.findChild(var_55_0.go, "scroll_productline/viewport/content/go_materialItem")
		var_55_0.simagedoor = gohelper.findChildSingleImage(var_55_0.go, "reward/simage_door")
		var_55_0.btncombine = gohelper.findChildButton(var_55_0.go, "reward/btn_combine")

		var_55_0.btncombine:AddClickListener(arg_55_0._btninitpartChangeOnClick, arg_55_0, var_55_0.partId)

		var_55_0.formulaItemList = {}

		gohelper.setActive(var_55_0.goformulaitem, false)
		table.insert(arg_55_0._initPartChangeItemList, var_55_0)
	end

	gohelper.setActive(var_55_0.go, true)

	local var_55_1 = RoomProductionHelper.getPartMaxLineLevel(arg_55_1.id)

	var_55_0.txtname.text = arg_55_1.name
	var_55_0.txtnameen.text = arg_55_1.nameEn

	var_55_0.simagedoor:LoadImage(ResUrl.getCurrencyItemIcon("door_room"))
	arg_55_0:_refreshInitPartChangeFormula(var_55_0, arg_55_1, var_55_1)
end

function var_0_0._refreshInitPartChangeFormula(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	local var_56_0 = {}

	for iter_56_0, iter_56_1 in ipairs(lua_formula_showtype.configList) do
		table.insert(var_56_0, iter_56_1)
	end

	table.sort(var_56_0, function(arg_57_0, arg_57_1)
		local var_57_0 = RoomProductionHelper.isFormulaShowTypeUnlock(arg_57_0.id) <= arg_56_3
		local var_57_1 = RoomProductionHelper.isFormulaShowTypeUnlock(arg_57_1.id) <= arg_56_3

		if var_57_0 and not var_57_1 then
			return true
		elseif var_57_1 and not var_57_0 then
			return false
		else
			return arg_57_0.id < arg_57_1.id
		end
	end)

	local var_56_1 = RoomProductionHelper.hasUnlockLine(arg_56_2.id)

	for iter_56_2, iter_56_3 in ipairs(var_56_0) do
		local var_56_2 = arg_56_1.formulaItemList[iter_56_2]
		local var_56_3 = RoomProductionHelper.isFormulaShowTypeUnlock(iter_56_3.id)
		local var_56_4 = var_56_3 <= arg_56_3 and var_56_1

		if not var_56_2 then
			var_56_2 = arg_56_0:getUserDataTb_()
			var_56_2.go = gohelper.cloneInPlace(arg_56_1.goformulaitem, "item" .. iter_56_2)
			var_56_2.gonormal = gohelper.findChild(var_56_2.go, "go_normal")
			var_56_2.txtnamenormal = gohelper.findChildText(var_56_2.go, "go_normal/txt_name")
			var_56_2.golock = gohelper.findChild(var_56_2.go, "go_lock")
			var_56_2.txtnamelock = gohelper.findChildText(var_56_2.go, "go_lock/txt_name")
			var_56_2.btnlockclick = gohelper.findChildButtonWithAudio(var_56_2.go, "go_lock/btn_lockclick")
			var_56_2.param = {}

			table.insert(arg_56_1.formulaItemList, var_56_2)
		end

		var_56_2.btnlockclick:RemoveClickListener()

		var_56_2.param.partConfig = arg_56_2
		var_56_2.param.unlockLevel = var_56_3
		var_56_2.param.unlockLevel = var_56_3

		if not var_56_4 then
			if var_56_1 then
				var_56_2.btnlockclick:AddClickListener(arg_56_0._btnMaterialItemLockOnClick, arg_56_0, var_56_2.param)
			else
				var_56_2.btnlockclick:AddClickListener(arg_56_0._btnMaterialItemLockOnClick2, arg_56_0)
			end
		end

		gohelper.setActive(var_56_2.gonormal, var_56_4)
		gohelper.setActive(var_56_2.golock, not var_56_4)

		if var_56_4 then
			var_56_2.txtnamenormal.text = iter_56_3.name
		else
			var_56_2.txtnamelock.text = iter_56_3.name
		end

		gohelper.setActive(var_56_2.go, true)
	end

	for iter_56_4 = #var_56_0 + 1, #arg_56_1.formulaItemList do
		local var_56_5 = arg_56_1.formulaItemList[iter_56_4]

		gohelper.setActive(var_56_5.go, false)
	end
end

function var_0_0._btnMaterialItemLockOnClick(arg_58_0, arg_58_1)
	GameFacade.showToast(ToastEnum.MaterialItemLockOnClick, arg_58_1.partConfig.name, arg_58_1.unlockLevel)
end

function var_0_0._btnMaterialItemLockOnClick2(arg_59_0)
	GameFacade.showToast(ToastEnum.MaterialItemLockOnClick2)
end

function var_0_0._refreshDetailPart(arg_60_0, arg_60_1)
	if arg_60_0._selectPartId == 0 then
		return
	end

	local var_60_0 = RoomConfig.instance:getProductionPartConfig(arg_60_0._selectPartId).productionLines

	if arg_60_0._selectLineId == 0 or not LuaUtil.tableContains(var_60_0, arg_60_0._selectLineId) then
		arg_60_0._selectLineId = var_60_0[1]

		arg_60_0.viewContainer:setSelectLine(arg_60_0._selectLineId)
	end

	local var_60_1 = RoomProductionHelper.getPartType(arg_60_0._selectPartId)

	gohelper.setActive(arg_60_0._gogather, var_60_1 == RoomProductLineEnum.ProductType.Product)
	gohelper.setActive(arg_60_0._gochange, var_60_1 == RoomProductLineEnum.ProductType.Change)

	if var_60_1 == RoomProductLineEnum.ProductType.Product then
		arg_60_0:_refreshDetailPartGather(arg_60_0._selectPartId, not arg_60_1)
	elseif var_60_1 == RoomProductLineEnum.ProductType.Change then
		arg_60_0:_refreshDetailPartChange(arg_60_0._selectPartId)
	end
end

function var_0_0._refreshDetailPartGather(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_1 == 0 then
		return
	end

	if not arg_61_0._gatherItem then
		arg_61_0._gatherItem = arg_61_0:_initGatherItem()
	end

	local var_61_0 = RoomConfig.instance:getProductionPartConfig(arg_61_1)
	local var_61_1 = var_61_0.productionLines
	local var_61_2 = #RoomProductionHelper.getCanGainLineIdList(arg_61_1) > 0

	gohelper.setActive(arg_61_0._gatherItem.btnget.gameObject, false)

	local var_61_3 = false
	local var_61_4 = 0
	local var_61_5

	arg_61_0._lastDetailPartGatherCanGet = var_61_2

	for iter_61_0, iter_61_1 in ipairs(var_61_1) do
		local var_61_6 = arg_61_0._gatherItem.lineItemList[iter_61_0]

		if not var_61_6 then
			var_61_6 = arg_61_0:getUserDataTb_()
			var_61_6.lineId = iter_61_1
			var_61_6.go = gohelper.cloneInPlace(arg_61_0._gatherItem.goline, "item" .. iter_61_0)

			arg_61_0:_initLine(var_61_6, var_61_6.go, true, iter_61_0)
			table.insert(arg_61_0._gatherItem.lineItemList, var_61_6)
		end

		local var_61_7 = RoomProductionModel.instance:getLineMO(iter_61_1)

		gohelper.setActive(var_61_6.go, true)
		arg_61_0:_refreshLine(var_61_6, var_61_7, true)

		if not var_61_7:isLock() and not var_61_7:isIdle() and not var_61_7:isFull() then
			var_61_4 = var_61_4 + 1
			var_61_3 = true
		end

		if not var_61_5 then
			if var_61_7.config.type == RoomProductLineEnum.ProductItemType.ProductExp then
				var_61_5 = "1_huibiao"
			elseif var_61_7.config.type == RoomProductLineEnum.ProductItemType.ProductGold then
				var_61_5 = "2_huibiao"
			end
		end
	end

	for iter_61_2 = #var_61_1 + 1, #arg_61_0._gatherItem.lineItemList do
		local var_61_8 = arg_61_0._gatherItem.lineItemList[iter_61_2]

		gohelper.setActive(var_61_8.go, false)
	end

	gohelper.setActive(arg_61_0._gatherItem.btnnewget.gameObject, var_61_2)

	arg_61_0._gatherItem.txtname.text = var_61_0.name

	local var_61_9 = RoomProductionHelper.getUnlockLineCount(arg_61_1)

	arg_61_0._gatherItem.txtprocess.text = string.format("%s/%s", var_61_4, var_61_9)

	arg_61_0._gatherItem.animatorcircle:Play(var_61_3 and UIAnimationName.Loop or "idle")
	UISpriteSetMgr.instance:setRoomSprite(arg_61_0._gatherItem.imagereward, var_61_5 or "2_huibiao")

	local var_61_10 = var_61_4 == 0 and var_61_9 > 0

	gohelper.setActive(arg_61_0._gatherItem.gopause, var_61_10)
	gohelper.setActive(arg_61_0._gatherItem.goarrow, not var_61_10)
	SLFramework.UGUI.GuiHelper.SetColor(arg_61_0._gatherItem.txtprocess, var_61_10 and "#D97373" or "#999999")
	arg_61_0:_refreshDetailPartGatherSelectLine()
end

function var_0_0._hideExpandDetailUI(arg_62_0)
	if arg_62_0._expandDetailLineId then
		arg_62_0._expandDetailLineId = nil

		arg_62_0:_refreshDetailPartGather(arg_62_0._selectPartId)
	end
end

function var_0_0._refreshDetailPartGatherSelectLine(arg_63_0)
	TaskDispatcher.cancelTask(arg_63_0._updateDetailPartGatherSelectLineTime, arg_63_0)

	if arg_63_0._selectPartId == 0 then
		gohelper.setActive(arg_63_0._gatherItem.goinfo, false)

		return
	end

	gohelper.setActive(arg_63_0._gatherItem.goinfo, arg_63_0._expandDetailLineId == arg_63_0._selectLineId)

	if arg_63_0._expandDetailLineId == arg_63_0._selectLineId then
		local var_63_0 = RoomProductionModel.instance:getLineMO(arg_63_0._selectLineId)
		local var_63_1 = ""

		if var_63_0.config.type == RoomProductLineEnum.ProductItemType.ProductExp then
			var_63_1 = luaLang("roominitbuildingview_dust")
		elseif var_63_0.config.type == RoomProductLineEnum.ProductItemType.ProductGold then
			var_63_1 = luaLang("roominitbuildingview_coin")
		end

		arg_63_0._gatherItem.txtstore.text = string.format("<color=#65b96f>%s</color>/%s", var_63_0.useReserve, var_63_0.reserve)

		local var_63_2, var_63_3, var_63_4 = TimeUtil.secondToHMS(var_63_0.costTime)
		local var_63_5 = var_63_3 + var_63_2 * 60

		if var_63_5 > 0 then
			if var_63_4 > 0 then
				arg_63_0._gatherItem.txttime.text = string.format("<color=#65b96f>%d </color>%s/<color=#65b96f>%d</color>%s<color=#65b96f>%d</color>%s", var_63_0.produceSpeed, var_63_1, var_63_5, luaLang("time_minute"), var_63_4, luaLang("time_second"))
			else
				arg_63_0._gatherItem.txttime.text = string.format("<color=#65b96f>%d </color>%s/<color=#65b96f>%d</color>%s", var_63_0.produceSpeed, var_63_1, var_63_5, luaLang("time_minute"))
			end
		else
			arg_63_0._gatherItem.txttime.text = string.format("<color=#65b96f>%d </color>%s/<color=#65b96f>%d</color>%s", var_63_0.produceSpeed, var_63_1, var_63_4, luaLang("time_second"))
		end

		arg_63_0:_updateDetailPartGatherSelectLineTime()
		TaskDispatcher.runRepeat(arg_63_0._updateDetailPartGatherSelectLineTime, arg_63_0, 1)

		local var_63_6 = arg_63_0:_getLineItemByLineId(arg_63_0._selectLineId)

		gohelper.addChild(var_63_6.go, arg_63_0._gatherItem.goinfo)

		local var_63_7, var_63_8, var_63_9 = transformhelper.getLocalPos(arg_63_0._gatherItem.goinfo.transform)

		transformhelper.setLocalPos(arg_63_0._gatherItem.goinfo.transform, var_63_7, 0, var_63_9)
	end
end

function var_0_0._updateDetailPartGatherSelectLineTime(arg_64_0)
	if arg_64_0._selectPartId == 0 then
		TaskDispatcher.cancelTask(arg_64_0._updateDetailPartGatherSelectLineTime, arg_64_0)

		return
	end

	if arg_64_0._selectLineId == 0 then
		TaskDispatcher.cancelTask(arg_64_0._updateDetailPartGatherSelectLineTime, arg_64_0)

		return
	end

	local var_64_0 = RoomProductionModel.instance:getLineMO(arg_64_0._selectLineId)

	if var_64_0.config.logic ~= RoomProductLineEnum.ProductType.Product then
		TaskDispatcher.cancelTask(arg_64_0._updateDetailPartGatherSelectLineTime, arg_64_0)

		return
	end

	local var_64_1 = math.floor(var_64_0.allFinishTime - ServerTime.now())

	if not var_64_0:isIdle() and var_64_0:isFull() then
		arg_64_0._gatherItem.txtremain.text = luaLang("roominitbuildingview_fullpro")
	else
		arg_64_0._gatherItem.txtremain.text = string.format("<color=#65B96F>%s </color>%s", TimeUtil.second2TimeString(math.max(0, var_64_1), true), luaLang("roominitbuildingview_stopproduct"))
	end
end

function var_0_0._refreshDetailPartChange(arg_65_0, arg_65_1)
	if not arg_65_0._changeItem then
		arg_65_0._changeItem = arg_65_0:_initChangeItem()
	end

	arg_65_0:_refreshDetailPartChangeTitle(arg_65_1)
	gohelper.setActive(arg_65_0._changeItem.gobgvx, false)
	gohelper.setActive(arg_65_0._changeItem.gohechengeffect, false)
end

function var_0_0._refreshDetailPartChangeTitle(arg_66_0, arg_66_1)
	local var_66_0 = RoomProductionHelper.getChangePartLineMO(arg_66_1)

	arg_66_0:_refreshLine(arg_66_0._changeItem.lineItem, var_66_0, false)
end

function var_0_0._refreshLine(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	arg_67_1.lineId = arg_67_2.id
	arg_67_1.txtname.text = arg_67_2.config.name

	gohelper.setActive(arg_67_1.btnupgrade.gameObject, arg_67_2.level < arg_67_2.maxConfigLevel)

	if arg_67_3 then
		gohelper.setActive(arg_67_1.txtname.gameObject, not arg_67_2:isLock())

		local var_67_0 = arg_67_2.config.needRoomLevel

		arg_67_1.txtlock.text = string.format(luaLang("room_initbuilding_linelock"), var_67_0)

		if arg_67_2:isLock() then
			gohelper.setActive(arg_67_1.gonormalbg, true)
			gohelper.setActive(arg_67_1.gofullbg, false)
			gohelper.setActive(arg_67_1.goshowprocess, false)
			gohelper.setActive(arg_67_1.btnupgrade.gameObject, false)
			gohelper.setActive(arg_67_1.goselectbg, false)
		else
			gohelper.setActive(arg_67_1.gonormalbg, arg_67_2:isIdle() or not arg_67_2:isFull())
			gohelper.setActive(arg_67_1.gofullbg, not arg_67_2:isIdle() and arg_67_2:isFull())
			gohelper.setActive(arg_67_1.goshowprocess, not arg_67_2:isIdle())
			gohelper.setActive(arg_67_1.goselectbg, arg_67_0._expandDetailLineId == arg_67_2.id)

			if arg_67_2:isIdle() then
				gohelper.setActive(arg_67_1.gofull, false)
				gohelper.setActive(arg_67_1.goprocess, false)
			elseif arg_67_2:isFull() then
				gohelper.setActive(arg_67_1.gofull, true)
				gohelper.setActive(arg_67_1.goprocess, false)
			else
				gohelper.setActive(arg_67_1.gofull, false)
				gohelper.setActive(arg_67_1.goprocess, true)

				local var_67_1, var_67_2 = arg_67_2:getReservePer()

				if not arg_67_0._lineIdPerDict[arg_67_1.lineId] then
					arg_67_1.imageprocess.fillAmount = var_67_1
					arg_67_1.txtprocess.text = string.format("%d%%", var_67_2)
				end
			end
		end

		if arg_67_2:isLock() then
			arg_67_1.gatherAnimator.speed = 0

			arg_67_1.gatherAnimator:Play("unlock", 0, 0)
			arg_67_1.gatherAnimator:Update(0)
		elseif RoomProductionModel.instance:shouldPlayLineUnlockDetail(arg_67_1.lineId) then
			RoomProductionModel.instance:setPlayLineUnlockDetail(arg_67_1.lineId, nil)

			arg_67_1.gatherAnimator.speed = 0

			arg_67_1.gatherAnimator:Play("unlock", 0, 0)
			arg_67_1.gatherAnimator:Update(0)
			TaskDispatcher.runDelay(arg_67_0._playLineUnlockDetail, arg_67_1, 0.4)
		else
			arg_67_1.gatherAnimator.speed = 0

			arg_67_1.gatherAnimator:Play(UIAnimationName.Idle, 0, 0)
			arg_67_1.gatherAnimator:Update(0)
		end
	else
		gohelper.setActive(arg_67_1.goselectbg, false)
		gohelper.setActive(arg_67_1.goshowprocess, true)

		arg_67_1.imageprocess.fillAmount = 0
		arg_67_1.txtprocess.text = string.format("%d%%", 0)
	end

	local var_67_3 = arg_67_2.level or 0
	local var_67_4 = arg_67_2.maxLevel or 0

	for iter_67_0 = 1, var_67_4 do
		local var_67_5 = arg_67_1.levelItemList[iter_67_0]

		if not var_67_5 then
			var_67_5 = arg_67_0:getUserDataTb_()
			var_67_5.go = gohelper.cloneInPlace(arg_67_1.golevelitem, "item" .. iter_67_0)
			var_67_5.golight = gohelper.findChild(var_67_5.go, "go_light")

			table.insert(arg_67_1.levelItemList, var_67_5)
		end

		gohelper.setActive(var_67_5.golight, iter_67_0 <= var_67_3)
		gohelper.setActive(var_67_5.go, true)
	end

	for iter_67_1 = var_67_4 + 1, #arg_67_1.levelItemList do
		local var_67_6 = arg_67_1.levelItemList[iter_67_1]

		gohelper.setActive(var_67_6.go, false)
	end

	RedDotController.instance:addRedDot(arg_67_1.reddot, RedDotEnum.DotNode.RoomProductionLevel, arg_67_1.lineId)
end

function var_0_0._playLineUnlockDetail(arg_68_0)
	arg_68_0.gatherAnimator.speed = 1

	arg_68_0.gatherAnimator:Play("unlock", 0, 0)
end

function var_0_0._onChangePartStart(arg_69_0)
	PopupController.instance:setPause("roominitbuildingview_changeeffect", true)
	UIBlockMgr.instance:startBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.cancelTask(arg_69_0._resetChangeProcessText, arg_69_0)
	arg_69_0._changeItem.lineItem.animator:Play(UIAnimationName.Open, 0, 0)

	if arg_69_0._changeItem.lineItem.tweenId then
		if arg_69_0._scene.tween then
			arg_69_0._scene.tween:killById(arg_69_0._changeItem.lineItem.tweenId)
		else
			ZProj.TweenHelper.KillById(arg_69_0._changeItem.lineItem.tweenId)
		end

		arg_69_0._changeItem.lineItem.tweenId = nil
	end

	if arg_69_0._scene.tween then
		arg_69_0._changeItem.lineItem.tweenId = arg_69_0._scene.tween:tweenFloat(0, 1, 1.3, arg_69_0._changeEffectFrame, arg_69_0._changeEffectFinish, arg_69_0)
	else
		arg_69_0._changeItem.lineItem.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.3, arg_69_0._changeEffectFrame, arg_69_0._changeEffectFinish, arg_69_0)
	end
end

function var_0_0._changeEffectFrame(arg_70_0, arg_70_1)
	arg_70_0._changeItem.lineItem.txtprocess.text = string.format("%d%%", math.ceil(arg_70_1 * 100))
end

function var_0_0._changeEffectFinish(arg_71_0)
	arg_71_0._changeItem.lineItem.txtprocess.text = "100%"

	PopupController.instance:setPause("roominitbuildingview_changeeffect", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.runDelay(arg_71_0._resetChangeProcessText, arg_71_0, 1)
end

function var_0_0._resetChangeProcessText(arg_72_0)
	if arg_72_0._changeItem then
		arg_72_0._changeItem.lineItem.txtprocess.text = "0%"
	end
end

function var_0_0._onCloseView(arg_73_0, arg_73_1)
	arg_73_0:_resetChangeProcessText()

	if arg_73_1 == ViewName.RoomLevelUpTipsView and arg_73_0._selectTabId == var_0_0.TabId.ProductionLine then
		arg_73_0:_refreshInitPart()
	end
end

function var_0_0.onUpdateParam(arg_74_0)
	arg_74_0:_refreshUI(true)
end

function var_0_0.onOpen(arg_75_0)
	arg_75_0:_refreshUI(true)

	if arg_75_0.viewParam and arg_75_0.viewParam.showFormulaView then
		arg_75_0:_changeSelectPart(3)
	end

	arg_75_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, arg_75_0._refreshLevel, arg_75_0)
	arg_75_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, arg_75_0._refreshCategory, arg_75_0)
	arg_75_0:addEventCb(RoomController.instance, RoomEvent.UpdateProduceLineData, arg_75_0._refreshInitPart, arg_75_0)
	arg_75_0:addEventCb(RoomController.instance, RoomEvent.UpdateProduceLineData, arg_75_0._refreshDetailPart, arg_75_0)
	arg_75_0:addEventCb(RoomController.instance, RoomEvent.GainProductionLineReply, arg_75_0._gainProductionLineCallback, arg_75_0)
	arg_75_0:addEventCb(RoomMapController.instance, RoomEvent.OnChangePartStart, arg_75_0._onChangePartStart, arg_75_0)
	arg_75_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_75_0._onCloseView, arg_75_0)
	arg_75_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, arg_75_0._refreshRoomLevelUpEffect, arg_75_0)
	NavigateMgr.instance:addEscape(ViewName.RoomInitBuildingView, arg_75_0._onEscape, arg_75_0)
end

function var_0_0.onClose(arg_76_0)
	if arg_76_0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Team_close)
	end
end

function var_0_0._onEscape(arg_77_0)
	ViewMgr.instance:closeView(ViewName.RoomInitBuildingView, false, true)
	RoomMapController.instance:onCloseRoomInitBuildingView()
end

function var_0_0.onDestroyView(arg_78_0)
	PopupController.instance:setPause("roominitbuildingview_changeeffect", false)
	UIBlockMgr.instance:endBlock("roominitbuildingview_changeeffect")
	TaskDispatcher.cancelTask(arg_78_0._resetChangeProcessText, arg_78_0)
	TaskDispatcher.cancelTask(arg_78_0._realChangeSelectPart, arg_78_0)
	TaskDispatcher.cancelTask(arg_78_0._changeShowSkinList, arg_78_0)
	TaskDispatcher.cancelTask(arg_78_0._updateDetailPartGatherSelectLineTime, arg_78_0)

	arg_78_0._keepOpenSkinListAfterChange = false

	for iter_78_0, iter_78_1 in ipairs(arg_78_0._categoryItemList) do
		iter_78_1.btnclick:RemoveClickListener()
	end

	for iter_78_2, iter_78_3 in ipairs(arg_78_0._initPartProductItemList) do
		iter_78_3.simagereward:UnLoadImage()
		iter_78_3.btnget:RemoveClickListener()
		iter_78_3.btnjumpclick:RemoveClickListener()

		for iter_78_4, iter_78_5 in ipairs(iter_78_3.lineItemList) do
			TaskDispatcher.cancelTask(arg_78_0._playLineUnlock, iter_78_5)
		end
	end

	for iter_78_6, iter_78_7 in ipairs(arg_78_0._initPartChangeItemList) do
		iter_78_7.simagedoor:UnLoadImage()
		iter_78_7.btncombine:RemoveClickListener()

		for iter_78_8, iter_78_9 in ipairs(iter_78_7.formulaItemList) do
			iter_78_9.btnlockclick:RemoveClickListener()
		end
	end

	if arg_78_0._changeItem then
		arg_78_0._changeItem.lineItem.btnupgrade:RemoveClickListener()

		if arg_78_0._changeItem.lineItem.tweenId then
			if arg_78_0._scene.tween then
				arg_78_0._scene.tween:killById(arg_78_0._changeItem.lineItem.tweenId)
			else
				ZProj.TweenHelper.KillById(arg_78_0._changeItem.lineItem.tweenId)
			end

			arg_78_0._changeItem.lineItem.tweenId = nil
		end

		arg_78_0._changeItem = nil
	end

	if arg_78_0._gatherItem then
		arg_78_0._gatherItem.btnget:RemoveClickListener()
		arg_78_0._gatherItem.btnnewget:RemoveClickListener()

		for iter_78_10, iter_78_11 in ipairs(arg_78_0._gatherItem.lineItemList) do
			iter_78_11.btnupgrade:RemoveClickListener()
			iter_78_11.btnclick:RemoveClickListener()
		end

		for iter_78_12, iter_78_13 in ipairs(arg_78_0._gatherItem.lineItemList) do
			TaskDispatcher.cancelTask(arg_78_0._playLineUnlockDetail, iter_78_13)
		end

		arg_78_0._gatherItem = nil
	end

	arg_78_0._flyEffectRewardInfoList = nil

	arg_78_0:_clearLineAnimation()
	arg_78_0._simagecombinebg:UnLoadImage()
	arg_78_0._simagemask:UnLoadImage()
	RoomSkinController.instance:setRoomSkinListVisible()
end

return var_0_0
