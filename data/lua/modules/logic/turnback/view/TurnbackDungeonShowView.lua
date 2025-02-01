module("modules.logic.turnback.view.TurnbackDungeonShowView", package.seeall)

slot0 = class("TurnbackDungeonShowView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "tipspanel/#txt_time")
	slot0._txtrule = gohelper.findChildText(slot0.viewGO, "tipspanel/#txt_rule")
	slot0._txttipdesc = gohelper.findChildText(slot0.viewGO, "tipspanel/tipsbg/#txt_tipdec")
	slot0._btngoto = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_goto")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngoto:RemoveClickListener()
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, slot0._refreshRemainTime, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0._refreshUI, slot0)
end

function slot0._btngotoOnClick(slot0)
	if slot0.config.jumpId ~= 0 then
		GameFacade.jump(slot0.config.jumpId)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_fullbg"))
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0.endTime = slot0:_getEndTime()

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0.config = TurnbackConfig.instance:getTurnbackSubModuleCo(slot0.viewParam.actId)
	slot0._txtrule.text = string.split(slot0.config.actDesc, "|")[1]
	slot2, slot3 = TurnbackModel.instance:getAdditionCountInfo()
	slot0._txttipdesc.text = string.format("%s (<color=%s>%s</color>/%s)", slot1[2], slot2 == 0 and "#d97373" or "#FFFFFF", slot2, slot3)

	slot0:_refreshRemainTime()
end

function slot0._refreshRemainTime(slot0)
	slot0._txttime.text = TurnbackController.instance:refreshRemainTime(slot0.endTime)
end

function slot0._getEndTime(slot0)
	return TurnbackModel.instance:getCurTurnbackMo().startTime + TurnbackConfig.instance:getAdditionDurationDays(TurnbackModel.instance:getCurTurnbackId()) * TimeUtil.OneDaySecond
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
