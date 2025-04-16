module("modules.logic.activity.view.Vxax_Special_FullSignView", package.seeall)

slot0 = class("Vxax_Special_FullSignView", Vxax_Special_BaseView)

function slot0.onInitView(slot0)
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
end

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0._inited = false

	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
end

function slot0._editableInitView(slot0)
	slot0._txtLimitTime.text = ""
end

function slot0.onOpen(slot0)
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
