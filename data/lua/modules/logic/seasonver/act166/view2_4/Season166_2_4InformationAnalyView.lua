module("modules.logic.seasonver.act166.view2_4.Season166_2_4InformationAnalyView", package.seeall)

local var_0_0 = class("Season166_2_4InformationAnalyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.simageReportPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "Report/image_Line/image_ReportPic")
	arg_1_0.goLockedPic = gohelper.findChild(arg_1_0.viewGO, "Report/image_Line/#go_Locked/image_ReportLockedPic")
	arg_1_0.lockedCtrl = arg_1_0.goLockedPic:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_1_0.simageLockedPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "Report/image_Line/#go_Locked/image_ReportLockedPic")
	arg_1_0.btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Left")
	arg_1_0.btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Right")
	arg_1_0.goDetail = gohelper.findChild(arg_1_0.viewGO, "Detail")
	arg_1_0.reportNameTxt = gohelper.findChildTextMesh(arg_1_0.viewGO, "Detail/#txt_ReportName")
	arg_1_0.reportNameEnTxt = gohelper.findChildTextMesh(arg_1_0.viewGO, "Detail/#txt_ReportNameEn")
	arg_1_0.simageDetailPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "Detail/#simage_DetailPic")
	arg_1_0.btnInvestigate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Detail/#btn_Investigate")
	arg_1_0.txtCost = gohelper.findChildTextMesh(arg_1_0.viewGO, "Detail/#btn_Investigate/txt_CostNum")
	arg_1_0.imgCost = gohelper.findChildImage(arg_1_0.viewGO, "Detail/#btn_Investigate/#image")
	arg_1_0.goComplete = gohelper.findChild(arg_1_0.viewGO, "Detail/#go_Complete")
	arg_1_0.goScroll = gohelper.findChild(arg_1_0.viewGO, "Detail/#scorll_Details")
	arg_1_0.rectScroll = arg_1_0.goScroll.transform
	arg_1_0.goContent = gohelper.findChild(arg_1_0.viewGO, "Detail/#scorll_Details/Viewport/Content")
	arg_1_0.rectContent = arg_1_0.goContent.transform
	arg_1_0.goDesc = gohelper.findChild(arg_1_0.viewGO, "Detail/#scorll_Details/Viewport/Content/#go_Descr")
	arg_1_0.goRevealTips = gohelper.findChild(arg_1_0.viewGO, "Detail/#scorll_Details/Viewport/Content/#go_RevealTips")
	arg_1_0.goLockInfo = gohelper.findChild(arg_1_0.viewGO, "LockInfo")
	arg_1_0.txtLockInfo = gohelper.findChildTextMesh(arg_1_0.viewGO, "LockInfo/#txt_lockInfo")
	arg_1_0.detailItems = {}
	arg_1_0.recycleItemsDict = {}
	arg_1_0.itemClsDict = {
		Season166InformationAnalyDescItem,
		Season166InformationAnalyTipsItem
	}
	arg_1_0.itemGODict = {
		arg_1_0.goDesc,
		arg_1_0.goRevealTips
	}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.itemGODict) do
		gohelper.setActive(iter_1_1, false)
	end

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnLeft, arg_2_0.onClickLeft, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRight, arg_2_0.onClickRight, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnInvestigate, arg_2_0.onClickInvestigate, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, arg_2_0.onInformationUpdate, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, arg_2_0.onAnalyInfoSuccess, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.ChangeAnalyInfo, arg_2_0.onChangeAnalyInfo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.anim = arg_4_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_4_0._animEventWrap = arg_4_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_4_0._animEventWrap:AddEventListener("switch", arg_4_0.checkChangeInfo, arg_4_0)
end

function var_0_0.onChangeAnalyInfo(arg_5_0, arg_5_1)
	arg_5_0.infoId = arg_5_1
	arg_5_0._imgValue = nil

	arg_5_0:refreshUI()
end

