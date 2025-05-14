module("modules.logic.gm.view.GMPostProcessView", package.seeall)

local var_0_0 = class("GMPostProcessView", BaseView)

var_0_0.Pos = {
	Normal = {
		x = 0,
		y = 0
	},
	Hide = {
		x = -536,
		y = -571
	},
	Large = {
		x = 0,
		y = 451
	}
}
var_0_0.SrcHeight = {
	Large = 1027,
	Hide = 568,
	Normal = 568
}
var_0_0.State = {
	Large = "Large",
	Hide = "Hide",
	Normal = "Normal"
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._state = var_0_0.State.Normal
	arg_1_0._btnNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/btnNormal")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/btnClose")
	arg_1_0._btnHide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/btnHide")
	arg_1_0._btnLarge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/btnLarge")
	arg_1_0._scrollGO = gohelper.findChild(arg_1_0.viewGO, "scroll")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnNormal:AddClickListener(arg_2_0._onClickNormal, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnHide:AddClickListener(arg_2_0._onClickHide, arg_2_0)
	arg_2_0._btnLarge:AddClickListener(arg_2_0._onClickLarge, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnNormal:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnHide:RemoveClickListener()
	arg_3_0._btnLarge:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_updateUI()
end

function var_0_0.onClose(arg_5_0)
	return
end

function var_0_0._updateUI(arg_6_0)
	gohelper.setActive(arg_6_0._btnNormal.gameObject, arg_6_0._state == var_0_0.State.Large)
	gohelper.setActive(arg_6_0._btnLarge.gameObject, arg_6_0._state ~= var_0_0.State.Large)

	local var_6_0 = var_0_0.Pos[arg_6_0._state]

	recthelper.setAnchor(arg_6_0.viewGO.transform, var_6_0.x, var_6_0.y)

	local var_6_1 = var_0_0.SrcHeight[arg_6_0._state]

	recthelper.setHeight(arg_6_0._scrollGO.transform, var_6_1)
end

function var_0_0._onClickNormal(arg_7_0)
	arg_7_0._state = var_0_0.State.Normal

	arg_7_0:_updateUI()
end

function var_0_0._onClickHide(arg_8_0)
	arg_8_0._state = var_0_0.State.Hide

	arg_8_0:_updateUI()
end

function var_0_0._onClickLarge(arg_9_0)
	arg_9_0._state = var_0_0.State.Large

	arg_9_0:_updateUI()
end

return var_0_0
