module("modules.logic.activity.view.LinkageActivity_PanelViewBase", package.seeall)

slot0 = class("LinkageActivity_PanelViewBase", LinkageActivity_BaseView)

function slot0.ctor(slot0, ...)
	uv0.super.ctor(slot0, ...)

	slot0._inited = false

	slot0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)

	slot0._inited = false
end

function slot0.onUpdateParam(slot0)
	slot0:_refresh()
end

function slot0.onOpen(slot0)
	slot0:internal_set_actId(slot0.viewParam.actId)

	if not slot0._inited then
		slot0:internal_onOpen()

		slot0._inited = true
	else
		slot0:_refresh()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
end

return slot0
