module("modules.ugui.textmeshpro.TMPMarkTopText", package.seeall)

slot0 = class("TMPMarkTopText", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0:reInitByCmp(slot1:GetComponent(gohelper.Type_TextMesh))
end

function slot0.initByCmp(slot0, slot1)
	slot0:reInitByCmp(slot1)
end

function slot0.reInitByCmp(slot0, slot1)
	if slot0._txtcontentcn == slot1 then
		return
	end

	slot0:onDestroyView()

	slot2 = slot1.gameObject
	slot0._markTopList = {}
	slot0._lineSpacing = 0
	slot0._txtcontentcn = slot1
	slot0._txtmarktopGo = IconMgr.instance:getCommonTextMarkTop(slot2)
	slot0._txtmarktop = slot0._txtmarktopGo:GetComponent(gohelper.Type_TextMesh)
	slot0._conMark = gohelper.onceAddComponent(slot2, typeof(ZProj.TMPMark))

	slot0._conMark:SetMarkTopGo(slot0._txtmarktopGo)

	slot0._originalLineSpacing = slot0._txtcontentcn.lineSpacing
	slot0._lineSpacing = slot0._originalLineSpacing

	uv0.super.init(slot0, slot2)
end

function slot0.setData(slot0, slot1)
	slot0._markTopList = StoryTool.getMarkTopTextList(slot1)

	slot0:_setLineSpacing(slot0:getLineSpacing())

	slot0._txtcontentcn.text = StoryTool.filterMarkTop(slot1)

	FrameTimerController.onDestroyViewMember(slot0, "_frameTimer")

	slot0._frameTimer = FrameTimerController.instance:register(slot0._onSetMarksTop, slot0)

	slot0._frameTimer:Start()
end

function slot0._onSetMarksTop(slot0)
	slot0._conMark:SetMarksTop(slot0._markTopList)
	slot0:rebuildLayout()
end

function slot0.getLineSpacing(slot0)
	return slot0:isContainsMarkTop() and slot0._lineSpacing or slot0._originalLineSpacing
end

function slot0._setLineSpacing(slot0, slot1)
	slot0._txtcontentcn.lineSpacing = slot1 or 0
end

function slot0.onDestroyView(slot0)
	FrameTimerController.onDestroyViewMember(slot0, "_frameTimer")
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:setData(slot1)
end

function slot0.isContainsMarkTop(slot0)
	return #slot0._markTopList > 0
end

function slot0.rebuildLayout(slot0)
	if not slot0._rbTrans then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._rbTrans)
end

function slot0.setTopOffset(slot0, slot1, slot2)
	slot0._conMark:SetTopOffset(slot1 or 0, slot2 or 0)
end

function slot0.setLineSpacing(slot0, slot1)
	slot0._lineSpacing = slot1 or 0
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.registerRebuildLayout(slot0, slot1)
	slot0._rbTrans = slot1
end

return slot0
