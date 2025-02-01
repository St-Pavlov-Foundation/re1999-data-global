module("modules.logic.rouge.dlc.101.view.RougeLimiterViewEmblemComp", package.seeall)

slot0 = class("RougeLimiterViewEmblemComp", BaseView)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.rootPath = slot1
end

function slot0.onInitView(slot0)
	slot0._goroot = gohelper.findChild(slot0.viewGO, slot0.rootPath)
	slot0._txtpoint = gohelper.findChildText(slot0._goroot, "point/#txt_point")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0._goroot, "point/#btn_click")
	slot0._gotips = gohelper.findChild(slot0._goroot, "tips")
	slot0._txttips = gohelper.findChildText(slot0._goroot, "tips/#txt_tips")

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

function slot0._btnclickOnClick(slot0)
	slot0._isTipVisible = not slot0._isTipVisible

	gohelper.setActive(slot0._gotips, slot0._isTipVisible)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateEmblem, slot0._onUpdateEmblem, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._emblemCount = RougeDLCModel101.instance:getTotalEmblemCount()

	slot0:initEmblemCount()
	slot0:refreshEmblemTips()
end

function slot0.initEmblemCount(slot0)
	slot0._txtpoint.text = slot0._emblemCount
end

function slot0.refreshEmblemTips(slot0)
	slot0._txttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_dlc_101_emblemTips"), {
		slot0._emblemCount,
		lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.MaxEmblemCount] and slot1.value or 0
	})
end

function slot0._onUpdateEmblem(slot0)
	slot0._emblemCount = RougeDLCModel101.instance:getTotalEmblemCount()

	slot0:initEmblemCount()
	slot0:refreshEmblemTips()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
