module("modules.logic.rouge.dlc.103.view.RougeBossCollectionDropView", package.seeall)

local var_0_0 = class("RougeBossCollectionDropView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagemaskbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_maskbg")
	arg_1_0._gotitletip = gohelper.findChild(arg_1_0.viewGO, "Title/txt_Tips")
	arg_1_0._scrollView = gohelper.findChildScrollRect(arg_1_0.viewGO, "scroll_view")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_confirm")
	arg_1_0._gorefresh = gohelper.findChild(arg_1_0.viewGO, "#go_refresh")
	arg_1_0._txtrefresh = gohelper.findChildText(arg_1_0.viewGO, "#go_refresh/#txt_refresh")
	arg_1_0._gorefreshactivebg = gohelper.findChild(arg_1_0.viewGO, "#go_refresh/#go_activebg")
	arg_1_0._gorefreshdisablebg = gohelper.findChild(arg_1_0.viewGO, "#go_refresh/#go_disablebg")
	arg_1_0._gorougefunctionitem2 = gohelper.findChild(arg_1_0.viewGO, "#go_rougefunctionitem2")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txtselectnum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#txt_num")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._btninherit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "layout/#go_rougemapbaseinherit/#btn_inherit")
	arg_1_0._godistortrule = gohelper.findChild(arg_1_0.viewGO, "Left/#go_distortrule")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btninherit:AddClickListener(arg_2_0._btninheritOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btninherit:RemoveClickListener()
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

function var_0_0.onClickBg(arg_8_0)
	if arg_8_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		return
	end

	arg_8_0:closeThis()
end

function var_0_0._btninheritOnClick(arg_9_0)
	arg_9_0._isShowMonsterRule = not arg_9_0._isShowMonsterRule

	arg_9_0:refreshInheritBtn()
	RougeController.instance:dispatchEvent(RougeEvent.ShowMonsterRuleDesc, arg_9_0._isShowMonsterRule)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.bgClick = gohelper.findChildClickWithDefaultAudio(arg_10_0.viewGO, "#simage_maskbg")

	arg_10_0.bgClick:AddClickListener(arg_10_0.onClickBg, arg_10_0)

	arg_10_0.viewPortClick = gohelper.findChildClickWithDefaultAudio(arg_10_0.viewGO, "scroll_view/Viewport")

	arg_10_0.viewPortClick:AddClickListener(arg_10_0.onClickBg, arg_10_0)
	arg_10_0._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")

	arg_10_0.txtTips = gohelper.findChildText(arg_10_0.viewGO, "Title/txt_Tips")
	arg_10_0.txtTitle = gohelper.findChildText(arg_10_0.viewGO, "Title/txt_Title")
	arg_10_0.goConfirmBtn = arg_10_0._btnconfirm.gameObject

	gohelper.setActive(arg_10_0._gocollectionitem, false)

	arg_10_0.selectPosList = {}
	arg_10_0.collectionItemList = {}

	arg_10_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectDropChange, arg_10_0.onSelectDropChange, arg_10_0)
	arg_10_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_10_0.onUpdateMapInfo, arg_10_0)

	arg_10_0.goCollection = arg_10_0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, arg_10_0._gorougefunctionitem2)
	arg_10_0.collectionComp = RougeCollectionComp.Get(arg_10_0.goCollection)

	NavigateMgr.instance:addEscape(arg_10_0.viewName, RougeMapHelper.blockEsc)
	arg_10_0:openSubView(RougeMapAttributeComp, nil, arg_10_0._godistortrule)

	arg_10_0._goselectinherit = gohelper.findChild(arg_10_0.viewGO, "layout/#go_rougemapbaseinherit/#btn_inherit/circle/select")
	arg_10_0._isShowMonsterRule = true
end

function var_0_0.onSelectDropChange(arg_11_0)
	arg_11_0:refreshConfirmBtn()
	arg_11_0:refreshTopRight()
end

function var_0_0.onUpdateParam(arg_12_0)
	arg_12_0:onOpen()
end

function var_0_0.initData(arg_13_0)
	arg_13_0.viewEnum = arg_13_0.viewParam.viewEnum
	arg_13_0.collectionList = arg_13_0.viewParam.collectionList
	arg_13_0.monsterRuleList = arg_13_0.viewParam.monsterRuleList

	if arg_13_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		arg_13_0.canSelectCount = arg_13_0.viewParam.canSelectCount
		arg_13_0.dropRandomNum = arg_13_0.viewParam.dropRandomNum
	end
end

function var_0_0.onOpen(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)
	arg_14_0:initData()
	arg_14_0:refreshUI()
	arg_14_0.collectionComp:onOpen()
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:refreshTitle()
	arg_15_0:refreshCollection()
	arg_15_0:refreshConfirmBtn()
	arg_15_0:refreshRefreshBtn()
	arg_15_0:refreshInheritBtn()
	arg_15_0:refreshTopRight()
