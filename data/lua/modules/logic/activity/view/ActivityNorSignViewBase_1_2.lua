module("modules.logic.activity.view.ActivityNorSignViewBase_1_2", package.seeall)

slot0 = class("ActivityNorSignViewBase_1_2", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebanner = gohelper.findChildSingleImage(slot0.viewGO, "#simage_banner")
	slot0._godaylist = gohelper.findChild(slot0.viewGO, "#go_daylist")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "#go_daylist/#scroll_item")
	slot0._titleicon = gohelper.findChildSingleImage(slot0.viewGO, "title/#titleicon")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "title/#txt_remaintime")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, slot0._refresh, slot0)
end

function slot0._editableInitView(slot0)
	assert(false, "please override this function")
end

function slot0._btnhelpOnClick(slot0)
	ViewMgr.instance:openView(ViewName.ActivityTipView, {
		title = luaLang("rule"),
		desc = ActivityConfig.instance:getActivityCo(slot0._actId).actTip,
		rootGo = slot0._btnhelp.gameObject
	})
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function slot0.onDestroyView(slot0)
	slot0._simagebanner:UnLoadImage()
	slot0._titleicon:UnLoadImage()
end

function slot0._refresh(slot0)
	slot1 = {}

	for slot5 = 1, 7 do
		table.insert(slot1, {
			data = ActivityConfig.instance:getNorSignActivityCo(slot0._actId, slot5)
		})
	end

	ActivityNorSignItemListModel_1_2.instance:setList(slot1)

	slot2, slot3 = ActivityModel.instance:getRemainTime(slot0._actId)
	slot0._txtremaintime.text = string.format(luaLang("activitynorsignview_remaintime"), slot2, slot3)
end

return slot0
