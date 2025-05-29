module("modules.logic.room.view.layout.RoomLayoutFindShareView", package.seeall)

local var_0_0 = class("RoomLayoutFindShareView", RoomLayoutInputBaseView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)
	gohelper.setActive(gohelper.findChildText(arg_1_0.viewGO, "tips/txt_tips"), false)
end

function var_0_0._btnsureOnClick(arg_2_0)
	local var_2_0 = arg_2_0._inputsignature:GetText()

	if string.nilorempty(var_2_0) then
		GameFacade.showToast(RoomEnum.Toast.LayoutShareCodeEmpty)

		return
	end

	RoomLayoutController.instance:sendGetShareCodeRpc(var_2_0)
end

function var_0_0._refreshInitUI(arg_3_0)
	arg_3_0._txtinputlang.text = luaLang("room_layoutplan_input_sharecode_tip")
	arg_3_0._txtbtnsurecn.text = luaLang("room_layoutplan_create_sharecode_map")
	arg_3_0._txtbtnsureed.text = luaLang("room_layoutplan_create_sharecode_map_en")
	arg_3_0._txttitlecn.text = luaLang("room_layoutplan_use_sharecode_title")
	arg_3_0._txttitleen.text = luaLang("room_layoutplan_use_sharecode_title_en")
end

function var_0_0._checkLimit(arg_4_0)
	local var_4_0 = arg_4_0._inputsignature:GetText()
	local var_4_1 = string.gsub(var_4_0, "[^a-zA-Z0-9]", "")
	local var_4_2 = RoomEnum.LayoutPlanShareCodeLimit
	local var_4_3 = GameUtil.utf8sub(var_4_1, 1, math.min(GameUtil.utf8len(var_4_1), var_4_2))

	if var_4_3 ~= var_4_0 then
		arg_4_0._inputsignature:SetText(var_4_3)
	end
end

function var_0_0._onInputNameValueChange(arg_5_0)
	arg_5_0:_checkLimit()
end

return var_0_0
