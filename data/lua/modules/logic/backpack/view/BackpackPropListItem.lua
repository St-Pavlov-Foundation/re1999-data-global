module("modules.logic.backpack.view.BackpackPropListItem", package.seeall)

local var_0_0 = class("BackpackPropListItem", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1

	gohelper.setActive(arg_1_1, false)

	arg_1_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_1_1)
end

function var_0_0.addEvents(arg_2_0)
	BackpackController.instance:registerCallback(BackpackEvent.SelectCategory, arg_2_0._categorySelected, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onViewClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.SelectCategory, arg_3_0._categorySelected, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onViewClose, arg_3_0)
end

function var_0_0._categorySelected(arg_4_0)
	if arg_4_0._itemIcon then
		arg_4_0._itemIcon:setAutoPlay(false)

		if not arg_4_0._canvasGroup then
			arg_4_0._canvasGroup = gohelper.onceAddComponent(arg_4_0._itemIcon.go, typeof(UnityEngine.CanvasGroup))
		end

		arg_4_0._canvasGroup.alpha = 1

		TaskDispatcher.cancelTask(arg_4_0._showItem, arg_4_0)

		arg_4_0._itemIcon.go:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1

		BackpackModel.instance:setItemAniHasShown(true)
	end
end

function var_0_0._onViewClose(arg_5_0, arg_5_1)
	if not arg_5_0._mo or not arg_5_0._itemIcon then
		return
	end

	local var_5_0 = arg_5_0._mo.config

	arg_5_0._itemIcon:setRecordFarmItem({
		type = var_5_0.type,
		id = var_5_0.id,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function var_0_0._showItem(arg_6_0)
	gohelper.setActive(arg_6_0.go, true)

	if not BackpackModel.instance:getItemAniHasShown() then
		arg_6_0._itemIcon:playAnimation("backpack_common_in")
	end

	if arg_6_0._index >= 24 then
		BackpackModel.instance:setItemAniHasShown(true)
	end
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	if arg_7_0._index <= 24 then
		TaskDispatcher.runDelay(arg_7_0._showItem, arg_7_0, 0.03 * math.floor((arg_7_0._index - 1) / 6))
	else
		arg_7_0._itemIcon:setAutoPlay(false)
		TaskDispatcher.cancelTask(arg_7_0._showItem, arg_7_0)
		arg_7_0:_showItem()
		BackpackModel.instance:setItemAniHasShown(true)
	end

	local var_7_0 = arg_7_1.config

	arg_7_0._itemIcon:setInPack(true)
	arg_7_0._itemIcon:setMOValue(var_7_0.type, var_7_0.id, var_7_0.quantity, var_7_0.uid)
	arg_7_0._itemIcon:isShowName(false)
	arg_7_0._itemIcon:isShowCount(var_7_0.isStackable ~= 0)
	arg_7_0._itemIcon:isShowEffect(true)
	arg_7_0._itemIcon:setRecordFarmItem({
		type = var_7_0.type,
		id = var_7_0.id,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function var_0_0.onDestroyView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._showItem, arg_8_0)
end

return var_0_0
