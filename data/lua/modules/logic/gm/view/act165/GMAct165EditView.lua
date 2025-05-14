module("modules.logic.gm.view.act165.GMAct165EditView", package.seeall)

local var_0_0 = class("GMAct165EditView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopre = gohelper.findChild(arg_1_0.viewGO, "#go_pre")
	arg_1_0._inputstory = gohelper.findChildInputField(arg_1_0.viewGO, "#go_pre/#input_story")
	arg_1_0._inputstep = gohelper.findChildInputField(arg_1_0.viewGO, "#go_pre/#input_step")
	arg_1_0._inputkw = gohelper.findChildInputField(arg_1_0.viewGO, "#go_pre/#input_kw")
	arg_1_0._goitemstep = gohelper.findChild(arg_1_0.viewGO, "#go_pre/#go_itemstep")
	arg_1_0._goiditem = gohelper.findChild(arg_1_0.viewGO, "#go_pre/#go_itemstep/#go_iditem")
	arg_1_0._btnsetcount = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_pre/#btn_setcount")
	arg_1_0._btnstep = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_pre/#btn_step")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_pre/#go_topleft")
	arg_1_0._gostep = gohelper.findChild(arg_1_0.viewGO, "#go_step")
	arg_1_0._btnreturn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_step/#btn_return")
	arg_1_0._btnokconfig = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_step/#btn_okconfig")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_step/#btn_ok")
	arg_1_0._btnclear = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_step/#btn_clear")
	arg_1_0._gostepitem = gohelper.findChild(arg_1_0.viewGO, "#go_step/stepitem/#go_stepitem")
	arg_1_0._txtcurStepId = gohelper.findChildText(arg_1_0.viewGO, "#go_step/#txt_curStepId")
	arg_1_0._gokwitem = gohelper.findChild(arg_1_0.viewGO, "#go_step/kwitem/#go_kwitem")
	arg_1_0._txtcurround = gohelper.findChildText(arg_1_0.viewGO, "#go_step/#txt_curround")
	arg_1_0._goscrollround = gohelper.findChild(arg_1_0.viewGO, "#go_step/#go_scrollround")
	arg_1_0._goround = gohelper.findChild(arg_1_0.viewGO, "#go_step/#go_scrollround/Viewport/Content/#go_round")
	arg_1_0._btnround = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_step/#go_scrollround/#btn_round")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "#txt_tip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsetcount:AddClickListener(arg_2_0._btnsetcountOnClick, arg_2_0)
	arg_2_0._btnstep:AddClickListener(arg_2_0._btnstepOnClick, arg_2_0)
	arg_2_0._btnreturn:AddClickListener(arg_2_0._btnreturnOnClick, arg_2_0)
	arg_2_0._btnokconfig:AddClickListener(arg_2_0._btnokconfigOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
	arg_2_0._btnclear:AddClickListener(arg_2_0._btnclearOnClick, arg_2_0)
	arg_2_0._btnround:AddClickListener(arg_2_0._btnroundOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsetcount:RemoveClickListener()
	arg_3_0._btnstep:RemoveClickListener()
	arg_3_0._btnreturn:RemoveClickListener()
	arg_3_0._btnokconfig:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btnclear:RemoveClickListener()
	arg_3_0._btnround:RemoveClickListener()
end

function var_0_0._btnclearOnClick(arg_4_0)
	arg_4_0._curround = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._stepItemList) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			iter_4_3.isClick = false
			iter_4_3.icon.color = Color.white
			iter_4_3.kwList = {}

			arg_4_0:_showKw(iter_4_3)
		end
	end

	arg_4_0._txtcurStepId.text = ""
	arg_4_0.curStepItem = nil
end

function var_0_0._btnreturnOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gopre, true)
	gohelper.setActive(arg_5_0._gostep, false)
end

function var_0_0._btnsetcountOnClick(arg_6_0)
	local var_6_0 = arg_6_0._inputstory:GetText()
	local var_6_1 = arg_6_0._inputstep:GetText()
	local var_6_2 = arg_6_0._inputkw:GetText()

	if string.nilorempty(var_6_0) or string.nilorempty(var_6_1) or string.nilorempty(var_6_2) then
		arg_6_0:_showTip("未完成填写")

		return
	end

	arg_6_0._storyId = tonumber(var_6_0)
	arg_6_0._stepCount = tonumber(var_6_1)
	arg_6_0._kwCount = tonumber(var_6_2)

	for iter_6_0 = 1, var_6_1 do
		local var_6_3 = arg_6_0:_getStepIdItem(iter_6_0)
		local var_6_4 = ""

		for iter_6_1 = 1, var_6_3.count do
			var_6_4 = var_6_4 .. arg_6_0:_getStepId(iter_6_0, iter_6_1) .. "  "
		end

		var_6_3.txtIds.text = var_6_4

		transformhelper.setLocalPosXY(var_6_3.go.transform, -750, -50 + -80 * iter_6_0)
		gohelper.setActive(var_6_3.go, true)
	end
end

function var_0_0._btnokconfigOnClick(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._allround) do
		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			local var_7_1 = arg_7_0:_getStepId(iter_7_2, iter_7_3.index)

			if not var_7_0[var_7_1] then
				var_7_0[var_7_1] = {}
				var_7_0[var_7_1].rounds = {}
				var_7_0[var_7_1].step = iter_7_2
				var_7_0[var_7_1].index = iter_7_3.index
			end

			table.insert(var_7_0[var_7_1].rounds, iter_7_1)
		end
	end

	local var_7_2 = {}

	for iter_7_4, iter_7_5 in pairs(var_7_0) do
		local var_7_3, var_7_4 = arg_7_0:_getConfig(iter_7_5.step, iter_7_5.index, iter_7_5.rounds)

		if not string.nilorempty(var_7_4) then
			table.insert(var_7_2, {
				id = var_7_3,
				info = var_7_4
			})
		end
	end

	table.sort(var_7_2, arg_7_0._sortConfig)

	local var_7_5 = ""

	for iter_7_6, iter_7_7 in ipairs(var_7_2) do
		var_7_5 = var_7_5 .. iter_7_7.id .. "  " .. iter_7_7.info .. "\n\n"
	end

	SLFramework.SLLogger.LogError(var_7_5)
end

function var_0_0._sortConfig(arg_8_0, arg_8_1)
	return arg_8_0.id < arg_8_1.id
end

function var_0_0._btnroundOnClick(arg_9_0)
	if not arg_9_0._isShowRoundPanel then
		arg_9_0:_showAllRound()
	end

	arg_9_0:_activeRoundPanel(not arg_9_0._isShowRoundPanel)
end

function var_0_0._btnstepOnClick(arg_10_0)
	gohelper.setActive(arg_10_0._gopre, false)
	gohelper.setActive(arg_10_0._gostep, true)
	arg_10_0:_createStepItem()
end

function var_0_0._btnokOnClick(arg_11_0)
	if not LuaUtil.tableNotEmpty(arg_11_0._curround) then
		arg_11_0:_showTip("当前路径未选择步骤")

		return
	end

	if not arg_11_0._curround[arg_11_0._stepCount] then
		arg_11_0:_showTip("没有选择结局")

		return
	end

	if not arg_11_0._curround[1] then
		arg_11_0:_showTip("没有选择开头")

		return
	end

	local var_11_0 = arg_11_0:_getSameRound(arg_11_0._curround)

	if var_11_0 == -1 then
		local var_11_1 = tabletool.copy(arg_11_0._curround)

		table.insert(arg_11_0._allround, var_11_1)
		arg_11_0:_showTip("保存成功")
	else
		arg_11_0:_showTip("已有相同路径 " .. var_11_0)
	end
end

function var_0_0._addEvents(arg_12_0)
	return
end

function var_0_0._removeEvents(arg_13_0)
	if arg_13_0._stepIdList then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._stepIdList) do
			PlayerPrefsHelper.setNumber("gmact165stepcount_" .. arg_13_0._storyId .. "_" .. iter_13_0, iter_13_1.count)
			iter_13_1.btnAdd:RemoveClickListener()
			iter_13_1.btnremove:RemoveClickListener()
		end
	end

	if arg_13_0._stepItemList then
		for iter_13_2, iter_13_3 in pairs(arg_13_0._stepItemList) do
			for iter_13_4, iter_13_5 in pairs(iter_13_3) do
				iter_13_5.btn:RemoveClickListener()
			end
		end
	end

	if arg_13_0._roundItemList then
		for iter_13_6, iter_13_7 in pairs(arg_13_0._roundItemList) do
			iter_13_7.btn:RemoveClickListener()
		end
	end

	if arg_13_0._kwItemList then
		for iter_13_8, iter_13_9 in pairs(arg_13_0._kwItemList) do
			iter_13_9.btn:RemoveClickListener()
		end
	end
