module("modules.logic.versionactivity1_4.act131.view.Activity131LogView", package.seeall)

slot0 = class("Activity131LogView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#btn_close")
	slot0._scrolllog = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_log")

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
	slot0.goEmpty = gohelper.findChild(slot0.viewGO, "Empty")
	slot0.goChapterRoot = gohelper.findChild(slot0.viewGO, "Left/scroll_chapterlist/viewport/content")

	if #Activity131Model.instance:getLogCategortList() > 0 then
		Activity131Model.instance:setSelectLogType(slot1[1].logType)
	end

	for slot6, slot7 in ipairs(slot1) do
		MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[2], slot0.goChapterRoot), Activity131LogCategoryItem):setInfo(slot7.logType)
	end
end

function slot0.onOpen(slot0)
	Activity131Controller.instance:registerCallback(Activity131Event.SelectCategory, slot0._onSelectCategoryChange, slot0)
	slot0:_refreshView()
end

function slot0.onClose(slot0)
	Activity131Controller.instance:unregisterCallback(Activity131Event.SelectCategory, slot0._onSelectCategoryChange, slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshView(slot0)
	slot1 = Activity131Model.instance:getLog()

	Activity131LogListModel.instance:setLogList(slot1)

	slot0._scrolllog.verticalNormalizedPosition = 0

	gohelper.setActive(slot0.goEmpty, not next(slot1))
end

function slot0._onSelectCategoryChange(slot0)
	slot0:_refreshView()
end

return slot0