end

function var_0_0.refreshTitle(arg_16_0)
	if arg_16_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		arg_16_0.txtTitle.text = luaLang("rougebosscollectionselectview_txt_title")
		arg_16_0.txtTips.text = string.gsub(luaLang("rougebosscollectionselectview_txt_tips"), "▩1%%s", arg_16_0.canSelectCount)

		gohelper.setActive(arg_16_0._gotitletip, true)
	else
		arg_16_0.txtTips.text = luaLang("rougecollectionselectview_txt_get_Tips")
		arg_16_0.txtTitle.text = luaLang("rougebosscollectionselectview_txt_title")

		gohelper.setActive(arg_16_0._gotitletip, false)
	end
end

function var_0_0.refreshCollection(arg_17_0)
	local var_17_0 = arg_17_0.collectionList or {}
	local var_17_1 = arg_17_0.monsterRuleList or {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_2 = arg_17_0.collectionItemList[iter_17_0]

		if not var_17_2 then
			var_17_2 = RougeBossCollectionDropItem.New()

			local var_17_3 = gohelper.cloneInPlace(arg_17_0._gocollectionitem)

			var_17_2:init(var_17_3, arg_17_0)
			var_17_2:setParentScroll(arg_17_0._scrollView.gameObject)
			table.insert(arg_17_0.collectionItemList, var_17_2)
		end

		var_17_2:show()
		var_17_2:update(iter_17_0, iter_17_1, var_17_1[iter_17_0], arg_17_0._isShowMonsterRule)
	end

	for iter_17_2 = #var_17_0 + 1, #arg_17_0.collectionItemList do
		arg_17_0.collectionItemList[iter_17_2]:hide()
	end

	arg_17_0._scrollView.horizontalNormalizedPosition = 0
end

function var_0_0.refreshConfirmBtn(arg_18_0)
	if arg_18_0.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		gohelper.setActive(arg_18_0.goConfirmBtn, false)
		gohelper.setActive(arg_18_0._gotips, true)

		return
	end

	gohelper.setActive(arg_18_0._gotips, false)
	gohelper.setActive(arg_18_0.goConfirmBtn, #arg_18_0.selectPosList >= arg_18_0.canSelectCount)
end

function var_0_0.refreshRefreshBtn(arg_19_0)
	arg_19_0.canClickRefresh = false

	if arg_19_0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(arg_19_0._gorefresh, false)

		return
	end

	local var_19_0 = RougeMapModel.instance:getMonsterRuleRemainCanFreshNum()

	arg_19_0.canClickRefresh = var_19_0 and var_19_0 > 0

	gohelper.setActive(arg_19_0._gorefresh, true)
	gohelper.setActive(arg_19_0._gorefreshactivebg, arg_19_0.canClickRefresh)
	gohelper.setActive(arg_19_0._gorefreshdisablebg, not arg_19_0.canClickRefresh)

	arg_19_0._txtrefresh.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougebosscollectionselectview_refresh"), var_19_0)
end

function var_0_0.refreshInheritBtn(arg_20_0)
	gohelper.setActive(arg_20_0._goselectinherit, arg_20_0._isShowMonsterRule)
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

function var_0_0.onUpdateMapInfo(arg_24_0)
	local var_24_0 = RougeMapModel.instance:getCurInteractiveJson()

	if not var_24_0 then
		return
	end

	arg_24_0.collectionList = var_24_0 and var_24_0.dropCollectList
	arg_24_0.monsterRuleList = var_24_0 and var_24_0.dropCollectMonsterRuleList
	arg_24_0.selectPosList = {}

	arg_24_0:refreshUI()
end

function var_0_0.clearSelectCallback(arg_25_0)
	if arg_25_0.selectCallbackId then
		RougeRpc.instance:removeCallbackById(arg_25_0.selectCallbackId)

		arg_25_0.selectCallbackId = nil
	end
end

function var_0_0.clearRefreshCallback(arg_26_0)
	if arg_26_0.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(arg_26_0.refreshCallbackId)

		arg_26_0.refreshCallbackId = nil
	end
end

function var_0_0.onClose(arg_27_0)
	arg_27_0:clearSelectCallback()
	arg_27_0:clearRefreshCallback()
	arg_27_0.collectionComp:onClose()

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.collectionItemList) do
		iter_27_1:onClose()
	end

	tabletool.clear(arg_27_0.selectPosList)
end

function var_0_0.onDestroyView(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.collectionItemList) do
		iter_28_1:destroy()
	end

	arg_28_0.collectionItemList = nil

	arg_28_0._simagemaskbg:UnLoadImage()
	arg_28_0.collectionComp:destroy()
	arg_28_0.bgClick:RemoveClickListener()
	arg_28_0.viewPortClick:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_28_0.closeThis, arg_28_0)
end

return var_0_0
