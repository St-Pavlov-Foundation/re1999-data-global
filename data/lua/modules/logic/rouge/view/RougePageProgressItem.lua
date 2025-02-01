module("modules.logic.rouge.view.RougePageProgressItem", package.seeall)

slot0 = class("RougePageProgressItem", UserDataDispose)
slot1 = {
	line2 = 3,
	line1 = 2,
	finished = 0,
	line3 = 4,
	unfinished = 1
}
slot0.LineStateEnum = {
	Edit = 2,
	Locked = 3,
	Done = 1
}

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._parent = slot1
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1.gameObject
	slot0._transFinished = slot1:GetChild(uv0.finished)
	slot0._transUnFinished = slot1:GetChild(uv0.unfinished)
	slot0._transLine1 = slot1:GetChild(uv0.line1)
	slot0._transLine2 = slot1:GetChild(uv0.line2)
	slot0._transLine3 = slot1:GetChild(uv0.line3)
end

function slot0.setActive(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0.setHighLight(slot0, slot1)
	GameUtil.setActive01(slot0._transFinished, slot1)
	GameUtil.setActive01(slot0._transUnFinished, not slot1)
end

function slot0.setLineActive(slot0, slot1, slot2)
	GameUtil.setActive01(slot0["_transLine" .. slot1], slot2)
end

function slot0.setLineActiveByState(slot0, slot1)
	GameUtil.setActive01(slot0._transLine1, slot1 == uv0.LineStateEnum.Done)
	GameUtil.setActive01(slot0._transLine2, slot1 == uv0.LineStateEnum.Edit)
	GameUtil.setActive01(slot0._transLine3, slot1 == uv0.LineStateEnum.Locked)
end

function slot0.onDestroy(slot0)
	slot0:onDestroyView()
end

function slot0.onDestroyView(slot0)
	slot0:__onDispose()
end

return slot0
