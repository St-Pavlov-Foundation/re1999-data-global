module("modules.logic.versionactivity2_3.act174.view.Act174GameWarehouseView", package.seeall)

slot0 = class("Act174GameWarehouseView", BaseView)

function slot0.onInitView(slot0)
	slot0._goEditTeam = gohelper.findChild(slot0.viewGO, "#go_EditTeam")
	slot0._goWarehouse = gohelper.findChild(slot0.viewGO, "go_Warehouse")
	slot0._goWareItemRoot = gohelper.findChild(slot0.viewGO, "go_Warehouse/go_WareItemRoot")
	slot0._btnLastPage = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_Warehouse/btn_LastPage")
	slot0._txtPage = gohelper.findChildText(slot0.viewGO, "go_Warehouse/Page/txt_Page")
	slot0._btnNextPage = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_Warehouse/btn_NextPage")
	slot0._btnHeroBage = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_Warehouse/btn_HeroBag")
	slot0._btnCollectionBag = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_Warehouse/btn_CollectionBag")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnCollectionBag, slot0._btnCollectionBagOnClick, slot0)
	slot0:addClickCb(slot0._btnHeroBage, slot0._btnHeroBageOnClick, slot0)
	slot0:addClickCb(slot0._btnLastPage, slot0._btnLastPageOnClick, slot0)
	slot0:addClickCb(slot0._btnNextPage, slot0._btnNextPageOnClick, slot0)
end

