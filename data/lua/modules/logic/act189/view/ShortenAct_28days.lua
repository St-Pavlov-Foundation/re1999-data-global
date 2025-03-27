module("modules.logic.act189.view.ShortenAct_28days", package.seeall)

slot0 = class("ShortenAct_28days", ShortenActStyleItem_impl)

function slot0.onInitView(slot0)
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "2/#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
end

function slot0._btnclickOnClick(slot0)
	BpController.instance:openBattlePassView()
end

return slot0
