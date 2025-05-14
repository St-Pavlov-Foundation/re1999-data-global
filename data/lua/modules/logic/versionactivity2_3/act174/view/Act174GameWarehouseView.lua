module("modules.logic.versionactivity2_3.act174.view.Act174GameWarehouseView", package.seeall)

local var_0_0 = class("Act174GameWarehouseView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goEditTeam = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam")
	arg_1_0._goWarehouse = gohelper.findChild(arg_1_0.viewGO, "go_Warehouse")
	arg_1_0._goWareItemRoot = gohelper.findChild(arg_1_0.viewGO, "go_Warehouse/go_WareItemRoot")
	arg_1_0._btnLastPage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_Warehouse/btn_LastPage")
	arg_1_0._txtPage = gohelper.findChildText(arg_1_0.viewGO, "go_Warehouse/Page/txt_Page")
	arg_1_0._btnNextPage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_Warehouse/btn_NextPage")
	arg_1_0._btnHeroBage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_Warehouse/btn_HeroBag")
	arg_1_0._btnCollectionBag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_Warehouse/btn_CollectionBag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnCollectionBag, arg_2_0._btnCollectionBagOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnHeroBage, arg_2_0._btnHeroBageOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnLastPage, arg_2_0._btnLastPageOnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnNextPage, arg_2_0._btnNextPageOnClick, arg_2_0)
end

