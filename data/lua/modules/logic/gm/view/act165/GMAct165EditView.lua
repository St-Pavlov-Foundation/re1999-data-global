module("modules.logic.gm.view.act165.GMAct165EditView", package.seeall)

slot0 = class("GMAct165EditView", BaseView)

function slot0.onInitView(slot0)
	slot0._gopre = gohelper.findChild(slot0.viewGO, "#go_pre")
	slot0._inputstory = gohelper.findChildInputField(slot0.viewGO, "#go_pre/#input_story")
	slot0._inputstep = gohelper.findChildInputField(slot0.viewGO, "#go_pre/#input_step")
	slot0._inputkw = gohelper.findChildInputField(slot0.viewGO, "#go_pre/#input_kw")
	slot0._goitemstep = gohelper.findChild(slot0.viewGO, "#go_pre/#go_itemstep")
	slot0._goiditem = gohelper.findChild(slot0.viewGO, "#go_pre/#go_itemstep/#go_iditem")
	slot0._btnsetcount = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_pre/#btn_setcount")
	slot0._btnstep = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_pre/#btn_step")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_pre/#go_topleft")
	slot0._gostep = gohelper.findChild(slot0.viewGO, "#go_step")
	slot0._btnreturn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_step/#btn_return")
	slot0._btnokconfig = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_step/#btn_okconfig")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_step/#btn_ok")
	slot0._btnclear = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_step/#btn_clear")
	slot0._gostepitem = gohelper.findChild(slot0.viewGO, "#go_step/stepitem/#go_stepitem")
	slot0._txtcurStepId = gohelper.findChildText(slot0.viewGO, "#go_step/#txt_curStepId")
	slot0._gokwitem = gohelper.findChild(slot0.viewGO, "#go_step/kwitem/#go_kwitem")
	slot0._txtcurround = gohelper.findChildText(slot0.viewGO, "#go_step/#txt_curround")
	slot0._goscrollround = gohelper.findChild(slot0.viewGO, "#go_step/#go_scrollround")
	slot0._goround = gohelper.findChild(slot0.viewGO, "#go_step/#go_scrollround/Viewport/Content/#go_round")
	slot0._btnround = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_step/#go_scrollround/#btn_round")
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "#txt_tip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsetcount:AddClickListener(slot0._btnsetcountOnClick, slot0)
	slot0._btnstep:AddClickListener(slot0._btnstepOnClick, slot0)
	slot0._btnreturn:AddClickListener(slot0._btnreturnOnClick, slot0)
	slot0._btnokconfig:AddClickListener(slot0._btnokconfigOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnclear:AddClickListener(slot0._btnclearOnClick, slot0)
	slot0._btnround:AddClickListener(slot0._btnroundOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsetcount:RemoveClickListener()
	slot0._btnstep:RemoveClickListener()
	slot0._btnreturn:RemoveClickListener()
	slot0._btnokconfig:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
	slot0._btnclear:RemoveClickListener()
	slot0._btnround:RemoveClickListener()
end

function slot0._btnclearOnClick(slot0)
	slot0._curround = {}

	for slot4, slot5 in pairs(slot0._stepItemList) do
		for slot9, slot10 in pairs(slot5) do
			slot10.isClick = false
			slot10.icon.color = Color.white
			slot10.kwList = {}

			slot0:_showKw(slot10)
		end
	end

	slot0._txtcurStepId.text = ""
	slot0.curStepItem = nil
end

function slot0._btnreturnOnClick(slot0)
	gohelper.setActive(slot0._gopre, true)
	gohelper.setActive(slot0._gostep, false)
end

function slot0._btnsetcountOnClick(slot0)
	slot2 = slot0._inputstep:GetText()
	slot3 = slot0._inputkw:GetText()

	if string.nilorempty(slot0._inputstory:GetText()) or string.nilorempty(slot2) or string.nilorempty(slot3) then
		slot0:_showTip("未完成填写")

		return
	end

	slot0._storyId = tonumber(slot1)
	slot0._stepCount = tonumber(slot2)
	slot0._kwCount = tonumber(slot3)

	for slot7 = 1, slot2 do
		for slot13 = 1, slot0:_getStepIdItem(slot7).count do
			slot9 = "" .. slot0:_getStepId(slot7, slot13) .. "  "
		end

		slot8.txtIds.text = slot9

		transformhelper.setLocalPosXY(slot8.go.transform, -750, -50 + -80 * slot7)
		gohelper.setActive(slot8.go, true)
	end
end

function slot0._btnokconfigOnClick(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._allround) do
		for slot10, slot11 in pairs(slot6) do
			if not slot1[slot0:_getStepId(slot10, slot11.index)] then
				slot1[slot12] = {
					rounds = {},
					step = slot10,
					index = slot11.index
				}
			end

			table.insert(slot1[slot12].rounds, slot6)
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		slot8, slot9 = slot0:_getConfig(slot7.step, slot7.index, slot7.rounds)

		if not string.nilorempty(slot9) then
			table.insert(slot2, {
				id = slot8,
				info = slot9
			})
		end
	end

	table.sort(slot2, slot0._sortConfig)

	for slot7, slot8 in ipairs(slot2) do
		slot3 = "" .. slot8.id .. "  " .. slot8.info .. "\n\n"
	end

	SLFramework.SLLogger.LogError(slot3)
end

function slot0._sortConfig(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0._btnroundOnClick(slot0)
	if not slot0._isShowRoundPanel then
		slot0:_showAllRound()
	end

	slot0:_activeRoundPanel(not slot0._isShowRoundPanel)
end

function slot0._btnstepOnClick(slot0)
	gohelper.setActive(slot0._gopre, false)
	gohelper.setActive(slot0._gostep, true)
	slot0:_createStepItem()
end

function slot0._btnokOnClick(slot0)
	if not LuaUtil.tableNotEmpty(slot0._curround) then
		slot0:_showTip("当前路径未选择步骤")

		return
	end

	if not slot0._curround[slot0._stepCount] then
		slot0:_showTip("没有选择结局")

		return
	end

	if not slot0._curround[1] then
		slot0:_showTip("没有选择开头")

		return
	end

	if slot0:_getSameRound(slot0._curround) == -1 then
		table.insert(slot0._allround, tabletool.copy(slot0._curround))
		slot0:_showTip("保存成功")
	else
		slot0:_showTip("已有相同路径 " .. slot1)
	end
end

function slot0._addEvents(slot0)
end

function slot0._removeEvents(slot0)
	if slot0._stepIdList then
		for slot4, slot5 in pairs(slot0._stepIdList) do
			PlayerPrefsHelper.setNumber("gmact165stepcount_" .. slot0._storyId .. "_" .. slot4, slot5.count)
			slot5.btnAdd:RemoveClickListener()
			slot5.btnremove:RemoveClickListener()
		end
	end

	if slot0._stepItemList then
		for slot4, slot5 in pairs(slot0._stepItemList) do
			for slot9, slot10 in pairs(slot5) do
				slot10.btn:RemoveClickListener()
			end
		end
	end

	if slot0._roundItemList then
		for slot4, slot5 in pairs(slot0._roundItemList) do
			slot5.btn:RemoveClickListener()
		end
	end

	if slot0._kwItemList then
		for slot4, slot5 in pairs(slot0._kwItemList) do
			slot5.btn:RemoveClickListener()
		end
	end
end

function slot0._getStepIdItem(slot0, slot1)
	if not slot0._stepIdList[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._goiditem)
		slot4 = gohelper.findChildButtonWithAudio(slot3, "btn_add")
		slot5 = gohelper.findChildButtonWithAudio(slot3, "btn_remove")
		slot6 = gohelper.findChildText(slot3, "txt_count")
		slot9 = PlayerPrefsHelper.getNumber("gmact165stepcount_" .. slot0._storyId .. "_" .. slot1, 1)
		gohelper.findChildText(slot3, "txt_index").text = slot1
		slot6.text = slot9

		function slot10()
			uv0.text = uv1.count

			for slot4 = 1, uv1.count do
				slot0 = "" .. uv2:_getStepId(uv3, slot4) .. "  "
			end

			uv4.text = slot0
		end

		slot4:AddClickListener(function ()
			if uv0 ~= 1 then
				uv1.count = uv1.count + 1

				uv2()
			end
		end, slot0)
		slot5:AddClickListener(function ()
			if uv0 ~= 1 and uv1.count > 1 then
				uv1.count = uv1.count - 1
				uv2.text = uv1.count

				for slot4 = 1, uv1.count do
					slot0 = "" .. uv3:_getStepId(uv0, slot4) .. "  "
				end

				uv4.text = slot0

				uv5()
			end
		end, slot0)

		slot0._stepIdList[slot1] = {
			go = slot3,
			btnAdd = slot4,
			btnremove = slot5,
			txtcount = slot6,
			txtIds = gohelper.findChildText(slot3, "ids"),
			count = slot9
		}
	end

	return slot2
end

function slot0._editableInitView(slot0)
	slot0:_addEvents()
	slot0._inputstory:SetText("1")
	slot0._inputstep:SetText("8")
	slot0._inputkw:SetText("10")

	slot0._stepIdList = slot0:getUserDataTb_()
	slot0._stepItemList = slot0:getUserDataTb_()
	slot0._roundItemList = slot0:getUserDataTb_()
	slot0._kwItemList = slot0:getUserDataTb_()
	slot0._allround = {}
	slot0._curround = {}

	slot0:_activeRoundPanel(false)
	slot0:_showCurRound()
	gohelper.setActive(slot0._gopre, true)
	gohelper.setActive(slot0._gostep, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_removeEvents()
	TaskDispatcher.cancelTask(slot0._hideTip, slot0)
end

function slot0._getStepId(slot0, slot1, slot2)
	return slot0._storyId * 1000 + slot1 * 100 + slot2
end

function slot0._createStepItem(slot0)
	for slot4, slot5 in pairs(slot0._stepIdList) do
		slot6 = slot5.count or 0

		for slot10 = 1, slot6 do
			slot11 = slot0:_getStepItem(slot4, slot10)

			transformhelper.setLocalPosXY(slot11.go.transform, -900 + slot4 * 200, 50 + slot6 * 100 - slot10 * 200)
			gohelper.setActive(slot11.go, true)
		end
	end
end

function slot0._getStepItem(slot0, slot1, slot2)
	if not slot0._stepItemList[slot1] then
		slot0._stepItemList[slot1] = slot0:getUserDataTb_()
	end

	if not slot3[slot2] then
		slot4 = slot0:getUserDataTb_()
		slot5 = slot0:_getStepId(slot1, slot2)
		slot6 = gohelper.cloneInPlace(slot0._gostepitem, slot5)
		slot4.txtkw = gohelper.findChildText(slot6, "kw")
		slot4.icon = gohelper.findChildImage(slot6, "icon")
		gohelper.findChildText(slot6, "txt").text = slot5
		slot9 = gohelper.findChildButtonWithAudio(slot6, "btn")

		slot9:AddClickListener(function ()
			uv0:_onClickStepItem(uv1)
		end, slot0)

		slot4.go = slot6
		slot4.btn = slot9
		slot4.isClick = false
		slot4.step = slot1
		slot4.index = slot2
		slot4.id = slot5
		slot4.kwList = {}
		slot3[slot2] = slot4
	end

	return slot4
end

function slot0._onClickStepItem(slot0, slot1)
	if slot1.isClick then
		slot0:_removeCurStep(slot1)
	else
		slot0:_addCurStep(slot1)
	end

	slot0:_refreshKwItem(slot1)
	slot0:_showCurRound()
end

function slot0._addCurStep(slot0, slot1)
	if slot0._curround[slot1.step] then
		slot0:_removeCurStep(slot0._stepItemList[slot1.step][slot0._curround[slot1.step].index])
	end

	if not slot0._curround[slot1.step] then
		slot0._curround[slot1.step] = {}
	end

	slot0._curround[slot1.step].index = slot1.index
	slot0._curround[slot1.step].kws = {}
	slot0._txtcurStepId.text = "步骤：" .. slot1.id
	slot0.curStepItem = slot1

	slot0:_showKw(slot0.curStepItem)

	slot1.icon.color = Color.yellow
	slot1.isClick = true
end

function slot0.checkHasPreRound(slot0, slot1)
	slot2 = {
		[slot6] = slot7
	}

	for slot6, slot7 in pairs(slot0._curround) do
		if slot6 <= slot1 then
			-- Nothing
		end
	end

	for slot6, slot7 in pairs(slot0._allround) do
		if slot0:isHasPreRound(slot2, slot7) then
			return true
		end
	end

	return false
end

function slot0.isHasPreRound(slot0, slot1, slot2)
	if not LuaUtil.tableNotEmpty(slot1) or not LuaUtil.tableNotEmpty(slot2) then
		return false
	end

	for slot6, slot7 in pairs(slot1) do
		if slot2[slot6] ~= slot7 then
			return false
		end
	end

	return true
end

function slot0._removeCurStep(slot0, slot1)
	slot1.icon.color = Color.white
	slot1.isClick = false
	slot0._curround[slot1.step] = nil
	slot0.curStepItem = nil
	slot1.kwList = {}
	slot0._txtcurStepId.text = ""

	slot0:_showKw(slot1)
end

function slot0._showCurRound(slot0)
	slot0._txtcurround.text = slot0:_getRoundStr(slot0._curround)
end

function slot0._getRoundStr(slot0, slot1)
	slot2 = ""

	for slot6, slot7 in pairs(slot1) do
		slot2 = slot6 == 1 and slot2 .. slot0:_getStepIdAndKw(slot6, slot7.index, slot7.kws) or slot2 .. slot0:_getStepIdAndKw(slot6, slot7.index, slot7.kws) .. "#" .. slot0:_getStepIdAndKw(slot6, slot7.index, slot7.kws)
	end

	return slot2
end

function slot0._getStepIdAndKw(slot0, slot1, slot2, slot3)
	slot4 = slot0:_getStepId(slot1, slot2)

	if not string.nilorempty(slot0:_getListStr(slot3, "#")) then
		return string.format("%s<color=#00FFE1><size=25>(%s)</color></size>", slot4, slot5)
	end

	return slot4
end

function slot0._showAllRound(slot0)
	slot0._roundItemList = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._allRoundCB, slot0._allround, slot0._goround.transform.parent.gameObject, slot0._goround)
end

function slot0._getSameRound(slot0, slot1)
	for slot5, slot6 in pairs(slot0._allround) do
		if slot0:_isSameTable(slot1, slot6) then
			return slot5
		end
	end

	return -1
end

function slot0._allRoundCB(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.btn = gohelper.findChildButtonWithAudio(slot1, "txt/btn")
	slot4.txt = gohelper.findChildText(slot1, "txt")
	slot4.txt.text = slot0:_getRoundStr(slot2)
	slot4.go = slot1

	slot4.btn:AddClickListener(function ()
		uv0:_onClickDeleteBtn(uv1)
	end, slot0)

	slot0._roundItemList[slot3] = slot4
end

function slot0._onClickDeleteBtn(slot0, slot1)
	table.remove(slot0._allround, slot1)
	gohelper.setActive(slot0._roundItemList[slot1].go, false)
	table.remove(slot0._roundItemList, slot1)
end

function slot0._isSameTable(slot0, slot1, slot2)
	if tabletool.len(slot1) ~= tabletool.len(slot2) then
		return false
	end

	for slot8, slot9 in pairs(slot1) do
		if slot9 ~= slot2[slot8] then
			return false
		end
	end

	return true
end

function slot0._createKwItem(slot0)
	slot0._kwItemList = slot0:getUserDataTb_()
	slot1 = {}

	for slot5 = 1, slot0._kwCount do
		table.insert(slot1, slot5)
	end

	gohelper.CreateObjList(slot0, slot0._createKwItemCB, slot1, slot0._gokwitem.transform.parent.gameObject, slot0._gokwitem)
end

function slot0._createKwItemCB(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.id = slot0._storyId * 100 + slot3
	slot4.isClick = false
	slot4.go = slot1
	slot4.txt = gohelper.findChildText(slot1, "txt")
	slot4.icon = gohelper.findChildImage(slot1, "icon")
	slot4.btn = gohelper.findChildButtonWithAudio(slot1, "btn")
	slot4.txt.text = slot4.id

	slot4.btn:AddClickListener(function ()
		uv0:_onClickKwItem(uv1)
	end, slot0)

	slot0._kwItemList[slot3] = slot4
end

function slot0._onClickKwItem(slot0, slot1)
	if not slot0.curStepItem then
		slot0:_showTip("未选择步骤")

		return
	end

	if slot0.curStepItem.step == slot0._stepCount then
		slot0:_showTip("结局不需要选关键词")

		return
	end

	if slot1.isClick then
		slot0:_removeKw(slot1)
	else
		slot0:_addKw(slot1)
	end
end

function slot0._addKw(slot0, slot1)
	slot1.icon.color = Color.yellow
	slot1.isClick = true

	if not LuaUtil.tableContains(slot0.curStepItem.kwList) then
		table.insert(slot0.curStepItem.kwList, slot1.id)

		slot0._curround[slot0.curStepItem.step].kws = slot0.curStepItem.kwList
	end

	slot0:_showKw(slot0.curStepItem)
	slot0:_showCurRound()
end

function slot0._removeKw(slot0, slot1)
	slot1.icon.color = Color.white
	slot1.isClick = false

	tabletool.removeValue(slot0.curStepItem.kwList, slot1.id)

	slot0._curround[slot0.curStepItem.step].kws = slot0.curStepItem.kwList

	slot0:_showKw(slot0.curStepItem)
	slot0:_showCurRound()
end

function slot0._refreshKwItem(slot0, slot1)
	for slot5, slot6 in pairs(slot0._kwItemList) do
		slot6.icon.color = LuaUtil.tableContains(slot1.kwList) and Color.yellow or Color.white
		slot6.isClick = slot7
	end
end

function slot0._showKw(slot0, slot1)
	if slot1 then
		slot1.txtkw.text = slot0:_getListStr(slot1.kwList, "#")
	end
end

function slot0._showTip(slot0, slot1)
	slot0._txttip.text = slot1

	TaskDispatcher.cancelTask(slot0._hideTip, slot0)
	TaskDispatcher.runDelay(slot0._hideTip, slot0, 3)
end

function slot0._hideTip(slot0)
	slot0._txttip.text = ""
end

function slot0._activeRoundPanel(slot0, slot1)
	transformhelper.setLocalPosXY(slot0._goscrollround.transform, slot1 and -960 or -2480, 540)

	slot0._isShowRoundPanel = slot1
end

function slot0._getListStr(slot0, slot1, slot2)
	slot3 = ""

	if slot1 then
		for slot7, slot8 in pairs(slot1) do
			slot3 = slot0:_getStr(slot3, slot7, slot8, slot2)
		end
	end

	return slot3
end

function slot0._getStr(slot0, slot1, slot2, slot3, slot4)
	return slot2 == 1 and slot1 .. slot3 or slot1 .. slot3 .. slot4 .. slot3
end

function slot0._getConfig(slot0, slot1, slot2, slot3)
	slot5 = {}
	slot10 = slot2
	slot6 = slot0:_getStepId(slot1, slot10)

	for slot10, slot11 in pairs(slot3) do
		slot13 = {}

		for slot17, slot18 in pairs(slot11) do
			if false then
				slot19 = slot0:_getStepId(slot17, slot18.index)

				table.insert(slot4[slot10], 1, slot19)

				if slot5[slot19] then
					if not slot0:_isSameTable(slot20, slot13) then
						slot0:_showTip(string.format("相同后置步骤选择的关键词不同：%s   %s   %s   %s", slot6, slot19, slot0:_getListStr(slot13, "#"), slot0:_getListStr(slot20, "#")))
					end

					break
				end

				slot5[slot19] = slot13

				break
			end

			if slot17 == slot1 then
				slot12 = true
				slot13 = slot18.kws
			else
				table.insert(slot4[slot10], slot0:_getStepId(slot17, slot18.index))
			end
		end
	end

	for slot11, slot12 in pairs({
		[slot10] = {}
	}) do
		slot7 = slot0:_getStr("", slot11, slot0:_getListStr(slot12, "#"), "|")
	end

	slot9 = 1
	slot10 = {}

	for slot14, slot15 in pairs(slot5) do
		slot20 = ""
		slot21 = slot9
		slot8 = slot0:_getStr(slot20, slot21, slot14 .. "#" .. slot0:_getListStr(slot15, "#"), "|")
		slot9 = slot9 + 1

		for slot20, slot21 in pairs(slot15) do
			if not LuaUtil.tableContains(slot10, slot21) then
				table.insert(slot10, slot21)
			end
		end
	end

	return slot6, "可跳转步骤的前置步骤要求:  " .. slot7
end

return slot0
