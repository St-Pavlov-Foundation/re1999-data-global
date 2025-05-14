module("modules.logic.rouge.map.view.collectionabandon.RougeMapCollectionAbandonView", package.seeall)

local var_0_0 = class("RougeMapCollectionAbandonView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_fullbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_rightbg")
	arg_1_0._simagetopbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_topbg1")
	arg_1_0._simagetopbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_topbg2")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "Title/txt_Title")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_dec")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_filter")
	arg_1_0._gofilterselect = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_filter/#go_select")
	arg_1_0._gofilterunselect = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_filter/#go_unselect")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_num")
	arg_1_0._gorightempty = gohelper.findChild(arg_1_0.viewGO, "Right/#go_rightempty")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._goCollectionContainer = gohelper.findChild(arg_1_0.viewGO, "#go_collectioncontainer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btnfilterOnClick(arg_4_0)
	arg_4_0.param = arg_4_0.param or {
		confirmCallback = arg_4_0.onConfirmCallback,
		confirmCallbackObj = arg_4_0,
		baseSelectMap = arg_4_0.baseFilterTagDict,
		extraSelectMap = arg_4_0.extraFilterTagDict
	}

	RougeController.instance:openRougeCollectionFilterView(arg_4_0.param)
end

function var_0_0.onConfirmCallback(arg_5_0, arg_5_1, arg_5_2)
	RougeCollectionHelper.removeInValidItem(arg_5_1)
	RougeCollectionHelper.removeInValidItem(arg_5_2)
	RougeLossCollectionListModel.instance:filterCollection()
	arg_5_0:refreshLeft()
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	if RougeLossCollectionListModel.instance:getSelectCount() < arg_6_0.lossCount then
		return
	end

	arg_6_0.callbackId = RougeRpc.instance:sendRougeSelectLostCollectionRequest(RougeLossCollectionListModel.instance:getSelectMoList(), arg_6_0.onReceiveMsg, arg_6_0)
end

function var_0_0.onReceiveMsg(arg_7_0)
	arg_7_0.callbackId = nil

	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.goCollection = arg_8_0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, arg_8_0._goCollectionContainer)
	arg_8_0.collectionComp = RougeCollectionComp.Get(arg_8_0.goCollection)

	arg_8_0.collectionComp:_editableInitView()
	arg_8_0._simagefullbg:LoadImage("singlebg/rouge/collection/rouge_collection_fullbg.png")
	arg_8_0._simagerightbg:LoadImage("singlebg/rouge/collection/rouge_collection_storebg.png")
	arg_8_0._simagetopbg1:LoadImage("singlebg/rouge/collection/rouge_collection_topmask_01.png")
	arg_8_0._simagetopbg2:LoadImage("singlebg/rouge/collection/rouge_collection_topmask_02.png")

	arg_8_0.leftCollectionItemList = {}
	arg_8_0.rightCollectionItemList = {}
	arg_8_0.selectedUidList = {}
	arg_8_0.baseFilterTagDict = {}
	arg_8_0.extraFilterTagDict = {}
	arg_8_0.goRightItemContainer = gohelper.findChild(arg_8_0.viewGO, "Right/#scroll_view/Viewport/Content")
	arg_8_0.rightItem = arg_8_0.viewContainer:getResInst(RougeMapEnum.CollectionRightItemRes, arg_8_0.goRightItemContainer)

	gohelper.setActive(arg_8_0.rightItem, false)
	arg_8_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLossCollectionChange, arg_8_0.onSelectLossCollectionChange, arg_8_0)
	NavigateMgr.instance:addEscape(arg_8_0.viewName, RougeMapHelper.blockEsc)
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.LossCollectionViewOpen)
	arg_9_0.collectionComp:onOpen()

	arg_9_0.lossType = arg_9_0.viewParam.lossType
	arg_9_0.lossCount = arg_9_0.viewParam.lostNum
	arg_9_0.filterUnique = arg_9_0.viewParam.filterUnique
	arg_9_0.collections = arg_9_0.viewParam.collections or RougeCollectionModel.instance:getAllCollections()

	RougeLossCollectionListModel.instance:setLossType(arg_9_0.lossType)
	RougeLossCollectionListModel.instance:initList(arg_9_0.lossCount, arg_9_0.collections, arg_9_0.baseFilterTagDict, arg_9_0.extraFilterTagDict, arg_9_0.filterUnique)
	arg_9_0:refreshTitle()
	arg_9_0:refreshLeft()
	arg_9_0:refreshRight()
	arg_9_0:refreshBtn()