function var_0_0.onInformationUpdate(arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onAnalyInfoSuccess(arg_7_0, arg_7_1)
	arg_7_0:refreshUI()
	arg_7_0:playTxtFadeInByStage(arg_7_1.stage)
end

function var_0_0.onClickLeft(arg_8_0)
	arg_8_0.infoId = arg_8_0.infoId - 1

	if arg_8_0.infoId <= 0 then
		arg_8_0.infoId = #Season166Config.instance:getSeasonInfos(arg_8_0.actId)
	end

	arg_8_0.anim:Play(UIAnimationName.Switch, 0, 0)
end

function var_0_0.onClickRight(arg_9_0)
	arg_9_0.infoId = arg_9_0.infoId + 1

	local var_9_0 = Season166Config.instance:getSeasonInfos(arg_9_0.actId)

	if arg_9_0.infoId > #var_9_0 then
		arg_9_0.infoId = 1
	end

	arg_9_0.anim:Play(UIAnimationName.Switch, 0, 0)
end

function var_0_0.checkChangeInfo(arg_10_0)
	Season166Controller.instance:dispatchEvent(Season166Event.ChangeAnalyInfo, arg_10_0.infoId)
end

function var_0_0.checkCanChangeInfo(arg_11_0, arg_11_1)
	return true
end

function var_0_0.onClickInvestigate(arg_12_0)
	local var_12_0 = Season166Model.instance:getActInfo(arg_12_0.actId)
	local var_12_1 = var_12_0 and var_12_0:getInformationMO(arg_12_0.infoId)
	local var_12_2 = (Season166Config.instance:getSeasonInfoAnalys(arg_12_0.actId, arg_12_0.infoId) or {})[var_12_1.stage + 1]

	if not var_12_2 then
		return
	end

	local var_12_3 = var_12_2.consume
	local var_12_4 = {}

	table.insert(var_12_4, {
		type = MaterialEnum.MaterialType.Currency,
		id = Season166Config.instance:getSeasonConstNum(arg_12_0.actId, Season166Enum.InfoCostId),
		quantity = var_12_3
	})

	local var_12_5, var_12_6, var_12_7 = ItemModel.instance:hasEnoughItems(var_12_4)

	if not var_12_6 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_12_7, var_12_5)

		return
	end

	Activity166Rpc.instance:sendAct166AnalyInfoRequest(arg_12_0.actId, arg_12_0.infoId)
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0.actId = arg_14_0.viewParam.actId
	arg_14_0.infoId = arg_14_0.viewParam.infoId

	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wulu_aizila_forward_paper)
	arg_14_0:refreshUI()
end

function var_0_0.refreshUI(arg_15_0)
	local var_15_0 = Season166Config.instance:getSeasonInfoConfig(arg_15_0.actId, arg_15_0.infoId)

	arg_15_0.simageReportPic:LoadImage(string.format("singlebg/seasonver/%s_1.png", var_15_0.reportRes))
	arg_15_0.simageLockedPic:LoadImage(string.format("singlebg/seasonver/%s_0.png", var_15_0.reportRes))

	arg_15_0.reportNameTxt.text = var_15_0.name
	arg_15_0.reportNameEnTxt.text = var_15_0.nameEn

	arg_15_0.simageDetailPic:LoadImage(string.format("singlebg/seasonver/%s.png", var_15_0.reportPic))

	local var_15_1 = Season166Model.instance:getActInfo(arg_15_0.actId)

	arg_15_0.unlockState = var_15_1 and var_15_1:getInformationMO(arg_15_0.infoId) and Season166Enum.UnlockState or Season166Enum.LockState

	local var_15_2 = arg_15_0.unlockState == Season166Enum.UnlockState

	if var_15_2 then
		arg_15_0:refreshDetail()
	else
		arg_15_0:_setImgValue(0)
	end

	arg_15_0.txtLockInfo.text = var_15_0.unlockDes

	gohelper.setActive(arg_15_0.goDetail, var_15_2)
	gohelper.setActive(arg_15_0.goLockInfo, not var_15_2)
	arg_15_0:refreshBtn()
end

function var_0_0.refreshBtn(arg_16_0)
	local var_16_0 = Season166Config.instance:getSeasonInfos(arg_16_0.actId)
	local var_16_1 = arg_16_0.infoId - 1
	local var_16_2 = arg_16_0.infoId + 1

	if var_16_1 <= 0 then
		var_16_1 = #var_16_0
	end

	if var_16_2 > #var_16_0 then
		var_16_2 = 1
	end

	gohelper.setActive(arg_16_0.btnLeft, arg_16_0:checkCanChangeInfo(var_16_1))
	gohelper.setActive(arg_16_0.btnRight, arg_16_0:checkCanChangeInfo(var_16_2))
end

function var_0_0.refreshDetail(arg_17_0)
	local var_17_0 = Season166Model.instance:getActInfo(arg_17_0.actId)
	local var_17_1 = var_17_0 and var_17_0:getInformationMO(arg_17_0.infoId)
	local var_17_2 = Season166Config.instance:getSeasonInfoAnalys(arg_17_0.actId, arg_17_0.infoId) or {}
	local var_17_3 = Season166Config.instance:getSeasonInfoConfig(arg_17_0.actId, arg_17_0.infoId)

	arg_17_0:recycleItems()

	local var_17_4 = #var_17_2
	local var_17_5
	local var_17_6

	arg_17_0:updateItemByData({
		stage = 0,
		content = var_17_3.initContent
	}, var_17_1, false)

	for iter_17_0, iter_17_1 in ipairs(var_17_2) do
		local var_17_7 = arg_17_0:updateItemByData(iter_17_1, var_17_1, var_17_4 == iter_17_0)

		if var_17_1.stage + 1 == iter_17_1.stage then
			var_17_5 = iter_17_1
			var_17_6 = var_17_7
		end
	end

	arg_17_0:refreshCost(var_17_5)

	local var_17_8 = var_17_2[var_17_4]

	arg_17_0:setComplete(not var_17_8 or var_17_1.stage >= var_17_8.stage)
	arg_17_0:setLockedImgValue()

	if var_17_6 == nil then
		var_17_6 = arg_17_0.detailItems[#arg_17_0.detailItems]
	end

	if var_17_6 then
		ZProj.UGUIHelper.RebuildLayout(arg_17_0.rectContent)

		local var_17_9 = math.abs(var_17_6:getPosY())
		local var_17_10 = recthelper.getHeight(arg_17_0.rectScroll)
		local var_17_11 = math.max(var_17_9 - var_17_10, 0)

		recthelper.setAnchorY(arg_17_0.rectContent, var_17_11)
	end
end

function var_0_0.setComplete(arg_18_0, arg_18_1)
	if arg_18_0.completeValue == arg_18_1 then
		return
	end

	arg_18_0.completeValue = arg_18_1

	gohelper.setActive(arg_18_0.goComplete, arg_18_1)

	if arg_18_1 then
		AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wulu_aizila_forward_paper)
	end
