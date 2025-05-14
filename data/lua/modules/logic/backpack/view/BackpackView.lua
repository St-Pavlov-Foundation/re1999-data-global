module("modules.logic.backpack.view.BackpackView", package.seeall)

local var_0_0 = class("BackpackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_category")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	BackpackController.instance:registerCallback(BackpackEvent.SelectCategory, arg_2_0._onSelectCategoryChange, arg_2_0)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_2_0._refreshView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.SelectCategory, arg_3_0._onSelectCategoryChange, arg_3_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_3_0._refreshView, arg_3_0)
end

function var_0_0.onOpenFinish(arg_4_0)
	arg_4_0._anim.enabled = true

	if BackpackModel.instance:getCurCategoryId() ~= ItemEnum.CategoryType.Material then
		arg_4_0:_onSelectCategoryChange()
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._cateList = arg_5_0.viewParam.data.cateList
	arg_5_0._enableAni = true

	arg_5_0:_refreshDeadline()
	CharacterBackpackEquipListModel.instance:openEquipView()
end

function var_0_0.onClose(arg_6_0)
	BackpackModel.instance:setItemAniHasShown(false)
end

function var_0_0._refreshView(arg_7_0)
	BackpackModel.instance:setBackpackCategoryList(arg_7_0._cateList)
	BackpackCategoryListModel.instance:setCategoryList(arg_7_0._cateList)
end

function var_0_0._refreshDeadline(arg_8_0)
	arg_8_0._itemDeadline = BackpackModel.instance:getItemDeadline()

	if arg_8_0._itemDeadline then
		TaskDispatcher.runRepeat(arg_8_0._onRefreshDeadline, arg_8_0, 1)
	end
end

function var_0_0._onSelectCategoryChange(arg_9_0)
	local var_9_0 = BackpackModel.instance:getCurCategoryId()

	if arg_9_0.viewContainer:getCurrentSelectCategoryId() == var_9_0 and not arg_9_0.viewParam.isJump then
		arg_9_0.viewParam.isJump = false

		return
	end

	arg_9_0:_refreshView()

	if var_9_0 == ItemEnum.CategoryType.Equip then
		arg_9_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 2)
		TaskDispatcher.cancelTask(arg_9_0._onRefreshDeadline, arg_9_0)
	elseif var_9_0 == ItemEnum.CategoryType.Antique then
		arg_9_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 3)
	else
		arg_9_0.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 2, 1)
		arg_9_0:_refreshDeadline()
	end
end

function var_0_0._onRefreshDeadline(arg_10_0)
	if arg_10_0._itemDeadline and arg_10_0._itemDeadline > 0 and arg_10_0._itemDeadline - ServerTime.now() <= -1 then
		arg_10_0._sendCount = arg_10_0._sendCount and arg_10_0._sendCount + 1 or 1

		if arg_10_0._sendCount < 2 then
			ItemRpc.instance:sendGetItemListRequest()
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
		else
			arg_10_0._sendCount = 0
		end
	end
end

function var_0_0.onDestroyView(arg_11_0)
	BackpackPropListModel.instance:clearList()
	TaskDispatcher.cancelTask(arg_11_0._onRefreshDeadline, arg_11_0)
	arg_11_0._imgBg:UnLoadImage()
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._imgBg = gohelper.findChildSingleImage(arg_12_0.viewGO, "bg/bgimg")

	arg_12_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/beibao_bj"))
end

return var_0_0
