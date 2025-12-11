module("modules.logic.versionactivity2_7.act191.view.Act191CollectionChangeView", package.seeall)

local var_0_0 = class("Act191CollectionChangeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnQuickAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_container/#btn_QuickAdd")
	arg_1_0._goQuickGray = gohelper.findChild(arg_1_0.viewGO, "left_container/#btn_QuickAdd/#go_QuickGray")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "left_container/scroll_collection/Viewport/#go_Content")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "right_container/#go_Empty")
	arg_1_0._goHas = gohelper.findChild(arg_1_0.viewGO, "right_container/#go_Has")
	arg_1_0._goChangeItem = gohelper.findChild(arg_1_0.viewGO, "right_container/#go_Has/#go_ChangeItem")
	arg_1_0._goLayout = gohelper.findChild(arg_1_0.viewGO, "right_container/#go_Has/#go_Layout")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "right_container/title/#txt_Title")
	arg_1_0._btnNext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#btn_Next")
	arg_1_0._txtRemainTimes = gohelper.findChildText(arg_1_0.viewGO, "right_container/#txt_RemainTimes")
	arg_1_0._btnExchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#btn_Exchange")
	arg_1_0._btnUpgrade = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#btn_Upgrade")
	arg_1_0._goCollectionInfo = gohelper.findChild(arg_1_0.viewGO, "right_container/#go_CollectionInfo")
	arg_1_0._simageCIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "right_container/#go_CollectionInfo/#simage_CIcon")
	arg_1_0._txtCName = gohelper.findChildText(arg_1_0.viewGO, "right_container/#go_CollectionInfo/#txt_CName")
	arg_1_0._txtCDesc = gohelper.findChildText(arg_1_0.viewGO, "right_container/#go_CollectionInfo/scroll_desc/Viewport/go_desccontent/#txt_CDesc")
	arg_1_0._goCTag1 = gohelper.findChild(arg_1_0.viewGO, "right_container/#go_CollectionInfo/tag/#go_CTag1")
	arg_1_0._txtCTag1 = gohelper.findChildText(arg_1_0.viewGO, "right_container/#go_CollectionInfo/tag/#go_CTag1/#txt_CTag1")
	arg_1_0._goCTag2 = gohelper.findChild(arg_1_0.viewGO, "right_container/#go_CollectionInfo/tag/#go_CTag2")
	arg_1_0._txtCTag2 = gohelper.findChildText(arg_1_0.viewGO, "right_container/#go_CollectionInfo/tag/#go_CTag2/#txt_CTag2")
	arg_1_0._btnAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right_container/#go_CollectionInfo/#btn_Add")
	arg_1_0._txtAdd = gohelper.findChildText(arg_1_0.viewGO, "right_container/#go_CollectionInfo/#btn_Add/#txt_Add")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnQuickAdd:AddClickListener(arg_2_0._btnQuickAddOnClick, arg_2_0)
	arg_2_0._btnNext:AddClickListener(arg_2_0._btnNextOnClick, arg_2_0)
	arg_2_0._btnExchange:AddClickListener(arg_2_0._btnExchangeOnClick, arg_2_0)
	arg_2_0._btnUpgrade:AddClickListener(arg_2_0._btnUpgradeOnClick, arg_2_0)
	arg_2_0._btnAdd:AddClickListener(arg_2_0._btnAddOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnQuickAdd:RemoveClickListener()
	arg_3_0._btnNext:RemoveClickListener()
	arg_3_0._btnExchange:RemoveClickListener()
	arg_3_0._btnUpgrade:RemoveClickListener()
	arg_3_0._btnAdd:RemoveClickListener()
end

function var_0_0._btnAddOnClick(arg_4_0)
	if arg_4_0.showItemUid then
		arg_4_0:onClickCollectionAdd()
	end
end

function var_0_0._btnExchangeOnClick(arg_5_0)
	local var_5_0 = {}

	for iter_5_0 = 1, #arg_5_0.selectItemUidList do
		var_5_0[iter_5_0] = arg_5_0.selectItemUidList[iter_5_0]
	end

	Activity191Rpc.instance:sendSelect191ReplaceEventRequest(arg_5_0.actId, var_5_0, arg_5_0.replaceReply, arg_5_0)
end

function var_0_0._btnUpgradeOnClick(arg_6_0)
	local var_6_0 = {}

	for iter_6_0 = 1, #arg_6_0.selectItemUidList do
		var_6_0[iter_6_0] = arg_6_0.selectItemUidList[iter_6_0]
	end

	Activity191Rpc.instance:sendSelect191UpgradeEventRequest(arg_6_0.actId, var_6_0, arg_6_0.upgradeReply, arg_6_0)
end

function var_0_0._btnQuickAddOnClick(arg_7_0)
	arg_7_0.quickAdd = not arg_7_0.quickAdd

	if arg_7_0.quickAdd then
		arg_7_0.showItemUid = nil
		arg_7_0.showItemId = nil

		arg_7_0:refreshCollectionFrame()
		arg_7_0:refreshCollectionInfo()
	end

	gohelper.setActive(arg_7_0._goQuickGray, not arg_7_0.quickAdd)
end

function var_0_0._btnNextOnClick(arg_8_0)
	Activity191Rpc.instance:sendEnd191ReplaceEventRequest(arg_8_0.actId)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	SkillHelper.addHyperLinkClick(arg_9_0._txtCDesc)

	arg_9_0.anim = arg_9_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_9_0.actId = Activity191Model.instance:getCurActId()
	arg_9_0.quickAdd = false
	arg_9_0.selectItemUidList = {}
	arg_9_0.selectItemIdList = {}
	arg_9_0.collectionItemList = {}

	arg_9_0:initAddItem()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_10_0.onCloseGetView, arg_10_0)
	arg_10_0:addEventCb(Activity191Controller.instance, Activity191Event.ClickCollectionItem, arg_10_0.onClickCollectionItem, arg_10_0)

	arg_10_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_10_0.nodeDetailMo = arg_10_0.gameInfo:getNodeDetailMo()

	local var_10_0

	if arg_10_0.nodeDetailMo.type == Activity191Enum.NodeType.ReplaceEvent then
		arg_10_0._txtTitle.text = luaLang("191collectionchangeview_title1")
		var_10_0 = lua_activity191_const.configDict[Activity191Enum.ConstKey.ReplaceMaxCnt].value

		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31502)

		arg_10_0._txtAdd.text = luaLang("191collectiontipview_addchange")
	else
		arg_10_0._txtTitle.text = luaLang("191collectionchangeview_title2")
		var_10_0 = lua_activity191_const.configDict[Activity191Enum.ConstKey.UpgradeMaxCnt].value

		Activity191Controller.instance:dispatchEvent(Activity191Event.ZTrigger31501)

		arg_10_0._txtAdd.text = luaLang("191collectiontipview_addupgrade")
	end

	arg_10_0.maxCntParams = GameUtil.splitString2(var_10_0, true)

	arg_10_0:refreshUI()
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.delayAddItem, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.delayRpcRefresh, arg_11_0)
end

