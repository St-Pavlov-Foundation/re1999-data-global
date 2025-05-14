module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUpDialogueItemBase", package.seeall)

local var_0_0 = class("V2a4_WarmUpDialogueItemBase", RougeSimpleItemBase)
local var_0_1 = typeof(ZProj.TMPMark)

function var_0_0.ctor(arg_1_0, ...)
	arg_1_0:__onInit()
	var_0_0.super.ctor(arg_1_0, ...)

	arg_1_0.__txtCmpList = arg_1_0:getUserDataTb_()
	arg_1_0.__txtmarktopList = arg_1_0:getUserDataTb_()
	arg_1_0.__txtmarktopGoList = arg_1_0:getUserDataTb_()
	arg_1_0.__txtConMarkList = arg_1_0:getUserDataTb_()
	arg_1_0.__txtmarktopIndex = 0
	arg_1_0.__fTimerList = {}
	arg_1_0.__lineSpacing = {}
	arg_1_0.__originalLineSpacing = {}
	arg_1_0.__markTopListList = {}
	arg_1_0._isFlushed = false
	arg_1_0._isReadyStepEnd = false
	arg_1_0._isGrayscaled = false
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

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.__fTimerList) do
		arg_10_0:_unregftimer(iter_10_0)
	end

	FrameTimerController.onDestroyViewMember(arg_10_0, "__fTimerSetTxt")
	var_0_0.super.onDestroyView(arg_10_0)
	arg_10_0:__onDispose()
end

function var_0_0.isFlushed(arg_11_0)
	return arg_11_0._isFlushed
end

function var_0_0.isReadyStepEnd(arg_12_0)
	return arg_12_0._isReadyStepEnd
end

function var_0_0.waveMO(arg_13_0)
	return arg_13_0._mo.waveMO
end

function var_0_0.roundMO(arg_14_0)
	return arg_14_0._mo.roundMO
end

function var_0_0.dialogCO(arg_15_0)
	return arg_15_0._mo.dialogCO
end

function var_0_0.addContentItem(arg_16_0, arg_16_1)
	arg_16_0:parent():onAddContentItem(arg_16_0, arg_16_1)
end

function var_0_0.uiInfo(arg_17_0)
	return arg_17_0:parent():uiInfo()
end

function var_0_0.stY(arg_18_0)
	return arg_18_0:uiInfo().stY or 0
end

function var_0_0.getTemplateGo(arg_19_0)
	assert(false, "please override this function")
end

function var_0_0.onRefreshLineInfo(arg_20_0)
	arg_20_0:stepEnd()
end

function var_0_0.onFlush(arg_21_0)
	if arg_21_0._isFlushed then
		return
	end

	arg_21_0._isFlushed = true

	arg_21_0:setActive_Txt(true)
end

function var_0_0.stepEnd(arg_22_0)
	arg_22_0:parent():onStepEnd(arg_22_0:waveMO(), arg_22_0:roundMO())
end

function var_0_0.lineCount(arg_23_0)
	return arg_23_0._txtcontent:GetTextInfo(arg_23_0._txtcontent.text).lineCount
end

function var_0_0.preferredWidthTxt(arg_24_0)
	return arg_24_0._txtcontent.preferredWidth
end

function var_0_0.preferredHeightTxt(arg_25_0)
	return arg_25_0._txtcontent.preferredHeight
end

function var_0_0.setActive_Txt(arg_26_0, arg_26_1)
	GameUtil.setActive01(arg_26_0._txtTrans, arg_26_1)
end

function var_0_0.setActive_loading(arg_27_0, arg_27_1)
	gohelper.setActive(arg_27_0._goloading, arg_27_1)
end

function var_0_0.setFontColor(arg_28_0, arg_28_1)
	arg_28_0._txtcontent.color = GameUtil.parseColor(arg_28_1)
end

function var_0_0.grayscale(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	if arg_29_0._isGrayscaled == arg_29_1 then
		return
	end

	arg_29_0._isGrayscaled = true

	if arg_29_2 then
		arg_29_0:setGrayscale(arg_29_2, arg_29_1)
	end

	if arg_29_3 then
		arg_29_0:setGrayscale(arg_29_3, arg_29_1)
	end

	if arg_29_4 then
		arg_29_0:setGrayscale(arg_29_4, arg_29_1)
	end

	if arg_29_5 then
		arg_29_0:setGrayscale(arg_29_5, arg_29_1)
	end
end

function var_0_0.refreshLineInfo(arg_30_0)
	local var_30_0 = arg_30_0._txtcontent:GetTextInfo(arg_30_0._txtcontent.text)
	local var_30_1 = var_30_0.lineCount

	arg_30_0._lineCount = var_30_1

	if var_30_1 > 0 then
		local var_30_2 = var_30_0.lineInfo[0]

		arg_30_0._lineHeight = var_30_2.lineHeight
		arg_30_0._lineWidth = var_30_2.width
	else
		arg_30_0._lineHeight = recthelper.getHeight(arg_30_0._txtTrans)
		arg_30_0._lineWidth = arg_30_0._txtcontent.preferredWidth
	end

	arg_30_0._isReadyStepEnd = true

	arg_30_0:onRefreshLineInfo()
end

function var_0_0.setData(arg_31_0, arg_31_1)
	var_0_0.super.setData(arg_31_0, arg_31_1)
	recthelper.setAnchorY(arg_31_0:transform(), arg_31_0:stY())
end

function var_0_0.setText(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0._txtcontent.text = arg_32_1
	arg_32_0._isFlushed = arg_32_2

	arg_32_0:setActive_Txt(false)
	FrameTimerController.onDestroyViewMember(arg_32_0, "__fTimerSetTxt")

	arg_32_0.__fTimerSetTxt = FrameTimerController.instance:register(function()
		if not gohelper.isNil(arg_32_0._txtGo) then
			arg_32_0:refreshLineInfo()

			if arg_32_0._isFlushed then
				arg_32_0:setActive_Txt(true)
			end
		end
	end, nil, 1)

	arg_32_0.__fTimerSetTxt:Start()
end

return var_0_0
