module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUpDialogueItemBase_LR", package.seeall)

local var_0_0 = class("V2a4_WarmUpDialogueItemBase_LR", V2a4_WarmUpDialogueItemBase)
local var_0_1 = SLFramework.AnimatorPlayer

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0._editableInitView(arg_2_0)
	var_0_0.super._editableInitView(arg_2_0)

	arg_2_0._bgGo = gohelper.findChild(arg_2_0.viewGO, "content_bg")
	arg_2_0._bgTrans = arg_2_0._bgGo.transform
	arg_2_0._txtGo = arg_2_0._txtcontent.gameObject
	arg_2_0._txtTrans = arg_2_0._txtGo.transform
	arg_2_0._oriTxtWidth = recthelper.getWidth(arg_2_0._txtTrans)
	arg_2_0._oriTxtHeight = recthelper.getHeight(arg_2_0._txtTrans)
	arg_2_0._oriBgWidth = recthelper.getWidth(arg_2_0._bgTrans)
	arg_2_0._oriBgHeight = recthelper.getHeight(arg_2_0._bgTrans)
	arg_2_0._animPlayer = var_0_1.Get(arg_2_0.viewGO)

	arg_2_0:setActive_loading(false)
end

function var_0_0.setActive_loading(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0._goloading, arg_3_1)
end

function var_0_0.setData(arg_4_0, arg_4_1)
	var_0_0.super.setData(arg_4_0, arg_4_1)
	arg_4_0:_openAnim()

	local var_4_0 = arg_4_1.dialogCO
	local var_4_1 = V2a4_WarmUpConfig.instance:getDialogDesc(var_4_0)

	arg_4_0:setText(var_4_1)
	arg_4_0:typing(var_4_1)
end

function var_0_0.onFlush(arg_5_0)
	if arg_5_0._isFlushed then
		return
	end

	arg_5_0._isFlushed = true

	TaskDispatcher.cancelTask(arg_5_0.onFlush, arg_5_0)
	FrameTimerController.onDestroyViewMember(arg_5_0, "_fTimerLoading")
	arg_5_0:setActive_loading(false)
	arg_5_0:setActive_Txt(true)

	if arg_5_0:isReadyStepEnd() then
		arg_5_0:stepEnd()
	end
end

function var_0_0._typingStartDelayTimer(arg_6_0)
	TaskDispatcher.runDelay(arg_6_0.onFlush, arg_6_0, V2a4_WarmUpConfig.instance:getSentenceInBetweenSec())
end

function var_0_0._typingStartFrameTimer(arg_7_0, arg_7_1)
	local var_7_0 = math.random(1, GameUtil.clamp(#arg_7_1, 60, 120) * V2a4_WarmUpConfig.instance:getSentenceInBetweenSec())

	FrameTimerController.onDestroyViewMember(arg_7_0, "_fTimerLoading")

	arg_7_0._fTimerLoading = FrameTimerController.instance:register(function()
		if not gohelper.isNil(arg_7_0._txtGo) then
			arg_7_0:onFlush()
		end
	end, var_7_0, 1)

	arg_7_0._fTimerLoading:Start()
end

local var_0_2 = 155

function var_0_0.typing(arg_9_0, arg_9_1)
	recthelper.setSize(arg_9_0._bgTrans, var_0_2, arg_9_0._oriBgHeight)
	arg_9_0:addContentItem(arg_9_0._oriBgHeight)
	arg_9_0:setActive_loading(true)
	arg_9_0:_typingStartDelayTimer()
end

function var_0_0.onDestroyView(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.onFlush, arg_10_0)
	GameUtil.onDestroyViewMember(arg_10_0, "_tmpFadeInWithScroll")
	FrameTimerController.onDestroyViewMember(arg_10_0, "_fTimerLoading")
	var_0_0.super.onDestroyView(arg_10_0)
end

function var_0_0.onRefreshLineInfo(arg_11_0)
	local var_11_0 = arg_11_0:preferredWidthTxt()
	local var_11_1 = arg_11_0:preferredHeightTxt()
	local var_11_2 = arg_11_0._oriBgWidth
	local var_11_3 = arg_11_0._oriBgHeight

	if var_11_0 <= arg_11_0._oriTxtWidth then
		var_11_2 = var_11_2 + (var_11_0 - arg_11_0._oriTxtWidth)
	else
		var_11_0 = arg_11_0._oriTxtWidth
		var_11_3 = var_11_3 + (var_11_1 - arg_11_0._oriTxtHeight)
	end

	arg_11_0._curTxtWidth = var_11_0
	arg_11_0._curTxtHeight = var_11_1
	arg_11_0._curBgWidth = var_11_2
	arg_11_0._curBgHeight = var_11_3

	if arg_11_0._isFlushed then
		arg_11_0:stepEnd()
	end
end

function var_0_0.stepEnd(arg_12_0)
	recthelper.setSize(arg_12_0._txtTrans, arg_12_0._curTxtWidth, arg_12_0._curTxtHeight)
	recthelper.setSize(arg_12_0._bgTrans, arg_12_0._curBgWidth, arg_12_0._curBgHeight)
	arg_12_0:addContentItem(arg_12_0._curBgHeight)
	var_0_0.super.stepEnd(arg_12_0)
end

function var_0_0.setGray(arg_13_0, arg_13_1)
	arg_13_0:grayscale(arg_13_1, arg_13_0._txtGo, arg_13_0._bgGo)
end

function var_0_0._openAnim(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._animPlayer:Play(UIAnimationName.Open, arg_14_1, arg_14_2)
end

return var_0_0