function slot0._btnCollectionBagOnClick(slot0)
	if slot0.wareType == Activity174Enum.WareType.Collection then
		return
	end

	slot0.animWareHouse:Play("switch", 0, 0)
	gohelper.setActive(slot0.goBtnHeroS, false)
	gohelper.setActive(slot0.goBtnHeroU, true)
	gohelper.setActive(slot0.goBtnCollectionS, true)
	gohelper.setActive(slot0.goBtnCollectionU, false)

	slot0.wareType = Activity174Enum.WareType.Collection
	slot0.maxPage = math.ceil(#slot0.wareHouseMo:getItemData() / slot0.maxWareCnt)

	slot0:setPage(1)
	TaskDispatcher.cancelTask(slot0.refreshWareItem, slot0)
	TaskDispatcher.runDelay(slot0.refreshWareItem, slot0, 0.16)
	Activity174Controller.instance:dispatchEvent(Activity174Event.WareHouseTypeChange, slot0.wareType)
end

function slot0._btnHeroBageOnClick(slot0)
	if slot0.wareType == Activity174Enum.WareType.Hero then
		return
	end

	slot0.animWareHouse:Play("switch", 0, 0)
	gohelper.setActive(slot0.goBtnHeroS, true)
	gohelper.setActive(slot0.goBtnHeroU, false)
	gohelper.setActive(slot0.goBtnCollectionS, false)
	gohelper.setActive(slot0.goBtnCollectionU, true)

	slot0.wareType = Activity174Enum.WareType.Hero
	slot0.maxPage = math.ceil(#slot0.wareHouseMo:getHeroData() / slot0.maxWareCnt)

	slot0:setPage(1)
	TaskDispatcher.cancelTask(slot0.refreshWareItem, slot0)
	TaskDispatcher.runDelay(slot0.refreshWareItem, slot0, 0.16)
	Activity174Controller.instance:dispatchEvent(Activity174Event.WareHouseTypeChange, slot0.wareType)
end

function slot0._btnLastPageOnClick(slot0)
	if slot0.curPage - 1 < 1 then
		return
	end

	slot0.animWareHouse:Play("switch", 0, 0)
	slot0:setPage(slot0.curPage - 1)
	TaskDispatcher.cancelTask(slot0.refreshWareItem, slot0)
	TaskDispatcher.runDelay(slot0.refreshWareItem, slot0, 0.16)
end

function slot0._btnNextPageOnClick(slot0)
	if slot0.maxPage < slot0.curPage + 1 then
		return
	end

	slot0.animWareHouse:Play("switch", 0, 0)
	slot0:setPage(slot0.curPage + 1)
	TaskDispatcher.cancelTask(slot0.refreshWareItem, slot0)
	TaskDispatcher.runDelay(slot0.refreshWareItem, slot0, 0.16)
end

function slot0.updateWareHouseInfo(slot0)
	slot0.wareHouseMo = slot0.gameInfo:getWarehouseInfo()
	slot1 = nil
	slot0.maxPage = math.ceil(#((slot0.wareType ~= Activity174Enum.WareType.Hero or slot0.wareHouseMo:getHeroData()) and slot0.wareHouseMo:getItemData()) / slot0.maxWareCnt)

	slot0:setPage(slot0.curPage)
	slot0:refreshWareItem(true)
end

function slot0._editableInitView(slot0)
	slot0.maxWareCnt = Activity174Enum.MaxWareItemSinglePage
	slot0.goware = gohelper.findChild(slot0._goWareItemRoot, "ware")
	slot0.goBtnHeroS = gohelper.findChild(slot0._btnHeroBage.gameObject, "select")
	slot0.goBtnHeroU = gohelper.findChild(slot0._btnHeroBage.gameObject, "unselect")
	slot0.goBtnCollectionS = gohelper.findChild(slot0._btnCollectionBag.gameObject, "select")
	slot0.goBtnCollectionU = gohelper.findChild(slot0._btnCollectionBag.gameObject, "unselect")
	slot0.goBtnLastL = gohelper.findChild(slot0._btnLastPage.gameObject, "lock")
	slot0.goBtnNextL = gohelper.findChild(slot0._btnNextPage.gameObject, "lock")
	slot0.animWareHouse = slot0._goWarehouse:GetComponent(gohelper.Type_Animator)

	slot0:initWareItem()
end

function slot0.onOpen(slot0)
	slot0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	slot0.wareHouseMo = slot0.gameInfo:getWarehouseInfo()

	slot0:_btnHeroBageOnClick()
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, slot0.updateWareHouseInfo, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.BuyInShopReply, slot0.updateWareHouseInfo, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.ChangeLocalTeam, slot0.onChangeLocalTeam, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, slot0.updateWareHouseInfo, slot0)
	slot0:removeEventCb(Activity174Controller.instance, Activity174Event.BuyInShopReply, slot0.updateWareHouseInfo, slot0)
	slot0:removeEventCb(Activity174Controller.instance, Activity174Event.ChangeLocalTeam, slot0.onChangeLocalTeam, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshWareItem, slot0)
	slot0.wareHouseMo:clearNewSign()
end

function slot0.initWareItem(slot0)
	slot0.wareItemList = {}

	for slot4 = 1, slot0.maxWareCnt do
		slot0.wareItemList[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0.goware, slot0._goWareItemRoot, "wareItem" .. slot4), Act174GameWareItem, slot0)

		slot0.wareItemList[slot4]:setIndex(slot4)
	end
end

function slot0.refreshWareItem(slot0, slot1)
	slot2 = nil

	if slot0.wareType == Activity174Enum.WareType.Hero then
		slot2 = slot0.wareHouseMo:getHeroData()
	elseif slot0.wareType == Activity174Enum.WareType.Collection then
		slot2 = slot0.wareHouseMo:getItemData()
	end

	slot0.curPageWareDatas = slot0:calculateCurPage(slot2)

	for slot6 = 1, slot0.maxWareCnt do
		slot0.wareItemList[slot6]:setData(slot0.curPageWareDatas[slot6], slot0.wareType)
	end

	if slot0.wareHouseMo:getNewIdDic(slot0.wareType) and next(slot3) then
		for slot7 = slot0.maxWareCnt, 1, -1 do
			if slot0.curPageWareDatas[slot7] then
				slot10 = slot0.wareItemList[slot7]

				if slot3[slot8.id] and slot3[slot9] ~= 0 then
					slot3[slot9] = slot3[slot9] - 1

					slot10:setNew(true)

					if slot1 then
						slot10:playNew()
					end
				end
			end
		end
	end
end

function slot0.calculateCurPage(slot0, slot1)
	slot2 = {}

	if (slot0.curPage - 1) * slot0.maxWareCnt + 1 + slot0.maxWareCnt - 1 > #slot1 then
		slot4 = #slot1 or slot4
	end

	for slot8 = slot3, slot4 do
		table.insert(slot2, slot1[slot8])
	end

	return slot2
end

function slot0.onChangeLocalTeam(slot0)
	slot0:refreshWareItem()
end

function slot0.setPage(slot0, slot1)
	slot0.curPage = slot1
	slot0._txtPage.text = slot0.curPage

	gohelper.setActive(slot0.goBtnLastL, slot0.curPage <= 1)
	gohelper.setActive(slot0.goBtnNextL, slot0.maxPage <= slot0.curPage)
end

return slot0
