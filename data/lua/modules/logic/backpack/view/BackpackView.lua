module("modules.logic.backpack.view.BackpackView", package.seeall)

slot0 = class("BackpackView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollcategory = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_category")
	slot0._scrollprop = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_prop")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	BackpackController.instance:registerCallback(BackpackEvent.SelectCategory, slot0._onSelectCategoryChange, slot0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, slot0._refreshView, slot0)
end

function slot0.removeEvents(slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.SelectCategory, slot0._onSelectCategoryChange, slot0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, slot0._refreshView, slot0)
end

function slot0.onOpenFinish(slot0)
	slot0._anim.enabled = true

	if BackpackModel.instance:getCurCategoryId() ~= ItemEnum.CategoryType.Material then
		slot0:_onSelectCategoryChange()
	end
end

function slot0.onOpen(slot0)
	slot0._cateList = slot0.viewParam.data.cateList
	slot0._enableAni = true

	slot0:_refreshDeadline()
	CharacterBackpackEquipListModel.instance:openEquipView()
end

function slot0.onClose(slot0)
	BackpackModel.instance:setItemAniHasShown(false)
end

function slot0._refreshView(slot0)
	BackpackModel.instance:setBackpackCategoryList(slot0._cateList)
	BackpackCategoryListModel.instance:setCategoryList(slot0._cateList)
end

function slot0._refreshDeadline(slot0)
	slot0._itemDeadline = BackpackModel.instance:getItemDeadline()

	if slot0._itemDeadline then
		TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	end
end

function slot0._onSelectCategoryChange(slot0)
	if slot0.viewContainer:getCurrentSelectCategoryId() == BackpackModel.instance:getCurCategoryId() and not slot0.viewParam.isJump then
		slot0.viewParam.isJump = false

		return
	end

	slot0:_refreshView()

	if slot1 == ItemEnum.CategoryType.Equip then
		slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 2)
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	elseif slot1 == ItemEnum.CategoryType.Antique then
		slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 3)
	else
		slot0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 1)
		slot0:_refreshDeadline()
	end
end

function slot0._onRefreshDeadline(slot0)
	if slot0._itemDeadline and slot0._itemDeadline > 0 and slot0._itemDeadline - ServerTime.now() <= -1 then
		slot0._sendCount = slot0._sendCount and slot0._sendCount + 1 or 1

		if slot0._sendCount < 2 then
			ItemRpc.instance:sendGetItemListRequest()
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
		else
			slot0._sendCount = 0
		end
	end
end

function slot0.onDestroyView(slot0)
	BackpackPropListModel.instance:clearList()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	slot0._imgBg:UnLoadImage()
end

function slot0._editableInitView(slot0)
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/beibao_bj"))
end

return slot0
