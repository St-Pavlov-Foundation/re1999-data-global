module("modules.logic.activity.view.Vxax_Role_SignItem_SignViewContainer", package.seeall)

local var_0_0 = string.format
local var_0_1 = class("Vxax_Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function var_0_1.onModifyListScrollParam(arg_1_0, arg_1_1)
	arg_1_1.cellClass = Vxax_Role_SignItem
	arg_1_1.scrollGOPath = "Root/#scroll_ItemList"
	arg_1_1.cellWidth = 220
	arg_1_1.cellHeight = 600
	arg_1_1.cellSpaceH = -16
end

function var_0_1.onBuildViews(arg_2_0)
	return {
		(arg_2_0:getMainView())
	}
end

local function var_0_2(arg_3_0, arg_3_1, arg_3_2)
	return var_0_0("singlebg/v%sa%s_sign_singlebg/%s.png", arg_3_0, arg_3_1, arg_3_2)
end

local function var_0_3(arg_4_0, arg_4_1, arg_4_2)
	return var_0_0("singlebg_lang/txt_v%sa%s_sign_singlebg/%s.png", arg_4_0, arg_4_1, arg_4_2)
end

function var_0_1.Vxax_Role_xxxSignView_Container(arg_5_0, arg_5_1)
	function arg_5_0.onGetMainViewClassType(arg_6_0)
		return arg_5_1
	end
end

function var_0_1.Vxax_Role_FullSignView_PartX(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	function arg_7_0._editableInitView(arg_8_0)
		local var_8_0 = var_0_0("v%sa%s_sign_fullbg%s", arg_7_1, arg_7_2, arg_7_3)

		GameUtil.loadSImage(arg_8_0._simageFullBG, var_0_2(arg_7_1, arg_7_2, var_8_0))

		local var_8_1 = var_0_0("v%sa%s_sign_title_%s", arg_7_1, arg_7_2, arg_7_3)

		GameUtil.loadSImage(arg_8_0._simageTitle, var_0_3(arg_7_1, arg_7_2, var_8_1))

		local var_8_2 = gohelper.findChild(arg_8_0.viewGO, "Root/vx_effect1")
		local var_8_3 = gohelper.findChild(arg_8_0.viewGO, "Root/vx_effect2")

		gohelper.setActive(var_8_2, true)
		gohelper.setActive(var_8_3, false)
	end
end

function var_0_1.Vxax_Role_PanelSignView_PartX(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	function arg_9_0._editableInitView(arg_10_0)
		local var_10_0 = var_0_0("v%sa%s_sign_panelbg%s", arg_9_1, arg_9_2, arg_9_3)

		GameUtil.loadSImage(arg_10_0._simagePanelBG, var_0_2(arg_9_1, arg_9_2, var_10_0))

		local var_10_1 = var_0_0("v%sa%s_sign_title_%s", arg_9_1, arg_9_2, arg_9_3)

		GameUtil.loadSImage(arg_10_0._simageTitle, var_0_3(arg_9_1, arg_9_2, var_10_1))

		local var_10_2 = gohelper.findChild(arg_10_0.viewGO, "Root/vx_effect1")
		local var_10_3 = gohelper.findChild(arg_10_0.viewGO, "Root/vx_effect2")

		gohelper.setActive(var_10_2, true)
		gohelper.setActive(var_10_3, false)
	end
end

local function var_0_4(arg_11_0, arg_11_1)
	local var_11_0 = GameBranchMgr.instance:getMajorVer()
	local var_11_1 = GameBranchMgr.instance:getMinorVer()

	return _G[var_0_0(arg_11_0, var_11_0, var_11_1, arg_11_1)]
end

function var_0_1.Vxax_Role_FullSignView_PartX_ContainerImpl(arg_12_0)
	return var_0_4("V%sa%s_Role_FullSignView_Part%s_Container", arg_12_0)
end

function var_0_1.Vxax_Role_PanelSignView_PartX_ContainerImpl(arg_13_0)
	return var_0_4("V%sa%s_Role_PanelSignView_Part%s_Container", arg_13_0)
end

return var_0_1