function var_0_0.initAddItem(arg_12_0)
	arg_12_0.addItemList = {}
	arg_12_0.curAddItemList = {}

	for iter_12_0 = 1, 15 do
		local var_12_0 = arg_12_0:getUserDataTb_()
		local var_12_1 = gohelper.findChild(arg_12_0._goLayout, "pos" .. iter_12_0)
		local var_12_2 = gohelper.clone(arg_12_0._goChangeItem, var_12_1)

		var_12_0.go = var_12_2
		var_12_0.anim = var_12_2:GetComponent(gohelper.Type_Animator)
		var_12_0.imageIndex = gohelper.findChildImage(var_12_2, "image_Index")
		var_12_0.imageRare = gohelper.findChildImage(var_12_2, "image_Rare")
		var_12_0.simageIcon = gohelper.findChildSingleImage(var_12_2, "simage_Icon")

		local var_12_3 = gohelper.findChildButtonWithAudio(var_12_2, "btn_Close")

		arg_12_0:addClickCb(var_12_3, arg_12_0.onClickCloseAddItem, arg_12_0, iter_12_0)

		arg_12_0.addItemList[iter_12_0] = var_12_0
	end
end

function var_0_0.refreshUI(arg_13_0)
	local var_13_0 = tonumber(lua_activity191_stage.configDict[arg_13_0.actId][arg_13_0.gameInfo.curStage].name)

	arg_13_0.maxAddCnt = arg_13_0.maxCntParams[var_13_0][2] - arg_13_0.nodeDetailMo.replaceNum

	arg_13_0:refreshCollectionItem()
	arg_13_0:refreshLeftTimes()
	arg_13_0:refreshAddItem()
	arg_13_0:refreshCollectionInfo()
