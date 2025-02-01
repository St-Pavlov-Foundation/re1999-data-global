module("modules.logic.weekwalk.view.WeekWalkDegradeView", package.seeall)

slot0 = class("WeekWalkDegradeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagetipbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_tipbg")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_no")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_sure")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnno:RemoveClickListener()
	slot0._btnsure:RemoveClickListener()
end

function slot0._btnnoOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnsureOnClick(slot0)
	WeekwalkRpc.instance:sendSelectWeekwalkLevelRequest(slot0._level - 1)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._level = WeekWalkModel.instance:getLevel()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
