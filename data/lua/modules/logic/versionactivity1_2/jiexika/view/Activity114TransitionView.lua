module("modules.logic.versionactivity1_2.jiexika.view.Activity114TransitionView", package.seeall)

slot0 = class("Activity114TransitionView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtdes = gohelper.findChildTextMesh(slot0.viewGO, "#txt_des")
	slot0._btnclose = gohelper.findChildButton(slot0.viewGO, "#btn_close")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._onClickClose, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot1 = ""
	slot2 = nil

	if slot0.viewParam.transitionId then
		slot2, slot1 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, slot0.viewParam.transitionId)
		slot0.viewParam.transitionId = nil
	elseif slot0.viewParam.type == Activity114Enum.EventType.Rest then
		slot2, slot1 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId["Rest" .. slot0.viewParam.result])
	else
		if not slot0.viewParam.answerIds then
			slot0.viewParam.answerIds = Activity114Model.instance.serverData.testIds
		end

		slot2, slot1 = Activity114Config.instance:getAnswerResult(Activity114Model.instance.id, slot0.viewParam.answerIds[1] or 1, slot0.viewParam.totalScore)
	end

	slot0._openDt = UnityEngine.Time.realtimeSinceStartup

	slot0._simagebg:LoadImage(ResUrl.getAct114Icon("transbg"))

	slot0._txtdes.text = string.gsub(slot1, "▩(%d+)%%s", function (slot0)
		if slot0 == "1" then
			return Activity114Helper.getNextKeyDayDesc(Activity114Model.instance.serverData.day)
		elseif slot0 == "2" then
			return Activity114Helper.getNextKeyDayLeft(Activity114Model.instance.serverData.day)
		end

		return ""
	end)

	TaskDispatcher.runDelay(slot0.closeThis, slot0, 4)
end

function slot0._onClickClose(slot0)
	if not slot0._openDt or UnityEngine.Time.realtimeSinceStartup - slot0._openDt < 1 then
		return
	end

	slot0._anim.enabled = false

	slot0:closeThis()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
