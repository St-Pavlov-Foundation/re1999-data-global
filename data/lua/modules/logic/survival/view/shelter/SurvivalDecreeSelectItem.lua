module("modules.logic.survival.view.shelter.SurvivalDecreeSelectItem", package.seeall)

local var_0_0 = class("SurvivalDecreeSelectItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goTagItem = gohelper.findChild(arg_1_0.viewGO, "Tag/TagList/#go_TagItem")

	gohelper.setActive(arg_1_0.goTagItem, false)

	arg_1_0.goDescItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_Descr/Viewport/Content/goItem")

	gohelper.setActive(arg_1_0.goDescItem, false)

	arg_1_0.btnAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Add")
	arg_1_0.itemList = {}
	arg_1_0.tagList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnAdd, arg_2_0.onClickAdd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnAdd)
end

function var_0_0.onClickAdd(arg_4_0)
	if not arg_4_0.mo or arg_4_0.policyId == 0 then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalDecreeSelectTip, MsgBoxEnum.BoxType.Yes_No, function()
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, true)
		SurvivalWeekRpc.instance:sendSurvivalDecreeChoosePolicyRequest(arg_4_0.policyId, arg_4_0.policyIndex)
	end)
end

function var_0_0.updateItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.policyId = arg_6_1
	arg_6_0.policyIndex = arg_6_2

	arg_6_0:onUpdateMO(arg_6_3)
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0.mo = arg_7_1

	gohelper.setActive(arg_7_0.viewGO, arg_7_1 ~= nil)

	if not arg_7_1 then
		return
	end

	arg_7_0:refreshDescList()
end

function var_0_0.refreshTagList(arg_8_0, arg_8_1)
	for iter_8_0 = 1, math.max(#arg_8_1, #arg_8_0.tagList) do
		local var_8_0 = arg_8_0:getTagItem(iter_8_0)

		arg_8_0:updateTagItem(var_8_0, arg_8_1[iter_8_0])
	end
end

function var_0_0.refreshDescList(arg_9_0)
	local var_9_0 = arg_9_0.mo:getPolicyList()

	for iter_9_0 = 1, math.max(#var_9_0, #arg_9_0.itemList) do
		local var_9_1 = arg_9_0:getItem(iter_9_0)

		arg_9_0:updateDescItem(var_9_1, var_9_0[iter_9_0])
	end

	local var_9_2 = {}
	local var_9_3 = {}

	for iter_9_1, iter_9_2 in ipairs(var_9_0) do
		local var_9_4 = SurvivalConfig.instance:getDecreeCo(iter_9_2.id)
		local var_9_5 = string.splitToNumber(var_9_4 and var_9_4.tags, "#")

		if var_9_5 then
			for iter_9_3, iter_9_4 in ipairs(var_9_5) do
				var_9_3[iter_9_4] = 1
			end
		end
	end

	for iter_9_5, iter_9_6 in pairs(var_9_3) do
		table.insert(var_9_2, iter_9_5)
	end

	table.sort(var_9_2, function(arg_10_0, arg_10_1)
		return arg_10_0 < arg_10_1
	end)
	arg_9_0:refreshTagList(var_9_2)
end

function var_0_0.getItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.itemList[arg_11_1]

	if not var_11_0 then
		local var_11_1 = gohelper.cloneInPlace(arg_11_0.goDescItem, tostring(arg_11_1))

		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = var_11_1
		var_11_0.itemList = {}

		for iter_11_0 = 1, 2 do
			local var_11_2 = arg_11_0:getUserDataTb_()

			var_11_2.go = gohelper.findChild(var_11_1, string.format("#go_%s", iter_11_0))
			var_11_2.txtDesc = gohelper.findChildTextMesh(var_11_2.go, "#txt_Descr")
			var_11_2.txtNum = gohelper.findChildTextMesh(var_11_2.go, "#txt_Descr/#go_Like/#txt_Num")
			var_11_2.goLike = gohelper.findChild(var_11_2.go, "#txt_Descr/#go_Like")
			var_11_0.itemList[iter_11_0] = var_11_2
		end

		var_11_0.imageIcon = gohelper.findChildImage(arg_11_0.viewGO, string.format("Left/image_Icon%s", arg_11_1))
		arg_11_0.itemList[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.updateDescItem(arg_12_0, arg_12_1, arg_12_2)
	gohelper.setActive(arg_12_1.go, arg_12_2 ~= nil)

	if not arg_12_2 then
		return
	end

	local var_12_0 = arg_12_2:isFinish()
	local var_12_1 = SurvivalConfig.instance:getDecreeCo(arg_12_2.id)
	local var_12_2 = var_12_0 and 1 or 2

	for iter_12_0 = 1, 2 do
		local var_12_3 = arg_12_1.itemList[iter_12_0]

		gohelper.setActive(var_12_3.go, iter_12_0 == var_12_2)

		if iter_12_0 == var_12_2 then
			gohelper.setActive(var_12_3.goLike, true)

			var_12_3.txtNum.text = string.format("%s/%s", arg_12_2.currVoteNum, arg_12_2.needVoteNum)
			var_12_3.txtDesc.text = string.format(luaLang("SurvivalDecreeSelectItem_descItem_txtDesc"), var_12_1 and var_12_1.name or "", var_12_1 and var_12_1.desc or "")
		end
	end

	if arg_12_1.imageIcon and var_12_1 and var_12_1.icon then
		UISpriteSetMgr.instance:setSurvivalSprite(arg_12_1.imageIcon, var_12_1.icon, true)
	end
end

function var_0_0.getTagItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.tagList[arg_13_1]

	if not var_13_0 then
		local var_13_1 = gohelper.cloneInPlace(arg_13_0.goTagItem, tostring(arg_13_1))

		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = var_13_1
		var_13_0.imgType = gohelper.findChildImage(var_13_1, "#image_Type")
		var_13_0.txtType = gohelper.findChildTextMesh(var_13_1, "#txt_Type")
		arg_13_0.tagList[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.updateTagItem(arg_14_0, arg_14_1, arg_14_2)
	gohelper.setActive(arg_14_1.go, arg_14_2 ~= nil)

	if not arg_14_2 then
		return
	end

	local var_14_0 = lua_survival_tag.configDict[arg_14_2]

	if not var_14_0 then
		return
	end

	arg_14_1.txtType.text = var_14_0.name

	local var_14_1 = SurvivalEnum.ShelterTagColor[var_14_0.color]

	if var_14_1 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_14_1.imgType, var_14_1)
	end
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0
