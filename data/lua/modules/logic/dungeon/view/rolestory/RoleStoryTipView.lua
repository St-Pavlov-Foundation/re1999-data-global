module("modules.logic.dungeon.view.rolestory.RoleStoryTipView", package.seeall)

local var_0_0 = class("RoleStoryTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0.itemList = {}
	arg_1_0.goItem = gohelper.findChild(arg_1_0.viewGO, "layout/item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnClose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnClose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btntipsOnClick(arg_6_0)
	gohelper.setActive(arg_6_0.goTips, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:refreshView()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.refreshView(arg_10_0)
	arg_10_0.storyId = RoleStoryModel.instance:getCurActStoryId()

	local var_10_0 = RoleStoryConfig.instance:getScoreConfig(arg_10_0.storyId) or {}

	for iter_10_0 = 1, math.max(#arg_10_0.itemList, #var_10_0) do
		local var_10_1 = arg_10_0.itemList[iter_10_0]

		if not var_10_1 then
			var_10_1 = arg_10_0:createItem(iter_10_0)
			arg_10_0.itemList[iter_10_0] = var_10_1
		end

		arg_10_0:updateItem(var_10_1, var_10_0[iter_10_0], var_10_0[iter_10_0 - 1])
	end
end

function var_0_0.createItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.index = arg_11_1
	var_11_0.go = gohelper.cloneInPlace(arg_11_0.goItem)
	var_11_0.txtNum = gohelper.findChildTextMesh(var_11_0.go, "#txt_num")
	var_11_0.txtScore = gohelper.findChildTextMesh(var_11_0.go, "#txt_score")
	var_11_0.goLine = gohelper.findChild(var_11_0.go, "line")

	gohelper.setActive(var_11_0.goLine, var_11_0.index ~= 1)

	return var_11_0
end

function var_0_0.updateItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_1 then
		return
	end

	arg_12_1.data = arg_12_2

	if not arg_12_2 then
		gohelper.setActive(arg_12_1.go, false)

		return
	end

	gohelper.setActive(arg_12_1.go, true)

	arg_12_1.txtScore.text = tostring(arg_12_2.score)

	if arg_12_3 and arg_12_3.wave < arg_12_2.wave - 1 then
		arg_12_1.txtNum.text = formatLuaLang("rolestoryactivitytips_wave", string.format("%s-%s", GameUtil.getNum2Chinese(arg_12_3.wave + 1), GameUtil.getNum2Chinese(arg_12_2.wave)))
	else
		arg_12_1.txtNum.text = formatLuaLang("rolestoryactivitytips_wave", GameUtil.getNum2Chinese(arg_12_2.wave))
	end
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
