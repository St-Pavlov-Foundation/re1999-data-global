module("modules.logic.sp01.assassinChase.view.AssassinChaseRewardItem", package.seeall)

local var_0_0 = class("AssassinChaseRewardItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._gorewardPos = gohelper.findChild(arg_1_0.viewGO, "go_rewardPos")
	arg_1_0._gorewardGet = gohelper.findChild(arg_1_0.viewGO, "go_rewardGet")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._rewardItem = IconMgr.instance:getCommonItemIcon(arg_2_0._gorewardPos)
end

function var_0_0.setData(arg_3_0, arg_3_1)
	local var_3_0 = string.splitToNumber(arg_3_1, "#")
	local var_3_1 = arg_3_0._rewardItem

	var_3_1:setMOValue(var_3_0[1], var_3_0[2], var_3_0[3])
	var_3_1:isShowCount(true)
	var_3_1:setInPack(false)
end

function var_0_0.setGetState(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0._gorewardGet, arg_4_1)
end

function var_0_0.setActive(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0.viewGO, arg_5_1)
end

function var_0_0.onDestroy(arg_6_0)
	return
end

return var_0_0