end

function var_0_0.refreshCost(arg_19_0, arg_19_1)
	if not arg_19_1 then
		gohelper.setActive(arg_19_0.btnInvestigate, false)

		return
	end

	gohelper.setActive(arg_19_0.btnInvestigate, true)

	local var_19_0 = Season166Config.instance:getSeasonConstNum(arg_19_0.actId, Season166Enum.InfoCostId)

	if ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, var_19_0) >= arg_19_1.consume then
		arg_19_0.txtCost.text = string.format("-%s", arg_19_1.consume)
	else
		arg_19_0.txtCost.text = formatLuaLang("Season166_2_4InformationAnalyView_consume", arg_19_1.consume)
	end

	local var_19_1 = CurrencyConfig.instance:getCurrencyCo(var_19_0)
	local var_19_2 = string.format("%s_1", var_19_1 and var_19_1.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_19_0.imgCost, var_19_2, true)
end

function var_0_0.updateItemByData(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_0:getItem(arg_20_1, arg_20_2)

	table.insert(arg_20_0.detailItems, var_20_0)
	var_20_0:setData({
		config = arg_20_1,
		info = arg_20_2,
		isEnd = arg_20_3
	})

	return var_20_0
end

function var_0_0.getItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0
	local var_21_1 = arg_21_2.stage >= arg_21_1.stage and 1 or 2

	if arg_21_0.recycleItemsDict[var_21_1] and #arg_21_0.recycleItemsDict[var_21_1] > 0 then
		return table.remove(arg_21_0.recycleItemsDict[var_21_1])
	else
		local var_21_2 = arg_21_0.itemClsDict[var_21_1]
		local var_21_3 = arg_21_0.itemGODict[var_21_1]

		return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(var_21_3), var_21_2, var_21_1)
	end
end

function var_0_0.recycleItems(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.detailItems) do
		arg_22_0:recycleItem(iter_22_1)
	end

	arg_22_0.detailItems = {}
end

function var_0_0.recycleItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.itemType

	if not arg_23_0.recycleItemsDict[var_23_0] then
		arg_23_0.recycleItemsDict[var_23_0] = {}
	end

	table.insert(arg_23_0.recycleItemsDict[var_23_0], arg_23_1)
	arg_23_1:onRecycle()
end

function var_0_0.playTxtFadeInByStage(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.detailItems) do
		iter_24_1:playTxtFadeInByStage(arg_24_1)
	end
end

function var_0_0.setLockedImgValue(arg_25_0)
	local var_25_0 = Season166Model.instance:getActInfo(arg_25_0.actId)
	local var_25_1 = var_25_0 and var_25_0:getInformationMO(arg_25_0.infoId)
	local var_25_2 = #(Season166Config.instance:getSeasonInfoAnalys(arg_25_0.actId, arg_25_0.infoId) or {})
	local var_25_3 = var_25_1.stage / var_25_2

	if arg_25_0._imgValue == var_25_3 then
		return
	end

	if arg_25_0._tweenId then
		ZProj.TweenHelper.KillById(arg_25_0._tweenId)

		arg_25_0._tweenId = nil
	end

	if arg_25_0._imgValue == nil then
		arg_25_0:_setImgValue(var_25_3)
	else
		arg_25_0._tweenId = ZProj.TweenHelper.DOTweenFloat(arg_25_0._imgValue, var_25_3, 1, arg_25_0._setImgValue, arg_25_0.playFinishCallBack, arg_25_0, nil, EaseType.Linear)
	end

	arg_25_0._imgValue = var_25_3
end

function var_0_0._setImgValue(arg_26_0, arg_26_1)
	arg_26_0.lockedCtrl:GetIndexProp(0, 0)

	local var_26_0 = arg_26_0.lockedCtrl.vector_01

	arg_26_0.lockedCtrl.vector_01 = Vector4.New(arg_26_1, 0.05, 0, 0)

	arg_26_0.lockedCtrl:SetIndexProp(0, 0)
end

function var_0_0.playFinishCallBack(arg_27_0)
	return
end

function var_0_0.onClose(arg_28_0)
	return
end

function var_0_0.onDestroyView(arg_29_0)
	if arg_29_0._tweenId then
		ZProj.TweenHelper.KillById(arg_29_0._tweenId)

		arg_29_0._tweenId = nil
	end

	arg_29_0.simageLockedPic:UnLoadImage()
	arg_29_0.simageReportPic:UnLoadImage()
	arg_29_0.simageDetailPic:UnLoadImage()
end

return var_0_0