end

function var_0_0.refreshTitle(arg_10_0)
	if arg_10_0.lossType == RougeMapEnum.LossType.Copy then
		arg_10_0._txttitle.text = luaLang("p_rougecollectionabandonview_txt_copy")
		arg_10_0._txtdec.text = luaLang("p_rougecollectionabandonview_txt_copy1")
	elseif arg_10_0.lossType == RougeMapEnum.LossType.AbandonSp then
		arg_10_0._txttitle.text = luaLang("p_rougecollectionabandonview_txt_losssp")
		arg_10_0._txtdec.text = luaLang("p_rougecollectionabandonview_txt_losssp1")
	else
		arg_10_0._txttitle.text = luaLang("p_rougecollectionabandonview_txt_dec1")
		arg_10_0._txtdec.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge_loss_title"), arg_10_0.lossCount)
	end
end

function var_0_0.refreshLeft(arg_11_0)
	RougeLossCollectionListModel.instance:refresh()
	arg_11_0:refreshFilterBtn()
end

function var_0_0.refreshFilterBtn(arg_12_0)
	local var_12_0 = RougeLossCollectionListModel.instance:isFiltering()

	gohelper.setActive(arg_12_0._gofilterselect, var_12_0)
	gohelper.setActive(arg_12_0._gofilterunselect, not var_12_0)
end

function var_0_0.refreshRight(arg_13_0)
	local var_13_0 = RougeLossCollectionListModel.instance:getSelectCount()

	arg_13_0._txtnum.text = string.format("（<#C69620>%s</color>/%s）", var_13_0, arg_13_0.lossCount)

	local var_13_1 = var_13_0 < 1

	gohelper.setActive(arg_13_0._gorightempty, var_13_1)

	local var_13_2 = RougeLossCollectionListModel.instance:getSelectMoList()

	RougeMapHelper.loadItem(arg_13_0.rightItem, RougeMapCollectionLossRightItem, var_13_2, arg_13_0.rightCollectionItemList)
end

function var_0_0.onClickRightItem(arg_14_0, arg_14_1, arg_14_2)
	RougeLossCollectionListModel.instance:deselectMo(arg_14_2)
end

function var_0_0.refreshBtn(arg_15_0)
	gohelper.setActive(arg_15_0._btnconfirm.gameObject, RougeLossCollectionListModel.instance:getSelectCount() >= arg_15_0.lossCount)
end

function var_0_0.onSelectLossCollectionChange(arg_16_0)
	arg_16_0:refreshLeft()
	arg_16_0:refreshRight()
	arg_16_0:refreshBtn()
end

function var_0_0.onClose(arg_17_0)
	arg_17_0.collectionComp:onClose()
	RougeLossCollectionListModel.instance:clear()

	if arg_17_0.callbackId then
		RougeRpc.instance:removeCallbackById(arg_17_0.callbackId)
	end
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0.collectionComp:destroy()
	RougeMapHelper.destroyItemList(arg_18_0.leftCollectionItemList)
	RougeMapHelper.destroyItemList(arg_18_0.rightCollectionItemList)
	arg_18_0._simagefullbg:UnLoadImage()
	arg_18_0._simagerightbg:UnLoadImage()
	arg_18_0._simagetopbg1:UnLoadImage()
	arg_18_0._simagetopbg2:UnLoadImage()
end

return var_0_0
