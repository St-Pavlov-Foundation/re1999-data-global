module("modules.logic.room.view.layout.RoomLayoutCopyView", package.seeall)

local var_0_0 = class("RoomLayoutCopyView", RoomLayoutInputBaseView)

function var_0_0._btncloseOnClick(arg_1_0)
	arg_1_0:closeThis()
	arg_1_0:_closeInvokeCallback(false)
end

function var_0_0._btnsureOnClick(arg_2_0)
	local var_2_0 = arg_2_0._inputsignature:GetText()

	if string.nilorempty(var_2_0) then
		GameFacade.showToast(RoomEnum.Toast.LayoutRenameEmpty)
	else
		if not arg_2_0.viewParam or arg_2_0.viewParam.yesBtnNotClose ~= true then
			arg_2_0:closeThis()
		end

		arg_2_0:_closeInvokeCallback(true, var_2_0)
	end
end

function var_0_0._editableInitView(arg_3_0)
	var_0_0.super._editableInitView(arg_3_0)

	arg_3_0._hyperLinkClick2 = arg_3_0._txtdes.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_3_0._hyperLinkClick2:SetClickListener(arg_3_0._onHyperLinkClick, arg_3_0)

	arg_3_0._groupMessage = gohelper.findChildComponent(arg_3_0.viewGO, "message", gohelper.Type_VerticalLayoutGroup)
end

function var_0_0._refreshInitUI(arg_4_0)
	local var_4_0 = arg_4_0.viewParam and arg_4_0.viewParam.playerName or ""

	arg_4_0._txttitlecn.text = formatLuaLang("room_layoutplan_copy_title", var_4_0)
	arg_4_0._txttitleen.text = luaLang("room_layoutplan_copy_title_en")
	arg_4_0._txtbtnsurecn.text = luaLang("room_layoutplan_copy_btn_confirm_txt")

	if arg_4_0.viewParam then
		local var_4_1 = arg_4_0.viewParam.defaultName

		if string.nilorempty(var_4_1) then
			arg_4_0._inputsignature:SetText("")
		else
			arg_4_0._inputsignature:SetText(var_4_1)
		end

		local var_4_2 = arg_4_0:_getDesStr(arg_4_0.viewParam.planInfo)

		if var_4_2 ~= nil then
			arg_4_0._txtdes.text = var_4_2
			arg_4_0._groupMessage.enabled = false

			TaskDispatcher.runDelay(arg_4_0._onDelayShowMessage, arg_4_0, 0.01)
		end
	end
end

function var_0_0._onDelayShowMessage(arg_5_0)
	arg_5_0._groupMessage.enabled = true
end

function var_0_0._onHyperLinkClick(arg_6_0, arg_6_1)
	RoomLayoutController.instance:openCopyTips(arg_6_0.viewParam.planInfo)
end

function var_0_0._getDesStr(arg_7_0, arg_7_1)
	local var_7_0, var_7_1, var_7_2, var_7_3 = RoomLayoutHelper.comparePlanInfo(arg_7_1)

	if #var_7_3 > 0 then
		local var_7_4 = {}

		arg_7_0:_addCollStrList("room_layoutplan_blockpackage_lack", var_7_0, var_7_4)
		arg_7_0:_addCollStrList("room_layoutplan_birthdayblock_lack", var_7_1, var_7_4)
		arg_7_0:_addCollStrList("room_layoutplan_building_lack", var_7_2, var_7_4)

		local var_7_5 = luaLang("room_levelup_init_and1")
		local var_7_6 = luaLang("room_levelup_init_and2")
		local var_7_7 = arg_7_0:_connStrList(var_7_3, var_7_5, var_7_6, RoomEnum.LayoutCopyShowNameMaxCount)
		local var_7_8 = arg_7_0:_connStrList(var_7_4, var_7_5, var_7_6)
		local var_7_9 = {
			var_7_7,
			var_7_8
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang("room_layoutplan_copy_lack_desc"), var_7_9)
	end

	return nil
end

function var_0_0._addCollStrList(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 > 0 then
		table.insert(arg_8_3, formatLuaLang(arg_8_1, arg_8_2))
	end
end

function var_0_0._connStrList(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	return RoomLayoutHelper.connStrList(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
end

function var_0_0.onDestroyView(arg_10_0)
	var_0_0.super.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._onDelayShowMessage, arg_10_0)
end

return var_0_0
