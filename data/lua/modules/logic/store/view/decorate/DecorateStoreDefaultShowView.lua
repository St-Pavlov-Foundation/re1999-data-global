module("modules.logic.store.view.decorate.DecorateStoreDefaultShowView", package.seeall)

slot0 = class("DecorateStoreDefaultShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._goview = gohelper.findChild(slot0.viewGO, "#go_view")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.viewParam.bg.transform:SetParent(slot0._gobg.transform, false)
	slot0.viewParam.contentBg.transform:SetParent(slot0._goview.transform, false)
	slot0:_openPlayerCard()
end

function slot0.onClose(slot0)
	if slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj, slot0.viewParam)

		slot0.viewParam.callback = nil
	end
end

function slot0.onDestroyView(slot0)
	if slot0._bgGo then
		gohelper.destroy(slot0._bgGo)

		slot0._bgGo = nil
	end

	if slot0._viewGo then
		gohelper.destroy(slot0._viewGo)

		slot0._viewGo = nil
	end
end

function slot0._openPlayerCard(slot0)
	if slot0.viewParam.viewCls and gohelper.findChild(slot0.viewParam.contentBg, "#go_typebg5/" .. slot0.viewParam.viewCls.viewGO.name) then
		slot0.playerCardView = MonoHelper.addNoUpdateLuaComOnceToGo(slot2, StorePlayerCardView)

		slot0.playerCardView:onShowDecorateStoreDefault()
	end
end

return slot0
