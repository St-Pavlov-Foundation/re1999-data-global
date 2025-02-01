module("modules.logic.rouge.map.view.collectiondrop.RougeCollectionDropView", package.seeall)

slot0 = class("RougeCollectionDropView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_maskbg")
	slot0._gotitletip = gohelper.findChild(slot0.viewGO, "Title/txt_Tips")
	slot0._scrollView = gohelper.findChildScrollRect(slot0.viewGO, "scroll_view")
	slot0._gocollectionitem = gohelper.findChild(slot0.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btnrefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "layout/#btn_refresh")
	slot0._gorefreshactivebg = gohelper.findChild(slot0.viewGO, "layout/#btn_refresh/#go_activebg")
	slot0._gorefreshdisablebg = gohelper.findChild(slot0.viewGO, "layout/#btn_refresh/#go_disablebg")
	slot0._gorougefunctionitem2 = gohelper.findChild(slot0.viewGO, "#go_rougefunctionitem2")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._txtselectnum = gohelper.findChildText(slot0.viewGO, "#go_topright/#txt_num")
	slot0._gotopright = gohelper.findChild(slot0.viewGO, "#go_topright")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnrefresh:AddClickListener(slot0._btnrefreshOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnrefresh:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		slot0:closeThis()

		return
	end

	if #slot0.selectPosList < 1 then
		return
	end

	slot0:clearSelectCallback()

	slot0.selectCallbackId = RougeRpc.instance:sendRougeSelectDropRequest(slot0.selectPosList, slot0.onReceiveSelect, slot0)
end

function slot0.onReceiveSelect(slot0)
	slot0.refreshCallbackId = nil

	slot0:delayCloseView()
end

function slot0.delayCloseView(slot0)
	UIBlockMgr.instance:startBlock(slot0.viewName)
	TaskDispatcher.cancelTask(slot0._closeView, slot0)
	TaskDispatcher.runDelay(slot0._closeView, slot0, RougeMapEnum.CollectionChangeAnimDuration)
end

function slot0._closeView(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName)
	slot0:closeThis()
end

function slot0._btnrefreshOnClick(slot0)
	if not slot0.canClickRefresh then
		return
	end

	slot0:clearRefreshCallback()

	slot0.refreshCallbackId = RougeRpc.instance:sendRougeRandomDropRequest(slot0.onReceiveRefresh, slot0)
end

function slot0.onReceiveRefresh(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)

	slot0.refreshCallbackId = nil
	slot1 = RougeMapModel.instance:getCurInteractiveJson()
	slot0.collectionList = slot1.dropCollectList
	slot0.canSelectCount = slot1.dropSelectNum
	slot0.dropRandomNum = slot1.dropRandomNum

	slot0:refreshUI()
	tabletool.clear(slot0.selectPosList)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
end

function slot0.onClickBg(slot0)
	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		return
	end

	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.bgClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#simage_maskbg")

	slot0.bgClick:AddClickListener(slot0.onClickBg, slot0)

	slot0.viewPortClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "scroll_view/Viewport")

	slot0.viewPortClick:AddClickListener(slot0.onClickBg, slot0)
	slot0._simagemaskbg:LoadImage("singlebg/rouge/rouge_talent_bg.png")

	slot0.txtTips = gohelper.findChildText(slot0.viewGO, "Title/txt_Tips")
	slot0.txtTitle = gohelper.findChildText(slot0.viewGO, "Title/txt_Title")
	slot0.goRefreshBtn = slot0._btnrefresh.gameObject
	slot0.goConfirmBtn = slot0._btnconfirm.gameObject

	gohelper.setActive(slot0._gocollectionitem, false)

	slot0.selectPosList = {}
	slot0.collectionItemList = {}

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectDropChange, slot0.onSelectDropChange, slot0)

	slot0.goCollection = slot0.viewContainer:getResInst(RougeEnum.ResPath.CommonCollectionItem, slot0._gorougefunctionitem2)
	slot0.collectionComp = RougeCollectionComp.Get(slot0.goCollection)

	NavigateMgr.instance:addEscape(slot0.viewName, RougeMapHelper.blockEsc)
end

function slot0.onSelectDropChange(slot0)
	slot0:refreshConfirmBtn()
	slot0:refreshTopRight()
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.initData(slot0)
	slot0.viewEnum = slot0.viewParam.viewEnum
	slot0.collectionList = slot0.viewParam.collectionList

	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		slot0.canSelectCount = slot0.viewParam.canSelectCount
		slot0.dropRandomNum = slot0.viewParam.dropRandomNum
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.DropRefresh)
	slot0:initData()
	slot0:refreshUI()
	slot0.collectionComp:onOpen()
end

