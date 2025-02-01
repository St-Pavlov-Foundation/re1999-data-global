module("modules.logic.seasonver.act166.view.Season166FightQuitTipView", package.seeall)

slot0 = class("Season166FightQuitTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btntargetShow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem/passtargetTip/tip/#btn_targetShow")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntargetShow:AddClickListener(slot0._btntargetShowOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntargetShow:RemoveClickListener()
end

function slot0._btntargetShowOnClick(slot0)
	Season166Controller.instance:openSeason166TargetView()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = Season166Model.instance:getCurSeasonId()

	if not slot0.actId then
		gohelper.setActive(slot0._btntargetShow, false)

		return
	end

	gohelper.setActive(slot0._btntargetShow, Season166Model.instance:getBattleContext(true) and slot1.baseId and slot1.baseId > 0)
end

function slot0.refreshUI(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
