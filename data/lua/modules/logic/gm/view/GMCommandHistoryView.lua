module("modules.logic.gm.view.GMCommandHistoryView", package.seeall)

local var_0_0 = class("GMCommandHistoryView", BaseView)

var_0_0.LevelType = "人物等级"
var_0_0.HeroAttr = "英雄提升"
var_0_0.ClickItem = "ClickItem"
var_0_0.Return = "Return"

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._maskGO = gohelper.findChild(arg_2_0.viewGO, "addItem")
	arg_2_0._inpItem = SLFramework.UGUI.InputFieldWrap.GetWithPath(arg_2_0.viewGO, "viewport/content/item1/inpText")

	arg_2_0:_hideScroll()
end

function var_0_0.addEvents(arg_3_0)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._inpItem.gameObject):AddClickListener(arg_3_0._onClickInpItem, arg_3_0, nil)
	SLFramework.UGUI.UIClickListener.Get(arg_3_0._maskGO):AddClickListener(arg_3_0._onClickMask, arg_3_0, nil)
	arg_3_0._inpItem:AddOnValueChanged(arg_3_0._onInpValueChanged, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	SLFramework.UGUI.UIClickListener.Get(arg_4_0._inpItem.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(arg_4_0._maskGO):RemoveClickListener()
	arg_4_0._inpItem:RemoveOnValueChanged()
end

function var_0_0.onOpen(arg_5_0)
	GMController.instance:registerCallback(var_0_0.ClickItem, arg_5_0._onClickItem, arg_5_0)
end

function var_0_0.onClose(arg_6_0)
	GMController.instance:unregisterCallback(var_0_0.ClickItem, arg_6_0._onClickItem, arg_6_0)
end

function var_0_0._onClickInpItem(arg_7_0)
	arg_7_0:_showScroll()
end

function var_0_0._onClickMask(arg_8_0)
	arg_8_0:_hideScroll()
end

function var_0_0._showScroll(arg_9_0)
	gohelper.setActive(arg_9_0._maskGO, true)
	recthelper.setAnchorX(arg_9_0._maskGO.transform, -600)
	arg_9_0:_showDefaultItems()
end

function var_0_0._hideScroll(arg_10_0)
	gohelper.setActive(arg_10_0._maskGO, false)
	recthelper.setAnchorX(arg_10_0._maskGO.transform, 0)
	GMAddItemModel.instance:clear()
end

local var_0_1 = "左ctrl + 点击删除对应记录"

function var_0_0._onClickItem(arg_11_0, arg_11_1)
	if arg_11_1.type then
		return
	end

	if arg_11_1.name == var_0_1 then
		return
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		GMCommandHistoryModel.instance:removeCommandHistory(arg_11_1.name)
		arg_11_0:_showDefaultItems()

		return
	end

	arg_11_0._inpItem:SetText(arg_11_1.name)
	arg_11_0:_hideScroll()
end

function var_0_0._onInpValueChanged(arg_12_0, arg_12_1)
	if string.nilorempty(arg_12_1) then
		arg_12_0:_showDefaultItems()
	else
		arg_12_0:_showTargetItems()
	end
end

function var_0_0._showDefaultItems(arg_13_0)
	local var_13_0 = GMCommandHistoryModel.instance:getCommandHistory()

	if #var_13_0 == 0 then
		arg_13_0:_hideScroll()

		return
	end

	local var_13_1 = {
		{
			name = var_0_1
		}
	}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		table.insert(var_13_1, {
			name = iter_13_1
		})
	end

	GMAddItemModel.instance:setList(var_13_1)
end

function var_0_0._showTargetItems(arg_14_0)
	local var_14_0 = GMCommandHistoryModel.instance:getCommandHistory()
	local var_14_1 = arg_14_0._inpItem:GetText()
	local var_14_2 = {}

	for iter_14_0 = 1, #var_14_0 do
		local var_14_3 = var_14_0[iter_14_0]

		if string.find(var_14_3, var_14_1) then
			table.insert(var_14_2, {
				name = var_14_3
			})
		end
	end

	GMAddItemModel.instance:setList(var_14_2)
end

return var_0_0
