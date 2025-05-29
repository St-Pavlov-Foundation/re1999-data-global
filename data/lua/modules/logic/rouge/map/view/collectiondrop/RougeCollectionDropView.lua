module("modules.logic.rouge.map.view.collectiondrop.RougeCollectionDropView", package.seeall)

local var_0_0 = class("RougeCollectionDropView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskbg")
	arg_1_0._gotitletip = gohelper.findChild(arg_1_0.viewGO, "Title/txt_Tips")
	arg_1_0._scrollView = gohelper.findChildScrollRect(arg_1_0.viewGO, "scroll_view")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._btnrefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#btn_refresh")
	arg_1_0._gorefreshactivebg = gohelper.findChild(arg_1_0.viewGO, "layout/#btn_refresh/#go_activebg")
	arg_1_0._gorefreshdisablebg = gohelper.findChild(arg_1_0.viewGO, "layout/#btn_refresh/#go_disablebg")
	arg_1_0._gorougefunctionitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_rougefunctionitem2")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txtselectnum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#txt_num")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btnrefresh:AddClickListener(arg_2_0._btnrefreshOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btnrefresh:RemoveClickListener()
end

function var_0_0._btnconfirmOnClick(arg_4_0)
	if arg_4_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		arg_4_0:closeThis()

		return
	end

	if #arg_4_0.selectPosList < 1 then
		return
	end

	arg_4_0:clearSelectCallback()

	arg_4_0.selectCallbackId = RougeRpc.instance:sendRougeSelectDropRequest(arg_4_0.selectPosList, arg_4_0.onReceiveSelect, arg_4_0)
end

function var_0_0.onReceiveSelect(arg_5_0)
	arg_5_0.refreshCallbackId = nil

	arg_5_0:delayCloseView()
end

function var_0_0.delayCloseView(arg_6_0)
	UIBlockMgr.instance:startBlock(arg_6_0.viewName)
	TaskDispatcher.cancelTask(arg_6_0._closeView, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._closeView, arg_6_0, RougeMapEnum.CollectionChangeAnimDuration)
end

function var_0_0._closeView(arg_7_0)
	UIBlockMgr.instance:endBlock(arg_7_0.viewName)
	arg_7_0:closeThis()
end

function var_0_0._btnrefreshOnClick(arg_8_0)
	if not arg_8_0.canClickRefresh then
		GameFacade.showToast(ToastEnum.RougeNotRefreshCollection)

		return
	end

	arg_8_0:clearRefreshCallback()

	arg_8_0.refreshCallbackId = RougeRpc.instance:sendRougeRandomDropRequest(arg_8_0.onReceiveRefresh, arg_8_0)
end

function var_0_0.onReceiveRefresh(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)

	arg_9_0.refreshCallbackId = nil

	local var_9_0 = RougeMapModel.instance:getCurInteractiveJson()

	arg_9_0.collectionList = var_9_0.dropCollectList
	arg_9_0.canSelectCount = var_9_0.dropSelectNum
	arg_9_0.dropRandomNum = var_9_0.dropRandomNum

	arg_9_0:refreshUI()
	tabletool.clear(arg_9_0.selectPosList)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
end

function var_0_0.onClickBg(arg_10_0)
	if arg_10_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		return
	end

	arg_10_0:closeThis()
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.bgClick = gohelper.findChildClickWithDefaultAudio(arg_11_0.viewGO, "#simage_maskbg")

	arg_11_0.bgClick:AddClickListener(arg_11_0.onClickBg, arg_11_0)

	arg_11_0.viewPortClick = gohelper.findChildClickWithDefaultAudio(arg_11_0.viewGO, "scroll_view/Viewport")

	arg_11_0.viewPortClick:AddClickListener(arg_11_0.onClickBg, arg_11_0)
	arg_11_0._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")

	arg_11_0.txtTips = gohelper.findChildText(arg_11_0.viewGO, "Title/txt_Tips")
	arg_11_0.txtTitle = gohelper.findChildText(arg_11_0.viewGO, "Title/txt_Title")
	arg_11_0.goRefreshBtn = arg_11_0._btnrefresh.gameObject
	arg_11_0.goConfirmBtn = arg_11_0._btnconfirm.gameObject

	gohelper.setActive(arg_11_0._gocollectionitem, false)

	arg_11_0.selectPosList = {}
	arg_11_0.collectionItemList = {}

	arg_11_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectDropChange, arg_11_0.onSelectDropChange, arg_11_0)

	arg_11_0.goCollection = arg_11_0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, arg_11_0._gorougefunctionitem2)
	arg_11_0.collectionComp = RougeCollectionComp.Get(arg_11_0.goCollection)

	NavigateMgr.instance:addEscape(arg_11_0.viewName, RougeMapHelper.blockEsc)
end

function var_0_0.onSelectDropChange(arg_12_0)
	arg_12_0:refreshConfirmBtn()
	arg_12_0:refreshTopRight()
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:onOpen()
end

function var_0_0.initData(arg_14_0)
	arg_14_0.viewEnum = arg_14_0.viewParam.viewEnum
	arg_14_0.collectionList = arg_14_0.viewParam.collectionList

	if arg_14_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		arg_14_0.canSelectCount = arg_14_0.viewParam.canSelectCount
		arg_14_0.dropRandomNum = arg_14_0.viewParam.dropRandomNum
	end
end

function var_0_0.onOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)
	arg_15_0:initData()
	arg_15_0:refreshUI()
	arg_15_0.collectionComp:onOpen()
end