function slot0.refreshUI(slot0)
	slot0:refreshTitle()
	slot0:refreshCollection()
	slot0:refreshConfirmBtn()
	slot0:refreshRefreshBtn()
	slot0:refreshTopRight()
end

function slot0.refreshTitle(slot0)
	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.Select then
		slot0.txtTitle.text = luaLang("rougecollectionselectview_txt_Title")
		slot0.txtTips.text = string.gsub(luaLang("rougecollectionselectview_txt_Tips"), "▩1%%s", slot0.canSelectCount)

		gohelper.setActive(slot0._gotitletip, true)
	else
		slot0.txtTips.text = luaLang("rougecollectionselectview_txt_get_Tips")
		slot0.txtTitle.text = luaLang("rougecollectionselectview_txt_get_Title")

		gohelper.setActive(slot0._gotitletip, false)
	end
end

function slot0.refreshCollection(slot0)
	slot1 = slot0.collectionList or {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.collectionItemList[slot5] then
			slot7 = RougeCollectionDropItem.New()

			slot7:init(gohelper.cloneInPlace(slot0._gocollectionitem), slot0)
			slot7:setParentScroll(slot0._scrollView.gameObject)
			table.insert(slot0.collectionItemList, slot7)
		end

		slot7:show()
		slot7:update(slot5, slot6)
	end

	for slot5 = #slot1 + 1, #slot0.collectionItemList do
		slot0.collectionItemList[slot5]:hide()
	end

	slot0._scrollView.horizontalNormalizedPosition = 0
end

function slot0.refreshConfirmBtn(slot0)
	if slot0.viewEnum == RougeMapEnum.CollectionDropViewEnum.OnlyShow then
		gohelper.setActive(slot0.goConfirmBtn, false)
		gohelper.setActive(slot0._gotips, true)

		return
	end

	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0.goConfirmBtn, slot0.canSelectCount <= #slot0.selectPosList)
end

function slot0.refreshRefreshBtn(slot0)
	slot0.canClickRefresh = false

	if slot0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(slot0.goRefreshBtn, false)

		return
	end

	slot2 = RougeMapModel.instance:getCurNode() and slot1:getEventCo()

	if not RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockFightDropRefresh, slot2 and slot2.type) then
		gohelper.setActive(slot0.goRefreshBtn, false)

		return
	end

	slot0.canClickRefresh = RougeMapConfig.instance:getFightDropMaxRefreshNum(slot3) - slot0.dropRandomNum > 0

	gohelper.setActive(slot0.goRefreshBtn, true)
	gohelper.setActive(slot0._gorefreshactivebg, slot0.canClickRefresh)
	gohelper.setActive(slot0._gorefreshdisablebg, not slot0.canClickRefresh)
end

function slot0.refreshTopRight(slot0)
	if slot0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		gohelper.setActive(slot0._gotopright, false)

		return
	end

	gohelper.setActive(slot0._gotopright, true)

	slot0._txtselectnum.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge_drop_select"), #slot0.selectPosList, slot0.canSelectCount)
end

function slot0.selectPos(slot0, slot1)
	if slot0.viewEnum ~= RougeMapEnum.CollectionDropViewEnum.Select then
		return false
	end

	if tabletool.indexOf(slot0.selectPosList, slot1) then
		table.remove(slot0.selectPosList, slot2)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)

		return
	end

	if slot0.canSelectCount > 1 then
		if slot0.canSelectCount <= #slot0.selectPosList then
			return
		end

		table.insert(slot0.selectPosList, slot1)
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
	end

	table.remove(slot0.selectPosList)
	table.insert(slot0.selectPosList, slot1)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectDropChange)
end

function slot0.isSelect(slot0, slot1)
	return tabletool.indexOf(slot0.selectPosList, slot1)
end

function slot0.clearSelectCallback(slot0)
	if slot0.selectCallbackId then
		RougeRpc.instance:removeCallbackById(slot0.selectCallbackId)

		slot0.selectCallbackId = nil
	end
end

function slot0.clearRefreshCallback(slot0)
	if slot0.refreshCallbackId then
		RougeRpc.instance:removeCallbackById(slot0.refreshCallbackId)

		slot0.refreshCallbackId = nil
	end
end

function slot0.onClose(slot0)
	slot0:clearSelectCallback()
	slot0:clearRefreshCallback()
	slot0.collectionComp:onClose()

	for slot4, slot5 in ipairs(slot0.collectionItemList) do
		slot5:onClose()
	end

	tabletool.clear(slot0.selectPosList)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.collectionItemList) do
		slot5:destroy()
	end

	slot0.collectionItemList = nil

	slot0._simagemaskbg:UnLoadImage()
	slot0.collectionComp:destroy()
	slot0.bgClick:RemoveClickListener()
	slot0.viewPortClick:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0
