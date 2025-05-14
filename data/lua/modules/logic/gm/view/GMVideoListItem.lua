module("modules.logic.gm.view.GMVideoListItem", package.seeall)

local var_0_0 = class("GMVideoListItem", ListScrollCell)
local var_0_1 = Color.New(1, 0.8, 0.8, 1)
local var_0_2 = Color.white
local var_0_3

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_1, "btn")

	arg_1_0._btn:AddClickListener(arg_1_0._onClickItem, arg_1_0)
	recthelper.setWidth(arg_1_1.transform, 500)
	recthelper.setWidth(arg_1_0._btn.transform, 500)

	arg_1_0._imgBtn = gohelper.findChildImage(arg_1_1, "btn")
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "btn/Text")
	arg_1_0._txtName.alignment = TMPro.TextAlignmentOptions.MidlineLeft
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1
	arg_2_0._txtName.text = arg_2_0._mo.id .. ": " .. arg_2_0._mo.video

	arg_2_0:onSelect(arg_2_0._mo.video == var_0_3)
end

function var_0_0._onClickItem(arg_3_0)
	var_0_3 = arg_3_0._mo.video

	arg_3_0._view:setSelect(arg_3_0._mo)
	ViewMgr.instance:openView(ViewName.GMVideoPlayView, arg_3_0._mo.video)
end

function var_0_0.onSelect(arg_4_0, arg_4_1)
	arg_4_0._imgBtn.color = arg_4_1 and var_0_1 or var_0_2
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._btn then
		arg_5_0._btn:RemoveClickListener()

		arg_5_0._btn = nil
	end
end

return var_0_0
