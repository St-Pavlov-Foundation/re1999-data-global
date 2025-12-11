module("modules.logic.survival.view.shelter.SurvivalDecreeSelectItem", package.seeall)

local var_0_0 = class("SurvivalDecreeSelectItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Add")
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "Left/image_Icon1")
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "#scroll_Descr/Viewport/Content/goItem/#go_1/#txt_Title")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "#scroll_Descr/Viewport/Content/goItem/#go_1/#txt_Descr")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnAdd, arg_2_0.onClickAdd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnAdd)
end

function var_0_0.onClickAdd(arg_4_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalDecreeSelectTip, MsgBoxEnum.BoxType.Yes_No, arg_4_0._onSelect, nil, nil, arg_4_0)
end

function var_0_0._onSelect(arg_5_0)
	local var_5_0 = SurvivalShelterModel.instance:getWeekInfo().panel

	if not var_5_0 then
		arg_5_0:_closeThis()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalPanelOperationRequest(var_5_0.uid, tostring(arg_5_0.policyIndex - 1), arg_5_0._closeThis, arg_5_0)
end

function var_0_0._closeThis(arg_6_0)
	GameFacade.showToastString(GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalDecreeSelectView_1"), {
		arg_6_0.mo.name
	}))
	ViewMgr.instance:closeView(ViewName.SurvivalDecreeSelectView)
end

function var_0_0.updateItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.policyIndex = arg_7_1

	local var_7_0 = lua_survival_decree.configDict[arg_7_2]

	arg_7_0:onUpdateMO(var_7_0)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0.mo = arg_8_1

	UISpriteSetMgr.instance:setSurvivalSprite(arg_8_0.imageIcon, arg_8_1.icon, true)

	arg_8_0.txtTitle.text = arg_8_1.name
	arg_8_0.txtDesc.text = arg_8_1.desc
end

return var_0_0
