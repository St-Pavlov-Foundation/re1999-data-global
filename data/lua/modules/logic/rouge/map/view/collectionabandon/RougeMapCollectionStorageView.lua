module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionStorageView", package.seeall)

slot0 = class("RougeMapCollectionStorageView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_fullbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_rightbg")
	slot0._simagetopbg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_topbg1")
	slot0._simagetopbg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_topbg2")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "Title/#txt_dec")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_filter")
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "Left/#btn_filter/#go_unselect")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "Left/#btn_filter/#go_select")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Right/#txt_num")
	slot0._gorightempty = gohelper.findChild(slot0.viewGO, "Right/#go_empty")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._goCollectionContainer = gohelper.findChild(slot0.viewGO, "#go_collectioncontainer")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfilter:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btnfilterOnClick(slot0)
	slot0.param = slot0.param or {
		confirmCallback = slot0.onConfirmCallback,
		confirmCallbackObj = slot0,
		baseSelectMap = slot0.baseFilterTagDict,
		extraSelectMap = slot0.extraFilterTagDict
	}

	RougeController.instance:openRougeCollectionFilterView(slot0.param)
end

function slot0.onConfirmCallback(slot0, slot1, slot2)
	RougeCollectionHelper.removeInValidItem(slot1)
	RougeCollectionHelper.removeInValidItem(slot2)
	RougeLossCollectionListModel.instance:filterCollection()
	slot0:refreshLeft()
end

function slot0._btnconfirmOnClick(slot0)
	if RougeLossCollectionListModel.instance:getSelectCount() < slot0.lossCount then
		return
	end

	slot0.callbackId = RougeRpc.instance:sendRougeSelectLostCollectionRequest(RougeLossCollectionListModel.instance:getSelectMoList(), slot0.onReceiveMsg, slot0)
end

function slot0.onReceiveMsg(slot0)
	slot0.callbackId = nil

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.goCollection = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, slot0._goCollectionContainer)
	slot0.collectionComp = RougeCollectionComp.Get(slot0.goCollection)

	slot0.collectionComp:_editableInitView()
	slot0._simagefullbg:LoadImage("singlebg/rouge/collection/rouge_collection_fullbg.png")
	slot0._simagerightbg:LoadImage("singlebg/rouge/collection/rouge_collection_storebg.png")
	slot0._simagetopbg1:LoadImage("singlebg/rouge/collection/rouge_collection_topmask_01.png")
	slot0._simagetopbg2:LoadImage("singlebg/rouge/collection/rouge_collection_topmask_02.png")

	slot0.leftCollectionItemList = {}
	slot0.rightCollectionItemList = {}
	slot0.selectedUidList = {}
	slot0.baseFilterTagDict = {}
	slot0.extraFilterTagDict = {}
	slot0.goRightItemContainer = gohelper.findChild(slot0.viewGO, "Right/#scroll_view/Viewport/Content")
	slot0.rightItem = slot0.viewContainer:getResInst(RougeMapEnum.CollectionRightItemRes, slot0.goRightItemContainer)

	gohelper.setActive(slot0.rightItem, false)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLossCollectionChange, slot0.onSelectLossCollectionChange, slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, RougeMapHelper.blockEsc)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.LossCollectionViewOpen)
	slot0.collectionComp:onOpen()

	slot0.lossCount = slot0.viewParam and slot0.viewParam.lossCount or 1
	slot0.collections = slot0.viewParam and slot0.viewParam.collections
	slot0.collections = slot0.collections or RougeCollectionModel.instance:getAllCollections()

	RougeLossCollectionListModel.instance:setLossType(RougeMapEnum.LossType.Storage)
	RougeLossCollectionListModel.instance:initList(slot0.lossCount, slot0.collections, slot0.baseFilterTagDict, slot0.extraFilterTagDict, true)
	slot0:refreshTitle()
	slot0:refreshLeft()
	slot0:refreshRight()
	slot0:refreshBtn()
end

function slot0.refreshTitle(slot0)
	slot0._txtdec.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_storage_title"), slot0.lossCount)
end

function slot0.refreshLeft(slot0)
	RougeLossCollectionListModel.instance:refresh()
	slot0:refreshFilterBtn()
end

function slot0.refreshFilterBtn(slot0)
	slot1 = RougeLossCollectionListModel.instance:isFiltering()

	gohelper.setActive(slot0._gofilterselect, slot1)
	gohelper.setActive(slot0._gofilterunselect, not slot1)
end

function slot0.refreshRight(slot0)
	slot1 = RougeLossCollectionListModel.instance:getSelectCount()
	slot0._txtnum.text = string.format("（<#C69620>%s</color>/%s）", slot1, slot0.lossCount)

	gohelper.setActive(slot0._gorightempty, slot1 < 1)
	RougeMapHelper.loadItem(slot0.rightItem, RougeMapCollectionLossRightItem, RougeLossCollectionListModel.instance:getSelectMoList(), slot0.rightCollectionItemList)
end

function slot0.onClickRightItem(slot0, slot1, slot2)
	RougeLossCollectionListModel.instance:deselectMo(slot2)
end

function slot0.refreshBtn(slot0)
	gohelper.setActive(slot0._btnconfirm.gameObject, slot0.lossCount <= RougeLossCollectionListModel.instance:getSelectCount())
end

function slot0.onSelectLossCollectionChange(slot0)
	slot0:refreshLeft()
	slot0:refreshRight()
	slot0:refreshBtn()
end

function slot0.onClose(slot0)
	slot0.collectionComp:onClose()
	RougeLossCollectionListModel.instance:clear()

	if slot0.callbackId then
		RougeRpc.instance:removeCallbackById(slot0.callbackId)
	end
end

function slot0.onDestroyView(slot0)
	slot0.collectionComp:destroy()
	RougeMapHelper.destroyItemList(slot0.leftCollectionItemList)
	RougeMapHelper.destroyItemList(slot0.rightCollectionItemList)
	slot0._simagefullbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simagetopbg1:UnLoadImage()
	slot0._simagetopbg2:UnLoadImage()
end

return slot0
