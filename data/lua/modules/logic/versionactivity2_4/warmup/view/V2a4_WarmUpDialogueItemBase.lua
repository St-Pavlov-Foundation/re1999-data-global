module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUpDialogueItemBase", package.seeall)

slot0 = class("V2a4_WarmUpDialogueItemBase", RougeSimpleItemBase)
slot1 = typeof(ZProj.TMPMark)

function slot0.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)

	slot0.__txtCmpList = slot0:getUserDataTb_()
	slot0.__txtmarktopList = slot0:getUserDataTb_()
	slot0.__txtmarktopGoList = slot0:getUserDataTb_()
	slot0.__txtConMarkList = slot0:getUserDataTb_()
	slot0.__txtmarktopIndex = 0
	slot0.__fTimerList = {}
	slot0.__lineSpacing = {}
	slot0.__originalLineSpacing = {}
	slot0.__markTopListList = {}
	slot0._isFlushed = false
	slot0._isReadyStepEnd = false
	slot0._isGrayscaled = false
end

function slot0.setTopOffset(slot0, slot1, slot2, slot3)
	if not slot0.__txtConMarkList[slot1] then
		return
	end

	slot4:SetTopOffset(slot2 or 0, slot3 or 0)
end

function slot0.createMarktopCmp(slot0, slot1)
	slot2 = slot0.__txtmarktopIndex + 1
	slot0.__txtmarktopIndex = slot2
	slot3 = slot1.gameObject
	slot4 = IconMgr.instance:getCommonTextMarkTop(slot3)
	slot6 = gohelper.onceAddComponent(slot3, uv0)
	slot0.__txtCmpList[slot2] = slot1
	slot0.__txtmarktopGoList[slot2] = slot4
	slot0.__txtmarktopList[slot2] = slot4:GetComponent(gohelper.Type_TextMesh)
	slot0.__txtConMarkList[slot2] = slot6
	slot0.__originalLineSpacing[slot2] = slot1.lineSpacing

	slot6:SetMarkTopGo(slot4)

	return slot2
end

function slot0.setTextWithMarktopByIndex(slot0, slot1, slot2)
	slot0.__markTopListList[slot1] = StoryTool.getMarkTopTextList(slot2)

	slot0:_setText(slot1, StoryTool.filterMarkTop(slot2))
	slot0:_unregftimer(slot1)

	slot3 = FrameTimerController.instance:register(function ()
		slot2 = uv0.__txtConMarkList[uv1]

		if uv0.__markTopListList[uv1] and uv0.__txtmarktopList[uv1] and slot2 and not gohelper.isNil(uv0.__txtmarktopGoList[uv1]) then
			slot2:SetMarksTop(slot3)
		end
	end, nil, 1)
	slot0.__fTimerList[slot1] = slot3

	slot3:Start()
end

function slot0._setText(slot0, slot1, slot2)
	if not slot0.__txtCmpList[slot1] then
		return
	end

	slot3.lineSpacing = slot0:getLineSpacing(slot1)
	slot3.text = slot2
end

function slot0.setLineSpacing(slot0, slot1, slot2)
	slot0.__lineSpacing[slot1] = slot2 or 0
end

function slot0.getLineSpacing(slot0, slot1)
	return slot0.__markTopListList[slot1] and #slot2 > 0 and slot0.__lineSpacing[slot1] or slot0.__originalLineSpacing[slot1] or 0
end

function slot0._unregftimer(slot0, slot1)
	if not slot0.__fTimerList[slot1] then
		return
	end

	FrameTimerController.instance:unregister(slot2)

	slot0.__fTimerList[slot1] = nil
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.__fTimerList) do
		slot0:_unregftimer(slot4)
	end

	FrameTimerController.onDestroyViewMember(slot0, "__fTimerSetTxt")
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

function slot0.isFlushed(slot0)
	return slot0._isFlushed
end

function slot0.isReadyStepEnd(slot0)
	return slot0._isReadyStepEnd
end

function slot0.waveMO(slot0)
	return slot0._mo.waveMO
end

function slot0.roundMO(slot0)
	return slot0._mo.roundMO
end

function slot0.dialogCO(slot0)
	return slot0._mo.dialogCO
end

function slot0.addContentItem(slot0, slot1)
	slot0:parent():onAddContentItem(slot0, slot1)
end

function slot0.uiInfo(slot0)
	return slot0:parent():uiInfo()
end

function slot0.stY(slot0)
	return slot0:uiInfo().stY or 0
end

function slot0.getTemplateGo(slot0)
	assert(false, "please override this function")
end

function slot0.onRefreshLineInfo(slot0)
	slot0:stepEnd()
end

function slot0.onFlush(slot0)
	if slot0._isFlushed then
		return
	end

	slot0._isFlushed = true

	slot0:setActive_Txt(true)
end

function slot0.stepEnd(slot0)
	slot0:parent():onStepEnd(slot0:waveMO(), slot0:roundMO())
end

function slot0.lineCount(slot0)
	return slot0._txtcontent:GetTextInfo(slot0._txtcontent.text).lineCount
end

function slot0.preferredWidthTxt(slot0)
	return slot0._txtcontent.preferredWidth
end

function slot0.preferredHeightTxt(slot0)
	return slot0._txtcontent.preferredHeight
end

function slot0.setActive_Txt(slot0, slot1)
	GameUtil.setActive01(slot0._txtTrans, slot1)
end

function slot0.setActive_loading(slot0, slot1)
	gohelper.setActive(slot0._goloading, slot1)
end

function slot0.setFontColor(slot0, slot1)
	slot0._txtcontent.color = GameUtil.parseColor(slot1)
end

function slot0.grayscale(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._isGrayscaled == slot1 then
		return
	end

	slot0._isGrayscaled = true

	if slot2 then
		slot0:setGrayscale(slot2, slot1)
	end

	if slot3 then
		slot0:setGrayscale(slot3, slot1)
	end

	if slot4 then
		slot0:setGrayscale(slot4, slot1)
	end

	if slot5 then
		slot0:setGrayscale(slot5, slot1)
	end
end

function slot0.refreshLineInfo(slot0)
	slot2 = slot0._txtcontent:GetTextInfo(slot0._txtcontent.text).lineCount
	slot0._lineCount = slot2

	if slot2 > 0 then
		slot3 = slot1.lineInfo[0]
		slot0._lineHeight = slot3.lineHeight
		slot0._lineWidth = slot3.width
	else
		slot0._lineHeight = recthelper.getHeight(slot0._txtTrans)
		slot0._lineWidth = slot0._txtcontent.preferredWidth
	end

	slot0._isReadyStepEnd = true

	slot0:onRefreshLineInfo()
end

function slot0.setData(slot0, slot1)
	uv0.super.setData(slot0, slot1)
	recthelper.setAnchorY(slot0:transform(), slot0:stY())
end

function slot0.setText(slot0, slot1, slot2)
	slot0._txtcontent.text = slot1
	slot0._isFlushed = slot2

	slot0:setActive_Txt(false)
	FrameTimerController.onDestroyViewMember(slot0, "__fTimerSetTxt")

	slot0.__fTimerSetTxt = FrameTimerController.instance:register(function ()
		if not gohelper.isNil(uv0._txtGo) then
			uv0:refreshLineInfo()

			if uv0._isFlushed then
				uv0:setActive_Txt(true)
			end
		end
	end, nil, 1)

	slot0.__fTimerSetTxt:Start()
end

return slot0