end

function var_0_0._getStepIdItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._stepIdList[arg_14_1]

	if not var_14_0 then
		local var_14_1 = gohelper.cloneInPlace(arg_14_0._goiditem)
		local var_14_2 = gohelper.findChildButtonWithAudio(var_14_1, "btn_add")
		local var_14_3 = gohelper.findChildButtonWithAudio(var_14_1, "btn_remove")
		local var_14_4 = gohelper.findChildText(var_14_1, "txt_count")
		local var_14_5 = gohelper.findChildText(var_14_1, "ids")
		local var_14_6 = gohelper.findChildText(var_14_1, "txt_index")
		local var_14_7 = PlayerPrefsHelper.getNumber("gmact165stepcount_" .. arg_14_0._storyId .. "_" .. arg_14_1, 1)

		var_14_6.text = arg_14_1
		var_14_4.text = var_14_7

		local function var_14_8()
			var_14_4.text = var_14_0.count

			local var_15_0 = ""

			for iter_15_0 = 1, var_14_0.count do
				var_15_0 = var_15_0 .. arg_14_0:_getStepId(arg_14_1, iter_15_0) .. "  "
			end

			var_14_5.text = var_15_0
		end

		local function var_14_9()
			if arg_14_1 ~= 1 then
				var_14_0.count = var_14_0.count + 1

				var_14_8()
			end
		end

		local function var_14_10()
			if arg_14_1 ~= 1 and var_14_0.count > 1 then
				var_14_0.count = var_14_0.count - 1
				var_14_4.text = var_14_0.count

				local var_17_0 = ""

				for iter_17_0 = 1, var_14_0.count do
					var_17_0 = var_17_0 .. arg_14_0:_getStepId(arg_14_1, iter_17_0) .. "  "
				end

				var_14_5.text = var_17_0

				var_14_8()
			end
		end

		var_14_2:AddClickListener(var_14_9, arg_14_0)
		var_14_3:AddClickListener(var_14_10, arg_14_0)

		var_14_0 = {
			go = var_14_1,
			btnAdd = var_14_2,
			btnremove = var_14_3,
			txtcount = var_14_4,
			txtIds = var_14_5,
			count = var_14_7
		}
		arg_14_0._stepIdList[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0:_addEvents()
	arg_18_0._inputstory:SetText("1")
	arg_18_0._inputstep:SetText("8")
	arg_18_0._inputkw:SetText("10")

	arg_18_0._stepIdList = arg_18_0:getUserDataTb_()
	arg_18_0._stepItemList = arg_18_0:getUserDataTb_()
	arg_18_0._roundItemList = arg_18_0:getUserDataTb_()
	arg_18_0._kwItemList = arg_18_0:getUserDataTb_()
	arg_18_0._allround = {}
	arg_18_0._curround = {}

	arg_18_0:_activeRoundPanel(false)
	arg_18_0:_showCurRound()
	gohelper.setActive(arg_18_0._gopre, true)
	gohelper.setActive(arg_18_0._gostep, false)
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	return
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0:_removeEvents()
	TaskDispatcher.cancelTask(arg_22_0._hideTip, arg_22_0)
end

function var_0_0._getStepId(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_0._storyId * 1000 + arg_23_1 * 100 + arg_23_2
end

function var_0_0._createStepItem(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0._stepIdList) do
		local var_24_0 = iter_24_1.count or 0

		for iter_24_2 = 1, var_24_0 do
			local var_24_1 = arg_24_0:_getStepItem(iter_24_0, iter_24_2)
			local var_24_2 = -900 + iter_24_0 * 200
			local var_24_3 = 50 + var_24_0 * 100 - iter_24_2 * 200

			transformhelper.setLocalPosXY(var_24_1.go.transform, var_24_2, var_24_3)
			gohelper.setActive(var_24_1.go, true)
		end
	end
end

function var_0_0._getStepItem(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0._stepItemList[arg_25_1]

	if not var_25_0 then
		var_25_0 = arg_25_0:getUserDataTb_()
		arg_25_0._stepItemList[arg_25_1] = var_25_0
	end

	local var_25_1 = var_25_0[arg_25_2]

	if not var_25_1 then
		var_25_1 = arg_25_0:getUserDataTb_()

		local var_25_2 = arg_25_0:_getStepId(arg_25_1, arg_25_2)
		local var_25_3 = gohelper.cloneInPlace(arg_25_0._gostepitem, var_25_2)
		local var_25_4 = gohelper.findChildText(var_25_3, "txt")

		var_25_1.txtkw = gohelper.findChildText(var_25_3, "kw")
		var_25_1.icon = gohelper.findChildImage(var_25_3, "icon")
		var_25_4.text = var_25_2

		local function var_25_5()
			arg_25_0:_onClickStepItem(var_25_1)
		end

		local var_25_6 = gohelper.findChildButtonWithAudio(var_25_3, "btn")

		var_25_6:AddClickListener(var_25_5, arg_25_0)

		var_25_1.go = var_25_3
		var_25_1.btn = var_25_6
		var_25_1.isClick = false
		var_25_1.step = arg_25_1
		var_25_1.index = arg_25_2
		var_25_1.id = var_25_2
		var_25_1.kwList = {}
		var_25_0[arg_25_2] = var_25_1
	end

	return var_25_1
end

function var_0_0._onClickStepItem(arg_27_0, arg_27_1)
	if arg_27_1.isClick then
		arg_27_0:_removeCurStep(arg_27_1)
	else
		arg_27_0:_addCurStep(arg_27_1)
	end

	arg_27_0:_refreshKwItem(arg_27_1)
	arg_27_0:_showCurRound()
end

function var_0_0._addCurStep(arg_28_0, arg_28_1)
	if arg_28_0._curround[arg_28_1.step] then
		local var_28_0 = arg_28_0._curround[arg_28_1.step].index
		local var_28_1 = arg_28_0._stepItemList[arg_28_1.step][var_28_0]

		arg_28_0:_removeCurStep(var_28_1)
	end

	if not arg_28_0._curround[arg_28_1.step] then
		arg_28_0._curround[arg_28_1.step] = {}
	end

	arg_28_0._curround[arg_28_1.step].index = arg_28_1.index
	arg_28_0._curround[arg_28_1.step].kws = {}
	arg_28_0._txtcurStepId.text = "步骤：" .. arg_28_1.id
	arg_28_0.curStepItem = arg_28_1

	arg_28_0:_showKw(arg_28_0.curStepItem)

	arg_28_1.icon.color = Color.yellow
	arg_28_1.isClick = true
end

function var_0_0.checkHasPreRound(arg_29_0, arg_29_1)
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(arg_29_0._curround) do
		if iter_29_0 <= arg_29_1 then
			var_29_0[iter_29_0] = iter_29_1
		end
	end

	for iter_29_2, iter_29_3 in pairs(arg_29_0._allround) do
		if arg_29_0:isHasPreRound(var_29_0, iter_29_3) then
			return true
		end
	end

	return false
end

function var_0_0.isHasPreRound(arg_30_0, arg_30_1, arg_30_2)
	if not LuaUtil.tableNotEmpty(arg_30_1) or not LuaUtil.tableNotEmpty(arg_30_2) then
		return false
	end

	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		if arg_30_2[iter_30_0] ~= iter_30_1 then
			return false
		end
	end

	return true
end

function var_0_0._removeCurStep(arg_31_0, arg_31_1)
	arg_31_1.icon.color = Color.white
	arg_31_1.isClick = false
	arg_31_0._curround[arg_31_1.step] = nil
	arg_31_0.curStepItem = nil
	arg_31_1.kwList = {}
	arg_31_0._txtcurStepId.text = ""

	arg_31_0:_showKw(arg_31_1)
end

function var_0_0._showCurRound(arg_32_0)
	local var_32_0 = arg_32_0:_getRoundStr(arg_32_0._curround)

	arg_32_0._txtcurround.text = var_32_0
end

function var_0_0._getRoundStr(arg_33_0, arg_33_1)
	local var_33_0 = ""

	for iter_33_0, iter_33_1 in pairs(arg_33_1) do
		if iter_33_0 == 1 then
			var_33_0 = var_33_0 .. arg_33_0:_getStepIdAndKw(iter_33_0, iter_33_1.index, iter_33_1.kws)
		else
			var_33_0 = var_33_0 .. "#" .. arg_33_0:_getStepIdAndKw(iter_33_0, iter_33_1.index, iter_33_1.kws)
		end
	end

	return var_33_0
end

function var_0_0._getStepIdAndKw(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_0:_getStepId(arg_34_1, arg_34_2)
	local var_34_1 = arg_34_0:_getListStr(arg_34_3, "#")

	if not string.nilorempty(var_34_1) then
		return string.format("%s<color=#00FFE1><size=25>(%s)</color></size>", var_34_0, var_34_1)
	end

	return var_34_0
end

function var_0_0._showAllRound(arg_35_0)
	arg_35_0._roundItemList = arg_35_0:getUserDataTb_()

	gohelper.CreateObjList(arg_35_0, arg_35_0._allRoundCB, arg_35_0._allround, arg_35_0._goround.transform.parent.gameObject, arg_35_0._goround)
end

function var_0_0._getSameRound(arg_36_0, arg_36_1)
	for iter_36_0, iter_36_1 in pairs(arg_36_0._allround) do
		if arg_36_0:_isSameTable(arg_36_1, iter_36_1) then
			return iter_36_0
		end
	end

	return -1
end

function var_0_0._allRoundCB(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	local var_37_0 = arg_37_0:getUserDataTb_()

	var_37_0.btn = gohelper.findChildButtonWithAudio(arg_37_1, "txt/btn")
	var_37_0.txt = gohelper.findChildText(arg_37_1, "txt")
	var_37_0.txt.text = arg_37_0:_getRoundStr(arg_37_2)

	local function var_37_1()
		arg_37_0:_onClickDeleteBtn(arg_37_3)
	end

	var_37_0.go = arg_37_1

	var_37_0.btn:AddClickListener(var_37_1, arg_37_0)

	arg_37_0._roundItemList[arg_37_3] = var_37_0
end

function var_0_0._onClickDeleteBtn(arg_39_0, arg_39_1)
	table.remove(arg_39_0._allround, arg_39_1)

	local var_39_0 = arg_39_0._roundItemList[arg_39_1]

	gohelper.setActive(var_39_0.go, false)
	table.remove(arg_39_0._roundItemList, arg_39_1)
end

function var_0_0._isSameTable(arg_40_0, arg_40_1, arg_40_2)
	if tabletool.len(arg_40_1) ~= tabletool.len(arg_40_2) then
		return false
	end

	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		if iter_40_1 ~= arg_40_2[iter_40_0] then
			return false
		end
	end

	return true
end

function var_0_0._createKwItem(arg_41_0)
	arg_41_0._kwItemList = arg_41_0:getUserDataTb_()

	local var_41_0 = {}

	for iter_41_0 = 1, arg_41_0._kwCount do
		table.insert(var_41_0, iter_41_0)
	end

	gohelper.CreateObjList(arg_41_0, arg_41_0._createKwItemCB, var_41_0, arg_41_0._gokwitem.transform.parent.gameObject, arg_41_0._gokwitem)
end

function var_0_0._createKwItemCB(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = arg_42_0:getUserDataTb_()

	var_42_0.id = arg_42_0._storyId * 100 + arg_42_3
	var_42_0.isClick = false
	var_42_0.go = arg_42_1
	var_42_0.txt = gohelper.findChildText(arg_42_1, "txt")
	var_42_0.icon = gohelper.findChildImage(arg_42_1, "icon")
	var_42_0.btn = gohelper.findChildButtonWithAudio(arg_42_1, "btn")
	var_42_0.txt.text = var_42_0.id

	local function var_42_1()
		arg_42_0:_onClickKwItem(var_42_0)
	end

	var_42_0.btn:AddClickListener(var_42_1, arg_42_0)

	arg_42_0._kwItemList[arg_42_3] = var_42_0
end

function var_0_0._onClickKwItem(arg_44_0, arg_44_1)
	if not arg_44_0.curStepItem then
		arg_44_0:_showTip("未选择步骤")

		return
	end

	if arg_44_0.curStepItem.step == arg_44_0._stepCount then
		arg_44_0:_showTip("结局不需要选关键词")

		return
	end

	if arg_44_1.isClick then
		arg_44_0:_removeKw(arg_44_1)
	else
		arg_44_0:_addKw(arg_44_1)
	end
end

function var_0_0._addKw(arg_45_0, arg_45_1)
	arg_45_1.icon.color = Color.yellow
	arg_45_1.isClick = true

	if not LuaUtil.tableContains(arg_45_0.curStepItem.kwList) then
		table.insert(arg_45_0.curStepItem.kwList, arg_45_1.id)

		arg_45_0._curround[arg_45_0.curStepItem.step].kws = arg_45_0.curStepItem.kwList
	end

	arg_45_0:_showKw(arg_45_0.curStepItem)
	arg_45_0:_showCurRound()
end

function var_0_0._removeKw(arg_46_0, arg_46_1)
	arg_46_1.icon.color = Color.white
	arg_46_1.isClick = false

	tabletool.removeValue(arg_46_0.curStepItem.kwList, arg_46_1.id)

	arg_46_0._curround[arg_46_0.curStepItem.step].kws = arg_46_0.curStepItem.kwList

	arg_46_0:_showKw(arg_46_0.curStepItem)
	arg_46_0:_showCurRound()
end

function var_0_0._refreshKwItem(arg_47_0, arg_47_1)
	for iter_47_0, iter_47_1 in pairs(arg_47_0._kwItemList) do
		local var_47_0 = LuaUtil.tableContains(arg_47_1.kwList)

		iter_47_1.icon.color = var_47_0 and Color.yellow or Color.white
		iter_47_1.isClick = var_47_0
	end
end

function var_0_0._showKw(arg_48_0, arg_48_1)
	if arg_48_1 then
		local var_48_0 = arg_48_0:_getListStr(arg_48_1.kwList, "#")

		arg_48_1.txtkw.text = var_48_0
	end
end

function var_0_0._showTip(arg_49_0, arg_49_1)
	arg_49_0._txttip.text = arg_49_1

	TaskDispatcher.cancelTask(arg_49_0._hideTip, arg_49_0)
	TaskDispatcher.runDelay(arg_49_0._hideTip, arg_49_0, 3)
end

function var_0_0._hideTip(arg_50_0)
	arg_50_0._txttip.text = ""
end

function var_0_0._activeRoundPanel(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1 and -960 or -2480

	transformhelper.setLocalPosXY(arg_51_0._goscrollround.transform, var_51_0, 540)

	arg_51_0._isShowRoundPanel = arg_51_1
end

function var_0_0._getListStr(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = ""

	if arg_52_1 then
		for iter_52_0, iter_52_1 in pairs(arg_52_1) do
			var_52_0 = arg_52_0:_getStr(var_52_0, iter_52_0, iter_52_1, arg_52_2)
		end
	end

	return var_52_0
end

function var_0_0._getStr(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	if arg_53_2 == 1 then
		arg_53_1 = arg_53_1 .. arg_53_3
	else
		arg_53_1 = arg_53_1 .. arg_53_4 .. arg_53_3
	end

	return arg_53_1
end

function var_0_0._getConfig(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = {}
	local var_54_1 = {}
	local var_54_2 = arg_54_0:_getStepId(arg_54_1, arg_54_2)

	for iter_54_0, iter_54_1 in pairs(arg_54_3) do
		local var_54_3 = false
		local var_54_4 = {}

		var_54_0[iter_54_0] = {}

		for iter_54_2, iter_54_3 in pairs(iter_54_1) do
			if var_54_3 then
				local var_54_5 = arg_54_0:_getStepId(iter_54_2, iter_54_3.index)

				table.insert(var_54_0[iter_54_0], 1, var_54_5)

				local var_54_6 = var_54_1[var_54_5]

				if var_54_6 then
					if not arg_54_0:_isSameTable(var_54_6, var_54_4) then
						local var_54_7 = string.format("相同后置步骤选择的关键词不同：%s   %s   %s   %s", var_54_2, var_54_5, arg_54_0:_getListStr(var_54_4, "#"), arg_54_0:_getListStr(var_54_6, "#"))

						arg_54_0:_showTip(var_54_7)
					end

					break
				end

				var_54_1[var_54_5] = var_54_4

				break
			end

			if iter_54_2 == arg_54_1 then
				var_54_3 = true
				var_54_4 = iter_54_3.kws
			else
				local var_54_8 = arg_54_0:_getStepId(iter_54_2, iter_54_3.index)

				table.insert(var_54_0[iter_54_0], var_54_8)
			end
		end
	end

	local var_54_9 = ""

	for iter_54_4, iter_54_5 in pairs(var_54_0) do
		local var_54_10 = arg_54_0:_getListStr(iter_54_5, "#")

		var_54_9 = arg_54_0:_getStr(var_54_9, iter_54_4, var_54_10, "|")
	end

	local var_54_11 = ""
	local var_54_12 = 1
	local var_54_13 = {}

	for iter_54_6, iter_54_7 in pairs(var_54_1) do
		local var_54_14 = iter_54_6 .. "#" .. arg_54_0:_getListStr(iter_54_7, "#")

		var_54_11 = arg_54_0:_getStr(var_54_11, var_54_12, var_54_14, "|")
		var_54_12 = var_54_12 + 1

		for iter_54_8, iter_54_9 in pairs(iter_54_7) do
			if not LuaUtil.tableContains(var_54_13, iter_54_9) then
				table.insert(var_54_13, iter_54_9)
			end
		end
	end

	local var_54_15 = "可跳转步骤的前置步骤要求:  " .. var_54_9

	return var_54_2, var_54_15
end

return var_0_0
