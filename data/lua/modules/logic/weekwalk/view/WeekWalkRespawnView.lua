module("modules.logic.weekwalk.view.WeekWalkRespawnView", package.seeall)

slot0 = class("WeekWalkRespawnView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorolecontainer = gohelper.findChild(slot0.viewGO, "#go_rolecontainer")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/#scroll_card")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	if not slot0._heroMO then
		GameFacade.showToast(ToastEnum.AdventureRespawn2)

		return
	end

	WeekwalkRpc.instance:sendWeekwalkRespawnRequest(slot0.info.elementId, slot0._heroMO.heroId)
end

function slot0._editableInitView(slot0)
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")

	slot0._imgBg:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	HeroGroupEditListModel.instance:setParam(nil, WeekWalkModel.instance:getInfo())
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.info = slot0.viewParam

	WeekWalkRespawnModel.instance:setRespawnList()
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, slot0._onHeroItemClick, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.WeekWalkRespawnReply, slot0._onWeekWalkRespawnReply, slot0)
end

function slot0._onHeroItemClick(slot0, slot1)
	slot0._heroMO = slot1
end

function slot0._onWeekWalkRespawnReply(slot0)
	GameFacade.showToast(ToastEnum.AdventureRespawn3)
	slot0:closeThis()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._imgBg:UnLoadImage()
end

return slot0
