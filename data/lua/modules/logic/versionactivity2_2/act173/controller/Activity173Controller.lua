module("modules.logic.versionactivity2_2.act173.controller.Activity173Controller", package.seeall)

slot0 = class("Activity173Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.openActivity173FullView(slot0)
	ViewMgr.instance:openView(ViewName.Activity173FullView)
end

function slot0.numberDisplay(slot0)
	if tonumber(slot0) <= 9999 then
		return slot1
	else
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity173panelview_tenThousand"), math.floor(slot1 / 10000))
	end
end

slot0.instance = slot0.New()

return slot0
