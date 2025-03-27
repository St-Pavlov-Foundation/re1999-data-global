module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUpDialogueItemBase_LR", package.seeall)

slot0 = class("V2a4_WarmUpDialogueItemBase_LR", V2a4_WarmUpDialogueItemBase)
slot1 = SLFramework.AnimatorPlayer

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._bgGo = gohelper.findChild(slot0.viewGO, "content_bg")
	slot0._bgTrans = slot0._bgGo.transform
	slot0._txtGo = slot0._txtcontent.gameObject
	slot0._txtTrans = slot0._txtGo.transform
	slot0._oriTxtWidth = recthelper.getWidth(slot0._txtTrans)
	slot0._oriTxtHeight = recthelper.getHeight(slot0._txtTrans)
	slot0._oriBgWidth = recthelper.getWidth(slot0._bgTrans)
	slot0._oriBgHeight = recthelper.getHeight(slot0._bgTrans)
	slot0._animPlayer = uv1.Get(slot0.viewGO)

	slot0:setActive_loading(false)
end

function slot0.setActive_loading(slot0, slot1)
	gohelper.setActive(slot0._goloading, slot1)
end

function slot0.setData(slot0, slot1)
	uv0.super.setData(slot0, slot1)
	slot0:_openAnim()

	slot3 = V2a4_WarmUpConfig.instance:getDialogDesc(slot1.dialogCO)

	slot0:setText(slot3)
	slot0:typing(slot3)
end

function slot0.onFlush(slot0)
	if slot0._isFlushed then
		return
	end

	slot0._isFlushed = true

	TaskDispatcher.cancelTask(slot0.onFlush, slot0)
	FrameTimerController.onDestroyViewMember(slot0, "_fTimerLoading")
	slot0:setActive_loading(false)
	slot0:setActive_Txt(true)

	if slot0:isReadyStepEnd() then
		slot0:stepEnd()
	end
end

function slot0._typingStartDelayTimer(slot0)
	TaskDispatcher.runDelay(slot0.onFlush, slot0, V2a4_WarmUpConfig.instance:getSentenceInBetweenSec())
end

function slot0._typingStartFrameTimer(slot0, slot1)
	FrameTimerController.onDestroyViewMember(slot0, "_fTimerLoading")

	slot0._fTimerLoading = FrameTimerController.instance:register(function ()
		if not gohelper.isNil(uv0._txtGo) then
			uv0:onFlush()
		end
	end, math.random(1, GameUtil.clamp(#slot1, 60, 120) * V2a4_WarmUpConfig.instance:getSentenceInBetweenSec()), 1)

	slot0._fTimerLoading:Start()
end

slot2 = 155

function slot0.typing(slot0, slot1)
	recthelper.setSize(slot0._bgTrans, uv0, slot0._oriBgHeight)
	slot0:addContentItem(slot0._oriBgHeight)
	slot0:setActive_loading(true)
	slot0:_typingStartDelayTimer()
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.onFlush, slot0)
	GameUtil.onDestroyViewMember(slot0, "_tmpFadeInWithScroll")
	FrameTimerController.onDestroyViewMember(slot0, "_fTimerLoading")
	uv0.super.onDestroyView(slot0)
end

function slot0.onRefreshLineInfo(slot0)
	slot2 = slot0:preferredHeightTxt()
	slot4 = slot0._oriBgHeight

	if slot0:preferredWidthTxt() <= slot0._oriTxtWidth then
		slot3 = slot0._oriBgWidth + slot1 - slot0._oriTxtWidth
	else
		slot1 = slot0._oriTxtWidth
		slot4 = slot4 + slot2 - slot0._oriTxtHeight
	end

	slot0._curTxtWidth = slot1
	slot0._curTxtHeight = slot2
	slot0._curBgWidth = slot3
	slot0._curBgHeight = slot4

	if slot0._isFlushed then
		slot0:stepEnd()
	end
end

function slot0.stepEnd(slot0)
	recthelper.setSize(slot0._txtTrans, slot0._curTxtWidth, slot0._curTxtHeight)
	recthelper.setSize(slot0._bgTrans, slot0._curBgWidth, slot0._curBgHeight)
	slot0:addContentItem(slot0._curBgHeight)
	uv0.super.stepEnd(slot0)
end

function slot0.setGray(slot0, slot1)
	slot0:grayscale(slot1, slot0._txtGo, slot0._bgGo)
end

function slot0._openAnim(slot0, slot1, slot2)
	slot0._animPlayer:Play(UIAnimationName.Open, slot1, slot2)
end

return slot0
