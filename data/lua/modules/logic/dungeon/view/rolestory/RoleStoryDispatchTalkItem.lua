module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkItem", package.seeall)

local var_0_0 = class("RoleStoryDispatchTalkItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.scrollconent = arg_1_0.viewGO.transform.parent
	arg_1_0.itemList = {}

	for iter_1_0 = 1, 2 do
		local var_1_0 = arg_1_0:getUserDataTb_()

		arg_1_0.itemList[iter_1_0] = var_1_0
		var_1_0.txtInfo = gohelper.findChildTextMesh(arg_1_0.viewGO, string.format("info%s", iter_1_0))
		var_1_0.txtRole = gohelper.findChildTextMesh(arg_1_0.viewGO, string.format("info%s/#txt_role", iter_1_0))
		var_1_0.canvasGroup = var_1_0.txtInfo.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.refreshItem(arg_4_0)
	arg_4_0:killTween()

	if not arg_4_0.data then
		arg_4_0:clear()
		gohelper.setActive(arg_4_0.viewGO, false)

		return
	end

	gohelper.setActive(arg_4_0.viewGO, true)

	local var_4_0 = arg_4_0.data.type

	arg_4_0.curItem = arg_4_0.itemList[var_4_0]

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.itemList) do
		gohelper.setActive(iter_4_1.txtInfo, var_4_0 == iter_4_0)
	end

	if var_4_0 == RoleStoryEnum.TalkType.Special then
		SLFramework.UGUI.GuiHelper.SetColor(arg_4_0.curItem.txtRole, string.format("#%s", arg_4_0.data.color))
		SLFramework.UGUI.GuiHelper.SetColor(arg_4_0.curItem.txtInfo, string.format("#%s", arg_4_0.data.color))
	end

	arg_4_0.curItem.canvasGroup.alpha = 1

	arg_4_0:setText(arg_4_0.data)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.data = arg_5_1
	arg_5_0.index = arg_5_2

	arg_5_0:refreshItem()
end

function var_0_0.startTween(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.callback = arg_6_1
	arg_6_0.callbackObj = arg_6_2

	if not arg_6_0.data then
		arg_6_0:finishTween()

		return
	end

	if not arg_6_0.tween then
		arg_6_0.tween = RoleStoryDispatchTalkItemTween.New()
	end

	arg_6_0.curItem.txtInfo.text = arg_6_0.data.content
	arg_6_0.curItem.txtRole.text = ""

	arg_6_0.tween:playTween(arg_6_0.curItem.txtInfo, arg_6_0.data.content, arg_6_0.finishTween, arg_6_0, arg_6_0.scrollconent)
end

function var_0_0.finishTween(arg_7_0)
	arg_7_0:setText(arg_7_0.data)

	local var_7_0 = arg_7_0.callback
	local var_7_1 = arg_7_0.callbackObj

	arg_7_0.callback = nil
	arg_7_0.callbackObj = nil

	if var_7_0 then
		var_7_0(var_7_1)
	end
end

function var_0_0.clearText(arg_8_0)
	arg_8_0:setText()

	if arg_8_0.curItem then
		arg_8_0.curItem.canvasGroup.alpha = 0
	end
end

function var_0_0.setText(arg_9_0, arg_9_1)
	if not arg_9_0.curItem then
		return
	end

	arg_9_0.curItem.txtInfo.text = arg_9_1 and arg_9_1.content or ""
	arg_9_0.curItem.txtRole.text = arg_9_1 and arg_9_1.speaker or ""
end

function var_0_0.killTween(arg_10_0)
	if arg_10_0.tween then
		arg_10_0.tween:killTween()
	end
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0.clear(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0.tween then
		arg_13_0.tween:destroy()
	end

	arg_13_0:clear()
end

return var_0_0
