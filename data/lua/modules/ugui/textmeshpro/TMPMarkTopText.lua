module("modules.ugui.textmeshpro.TMPMarkTopText", package.seeall)

local var_0_0 = class("TMPMarkTopText", ListScrollCellExtend)

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:GetComponent(gohelper.Type_TextMesh)

	arg_1_0:reInitByCmp(var_1_0)
end

function var_0_0.initByCmp(arg_2_0, arg_2_1)
	arg_2_0:reInitByCmp(arg_2_1)
end

function var_0_0.reInitByCmp(arg_3_0, arg_3_1)
	if arg_3_0._txtcontentcn == arg_3_1 then
		return
	end

	arg_3_0:onDestroyView()

	local var_3_0 = arg_3_1.gameObject

	arg_3_0._markTopList = {}
	arg_3_0._lineSpacing = 0
	arg_3_0._txtcontentcn = arg_3_1
	arg_3_0._txtmarktopGo = IconMgr.instance:getCommonTextMarkTop(var_3_0)
	arg_3_0._txtmarktop = arg_3_0._txtmarktopGo:GetComponent(gohelper.Type_TextMesh)
	arg_3_0._conMark = gohelper.onceAddComponent(var_3_0, typeof(ZProj.TMPMark))

	arg_3_0._conMark:SetMarkTopGo(arg_3_0._txtmarktopGo)

	arg_3_0._originalLineSpacing = arg_3_0._txtcontentcn.lineSpacing
	arg_3_0._lineSpacing = arg_3_0._originalLineSpacing

	var_0_0.super.init(arg_3_0, var_3_0)
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0._markTopList = StoryTool.getMarkTopTextList(arg_4_1)

	arg_4_0:_setLineSpacing(arg_4_0:getLineSpacing())

	arg_4_0._txtcontentcn.text = StoryTool.filterMarkTop(arg_4_1)

	FrameTimerController.onDestroyViewMember(arg_4_0, "_frameTimer")

	arg_4_0._frameTimer = FrameTimerController.instance:register(arg_4_0._onSetMarksTop, arg_4_0)

	arg_4_0._frameTimer:Start()
end

function var_0_0._onSetMarksTop(arg_5_0)
	arg_5_0._conMark:SetMarksTop(arg_5_0._markTopList)
	arg_5_0:rebuildLayout()
end

function var_0_0.getLineSpacing(arg_6_0)
	return arg_6_0:isContainsMarkTop() and arg_6_0._lineSpacing or arg_6_0._originalLineSpacing
end

function var_0_0._setLineSpacing(arg_7_0, arg_7_1)
	arg_7_0._txtcontentcn.lineSpacing = arg_7_1 or 0
end

function var_0_0.onDestroyView(arg_8_0)
	FrameTimerController.onDestroyViewMember(arg_8_0, "_frameTimer")
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0:onDestroyView()
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0:setData(arg_10_1)
end

function var_0_0.isContainsMarkTop(arg_11_0)
	return #arg_11_0._markTopList > 0
end

function var_0_0.rebuildLayout(arg_12_0)
	if not arg_12_0._rbTrans then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(arg_12_0._rbTrans)
end

function var_0_0.setTopOffset(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._conMark:SetTopOffset(arg_13_1 or 0, arg_13_2 or 0)
end

function var_0_0.setLineSpacing(arg_14_0, arg_14_1)
	arg_14_0._lineSpacing = arg_14_1 or 0
end

function var_0_0.setActive(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0.viewGO, arg_15_1)
end

function var_0_0.registerRebuildLayout(arg_16_0, arg_16_1)
	arg_16_0._rbTrans = arg_16_1
end

return var_0_0