end

function var_0_0.refreshLeftTimes(arg_14_0)
	local var_14_0 = #arg_14_0.selectItemUidList ~= 0
	local var_14_1 = arg_14_0.maxAddCnt - #arg_14_0.selectItemUidList

	if arg_14_0.nodeDetailMo.type == Activity191Enum.NodeType.ReplaceEvent then
		local var_14_2 = luaLang("191collectionchangeview_addtip1")

		arg_14_0._txtRemainTimes.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_14_2, var_14_1)

		gohelper.setActive(arg_14_0._btnExchange, var_14_0)
		gohelper.setActive(arg_14_0._btnNext, true)
	else
		local var_14_3 = luaLang("191collectionchangeview_addtip2")

		arg_14_0._txtRemainTimes.text = GameUtil.getSubPlaceholderLuaLangTwoParam(var_14_3, #arg_14_0.selectItemUidList, arg_14_0.maxAddCnt)

		gohelper.setActive(arg_14_0._btnUpgrade, var_14_0)
		gohelper.setActive(arg_14_0._btnNext, false)
	end
end

function var_0_0.refreshCollectionItem(arg_15_0)
	local var_15_0 = {}

	if arg_15_0.nodeDetailMo.type == Activity191Enum.NodeType.ReplaceEvent then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.gameInfo.warehouseInfo.item) do
			if not tabletool.indexOf(arg_15_0.selectItemUidList, iter_15_1.uid) then
				var_15_0[#var_15_0 + 1] = iter_15_1
			end
		end
	elseif arg_15_0.nodeDetailMo.type == Activity191Enum.NodeType.UpgradeEvent then
		for iter_15_2, iter_15_3 in ipairs(arg_15_0.gameInfo.warehouseInfo.item) do
			if Activity191Config.instance:getCollectionCo(iter_15_3.itemId).rare < Activity191Enum.MaxItemLevel and not tabletool.indexOf(arg_15_0.selectItemUidList, iter_15_3.uid) then
				var_15_0[#var_15_0 + 1] = iter_15_3
			end
		end
	end

	table.sort(var_15_0, function(arg_16_0, arg_16_1)
		local var_16_0 = Activity191Config.instance:getCollectionCo(arg_16_0.itemId)
		local var_16_1 = Activity191Config.instance:getCollectionCo(arg_16_1.itemId)

		return var_16_0.rare > var_16_1.rare
	end)

	for iter_15_4 = 1, #var_15_0 do
		local var_15_1 = var_15_0[iter_15_4]
		local var_15_2 = arg_15_0.collectionItemList[iter_15_4]

		if not var_15_2 then
			local var_15_3 = arg_15_0:getResInst(Activity191Enum.PrefabPath.CollectionItem, arg_15_0._goContent)

			var_15_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_3, Act191CollectionItem)
			arg_15_0.collectionItemList[iter_15_4] = var_15_2
		end

		var_15_2:setData(var_15_1)
		arg_15_0.collectionItemList[iter_15_4]:setActive(true)

		if arg_15_0.removeItemUid and arg_15_0.removeItemUid == var_15_1.uid then
			var_15_2:playAnim("open")

			arg_15_0.removeItemUid = nil
		end
	end

	for iter_15_5 = #var_15_0 + 1, #arg_15_0.collectionItemList do
		arg_15_0.collectionItemList[iter_15_5]:setActive(false)
	end
end

function var_0_0.onClickCloseAddItem(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1 - arg_17_0.startIndex + 1

	arg_17_0.removeItemUid = arg_17_0.selectItemUidList[var_17_0]

	table.remove(arg_17_0.selectItemUidList, var_17_0)
	table.remove(arg_17_0.selectItemIdList, var_17_0)
	arg_17_0:refreshCollectionItem()
	arg_17_0:refreshAddItem()
	arg_17_0:refreshLeftTimes()
end

function var_0_0.refreshAddItem(arg_18_0)
	tabletool.clear(arg_18_0.curAddItemList)

	local var_18_0 = #arg_18_0.selectItemUidList

	gohelper.setActive(arg_18_0._goEmpty, var_18_0 == 0)
	gohelper.setActive(arg_18_0._goHas, var_18_0 ~= 0)

	arg_18_0.startIndex = 1

	for iter_18_0 = 1, var_18_0 - 1 do
		arg_18_0.startIndex = arg_18_0.startIndex + iter_18_0
	end

	local var_18_1 = arg_18_0.startIndex + var_18_0 - 1

	for iter_18_1, iter_18_2 in ipairs(arg_18_0.addItemList) do
		if iter_18_1 >= arg_18_0.startIndex and iter_18_1 <= var_18_1 then
			local var_18_2 = iter_18_1 - arg_18_0.startIndex + 1
			local var_18_3 = arg_18_0.selectItemIdList[var_18_2]
			local var_18_4 = Activity191Config.instance:getCollectionCo(var_18_3)

			if var_18_4 then
				UISpriteSetMgr.instance:setAct174Sprite(iter_18_2.imageIndex, "act174_stage_num_0" .. var_18_2)
				UISpriteSetMgr.instance:setAct174Sprite(iter_18_2.imageRare, "act174_propitembg_" .. var_18_4.rare)
				iter_18_2.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_18_4.icon))
			end

			gohelper.setActive(iter_18_2.go, true)
			iter_18_2.anim:Play("open", 0, 0)

			arg_18_0.curAddItemList[var_18_2] = iter_18_2
		else
			gohelper.setActive(iter_18_2.go, false)
		end
	end
