module("modules.logic.backpack.view.BackpackCategoryListItem", package.seeall)

local var_0_0 = class("BackpackCategoryListItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._bgs = arg_1_0:getUserDataTb_()
	arg_1_0._nameTxt = arg_1_0:getUserDataTb_()
	arg_1_0._subnameTxt = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 2 do
		arg_1_0._bgs[iter_1_0] = gohelper.findChild(arg_1_1, "bg" .. tostring(iter_1_0))
		arg_1_0._nameTxt[iter_1_0] = gohelper.findChildText(arg_1_0._bgs[iter_1_0], "#txt_itemcn" .. tostring(iter_1_0))
		arg_1_0._subnameTxt[iter_1_0] = gohelper.findChildText(arg_1_0._bgs[iter_1_0], "#txt_itemen" .. tostring(iter_1_0))
	end

	gohelper.setActive(arg_1_0._bgs[2], false)

	arg_1_0._btnCategory = SLFramework.UGUI.UIClickListener.Get(arg_1_1)
	arg_1_0._deadline1 = gohelper.findChild(arg_1_1, "bg1/#txt_itemcn1/deadline1")
	arg_1_0._deadlinebg = gohelper.findChildImage(arg_1_1, "bg1/#txt_itemcn1/deadline1/deadlinebg")
	arg_1_0._deadlineTxt1 = gohelper.findChildText(arg_1_0._deadline1, "deadlinetxt")
	arg_1_0._deadlineEffect = gohelper.findChild(arg_1_0._deadline1, "#effect")
	arg_1_0._deadlinetimeicon = gohelper.findChildImage(arg_1_0._deadline1, "deadlinetxt/timeicon")
	arg_1_0._format1 = gohelper.findChildText(arg_1_0._deadline1, "deadlinetxt/format")
	arg_1_0._lastIsDay = nil
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnCategory:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	TaskDispatcher.runRepeat(arg_2_0._onRefreshDeadline, arg_2_0, 1)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnCategory:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_3_0._onRefreshDeadline, arg_3_0, 1)
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = arg_4_0:_isSelected()

	gohelper.setActive(arg_4_0._bgs[1], not var_4_0)
	gohelper.setActive(arg_4_0._bgs[2], var_4_0)

	if var_4_0 then
		arg_4_0._nameTxt[2].text = arg_4_1.name
		arg_4_0._subnameTxt[2].text = arg_4_1.subname
	else
		arg_4_0._nameTxt[1].text = arg_4_1.name
		arg_4_0._subnameTxt[1].text = arg_4_1.subname
	end

	arg_4_0:_onRefreshDeadline()
end

function var_0_0._onRefreshDeadline(arg_5_0)
	if arg_5_0:_isSelected() then
		return
	end

	local var_5_0
	local var_5_1
	local var_5_2
	local var_5_3
	local var_5_4
	local var_5_5
	local var_5_6
	local var_5_7 = arg_5_0._deadline1

	if arg_5_0._mo.id == ItemEnum.CategoryType.Equip then
		gohelper.setActive(var_5_7, false)

		return
	end

	local var_5_8 = arg_5_0._deadlineTxt1
	local var_5_9 = arg_5_0._format1
	local var_5_10 = arg_5_0._deadlinebg
	local var_5_11 = arg_5_0._deadlinetimeicon
	local var_5_12 = arg_5_0._deadlineEffect
	local var_5_13 = BackpackModel.instance:getCategoryItemsDeadline(arg_5_0._mo.id)

	if var_5_13 and var_5_13 > 0 and arg_5_0._mo.id ~= 0 then
		gohelper.setActive(var_5_7, true)

		local var_5_14 = math.floor(var_5_13 - ServerTime.now())

		if var_5_14 <= 0 then
			gohelper.setActive(var_5_7, false)

			return
		end

		local var_5_15

		var_5_8.text, var_5_9.text, var_5_15 = TimeUtil.secondToRoughTime(var_5_14, true)

		if arg_5_0._lastIsDay == nil or arg_5_0._lastIsDay ~= var_5_15 then
			UISpriteSetMgr.instance:setCommonSprite(var_5_10, var_5_15 and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(var_5_11, var_5_15 and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(var_5_8, var_5_15 and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(var_5_9, var_5_15 and "#98D687" or "#E99B56")
			gohelper.setActive(var_5_12, not var_5_15)

			arg_5_0._lastIsDay = var_5_15
		end
	else
		gohelper.setActive(var_5_7, false)
	end

	gohelper.setActive(arg_5_0._deadline2, false)
end

function var_0_0._isSelected(arg_6_0)
	return arg_6_0._mo.id == BackpackModel.instance:getCurCategoryId()
end

function var_0_0._onItemClick(arg_7_0)
	if arg_7_0:_isSelected() then
		return
	end

	BackpackModel.instance:setItemAniHasShown(false)
	BackpackModel.instance:setCurCategoryId(arg_7_0._mo.id)
	BackpackController.instance:dispatchEvent(BackpackEvent.SelectCategory)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0._lastIsDay = nil
end

return var_0_0
