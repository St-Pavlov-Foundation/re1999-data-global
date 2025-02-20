module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyView", package.seeall)

slot0 = class("Season166InformationAnalyView", BaseView)

function slot0.onInitView(slot0)
	slot0.simageReportPic = gohelper.findChildSingleImage(slot0.viewGO, "Report/image_Line/image_ReportPic")
	slot0.goLockedPic = gohelper.findChild(slot0.viewGO, "Report/image_Line/#go_Locked/image_ReportLockedPic")
	slot0.lockedCtrl = slot0.goLockedPic:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	slot0.simageLockedPic = gohelper.findChildSingleImage(slot0.viewGO, "Report/image_Line/#go_Locked/image_ReportLockedPic")
	slot0.btnLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Left")
	slot0.btnRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Right")
	slot0.reportNameTxt = gohelper.findChildTextMesh(slot0.viewGO, "Detail/#txt_ReportName")
	slot0.reportNameEnTxt = gohelper.findChildTextMesh(slot0.viewGO, "Detail/#txt_ReportNameEn")
	slot0.simageDetailPic = gohelper.findChildSingleImage(slot0.viewGO, "Detail/#simage_DetailPic")
	slot0.btnInvestigate = gohelper.findChildButtonWithAudio(slot0.viewGO, "Detail/#btn_Investigate")
	slot0.txtCost = gohelper.findChildTextMesh(slot0.viewGO, "Detail/#btn_Investigate/txt_CostNum")
	slot0.imgCost = gohelper.findChildImage(slot0.viewGO, "Detail/#btn_Investigate/#image")
	slot0.goComplete = gohelper.findChild(slot0.viewGO, "Detail/#go_Complete")
	slot0.goScroll = gohelper.findChild(slot0.viewGO, "Detail/#scorll_Details")
	slot0.rectScroll = slot0.goScroll.transform
	slot0.goContent = gohelper.findChild(slot0.viewGO, "Detail/#scorll_Details/Viewport/Content")
	slot0.rectContent = slot0.goContent.transform
	slot0.goDesc = gohelper.findChild(slot0.viewGO, "Detail/#scorll_Details/Viewport/Content/#go_Descr")
	slot4 = "Detail/#scorll_Details/Viewport/Content/#go_RevealTips"
	slot0.goRevealTips = gohelper.findChild(slot0.viewGO, slot4)
	slot0.detailItems = {}
	slot0.recycleItemsDict = {}
	slot0.itemClsDict = {
		Season166InformationAnalyDescItem,
		Season166InformationAnalyTipsItem
	}
	slot0.itemGODict = {
		slot0.goDesc,
		slot0.goRevealTips
	}

	for slot4, slot5 in pairs(slot0.itemGODict) do
		gohelper.setActive(slot5, false)
	end

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnLeft, slot0.onClickLeft, slot0)
	slot0:addClickCb(slot0.btnRight, slot0.onClickRight, slot0)
	slot0:addClickCb(slot0.btnInvestigate, slot0.onClickInvestigate, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, slot0.onInformationUpdate, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, slot0.onAnalyInfoSuccess, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.ChangeAnalyInfo, slot0.onChangeAnalyInfo, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onChangeAnalyInfo(slot0, slot1)
	slot0.infoId = slot1
	slot0._imgValue = nil

	slot0:refreshUI()
end

function slot0.onInformationUpdate(slot0)
	slot0:refreshUI()
end

function slot0.onAnalyInfoSuccess(slot0, slot1)
	slot0:refreshUI()
	slot0:playTxtFadeInByStage(slot1.stage)
end

function slot0.onClickLeft(slot0)
	if slot0.infoId - 1 <= 0 then
		slot1 = #Season166Config.instance:getSeasonInfos(slot0.actId)
	end

	slot0:checkChangeInfo(slot1)
end

function slot0.onClickRight(slot0)
	if slot0.infoId + 1 > #Season166Config.instance:getSeasonInfos(slot0.actId) then
		slot1 = 1
	end

	slot0:checkChangeInfo(slot1)
end

function slot0.checkChangeInfo(slot0, slot1)
	if not slot0:checkCanChangeInfo(slot1) then
		return
	end

	Season166Controller.instance:dispatchEvent(Season166Event.ChangeAnalyInfo, slot1)
end

function slot0.checkCanChangeInfo(slot0, slot1)
	if not (Season166Model.instance:getActInfo(slot0.actId) and slot2:getInformationMO(slot1)) then
		return false
	end

	return true
end

function slot0.onClickInvestigate(slot0)
	if not (Season166Config.instance:getSeasonInfoAnalys(slot0.actId, slot0.infoId) or {})[(Season166Model.instance:getActInfo(slot0.actId) and slot1:getInformationMO(slot0.infoId)).stage + 1] then
		return
	end

	slot6 = {}

	table.insert(slot6, {
		type = MaterialEnum.MaterialType.Currency,
		id = Season166Config.instance:getSeasonConstNum(slot0.actId, Season166Enum.InfoCostId),
		quantity = slot4.consume
	})

	slot7, slot8, slot9 = ItemModel.instance:hasEnoughItems(slot6)

	if not slot8 then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, slot9, slot7)

		return
	end

	Activity166Rpc.instance:sendAct166AnalyInfoRequest(slot0.actId, slot0.infoId)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.infoId = slot0.viewParam.infoId

	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wulu_aizila_forward_paper)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1 = Season166Config.instance:getSeasonInfoConfig(slot0.actId, slot0.infoId)

	slot0.simageReportPic:LoadImage(string.format("singlebg/seasonver/%s_1.png", slot1.reportRes))
	slot0.simageLockedPic:LoadImage(string.format("singlebg/seasonver/%s_0.png", slot1.reportRes))

	slot0.reportNameTxt.text = slot1.name
	slot0.reportNameEnTxt.text = slot1.nameEn

	slot0.simageDetailPic:LoadImage(string.format("singlebg/seasonver/%s.png", slot1.reportPic))
	slot0:refreshDetail()
	slot0:refreshBtn()
