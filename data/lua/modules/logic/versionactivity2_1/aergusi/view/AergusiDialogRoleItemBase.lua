module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleItemBase", package.seeall)

slot0 = class("AergusiDialogRoleItemBase", LuaCompBase)
slot1 = typeof(ZProj.TMPMark)

function slot0.ctor(slot0, ...)
	slot0:__onInit()

	slot0.__txtCmpList = slot0:getUserDataTb_()
	slot0.__txtmarktopList = slot0:getUserDataTb_()
	slot0.__txtmarktopGoList = slot0:getUserDataTb_()
	slot0.__txtConMarkList = slot0:getUserDataTb_()
	slot0.__txtmarktopIndex = 0
	slot0.__fTimerList = {}
	slot0.__lineSpacing = {}
	slot0.__originalLineSpacing = {}
	slot0.__markTopListList = {}
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

function slot0.destroy(slot0)
	for slot4, slot5 in pairs(slot0.__fTimerList) do
		slot0:_unregftimer(slot4)
	end

	slot0:__onDispose()
end

return slot0