end

function var_0_0.onClickCollectionAdd(arg_19_0)
	if #arg_19_0.selectItemUidList >= arg_19_0.maxAddCnt then
		GameFacade.showToast(ToastEnum.DouQuQu3CntNotEnough)

		return
	end

	for iter_19_0 = 1, #arg_19_0.collectionItemList do
		local var_19_0 = arg_19_0.collectionItemList[iter_19_0]

		if var_19_0.itemInfo.uid == arg_19_0.showItemUid then
			var_19_0:playAnim("close")

			arg_19_0.removeCollectionItem = var_19_0

			break
		end
	end

	table.insert(arg_19_0.selectItemUidList, arg_19_0.showItemUid)
	table.insert(arg_19_0.selectItemIdList, arg_19_0.showItemId)
	TaskDispatcher.runDelay(arg_19_0.delayAddItem, arg_19_0, 0.16)
end

function var_0_0.delayAddItem(arg_20_0)
	arg_20_0.showItemUid = nil
	arg_20_0.showItemId = nil

	arg_20_0:refreshCollectionFrame()

	if arg_20_0.removeCollectionItem then
		arg_20_0.removeCollectionItem:playAnim("idle", true)
	end

	arg_20_0:refreshCollectionItem()
	arg_20_0:refreshAddItem()
	arg_20_0:refreshLeftTimes()
	arg_20_0:refreshCollectionInfo()
end

function var_0_0.onClickCollectionItem(arg_21_0, arg_21_1, arg_21_2)
	if ViewMgr.instance:isOpen(ViewName.Act191CollectionGetView) then
		return
	end

	if arg_21_0.quickAdd then
		if #arg_21_0.selectItemUidList >= arg_21_0.maxAddCnt then
			GameFacade.showToast(ToastEnum.DouQuQu3CntNotEnough)

			return
		end

		arg_21_0.showItemUid = arg_21_1
		arg_21_0.showItemId = arg_21_2

		TaskDispatcher.runDelay(arg_21_0.onClickCollectionAdd, arg_21_0, 0.16)
	else
		if arg_21_0.showItemUid == arg_21_1 then
			arg_21_0.showItemUid = nil
			arg_21_0.showItemId = nil

			arg_21_0:refreshCollectionInfo()
		else
			arg_21_0.showItemUid = arg_21_1
			arg_21_0.showItemId = arg_21_2

			arg_21_0:refreshCollectionInfo()
		end

		arg_21_0:refreshCollectionFrame()
	end
end

function var_0_0.refreshCollectionFrame(arg_22_0)
	for iter_22_0 = 1, #arg_22_0.collectionItemList do
		local var_22_0 = arg_22_0.collectionItemList[iter_22_0]

		var_22_0:setSelect(var_22_0.itemInfo.uid == arg_22_0.showItemUid)
	end
