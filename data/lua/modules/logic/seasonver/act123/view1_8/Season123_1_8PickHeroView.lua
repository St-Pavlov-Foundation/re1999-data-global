module("modules.logic.seasonver.act123.view1_8.Season123_1_8PickHeroView", package.seeall)

slot0 = class("Season123_1_8PickHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "#go_count/#txt_count")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ops/#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ops/#btn_cancel")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	Season123PickHeroController.instance:pickOver()
	slot0:closeThis()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")
	slot0._simageredlight = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_redlight")

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	slot0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))
end

function slot0.onDestroyView(slot0)
	slot0._imgBg:UnLoadImage()
	slot0._simageredlight:UnLoadImage()
	Season123PickHeroController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.actId

	Season123PickHeroController.instance:onOpenView(slot1, slot0.viewParam.stage, slot0.viewParam.finishCall, slot0.viewParam.finishCallObj, slot0.viewParam.entryMOList, slot0.viewParam.selectHeroUid)

	if not ActivityModel.instance:getActMO(slot1) or not slot3:isOpen() or slot3:isExpired() then
		return
	end

	slot0:addEventCb(Season123Controller.instance, Season123Event.PickViewRefresh, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0._txtcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season123_custompick_selectnum"), {
		Season123PickHeroModel.instance:getSelectCount(),
		Season123PickHeroModel.instance:getLimitCount()
	})
end

return slot0