end

function slot0.refreshBtn(slot0)
	slot1 = Season166Config.instance:getSeasonInfos(slot0.actId)
	slot3 = slot0.infoId + 1

	if slot0.infoId - 1 <= 0 then
		slot2 = #slot1
	end

	if slot3 > #slot1 then
		slot3 = 1
	end

	gohelper.setActive(slot0.btnLeft, slot0:checkCanChangeInfo(slot2))
	gohelper.setActive(slot0.btnRight, slot0:checkCanChangeInfo(slot3))
end

function slot0.refreshDetail(slot0)
	slot0:recycleItems()

	slot5 = #(Season166Config.instance:getSeasonInfoAnalys(slot0.actId, slot0.infoId) or {})
	slot6, slot7 = nil

	slot0:updateItemByData({
		stage = 0,
		content = Season166Config.instance:getSeasonInfoConfig(slot0.actId, slot0.infoId).initContent
	}, Season166Model.instance:getActInfo(slot0.actId) and slot1:getInformationMO(slot0.infoId), false)

	for slot11, slot12 in ipairs(slot3) do
		if slot2.stage + 1 == slot12.stage then
			slot6 = slot12
			slot7 = slot0:updateItemByData(slot12, slot2, slot5 == slot11)
		end
	end

	slot0:refreshCost(slot6)
	slot0:setComplete(not slot3[slot5] or slot8.stage <= slot2.stage)
	slot0:setLockedImgValue()

	if slot7 == nil then
		slot7 = slot0.detailItems[#slot0.detailItems]
	end

	if slot7 then
		ZProj.UGUIHelper.RebuildLayout(slot0.rectContent)
		recthelper.setAnchorY(slot0.rectContent, math.max(math.abs(slot7:getPosY()) - recthelper.getHeight(slot0.rectScroll), 0))
	end
end

function slot0.setComplete(slot0, slot1)
	if slot0.completeValue == slot1 then
		return
	end

	slot0.completeValue = slot1

	gohelper.setActive(slot0.goComplete, slot1)

	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wulu_aizila_forward_paper)
	end
end

function slot0.refreshCost(slot0, slot1)
	if not slot1 then
		gohelper.setActive(slot0.btnInvestigate, false)

		return
	end

	gohelper.setActive(slot0.btnInvestigate, true)

	if slot1.consume <= ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, Season166Config.instance:getSeasonConstNum(slot0.actId, Season166Enum.InfoCostId)) then
		slot0.txtCost.text = string.format("-%s", slot1.consume)
	else
		slot0.txtCost.text = string.format("<color=#BF2E11>-%s</color>", slot1.consume)
	end

	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.imgCost, string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(slot2) and slot5.icon), true)
end

function slot0.updateItemByData(slot0, slot1, slot2, slot3)
	slot4 = slot0:getItem(slot1, slot2)

	table.insert(slot0.detailItems, slot4)
	slot4:setData({
		config = slot1,
		info = slot2,
		isEnd = slot3
	})

	return slot4
end

function slot0.getItem(slot0, slot1, slot2)
	slot3 = nil

	if slot0.recycleItemsDict[slot1.stage <= slot2.stage and 1 or 2] and #slot0.recycleItemsDict[slot3] > 0 then
		return table.remove(slot0.recycleItemsDict[slot3])
	else
		return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0.itemGODict[slot3]), slot0.itemClsDict[slot3], slot3)
	end
end

function slot0.recycleItems(slot0)
	for slot4, slot5 in ipairs(slot0.detailItems) do
		slot0:recycleItem(slot5)
	end

	slot0.detailItems = {}
end

function slot0.recycleItem(slot0, slot1)
	if not slot0.recycleItemsDict[slot1.itemType] then
		slot0.recycleItemsDict[slot2] = {}
	end

	table.insert(slot0.recycleItemsDict[slot2], slot1)
	slot1:onRecycle()
end

function slot0.playTxtFadeInByStage(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.detailItems) do
		slot6:playTxtFadeInByStage(slot1)
	end
end

function slot0.setLockedImgValue(slot0)
	if slot0._imgValue == (Season166Model.instance:getActInfo(slot0.actId) and slot1:getInformationMO(slot0.infoId)).stage / #(Season166Config.instance:getSeasonInfoAnalys(slot0.actId, slot0.infoId) or {}) then
		return
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._imgValue == nil then
		slot0:_setImgValue(slot5)
	else
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._imgValue, slot5, 1, slot0._setImgValue, slot0.playFinishCallBack, slot0, nil, EaseType.Linear)
	end

	slot0._imgValue = slot5
end

function slot0._setImgValue(slot0, slot1)
	slot0.lockedCtrl:GetIndexProp(0, 0)

	slot2 = slot0.lockedCtrl.vector_01
	slot0.lockedCtrl.vector_01 = Vector4.New(slot1, 0.05, 0, 0)

	slot0.lockedCtrl:SetIndexProp(0, 0)
end

function slot0.playFinishCallBack(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0.simageLockedPic:UnLoadImage()
	slot0.simageReportPic:UnLoadImage()
	slot0.simageDetailPic:UnLoadImage()
end

return slot0
