module("modules.logic.rouge.dlc.102.view.RougeCollectionLevelUpView", package.seeall)

local var_0_0 = class("RougeCollectionLevelUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_fullbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_rightbg")
	arg_1_0._simagetopbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_topbg1")
	arg_1_0._simagetopbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_topbg2")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "Title/#txt_dec")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_filter")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_filter/#go_unselect")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_filter/#go_select")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Right/#txt_num")
	arg_1_0._gorightempty = gohelper.findChild(arg_1_0.viewGO, "Right/#go_empty")
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
	RougeCollectionLevelUpListModel.instance:filterCollection()
	arg_5_0:refreshLeft()
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	if RougeCollectionLevelUpListModel.instance:getSelectCount() > arg_6_0.maxLevelUpNum then
		return
	end

	local var_6_0 = RougeCollectionLevelUpListModel.instance:getSelectMoList()
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		table.insert(var_6_1, iter_6_1.uid)
	end

	arg_6_0:sendSelectCollectionLevelUp(var_6_1)
end

function var_0_0.sendSelectCollectionLevelUp(arg_7_0, arg_7_1)
	local var_7_0 = RougeModel.instance:getSeason()

	arg_7_0.callbackId = RougeRpc.instance:sendRougeSelectCollectionLevelUpRequest(var_7_0, arg_7_1 or {}, arg_7_0.onReceiveMsg, arg_7_0)
end

function var_0_0.onReceiveMsg(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshPieceChoiceEvent)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.goCollection = arg_9_0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, arg_9_0._goCollectionContainer)
	arg_9_0.collectionComp = RougeCollectionComp.Get(arg_9_0.goCollection)

	arg_9_0.collectionComp:_editableInitView()
	arg_9_0._simagefullbg:LoadImage("singlebg/rouge/collection/rouge_collection_fullbg.png")
	arg_9_0._simagerightbg:LoadImage("singlebg/rouge/collection/rouge_collection_storebg.png")
	arg_9_0._simagetopbg1:LoadImage("singlebg/rouge/collection/rouge_collection_topmask_01.png")
	arg_9_0._simagetopbg2:LoadImage("singlebg/rouge/collection/rouge_collection_topmask_02.png")

	arg_9_0.leftCollectionItemList = {}
	arg_9_0.rightCollectionItemList = {}
	arg_9_0.selectedUidList = {}
	arg_9_0.baseFilterTagDict = {}
	arg_9_0.extraFilterTagDict = {}
	arg_9_0.goRightItemContainer = gohelper.findChild(arg_9_0.viewGO, "Right/#scroll_view/Viewport/Content")
	arg_9_0.rightItem = arg_9_0.viewContainer:getResInst(RougeEnum.ResPath.CollectionLevelUpRightItem, arg_9_0.goRightItemContainer)

	gohelper.setActive(arg_9_0.rightItem, false)
	arg_9_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLossCollectionChange, arg_9_0.onSelectLossCollectionChange, arg_9_0)
end

function var_0_0.onOpen(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.LossCollectionViewOpen)
	arg_10_0.collectionComp:onOpen()

	arg_10_0.maxLevelUpNum = arg_10_0.viewParam and arg_10_0.viewParam.maxLevelUpNum

	RougeCollectionLevelUpListModel.instance:initList(arg_10_0.maxLevelUpNum, arg_10_0.baseFilterTagDict, arg_10_0.extraFilterTagDict)
	arg_10_0:refreshTitle()
	arg_10_0:refreshLeft()
	arg_10_0:refreshRight()
	arg_10_0:refreshBtn()
	arg_10_0:checkCanLevelUpSpCollectionNum()
end

function var_0_0.checkCanLevelUpSpCollectionNum(arg_11_0)
	local var_11_0 = RougeCollectionLevelUpListModel.instance:getAllMoCount()

	if not var_11_0 or var_11_0 <= 0 then
		local var_11_1 = arg_11_0.viewContainer:getNavigateView()

		var_11_1:setParam({
			true,
			false,
			false
		})
		var_11_1:setOverrideClose(arg_11_0.sendSelectCollectionLevelUp, arg_11_0)
	end
end

function var_0_0.refreshTitle(arg_12_0)
	arg_12_0._txtdec.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougecollectionlevelupview_desc"), arg_12_0.maxLevelUpNum)
end

function var_0_0.refreshLeft(arg_13_0)
	RougeCollectionLevelUpListModel.instance:refresh()
	arg_13_0:refreshFilterBtn()
end

function var_0_0.refreshFilterBtn(arg_14_0)
	local var_14_0 = RougeCollectionLevelUpListModel.instance:isFiltering()

	gohelper.setActive(arg_14_0._gofilterselect, var_14_0)
	gohelper.setActive(arg_14_0._gofilterunselect, not var_14_0)
end

function var_0_0.refreshRight(arg_15_0)
	local var_15_0 = RougeCollectionLevelUpListModel.instance:getSelectCount()

	arg_15_0._txtnum.text = string.format("（<#C69620>%s</color>/%s）", var_15_0, arg_15_0.maxLevelUpNum)

	local var_15_1 = var_15_0 < 1

	gohelper.setActive(arg_15_0._gorightempty, var_15_1)

	local var_15_2 = RougeCollectionLevelUpListModel.instance:getSelectMoList()

	RougeMapHelper.loadItem(arg_15_0.rightItem, RougeCollectionLevelUpRightItem, var_15_2, arg_15_0.rightCollectionItemList)
end

function var_0_0.onClickRightItem(arg_16_0, arg_16_1, arg_16_2)
	RougeCollectionLevelUpListModel.instance:deselectMo(arg_16_2)
end

function var_0_0.refreshBtn(arg_17_0)
	local var_17_0 = RougeCollectionLevelUpListModel.instance:getSelectCount()

	gohelper.setActive(arg_17_0._btnconfirm.gameObject, var_17_0 > 0 and var_17_0 <= arg_17_0.maxLevelUpNum)
end

function var_0_0.onSelectLossCollectionChange(arg_18_0)
	arg_18_0:refreshLeft()
	arg_18_0:refreshRight()
	arg_18_0:refreshBtn()
end

function var_0_0.onClose(arg_19_0)
	arg_19_0.collectionComp:onClose()
	RougeCollectionLevelUpListModel.instance:clear()

	if arg_19_0.callbackId then
		RougeRpc.instance:removeCallbackById(arg_19_0.callbackId)
	end
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0.collectionComp:destroy()
	RougeMapHelper.destroyItemList(arg_20_0.leftCollectionItemList)
	RougeMapHelper.destroyItemList(arg_20_0.rightCollectionItemList)
	arg_20_0._simagefullbg:UnLoadImage()
	arg_20_0._simagerightbg:UnLoadImage()
	arg_20_0._simagetopbg1:UnLoadImage()
	arg_20_0._simagetopbg2:UnLoadImage()
end

return var_0_0
