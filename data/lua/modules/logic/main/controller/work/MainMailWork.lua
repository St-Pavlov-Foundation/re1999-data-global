module("modules.logic.main.controller.work.MainMailWork", package.seeall)

slot0 = class("MainMailWork", BaseWork)

function slot0.onStart(slot0, slot1)
	MailController.instance:tryShowMailToast()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
