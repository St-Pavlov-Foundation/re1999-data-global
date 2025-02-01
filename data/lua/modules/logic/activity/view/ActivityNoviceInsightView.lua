module("modules.logic.activity.view.ActivityNoviceInsightView", package.seeall)

slot0 = class("ActivityNoviceInsightView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "name/title/#txt_namecn")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "name/title/#txt_nameen")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "time")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "time/#txt_time")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._btnjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_jump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnjump:AddClickListener(slot0._btnjumpOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnjump:RemoveClickListener()
end

function slot0._btnjumpOnClick(slot0)
	slot0:closeThis()

	if ViewMgr.instance:isOpen(ViewName.ActivityBeginnerView) then
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	end

	GameFacade.jump(53)
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnjump.gameObject, AudioEnum.UI.play_ui_activity_jump)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot2 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NoviceInsight)
	slot0._txtnamecn.text = slot2.name
	slot0._txtnameen.text = slot2.nameEn
	slot3 = ActivityModel.instance:getActStartTime(ActivityEnum.Activity.NoviceInsight)

	if type(slot2.endTime) == "number" then
		gohelper.setActive(slot0._gotime, true)

		slot0._txttime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("activitynoviceinsightview_time"), {
			type(slot3) == "number" and TimeUtil.timestampToString1(slot3 / 1000) or "   ",
			TimeUtil.timestampToString1(ActivityModel.instance:getActEndTime(ActivityEnum.Activity.NoviceInsight) / 1000)
		})
	else
		gohelper.setActive(slot0._gotime, false)
	end

	slot0._txtdesc.text = slot2.actTip
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
