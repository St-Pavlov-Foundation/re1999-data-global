module("modules.logic.activity.view.V2a3_Special_PanelsView", package.seeall)

slot0 = class("V2a3_Special_PanelsView", V2a3_Special_BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "Root/#simage_FullBG/#btn_Close")
	slot0._btnemptyTop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyTop")
	slot0._btnemptyBottom = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyBottom")
	slot0._btnemptyLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyLeft")
	slot0._btnemptyRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyRight")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btnemptyTop:AddClickListener(slot0._btnemptyTopOnClick, slot0)
	slot0._btnemptyBottom:AddClickListener(slot0._btnemptyBottomOnClick, slot0)
	slot0._btnemptyLeft:AddClickListener(slot0._btnemptyLeftOnClick, slot0)
	slot0._btnemptyRight:AddClickListener(slot0._btnemptyRightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	uv0.super.removeEvents(slot0)
	slot0._btnemptyTop:RemoveClickListener()
	slot0._btnemptyBottom:RemoveClickListener()
	slot0._btnemptyLeft:RemoveClickListener()
	slot0._btnemptyRight:RemoveClickListener()
end

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)
	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyTopOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyBottomOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyLeftOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyRightOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._txtLimitTime.text = ""
end

function slot0.onOpen(slot0)
	slot0:internal_set_actId(slot0.viewParam.actId)
	slot0:_clearTimeTick()
	TaskDispatcher.runRepeat(slot0._refreshTimeTick, slot0, 1)

	if not slot0._inited then
		slot0:internal_onOpen()

		slot0._inited = true
	else
		slot0:_refresh()
	end
end

function slot0.onClose(slot0)
	slot0:_clearTimeTick()
end

function slot0.onDestroyView(slot0)
	slot0:_clearTimeTick()
	uv0.super.onDestroyView(slot0)
end

function slot0._clearTimeTick(slot0)
	TaskDispatcher.cancelTask(slot0._refreshTimeTick, slot0)
end

function slot0.onRefresh(slot0)
	slot0:_refreshList()
	slot0:_refreshTimeTick()
end

function slot0._refreshTimeTick(slot0)
	slot0._txtLimitTime.text = slot0:getRemainTimeStr()
end

function slot0.onFindChind_RewardGo(slot0, slot1)
	return gohelper.findChild(slot0.viewGO, "Root/reward/node" .. slot1)
end

return slot0