function var_0_0.refreshUI(arg_16_0)
	arg_16_0:refreshTitle()
	arg_16_0:refreshCollection()
	arg_16_0:refreshConfirmBtn()
	arg_16_0:refreshRefreshBtn()
	arg_16_0:refreshTopRight()
end

function var_0_0.refreshTitle(arg_17_0)
	if arg_17_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		arg_17_0.txtTitle.text = luaLang("rougecollectionselectview_txt_Title")
		arg_17_0.txtTips.text = string.gsub(luaLang("rougecollectionselectview_txt_Tips"), "▩1%%s", arg_17_0.canSelectCount)

		gohelper.setActive(arg_17_0._gotitletip, true)
	else
		arg_17_0.txtTips.text = luaLang("rougecollectionselectview_txt_get_Tips")
		arg_17_0.txtTitle.text = luaLang("rougecollectionselectview_txt_get_Title")

		gohelper.setActive(arg_17_0._gotitletip, false)
	end
end

function var_0_0.refreshCollection(arg_18_0)
	local var_18_0 = arg_18_0.collectionList or {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_1 = arg_18_0.collectionItemList[iter_18_0]

		if not var_18_1 then
			var_18_1 = RougeCollectionDropItem.New()

			local var_18_2 = gohelper.cloneInPlace(arg_18_0._gocollectionitem)

			var_18_1:init(var_18_2, arg_18_0)
			var_18_1:setParentScroll(arg_18_0._scrollView.gameObject)
			table.insert(arg_18_0.collectionItemList, var_18_1)
		end

		var_18_1:show()
		var_18_1:update(iter_18_0, iter_18_1)
	end

	for iter_18_2 = #var_18_0 + 1, #arg_18_0.collectionItemList do
		arg_18_0.collectionItemList[iter_18_2]:hide()
	end

	arg_18_0._scrollView.horizontalNormalizedPosition = 0
end

function var_0_0.refreshConfirmBtn(arg_19_0)
	if arg_19_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		gohelper.setActive(arg_19_0.goConfirmBtn, false)
		gohelper.setActive(arg_19_0._gotips, true)

		return
	end

	gohelper.setActive(arg_19_0._gotips, false)
	gohelper.setActive(arg_19_0.goConfirmBtn, #arg_19_0.selectPosList >= arg_19_0.canSelectCount)
end

function var_0_0.refreshRefreshBtn(arg_20_0)
	arg_20_0.canClickRefresh = false

	if arg_20_0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(arg_20_0.goRefreshBtn, false)

		return
	end

	local var_20_0 = RougeMapModel.instance:getCurNode()
	local var_20_1 = var_20_0 and var_20_0:getEventCo()
	local var_20_2 = var_20_1 and var_20_1.type

	if not RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockFightDropRefresh, var_20_2) then
		gohelper.setActive(arg_20_0.goRefreshBtn, false)

		return
	end

	arg_20_0.canClickRefresh = RougeMapConfig.instance:getFightDropMaxRefreshNum(var_20_2) - arg_20_0.dropRandomNum > 0

	gohelper.setActive(arg_20_0.goRefreshBtn, true)
	gohelper.setActive(arg_20_0._gorefreshactivebg, arg_20_0.canClickRefresh)
	gohelper.setActive(arg_20_0._gorefreshdisablebg, not arg_20_0.canClickRefresh)
end

function var_0_0.refreshTopRight(arg_21_0)
	if arg_21_0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(arg_21_0._gotopright, false)

		return
	end

	gohelper.setActive(arg_21_0._gotopright, true)

	arg_21_0._txtselectnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge_drop_select"), #arg_21_0.selectPosList, arg_21_0.canSelectCount)
end

function var_0_0.selectPos(arg_22_0, arg_22_1)
	if arg_22_0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		return false
	end

	local var_22_0 = tabletool.indexOf(arg_22_0.selectPosList, arg_22_1)

	if var_22_0 then
		table.remove(arg_22_0.selectPosList, var_22_0)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)

		return
	end

	if arg_22_0.canSelectCount > 1 then
		if #arg_22_0.selectPosList >= arg_22_0.canSelectCount then
			return
		end

		table.insert(arg_22_0.selectPosList, arg_22_1)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
	end

	table.remove(arg_22_0.selectPosList)
	table.insert(arg_22_0.selectPosList, arg_22_1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
end

function var_0_0.isSelect(arg_23_0, arg_23_1)
	return tabletool.indexOf(arg_23_0.selectPosList, arg_23_1)
end

function var_0_0.clearSelectCallback(arg_24_0)
	if arg_24_0.selectCallbackId then
		RougeRpc.instance:removeCallbackById(arg_24_0.selectCallbackId)

		arg_24_0.selectCallbackId = nil
	end
end

function var_0_0.clearRefreshCallback(arg_25_0)
	if arg_25_0.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(arg_25_0.refreshCallbackId)

		arg_25_0.refreshCallbackId = nil
	end
end

function var_0_0.onClose(arg_26_0)
	arg_26_0:clearSelectCallback()
	arg_26_0:clearRefreshCallback()
	arg_26_0.collectionComp:onClose()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.collectionItemList) do
		iter_26_1:onClose()
	end

	tabletool.clear(arg_26_0.selectPosList)
end

function var_0_0.onDestroyView(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.collectionItemList) do
		iter_27_1:destroy()
	end

	arg_27_0.collectionItemList = nil

	arg_27_0._simagemaskbg:UnLoadImage()
	arg_27_0.collectionComp:destroy()
	arg_27_0.bgClick:RemoveClickListener()
	arg_27_0.viewPortClick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_27_0.closeThis, arg_27_0)
end

return var_0_0