function var_0_0._btnCollectionBagOnClick(arg_3_0)
	if arg_3_0.wareType == Activity174Enum.WareType.Collection then
		return
	end

	arg_3_0.animWareHouse:Play("switch", 0, 0)
	gohelper.setActive(arg_3_0.goBtnHeroS, false)
	gohelper.setActive(arg_3_0.goBtnHeroU, true)
	gohelper.setActive(arg_3_0.goBtnCollectionS, true)
	gohelper.setActive(arg_3_0.goBtnCollectionU, false)

	arg_3_0.wareType = Activity174Enum.WareType.Collection

	local var_3_0 = arg_3_0.wareHouseMo:getItemData()

	arg_3_0.maxPage = math.ceil(#var_3_0 / arg_3_0.maxWareCnt)

	arg_3_0:setPage(1)
	TaskDispatcher.cancelTask(arg_3_0.refreshWareItem, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0.refreshWareItem, arg_3_0, 0.16)
	Activity174Controller.instance:dispatchEvent(Activity174Event.WareHouseTypeChange, arg_3_0.wareType)
end

function var_0_0._btnHeroBageOnClick(arg_4_0)
	if arg_4_0.wareType == Activity174Enum.WareType.Hero then
		return
	end

	arg_4_0.animWareHouse:Play("switch", 0, 0)
	gohelper.setActive(arg_4_0.goBtnHeroS, true)
	gohelper.setActive(arg_4_0.goBtnHeroU, false)
	gohelper.setActive(arg_4_0.goBtnCollectionS, false)
	gohelper.setActive(arg_4_0.goBtnCollectionU, true)

	arg_4_0.wareType = Activity174Enum.WareType.Hero

	local var_4_0 = arg_4_0.wareHouseMo:getHeroData()

	arg_4_0.maxPage = math.ceil(#var_4_0 / arg_4_0.maxWareCnt)

	arg_4_0:setPage(1)
	TaskDispatcher.cancelTask(arg_4_0.refreshWareItem, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0.refreshWareItem, arg_4_0, 0.16)
	Activity174Controller.instance:dispatchEvent(Activity174Event.WareHouseTypeChange, arg_4_0.wareType)
end

function var_0_0._btnLastPageOnClick(arg_5_0)
	if arg_5_0.curPage - 1 < 1 then
		return
	end

	arg_5_0.animWareHouse:Play("switch", 0, 0)
	arg_5_0:setPage(arg_5_0.curPage - 1)
	TaskDispatcher.cancelTask(arg_5_0.refreshWareItem, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0.refreshWareItem, arg_5_0, 0.16)
end

function var_0_0._btnNextPageOnClick(arg_6_0)
	if arg_6_0.curPage + 1 > arg_6_0.maxPage then
		return
	end

	arg_6_0.animWareHouse:Play("switch", 0, 0)
	arg_6_0:setPage(arg_6_0.curPage + 1)
	TaskDispatcher.cancelTask(arg_6_0.refreshWareItem, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.refreshWareItem, arg_6_0, 0.16)
end

function var_0_0.updateWareHouseInfo(arg_7_0)
	arg_7_0.wareHouseMo = arg_7_0.gameInfo:getWarehouseInfo()

	local var_7_0

	if arg_7_0.wareType == Activity174Enum.WareType.Hero then
		var_7_0 = arg_7_0.wareHouseMo:getHeroData()
	else
		var_7_0 = arg_7_0.wareHouseMo:getItemData()
	end

	arg_7_0.maxPage = math.ceil(#var_7_0 / arg_7_0.maxWareCnt)

	arg_7_0:setPage(arg_7_0.curPage)
	arg_7_0:refreshWareItem(true)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.maxWareCnt = Activity174Enum.MaxWareItemSinglePage
	arg_8_0.goware = gohelper.findChild(arg_8_0._goWareItemRoot, "ware")
	arg_8_0.goBtnHeroS = gohelper.findChild(arg_8_0._btnHeroBage.gameObject, "select")
	arg_8_0.goBtnHeroU = gohelper.findChild(arg_8_0._btnHeroBage.gameObject, "unselect")
	arg_8_0.goBtnCollectionS = gohelper.findChild(arg_8_0._btnCollectionBag.gameObject, "select")
	arg_8_0.goBtnCollectionU = gohelper.findChild(arg_8_0._btnCollectionBag.gameObject, "unselect")
	arg_8_0.goBtnLastL = gohelper.findChild(arg_8_0._btnLastPage.gameObject, "lock")
	arg_8_0.goBtnNextL = gohelper.findChild(arg_8_0._btnNextPage.gameObject, "lock")
	arg_8_0.animWareHouse = arg_8_0._goWarehouse:GetComponent(gohelper.Type_Animator)

	arg_8_0:initWareItem()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	arg_9_0.wareHouseMo = arg_9_0.gameInfo:getWarehouseInfo()

	arg_9_0:_btnHeroBageOnClick()
	arg_9_0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, arg_9_0.updateWareHouseInfo, arg_9_0)
	arg_9_0:addEventCb(Activity174Controller.instance, Activity174Event.BuyInShopReply, arg_9_0.updateWareHouseInfo, arg_9_0)
	arg_9_0:addEventCb(Activity174Controller.instance, Activity174Event.ChangeLocalTeam, arg_9_0.onChangeLocalTeam, arg_9_0)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:removeEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, arg_10_0.updateWareHouseInfo, arg_10_0)
	arg_10_0:removeEventCb(Activity174Controller.instance, Activity174Event.BuyInShopReply, arg_10_0.updateWareHouseInfo, arg_10_0)
	arg_10_0:removeEventCb(Activity174Controller.instance, Activity174Event.ChangeLocalTeam, arg_10_0.onChangeLocalTeam, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.refreshWareItem, arg_11_0)
	arg_11_0.wareHouseMo:clearNewSign()
end

function var_0_0.initWareItem(arg_12_0)
	arg_12_0.wareItemList = {}

	for iter_12_0 = 1, arg_12_0.maxWareCnt do
		local var_12_0 = gohelper.clone(arg_12_0.goware, arg_12_0._goWareItemRoot, "wareItem" .. iter_12_0)

		arg_12_0.wareItemList[iter_12_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_0, Act174GameWareItem, arg_12_0)

		arg_12_0.wareItemList[iter_12_0]:setIndex(iter_12_0)
	end
end

function var_0_0.refreshWareItem(arg_13_0, arg_13_1)
	local var_13_0

	if arg_13_0.wareType == Activity174Enum.WareType.Hero then
		var_13_0 = arg_13_0.wareHouseMo:getHeroData()
	elseif arg_13_0.wareType == Activity174Enum.WareType.Collection then
		var_13_0 = arg_13_0.wareHouseMo:getItemData()
	end

	arg_13_0.curPageWareDatas = arg_13_0:calculateCurPage(var_13_0)

	for iter_13_0 = 1, arg_13_0.maxWareCnt do
		local var_13_1 = arg_13_0.curPageWareDatas[iter_13_0]

		arg_13_0.wareItemList[iter_13_0]:setData(var_13_1, arg_13_0.wareType)
	end

	local var_13_2 = arg_13_0.wareHouseMo:getNewIdDic(arg_13_0.wareType)

	if var_13_2 and next(var_13_2) then
		for iter_13_1 = arg_13_0.maxWareCnt, 1, -1 do
			local var_13_3 = arg_13_0.curPageWareDatas[iter_13_1]

			if var_13_3 then
				local var_13_4 = var_13_3.id
				local var_13_5 = arg_13_0.wareItemList[iter_13_1]

				if var_13_2[var_13_4] and var_13_2[var_13_4] ~= 0 then
					var_13_2[var_13_4] = var_13_2[var_13_4] - 1

					var_13_5:setNew(true)

					if arg_13_1 then
						var_13_5:playNew()
					end
				end
			end
		end
	end
end

function var_0_0.calculateCurPage(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = (arg_14_0.curPage - 1) * arg_14_0.maxWareCnt + 1
	local var_14_2 = var_14_1 + arg_14_0.maxWareCnt - 1

	var_14_2 = var_14_2 > #arg_14_1 and #arg_14_1 or var_14_2

	for iter_14_0 = var_14_1, var_14_2 do
		table.insert(var_14_0, arg_14_1[iter_14_0])
	end

	return var_14_0
end

function var_0_0.onChangeLocalTeam(arg_15_0)
	arg_15_0:refreshWareItem()
end

function var_0_0.setPage(arg_16_0, arg_16_1)
	arg_16_0.curPage = arg_16_1
	arg_16_0._txtPage.text = arg_16_0.curPage

	gohelper.setActive(arg_16_0.goBtnLastL, arg_16_0.curPage <= 1)
	gohelper.setActive(arg_16_0.goBtnNextL, arg_16_0.curPage >= arg_16_0.maxPage)
end

return var_0_0
