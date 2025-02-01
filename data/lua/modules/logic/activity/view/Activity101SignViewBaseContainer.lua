module("modules.logic.activity.view.Activity101SignViewBaseContainer", package.seeall)

slot0 = class("Activity101SignViewBaseContainer", BaseViewContainer)

function slot0.actId(slot0)
	return slot0.viewParam.actId
end

function slot0._getScrollView(slot0)
	slot3 = ListScrollParam.New()
	slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot3.scrollDir = ScrollEnum.ScrollDirH
	slot3.sortMode = ScrollEnum.ScrollSortDown
	slot3.lineCount = 1
	slot3.cellSpaceV = 0
	slot3.startSpace = 0
	slot3.prefabUrl = slot0._viewSetting.otherRes[1]

	slot0:onModifyListScrollParam(slot3)
	assert(slot3.cellClass)
	assert(slot3.scrollGOPath)
	assert(slot3.prefabUrl)

	return slot0:onGetListScrollModelClassType().New(), slot3
end

function slot0._createMainView(slot0)
	if slot0:onGetMainViewClassType() then
		return slot1.New()
	end
end

function slot0.buildViews(slot0)
	slot0.__scrollModel, slot0.__listScrollParam = slot0:_getScrollView()
	slot0.__mainView = slot0:_createMainView()

	return slot0:onBuildViews()
end

function slot0.onContainerInit(slot0)
	uv0.super.onContainerInit(slot0)

	slot1 = slot0:getScrollRect()
	slot2 = slot1:GetComponent(gohelper.Type_RectTransform)
	slot0.__scrollContentTrans = slot1.content
	slot0.__scrollContentGo = slot0.__scrollContentTrans.gameObject
	slot0.__viewPortHeight = recthelper.getHeight(slot2)
	slot0.__viewPortWidth = recthelper.getWidth(slot2)
	slot0.__onceGotRewardFetch101Infos = false

	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0._onRefreshNorSignActivity, slot0)
end

function slot0.onContainerClose(slot0)
	uv0.super.onContainerClose(slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0._onRefreshNorSignActivity, slot0)

	slot0.__onceGotRewardFetch101Infos = false
end

function slot0.getScrollModel(slot0)
	return slot0.__scrollModel
end

function slot0.getScrollView(slot0)
	return slot0.__scrollView
end

function slot0.getMainView(slot0)
	return slot0.__mainView
end

function slot0.isLimitedScrollView(slot0)
	return slot0.__scrollView ~= nil
end

function slot0.getCsListScroll(slot0)
	if not slot0:isLimitedScrollView() then
		return
	end

	return slot0:getScrollView():getCsListScroll()
end

function slot0.getScrollRect(slot0)
	if slot0.__scrollRect then
		return slot0.__scrollRect
	end

	slot1 = nil
	slot1 = (not slot0:isLimitedScrollView() or slot0:getCsListScroll():GetComponent(gohelper.Type_ScrollRect)) and gohelper.findChildScrollRect(slot0:getMainView().viewGO, slot0:getListScrollParam().scrollGOPath)
	slot0.__scrollRect = slot1

	return slot1
end

function slot0.getScrollContentTranform(slot0)
	return slot0.__scrollContentTrans
end

function slot0.getListScrollParam(slot0)
	return slot0.__listScrollParam
end

function slot0.getViewportWH(slot0)
	return slot0.__viewPortWidth, slot0.__viewPortHeight
end

function slot0.getScrollContentGo(slot0)
	return slot0.__scrollContentGo
end

function slot0.createItemInst(slot0)
	slot1 = slot0:getListScrollParam()
	slot2 = slot1.cellClass

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot1.prefabUrl, slot0:getScrollContentGo(), slot2.__cname), slot2)
end

function slot0.onGetListScrollModelClassType(slot0)
	return Activity101SignViewListModelBase
end

function slot0.onGetMainViewClassType(slot0)
	assert(false, "please overeide this function!")
end

function slot0.onModifyListScrollParam(slot0, slot1)
	assert(false, "please overeide this function!")
end

function slot0.onBuildViews(slot0)
	slot1, slot2 = slot0:_getScrollView()
	slot0.__scrollView = LuaListScrollView.New(slot1, slot2)

	return {
		slot0.__scrollView,
		slot0.__mainView
	}
end

function slot0.setOnceGotRewardFetch101Infos(slot0, slot1)
	slot0.__onceGotRewardFetch101Infos = slot1 and true or false
end

function slot0._onRefreshNorSignActivity(slot0)
	if slot0.__onceGotRewardFetch101Infos then
		Activity101Rpc.instance:sendGet101InfosRequest(slot0:actId())

		slot0.__onceGotRewardFetch101Infos = false
	end
end

return slot0