end

function var_0_0.resetSelect(arg_23_0)
	tabletool.clear(arg_23_0.selectItemUidList)
	tabletool.clear(arg_23_0.selectItemIdList)
end

function var_0_0.replaceReply(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_2 ~= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_1.DouQuQu3.ui_mingdi_aperture_shrink)
	arg_24_0.anim:Play("change", 0, 0)

	for iter_24_0, iter_24_1 in pairs(arg_24_0.curAddItemList) do
		iter_24_1.anim:Play("change", 0, 0)
	end

	local var_24_0 = tabletool.copy(arg_24_0.selectItemIdList)
	local var_24_1 = {
		oldIdList = var_24_0,
		newIdList = arg_24_3.resItemId
	}

	ViewMgr.instance:openView(ViewName.Act191CollectionGetView, var_24_1)
	TaskDispatcher.runDelay(arg_24_0.delayRpcRefresh, arg_24_0, 2)
end

function var_0_0.upgradeReply(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if arg_25_2 ~= 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_1.DouQuQu3.ui_mingdi_aperture_shrink)
	arg_25_0.anim:Play("change", 0, 0)

	for iter_25_0, iter_25_1 in pairs(arg_25_0.curAddItemList) do
		iter_25_1.anim:Play("change", 0, 0)
	end

	local var_25_0 = tabletool.copy(arg_25_0.selectItemIdList)
	local var_25_1 = {
		oldIdList = var_25_0,
		newIdList = arg_25_3.resItemId
	}

	ViewMgr.instance:openView(ViewName.Act191CollectionGetView, var_25_1)
	TaskDispatcher.runDelay(arg_25_0.delayRpcRefresh, arg_25_0, 2)
end

function var_0_0.delayRpcRefresh(arg_26_0)
	arg_26_0:resetSelect()

	if arg_26_0.nodeDetailMo.type == Activity191Enum.NodeType.UpgradeEvent then
		arg_26_0.nodeDetailMo = arg_26_0.gameInfo:getNodeDetailMo(arg_26_0.gameInfo.curNode - 1)
	else
		arg_26_0.nodeDetailMo = arg_26_0.gameInfo:getNodeDetailMo()
	end

	arg_26_0:refreshUI()
	gohelper.setActive(arg_26_0._goEmpty, false)
end

function var_0_0.onCloseGetView(arg_27_0, arg_27_1)
	if arg_27_1 == ViewName.Act191CollectionGetView then
		if arg_27_0.nodeDetailMo.type == Activity191Enum.NodeType.UpgradeEvent then
			arg_27_0:closeThis()
			Activity191Controller.instance:nextStep()
		else
			arg_27_0.anim:Play("open", 0, 1)

			for iter_27_0, iter_27_1 in ipairs(arg_27_0.addItemList) do
				iter_27_1.anim:Play("idle", 0, 1)
			end

			gohelper.setActive(arg_27_0._goEmpty, true)
		end
	end
end

function var_0_0.refreshCollectionInfo(arg_28_0)
	if arg_28_0.showItemId then
		local var_28_0 = Activity191Config.instance:getCollectionCo(arg_28_0.showItemId)

		arg_28_0._simageCIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_28_0.icon))

		local var_28_1 = Activity191Enum.CollectionColor[var_28_0.rare]

		arg_28_0._txtCName.text = string.format("<#%s>%s</color>", var_28_1, var_28_0.title)
		arg_28_0._txtCDesc.text = Activity191Helper.replaceSymbol(SkillHelper.buildDesc(var_28_0.desc))

		if string.nilorempty(var_28_0.label) then
			gohelper.setActive(arg_28_0._goCTag1, false)
			gohelper.setActive(arg_28_0._goCTag2, false)
		else
			local var_28_2 = string.split(var_28_0.label, "#")

			for iter_28_0 = 1, 2 do
				local var_28_3 = var_28_2[iter_28_0]

				arg_28_0["_txtCTag" .. iter_28_0].text = var_28_3

				gohelper.setActive(arg_28_0["_goCTag" .. iter_28_0], var_28_3)
			end
		end
	end

	gohelper.setActive(arg_28_0._goCollectionInfo, arg_28_0.showItemUid)
end

return var_0_0
