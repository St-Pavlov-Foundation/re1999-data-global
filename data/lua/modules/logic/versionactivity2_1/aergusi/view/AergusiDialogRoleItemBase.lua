module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleItemBase", package.seeall)

local var_0_0 = class("AergusiDialogRoleItemBase", LuaCompBase)
local var_0_1 = typeof(ZProj.TMPMark)

function var_0_0.ctor(arg_1_0, ...)
	arg_1_0:__onInit()

	arg_1_0.__txtCmpList = arg_1_0:getUserDataTb_()
	arg_1_0.__txtmarktopList = arg_1_0:getUserDataTb_()
	arg_1_0.__txtmarktopGoList = arg_1_0:getUserDataTb_()
	arg_1_0.__txtConMarkList = arg_1_0:getUserDataTb_()
	arg_1_0.__txtmarktopIndex = 0
	arg_1_0.__fTimerList = {}
	arg_1_0.__lineSpacing = {}
	arg_1_0.__originalLineSpacing = {}
	arg_1_0.__markTopListList = {}
end

function var_0_0.setTopOffset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_0.__txtConMarkList[arg_2_1]

	if not var_2_0 then
		return
	end

	var_2_0:SetTopOffset(arg_2_2 or 0, arg_2_3 or 0)
end

function var_0_0.createMarktopCmp(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.__txtmarktopIndex + 1

	arg_3_0.__txtmarktopIndex = var_3_0

	local var_3_1 = arg_3_1.gameObject
	local var_3_2 = IconMgr.instance:getCommonTextMarkTop(var_3_1)
	local var_3_3 = var_3_2:GetComponent(gohelper.Type_TextMesh)
	local var_3_4 = gohelper.onceAddComponent(var_3_1, var_0_1)

	arg_3_0.__txtCmpList[var_3_0] = arg_3_1
	arg_3_0.__txtmarktopGoList[var_3_0] = var_3_2
	arg_3_0.__txtmarktopList[var_3_0] = var_3_3
	arg_3_0.__txtConMarkList[var_3_0] = var_3_4
	arg_3_0.__originalLineSpacing[var_3_0] = arg_3_1.lineSpacing

	var_3_4:SetMarkTopGo(var_3_2)

	return var_3_0
end

function var_0_0.setTextWithMarktopByIndex(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.__markTopListList[arg_4_1] = StoryTool.getMarkTopTextList(arg_4_2)

	arg_4_0:_setText(arg_4_1, StoryTool.filterMarkTop(arg_4_2))
	arg_4_0:_unregftimer(arg_4_1)

	local var_4_0 = FrameTimerController.instance:register(function()
		local var_5_0 = arg_4_0.__txtmarktopList[arg_4_1]
		local var_5_1 = arg_4_0.__txtmarktopGoList[arg_4_1]
		local var_5_2 = arg_4_0.__txtConMarkList[arg_4_1]
		local var_5_3 = arg_4_0.__markTopListList[arg_4_1]

		if var_5_3 and var_5_0 and var_5_2 and not gohelper.isNil(var_5_1) then
			var_5_2:SetMarksTop(var_5_3)
		end
	end, nil, 1)

	arg_4_0.__fTimerList[arg_4_1] = var_4_0

	var_4_0:Start()
end

function var_0_0._setText(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.__txtCmpList[arg_6_1]

	if not var_6_0 then
		return
	end

	var_6_0.lineSpacing = arg_6_0:getLineSpacing(arg_6_1)
	var_6_0.text = arg_6_2
end

function var_0_0.setLineSpacing(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.__lineSpacing[arg_7_1] = arg_7_2 or 0
end

function var_0_0.getLineSpacing(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.__markTopListList[arg_8_1]
	local var_8_1 = arg_8_0.__lineSpacing[arg_8_1]
	local var_8_2 = arg_8_0.__originalLineSpacing[arg_8_1]

	return var_8_0 and #var_8_0 > 0 and var_8_1 or var_8_2 or 0
end

function var_0_0._unregftimer(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.__fTimerList[arg_9_1]

	if not var_9_0 then
		return
	end

	FrameTimerController.instance:unregister(var_9_0)

	arg_9_0.__fTimerList[arg_9_1] = nil
end

function var_0_0.destroy(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.__fTimerList) do
		arg_10_0:_unregftimer(iter_10_0)
	end

	arg_10_0:__onDispose()
end

return var_0_0
