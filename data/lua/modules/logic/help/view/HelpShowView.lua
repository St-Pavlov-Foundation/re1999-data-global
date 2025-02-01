module("modules.logic.help.view.HelpShowView", package.seeall)

slot0 = class("HelpShowView", BaseView)

function slot0.setHelpId(slot0, slot1)
	slot0._helpId = slot1
end

function slot0.setDelayTime(slot0, slot1)
	slot0._time = slot1
end

function slot0.setDelayTimeFromConst(slot0, slot1)
	slot0._time = CommonConfig.instance:getConstNum(slot1)
end

function slot0.onOpenFinish(slot0)
	slot0:tryShowHelp()
end

function slot0.tryShowHelp(slot0)
	if HelpController.instance:canShowFirstHelp(slot0._helpId) then
		slot0:_showHelp()
	end
end

function slot0._showHelp(slot0)
	if not slot0._helpId then
		return
	end

	UIBlockMgr.instance:startBlock("HelpShowView tryShowFirstHelp")
	TaskDispatcher.runDelay(slot0._tryShowFirstHelp, slot0, slot0._time or 0)
end

function slot0._tryShowFirstHelp(slot0)
	UIBlockMgr.instance:endBlock("HelpShowView tryShowFirstHelp")
	HelpController.instance:tryShowFirstHelp(slot0._helpId)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock("HelpShowView tryShowFirstHelp")
	TaskDispatcher.cancelTask(slot0._tryShowFirstHelp, slot0)
end

return slot0
