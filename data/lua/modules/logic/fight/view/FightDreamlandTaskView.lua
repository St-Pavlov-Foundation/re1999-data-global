module("modules.logic.fight.view.FightDreamlandTaskView", package.seeall)

slot0 = class("FightDreamlandTaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._goTask = gohelper.findChild(slot0.viewGO, "root/topLeftContent/#go_tasktips")
	slot0._txtTask = gohelper.findChildText(slot0.viewGO, "root/topLeftContent/#go_tasktips/taskitembg/#txt_task")
	slot0._ani = SLFramework.AnimatorPlayer.Get(slot0._goTask)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnIndicatorChange, slot0._refreshDes, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, slot0._onCameraFocusChanged, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._taskConfig = Activity126Config.instance:getDramlandTask(FightModel.instance:getFightParam() and slot1.battleId)

	slot0:_refreshDes()
end

function slot0._refreshDes(slot0)
	gohelper.setActive(slot0._goTask, slot0._taskConfig)

	if slot0._taskConfig then
		slot1 = FightModel.instance:getIndicatorNum(slot0._taskConfig.indicator)
		slot2 = slot0._taskConfig.num
		slot0._txtTask.text = slot0._taskConfig.desc .. string.format(" <color=#cc7f56>(%d/%d)</color>", slot1, slot2)

		if slot2 <= slot1 then
			if slot0._finish then
				gohelper.setActive(slot0._goTask, false)

				return
			end

			slot0._ani:Play("finish", slot0._finishDone, slot0)

			slot0._finish = true
		else
			slot0._ani:Play("idle", nil, )

			slot0._finish = false
		end
	end
end

function slot0._finishDone(slot0)
	gohelper.setActive(slot0._goTask, false)
end

function slot0._onCameraFocusChanged(slot0, slot1)
	if slot1 then
		gohelper.setActive(slot0._goTask, slot0._taskConfig)
	else
		slot0:_refreshDes()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
